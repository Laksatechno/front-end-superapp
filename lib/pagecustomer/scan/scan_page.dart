import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/datasource/riwayat_ds.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  final MobileScannerController _cameraController = MobileScannerController();

  bool _isRiwayatOpen = false;
  bool _isProcessingScan = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _showRiwayatMaintenance(String noseri) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await RiwayatDataSource().getRiwayat(search: noseri);

    if (mounted) Navigator.of(context, rootNavigator: true).pop();

    result.fold(
      (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      },
      (riwayatList) async {
        if (!mounted) return;
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(sheetContext).size.height * 0.92,
              ),
              decoration: const BoxDecoration(
                color: AppTheme.bg,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 46,
                    height: 5,
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.history_rounded,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Riwayat Maintenance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'No Seri: $noseri',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: riwayatList.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 52,
                                  color: AppTheme.textMuted,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Belum ada riwayat maintenance',
                                  style: TextStyle(
                                    color: AppTheme.textMuted,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            itemCount: riwayatList.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final item = riwayatList[index];
                              return _riwayatCard(item);
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _riwayatCard(MaintenanceModel item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.tglMt ?? '-',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.jamMt ?? '-',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoRow(
            icon: Icons.store_rounded,
            label: 'Outlet',
            value: item.displayOutlet,
          ),
          const SizedBox(height: 8),
          _infoRow(
            icon: Icons.person_rounded,
            label: 'Teknisi',
            value: item.displayTeknisi,
          ),
          const SizedBox(height: 8),
          _infoRow(
            icon: Icons.speed_rounded,
            label: 'Kalibrasi Awal',
            value: item.displayQc,
          ),
          const SizedBox(height: 8),
          _infoRow(
            icon: Icons.build_circle_rounded,
            label: 'Hasil Kalibrasi',
            value: item.displayHasil,
          ),
          if (item.ketMt != null && item.ketMt!.isNotEmpty) ...[
            const SizedBox(height: 8),
            _infoRow(
              icon: Icons.notes_rounded,
              label: 'Catatan',
              value: item.ketMt!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.textMuted),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Scan Alat'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _panel(
                child: Column(
                  children: [
                    const Text(
                      'Arahkan Kamera Di Barcode Alat ',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.border),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: MobileScanner(
                        controller: _cameraController,
                        onDetect: (capture) async {
                          if (_isRiwayatOpen || _isProcessingScan) return;

                          final code = capture.barcodes.firstOrNull?.rawValue;

                          if (code != null && code.isNotEmpty) {
                            _isProcessingScan = true;
                            _isRiwayatOpen = true;

                            await _cameraController.stop();

                            await _showRiwayatMaintenance(code);

                            _isRiwayatOpen = false;
                            _isProcessingScan = false;

                            await _cameraController.start();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _primaryButton(
                      text: 'Switch Camera',
                      icon: Icons.cameraswitch_rounded,
                      onTap: () => _cameraController.switchCamera(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.border),
      ),
      child: child,
    );
  }

  Widget _primaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
