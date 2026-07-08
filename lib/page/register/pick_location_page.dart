import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:yofa/theme/app_theme.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  final MapController mapController = MapController();
  final TextEditingController searchCtrl = TextEditingController();

  Timer? _debounce;

  static const Color primaryColor = Color.fromRGBO(101, 39, 105, 1);

  LatLng selectedLatLng = const LatLng(-7.705, 110.606);
  String selectedAddress = 'Pilih titik lokasi';

  bool loading = true;
  bool loadingAddress = false;
  bool searching = false;
  String mapType = 'm';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() => loading = false);
        return;
      }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => loading = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      await _setLocation(
        LatLng(position.latitude, position.longitude),
      );
    } catch (_) {
      setState(() => loading = false);
    }
  }

  Future<String?> _getAddressFromLatLng(LatLng point) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse'
      '?format=jsonv2'
      '&lat=${point.latitude}'
      '&lon=${point.longitude}'
      '&zoom=18'
      '&addressdetails=1',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'YofaApp/1.0',
      },
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    final displayName = data['display_name'];

    if (displayName == null || displayName.toString().trim().isEmpty) {
      return null;
    }

    return displayName.toString();
  }

  Future<LatLng?> _getLatLngFromAddress(String keyword) async {
    final encodedKeyword = Uri.encodeComponent(keyword);

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search'
      '?format=jsonv2'
      '&q=$encodedKeyword'
      '&limit=1'
      '&addressdetails=1',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'YofaApp/1.0',
      },
    );

    if (response.statusCode != 200) return null;

    final List data = jsonDecode(response.body);

    if (data.isEmpty) return null;

    final lat = double.tryParse(data.first['lat'].toString());
    final lon = double.tryParse(data.first['lon'].toString());

    if (lat == null || lon == null) return null;

    return LatLng(lat, lon);
  }

  Future<void> _setLocation(
    LatLng point, {
    bool moveCamera = true,
  }) async {
    setState(() {
      selectedLatLng = point;
      selectedAddress = 'Mencari alamat...';
      loadingAddress = true;
    });

    final address = await _getAddressFromLatLng(point);

    if (!mounted) return;

    setState(() {
      selectedAddress = address ?? 'Alamat belum ditemukan, geser titik marker';
      loadingAddress = false;
      loading = false;
    });

    if (moveCamera) {
      mapController.move(point, 17);
    }
  }

  Future<void> _searchAddress(String value) async {
    final keyword = value.trim();

    if (keyword.isEmpty) return;

    setState(() {
      searching = true;
    });

    final point = await _getLatLngFromAddress(keyword);

    if (!mounted) return;

    setState(() {
      searching = false;
    });

    if (point == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alamat tidak ditemukan'),
        ),
      );
      return;
    }

    await _setLocation(point);
  }

  void _submitLocation() {
    if (selectedAddress == 'Mencari alamat...' ||
        selectedAddress.startsWith('Alamat belum ditemukan')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alamat belum ditemukan, coba geser marker lagi.'),
        ),
      );
      return;
    }

    Navigator.pop(context, {
      'address': selectedAddress,
      'lat': selectedLatLng.latitude,
      'lng': selectedLatLng.longitude,
    });
  }

  Widget _topSearchBar() {
    return Positioned(
      top: 45,
      left: 16,
      right: 16,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: TextField(
                controller: searchCtrl,
                textInputAction: TextInputAction.search,
                onSubmitted: _searchAddress,
                onChanged: (value) {
                  setState(() {});

                  if (_debounce?.isActive ?? false) {
                    _debounce?.cancel();
                  }

                  _debounce = Timer(
                    const Duration(milliseconds: 800),
                    () => _searchAddress(value),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Cari alamat, outlet, kota...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: primaryColor,
                  ),
                  suffixIcon: searching
                      ? const Padding(
                          padding: EdgeInsets.all(14),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                searchCtrl.clear();
                                setState(() {});
                              },
                            )
                          : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.primary,
            elevation: 0,
            mini: true,
            
            onPressed: () {
              setState(() {
                mapType = mapType == 'm' ? 's' : 'm';
              });
            },
            child: Icon(
              mapType == 'm'
                  ? Icons.satellite_alt_rounded
                  : Icons.map_rounded,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomAddressCard() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedAddress,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loadingAddress ? null : _submitLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  loadingAddress ? 'Mencari Alamat...' : 'Gunakan Alamat Ini',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: selectedLatLng,
                    initialZoom: 16,
                    onTap: (tapPosition, point) {
                      _setLocation(point);
                    },
                  ),
                  children: [
                    TileLayer(
                      
                      urlTemplate:
                          'https://{s}.google.com/vt/lyrs=$mapType&x={x}&y={y}&z={z}',
                      subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                    ),
                    DragMarkers(
                      markers: [
                        DragMarker(
                          point: selectedLatLng,
                          size: const Size(58, 58),
                          offset: const Offset(0, -20),
                          builder: (_, __, ___) {
                            return const Icon(
                              Icons.location_on_rounded,
                              color: primaryColor,
                              size: 52,
                            );
                          },
                          onDragUpdate: (_, point) {
                            setState(() {
                              selectedLatLng = point;
                              selectedAddress =
                                  'Lepaskan marker untuk mencari alamat...';
                            });
                          },
                          onDragEnd: (_, point) {
                            _setLocation(
                              point,
                              moveCamera: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                _topSearchBar(),
                _bottomAddressCard(),
                // FloatingActionButton(
                //     backgroundColor: Colors.white,
                //     onPressed: () {
                //       setState(() {
                //         mapType = mapType == 'm' ? 's' : 'm';
                //       });
                //     },
                //     child: Icon(
                //       mapType == 'm'
                //           ? Icons.satellite_alt_rounded
                //           : Icons.map_rounded,
                //       color: AppTheme.primary,
                //     ),
                //   ),
              ],
            ),
    );
  }
}

