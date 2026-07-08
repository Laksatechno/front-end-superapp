import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yofa/bloc/presensi/presensi_bloc.dart';

import '../../theme/app_theme.dart';
import '../../main.dart'; // <-- pastikan routeObserver ada di sini (sesuaikan path)

class PresensiPage extends StatefulWidget {
  final bool active;

  const PresensiPage({super.key, required this.active});

  @override
  PresensiPageState createState() => PresensiPageState();
}

class PresensiPageState extends State<PresensiPage>
    with WidgetsBindingObserver, RouteAware {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];

  int _selectedIndex = 0;
  int _frontIndex = -1;
  int _backIndex = -1;

  bool _isTaking = false;
  bool _startingCamera = false;

  // ====== LOCATION STATE ======
  bool _locLoading = false;
  String _address = 'Mengambil lokasi...';
  double? _lat;
  double? _lng;

  bool _locFetched = false;
  DateTime? _lastGeo;

  bool get _ready => _controller != null && _controller!.value.isInitialized;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.active) {
      _initCamera();
      _initLocation();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didUpdateWidget(covariant PresensiPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.active != widget.active) {
      if (widget.active) {
        _initCamera();
        _initLocation();
      } else {
        _stopCamera();
      }
    }
  }

  // ===== RouteAware: stop/start camera ketika page ketutup route lain =====
  @override
  void didPushNext() {
    // halaman ini ketutup oleh halaman baru
    _stopCamera();
  }

  @override
  void didPopNext() {
    // balik lagi ke halaman ini
    if (widget.active) {
      _initCamera();
      _initLocation();
    }
  }

  Future<void> _stopCamera() async {
    final old = _controller;
    _controller = null;
    if (mounted) setState(() {});
    await old?.dispose();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.active) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _stopCamera();
      return;
    }

    if (state == AppLifecycleState.resumed) {
      _initCamera();
      _initLocation();
    }
  }

  Future<void> _initCamera() async {
    if (_startingCamera) return;
    _startingCamera = true;

    try {
      if (_ready) return;

      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      // cari index depan & belakang (biar switch toggle, bukan cycle semua camera)
      _frontIndex =
          _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front);
      _backIndex =
          _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);

      // default kamera depan (kalau tidak ada, fallback ke belakang, kalau tidak ada juga ke 0)
      if (_frontIndex != -1) {
        _selectedIndex = _frontIndex;
      } else if (_backIndex != -1) {
        _selectedIndex = _backIndex;
      } else {
        _selectedIndex = 0;
      }

      await _startCamera(_cameras[_selectedIndex]);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal akses kamera: $e')),
      );
    } finally {
      _startingCamera = false;
    }
  }

  Future<void> _startCamera(CameraDescription camera) async {
    final old = _controller;
    _controller = null;
    if (mounted) setState(() {});
    await old?.dispose();

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = controller;

    try {
      await controller.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal inisialisasi kamera: $e')),
      );
    }
  }

  /// Toggle: depan <-> belakang
  Future<void> _switchCamera() async {
    if (!_ready) return;

    // kalau tidak punya salah satu, jangan switch
    if (_frontIndex == -1 || _backIndex == -1) return;

    final current = _cameras[_selectedIndex].lensDirection;
    final nextIndex =
        current == CameraLensDirection.front ? _backIndex : _frontIndex;

    if (nextIndex == _selectedIndex) return;

    _selectedIndex = nextIndex;
    await _startCamera(_cameras[_selectedIndex]);
  }

  Future<void> _takePicture() async {
    if (!_ready || _isTaking) return;

    try {
      if (!mounted) return;
      setState(() => _isTaking = true);

      await _controller!.setFlashMode(FlashMode.off);
      final XFile file = await _controller!.takePicture();

      // ambil lokasi kalau belum ada
      if (_lat == null || _lng == null) {
        await _initLocation();
      }

      final bytes = await File(file.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      if (!mounted) return;
      setState(() => _isTaking = false);

      // 
      final latStr = (_lat ?? 0).toString();
      final lngStr = (_lng ?? 0).toString();
      print ('Presensi with lat=$latStr, lng=$lngStr, imageSize=${bytes.length} bytes');
      if (!context.mounted) return;
      context.read<PresensiBloc>().add(
            PresensiEvent.addPresensi(latStr, lngStr, base64Image),
          );

      // optional: preview foto tetap tampil
      if (!context.mounted) return;
      // showDialog(
      //   context: context,
      //   builder: (_) => Dialog(
      //     insetPadding: const EdgeInsets.all(16),
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(16),
      //       child: AspectRatio(
      //         aspectRatio: 3 / 4,
      //         child: Image.file(File(file.path), fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      // );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isTaking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil foto: $e')),
      );
    }
  }


  // ================= LOCATION =================
  Future<void> _initLocation() async {
    if (_locFetched && _lastGeo != null) {
      final diff = DateTime.now().difference(_lastGeo!);
      if (diff.inSeconds < 20) return;
    }

    if (_locLoading) return;

    if (!mounted) return;
    setState(() {
      _locLoading = true;
      _address = 'Mengambil lokasi...';
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (!mounted) return;
        setState(() {
          _locLoading = false;
          _address = 'GPS tidak aktif. Tap untuk buka Maps.';
        });
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() {
          _locLoading = false;
          _address = 'Izin lokasi ditolak. Tap untuk buka Maps.';
        });
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _lat = pos.latitude;
      _lng = pos.longitude;

      final placemarks = await placemarkFromCoordinates(_lat!, _lng!);

      String addr = 'Lokasi terdeteksi';
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          if ((p.street ?? '').isNotEmpty) p.street,
          if ((p.subLocality ?? '').isNotEmpty) p.subLocality,
          if ((p.locality ?? '').isNotEmpty) p.locality,
          if ((p.subAdministrativeArea ?? '').isNotEmpty)
            p.subAdministrativeArea,
          if ((p.administrativeArea ?? '').isNotEmpty) p.administrativeArea,
        ].whereType<String>().toList();
        addr = parts.isNotEmpty ? parts.join(', ') : addr;
      }

      _locFetched = true;
      _lastGeo = DateTime.now();

      if (!mounted) return;
      setState(() {
        _locLoading = false;
        _address = addr;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _locLoading = false;
        _address = 'Gagal ambil lokasi. Tap untuk buka Maps.';
      });
    }
  }

  Future<void> _openMaps() async {
    if (_lat == null || _lng == null) {
      await _initLocation();
    }

    final lat = _lat ?? -6.200000;
    final lng = _lng ?? 106.816666;

    final geoUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng(Lokasi Presensi)');
    final webUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (Platform.isAndroid && await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      return;
    }
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  // ================= UI =================
  Widget _roundedButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool primary = false,
    bool disabled = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: primary ? AppTheme.primary : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEADDE6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: primary ? Colors.white : AppTheme.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: primary ? Colors.white : AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationOverlay() {
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: InkWell(
        onTap: _openMaps,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _locLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.map_outlined, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canSwitch = _ready && _frontIndex != -1 && _backIndex != -1;

    return BlocListener<PresensiBloc, PresensiState>(
  listener: (context, state) {
    state.whenOrNull(
      loaded: (res) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(res.message))),
      error: (msg) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg))),
    );
  }, child: Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Presensi'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  color: Colors.black,
                  child: widget.active
                      ? (_ready
                          ? Stack(
                              children: [
                                Positioned.fill(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: _controller!.value.previewSize!.height,
                                      height: _controller!.value.previewSize!.width,
                                      child: CameraPreview(_controller!),
                                    ),
                                  ),
                                ),
                                _locationOverlay(),
                                if (_isTaking)
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.black.withOpacity(0.35),
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()))
                      : const Center(
                          child: Text(
                            'Kamera nonaktif',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                _roundedButton(
                  icon: Icons.cameraswitch_rounded,
                  label: 'Putar',
                  onTap: _switchCamera,
                  disabled: !canSwitch,
                ),
                const SizedBox(width: 12),
                _roundedButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Ambil',
                  onTap: _takePicture,
                  primary: true,
                  disabled: !_ready,
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}
