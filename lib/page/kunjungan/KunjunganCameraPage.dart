import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_theme.dart';
import 'kunjungan_page.dart'; // untuk akses VisitItem (sesuaikan path)

class Kunjungancamerapage extends StatefulWidget {
  final VisitItem item;

  const Kunjungancamerapage({super.key, required this.item});

  @override
  State<Kunjungancamerapage> createState() => _KunjungancamerapageState();
}

class _KunjungancamerapageState extends State<Kunjungancamerapage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _selectedIndex = 0;
  bool _isTaking = false;

  // cegah init kamera berulang (race)
  bool _startingCamera = false;

  // ====== LOCATION STATE ======
  bool _locLoading = false;
  String _address = 'Mengambil lokasi...';
  double? _lat;
  double? _lng;

  bool _isDisposing = false;

  // cache/throttle lokasi biar ga spam (menghindari freeze)
  bool _locFetched = false;
  DateTime? _lastGeo;

  bool get _ready => _controller != null && _controller!.value.isInitialized;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
    _initLocation();
  }

  Future<void> _stopCamera({bool rebuild = true}) async {
    final old = _controller;
    _controller = null;

    // setState hanya jika widget masih hidup & bukan lagi proses dispose
    if (rebuild && mounted && !_isDisposing) {
      setState(() {});
    }

    await old?.dispose();
  }


  @override
  void dispose() {
    _isDisposing = true;
    WidgetsBinding.instance.removeObserver(this);

    // jangan rebuild saat dispose
    _stopCamera(rebuild: false);

    super.dispose();
}


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
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

      // default kamera depan
      final frontIndex = _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front);
      _selectedIndex = frontIndex != -1 ? frontIndex : 0;

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
    // dispose controller lama dengan aman
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

  Future<void> _switchCamera() async {
    if (_cameras.length < 2 || !_ready) return;
    _selectedIndex = (_selectedIndex + 1) % _cameras.length;
    await _startCamera(_cameras[_selectedIndex]);
  }

  Future<void> _takePicture() async {
    if (!_ready || _isTaking) return;

    try {
      if (!mounted) return;
      setState(() => _isTaking = true);

      await _controller!.setFlashMode(FlashMode.off);
      final XFile file = await _controller!.takePicture();

      if (!mounted) return;
      setState(() => _isTaking = false);

      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (dCtx) => Dialog(
          insetPadding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.file(File(file.path), fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () => Navigator.pop(dCtx),
                    icon: const Icon(Icons.close_rounded),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // TODO: upload file.path + widget.item + _lat/_lng + _address
    } catch (e) {
      if (!mounted) return;
      setState(() => _isTaking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil foto: $e')),
      );
    }
  }

  // ====== LOCATION ======
  Future<void> _initLocation() async {
    // throttle biar ga spam
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
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() {
          _locLoading = false;
          _address = 'Izin lokasi ditolak. Tap untuk buka Maps.';
        });
        return;
      }

      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

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
          if ((p.subAdministrativeArea ?? '').isNotEmpty) p.subAdministrativeArea,
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

    final geoUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng(Lokasi Kunjungan)');
    final webUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (Platform.isAndroid && await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      return;
    }
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  // ====== UI ======
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

  Widget _topOverlay() {
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: Column(
        children: [
          // outlet + tanggal
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.storefront_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.outlet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, size: 14, color: Colors.white70),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.item.date,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // alamat (tap -> maps)
          InkWell(
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Kamera Kunjungan'),
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
                  child: _ready
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
                            _topOverlay(),
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
                      : const Center(child: CircularProgressIndicator()),
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
                  label: 'Switch',
                  onTap: _switchCamera,
                  disabled: !_ready || _cameras.length < 2,
                ),
                const SizedBox(width: 12),
                _roundedButton(
                  icon: Icons.camera_alt_rounded,
                  label: 'Ambil Foto',
                  onTap: _takePicture,
                  primary: true,
                  disabled: !_ready,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
