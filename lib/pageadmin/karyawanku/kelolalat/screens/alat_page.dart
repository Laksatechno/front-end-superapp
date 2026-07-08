import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/bloc/riwayat_bloc.dart';
import 'package:yofa/pageadmin/karyawanku/kelolalat/model/maintenance_model.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final MobileScannerController _cameraController = MobileScannerController();

  final TextEditingController _searchRiwayatCtrl = TextEditingController();
  final TextEditingController _searchTerpasangCtrl = TextEditingController();
  final TextEditingController _dateFromCtrl = TextEditingController();
  final TextEditingController _dateToCtrl = TextEditingController();
  Timer? _searchRiwayatDebounce;
  bool _isMaintenanceFormOpen = false;
  bool _isProcessingScan = false;

  XFile? fotoHasil;


  final List<_AlatUiItem> _alatTerpasang = const [
    _AlatUiItem(
      outlet: 'PT Macro Inti Guna',
      noseri: 'Ma22090400100',
      status: 'kso',
      kondisi: 'Second',
      tanggalInstall: '2022-10-25',
    ),
    _AlatUiItem(
      outlet: 'Puskesmas Pakjo',
      noseri: 'Ma22090400067',
      status: 'kso',
      kondisi: 'Second',
      tanggalInstall: '2024-07-11',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cameraController.dispose();
    _searchRiwayatCtrl.dispose();
    _searchTerpasangCtrl.dispose();
    _dateFromCtrl.dispose();
    _dateToCtrl.dispose();
    _searchRiwayatDebounce?.cancel();
    super.dispose();
  }

Future<void> _refreshUi() async {
  if (_tabController.index == 1) {
      BlocProvider.of<RiwayatBloc>(context).add(
        RiwayatEvent.refresh(
          from: _dateFromCtrl.text.trim().isEmpty ? null : _dateFromCtrl.text.trim(),
          to: _dateToCtrl.text.trim().isEmpty ? null : _dateToCtrl.text.trim(),
          search: _searchRiwayatCtrl.text.trim().isEmpty
              ? null
              : _searchRiwayatCtrl.text.trim(),
        ),
      );
    return;
  }

  setState(() {});
}

void _getRiwayatData() {
  context.read<RiwayatBloc>().add(
        RiwayatEvent.changeFilter(
          from: _dateFromCtrl.text.trim().isEmpty ? null : _dateFromCtrl.text.trim(),
          to: _dateToCtrl.text.trim().isEmpty ? null : _dateToCtrl.text.trim(),
          search: _searchRiwayatCtrl.text.trim().isEmpty ? null : _searchRiwayatCtrl.text.trim(),
        ),
      );
}

void _onSearchRiwayatChanged(String value) {
  _searchRiwayatDebounce?.cancel();
  _searchRiwayatDebounce = Timer(const Duration(milliseconds: 500), () {
    _getRiwayatData();
  });

  setState(() {});
}

Future<void> _showMaintenanceForm(String noseri) async {
  final noSeriCtrl = TextEditingController(text: noseri);
  final customerCtrl = TextEditingController();
  final kalibrasiAwalCtrl = TextEditingController();
  final kalibrasiAkhirCtrl = TextEditingController();
  final kodeRefCtrl = TextEditingController();
  final terakhirDigunakanCtrl = TextEditingController();
  final riwayatCtrl = TextEditingController();
  final noSeriBackupCtrl = TextEditingController();
  final catatanCtrl = TextEditingController();

  DateTime? terakhirDigunakan;

  final customers = <String>[
    'Nama Outlet',
    'Customer A',
    'Customer B',
  ];

  try {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
          Future<void> pickCamera() async {
            try {
              final picker = ImagePicker();

              final picked = await picker.pickImage(
                source: kIsWeb ? ImageSource.gallery : ImageSource.camera,
                imageQuality: 75,
              );

              if (picked != null) {
                setSheetState(() {
                  fotoHasil = picked;
                });
              }
            } catch (e) {
              debugPrint('Gagal ambil foto: $e');
            }
          }

            Future<void> pickDate() async {
              final pickedDate = await showDatePicker(
                context: sheetContext,
                initialDate: terakhirDigunakan ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setSheetState(() {
                  terakhirDigunakan = pickedDate;
                  terakhirDigunakanCtrl.text =
                      '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                });
              }
            }

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
                            Icons.build_circle_rounded,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambah Maintenance',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Lengkapi data hasil maintenance alat',
                                style: TextStyle(
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom:
                            MediaQuery.of(sheetContext).viewInsets.bottom + 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formSection(
                            title: 'Foto Hasil',
                            child: InkWell(
                              onTap: pickCamera,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double.infinity,
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppTheme.border),
                                ),
                                child: fotoHasil == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 58,
                                            height: 58,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primary
                                                  .withOpacity(0.12),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.camera_alt_rounded,
                                              size: 30,
                                              color: AppTheme.primary,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            'Ambil Foto dari Camera',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.textDark,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Tap untuk membuka camera',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppTheme.textMuted,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              fotoHasil!.path,
                                              width: double.infinity,
                                              height: 170,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius: BorderRadius.circular(99),
                                              ),
                                              child: IconButton(
                                                onPressed: pickCamera,
                                                icon: const Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          _formSection(
                            title: 'Informasi Alat',
                            child: Column(
                              children: [
                                _inputField(
                                  controller: noSeriCtrl,
                                  label: 'No Seri',
                                  icon: Icons.qr_code_rounded,
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: customerCtrl.text.isEmpty
                                      ? null
                                      : customerCtrl.text,
                                  isExpanded: true,
                                  decoration: _fieldDecoration(
                                    label: 'Customer',
                                    icon: Icons.store_rounded,
                                  ),
                                  items: customers.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setSheetState(() {
                                      customerCtrl.text = value ?? '';
                                    });
                                  },
                                ),
                                const SizedBox(height: 10),
                                _inputField(
                                  controller: kodeRefCtrl,
                                  label: 'Kode Ref',
                                  icon: Icons.confirmation_number_rounded,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          _formSection(
                            title: 'Kalibrasi & Pemakaian',
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _inputField(
                                        controller: kalibrasiAwalCtrl,
                                        label: 'Kalibrasi Awal',
                                        icon: Icons.speed_rounded,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _inputField(
                                        controller: kalibrasiAkhirCtrl,
                                        label: 'Kalibrasi Akhir',
                                        icon: Icons.speed_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: terakhirDigunakanCtrl,
                                  readOnly: true,
                                  onTap: pickDate,
                                  decoration: _fieldDecoration(
                                    label: 'Terakhir Digunakan',
                                    icon: Icons.calendar_month_rounded,
                                    suffixIcon:
                                        Icons.arrow_drop_down_rounded,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _inputField(
                                  controller: riwayatCtrl,
                                  label: 'Riwayat',
                                  icon: Icons.history_rounded,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          _formSection(
                            title: 'Tambahan',
                            child: Column(
                              children: [
                                _inputField(
                                  controller: noSeriBackupCtrl,
                                  label: 'No Seri Backup (Opsional)',
                                  icon: Icons.qr_code_2_rounded,
                                ),
                                const SizedBox(height: 10),
                                _inputField(
                                  controller: catatanCtrl,
                                  label: 'Catatan',
                                  icon: Icons.notes_rounded,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: AppTheme.border),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final data = {
                            'foto_hasil': fotoHasil?.path,
                            'noseri': noSeriCtrl.text.trim(),
                            'customer': customerCtrl.text.trim(),
                            'kalibrasi_awal': kalibrasiAwalCtrl.text.trim(),
                            'kalibrasi_akhir': kalibrasiAkhirCtrl.text.trim(),
                            'kode_ref': kodeRefCtrl.text.trim(),
                            'terakhir_digunakan':
                                terakhirDigunakanCtrl.text.trim(),
                            'riwayat': riwayatCtrl.text.trim(),
                            'sn_backup':
                                noSeriBackupCtrl.text.trim().isEmpty
                                    ? null
                                    : noSeriBackupCtrl.text.trim(),
                            'ket_mt': catatanCtrl.text.trim(),
                          };

                          Navigator.pop(sheetContext, data);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.save_rounded),
                        label: const Text(
                          'Simpan Maintenance',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  } finally {
    noSeriCtrl.dispose();
    customerCtrl.dispose();
    kalibrasiAwalCtrl.dispose();
    kalibrasiAkhirCtrl.dispose();
    kodeRefCtrl.dispose();
    terakhirDigunakanCtrl.dispose();
    riwayatCtrl.dispose();
    noSeriBackupCtrl.dispose();
    catatanCtrl.dispose();
  }
}

Widget _formSection({
  required String title,
  required Widget child,
}) {
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

InputDecoration _fieldDecoration({
  required String label,
  required IconData icon,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
    filled: true,
    fillColor: const Color(0xFFFCFAFC),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppTheme.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppTheme.primary,
        width: 1.4,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
  );
}

void _showEditForm(MaintenanceModel item) {
  final hasilCtrl = TextEditingController(text: item.kalibrasiMt ?? '');
  final ketCtrl = TextEditingController(text: item.ketMt ?? '');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return _BottomSheetContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SheetTitle('Edit Maintenance'),
            const SizedBox(height: 12),
            _readonlyField('Outlet', item.displayOutlet),
            const SizedBox(height: 10),
            _readonlyField('No Seri', item.displayNoSeri),
            const SizedBox(height: 10),
            _readonlyField('QC Awal', item.displayQc),
            const SizedBox(height: 10),
            _inputField(
              controller: hasilCtrl,
              label: 'Kalibrasi Maintenance',
              icon: Icons.speed_rounded,
            ),
            const SizedBox(height: 10),
            _inputField(
              controller: ketCtrl,
              label: 'Keterangan',
              icon: Icons.notes_rounded,
              maxLines: 3,
            ),
            const SizedBox(height: 14),
            _submitButton(
              text: 'Update',
              icon: Icons.save_rounded,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

  void _showMoveForm(_AlatUiItem item) {
    final tujuanCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return _BottomSheetContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SheetTitle('Pindah Alat'),
              const SizedBox(height: 12),
              _readonlyField('Outlet Saat Ini', item.outlet),
              const SizedBox(height: 10),
              _readonlyField('No Seri', item.noseri),
              const SizedBox(height: 10),
              _inputField(
                controller: tujuanCtrl,
                label: 'ID Customer / Tujuan Baru',
                icon: Icons.store_rounded,
              ),
              const SizedBox(height: 14),
              _submitButton(
                text: 'Pindahkan',
                icon: Icons.compare_arrows_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dateFilterField({
  required String label,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    readOnly: true,
    onTap: () async {
      final now = DateTime.now();

      final picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 5),
        lastDate: DateTime(now.year + 5),
      );

      if (picked == null) return;

      controller.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

      setState(() {});
    },
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.calendar_month_rounded),
      suffixIcon: controller.text.isEmpty
          ? null
          : IconButton(
              onPressed: () {
                controller.clear();
                setState(() {});
              },
              icon: const Icon(Icons.close_rounded),
            ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}

  Widget _tabScan() {
    return RefreshIndicator(
      onRefresh: _refreshUi,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _panel(
            child: Column(
              children: [
                Row(
                  children: [
                    _pill('Maintenance'),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        DateTime.now().toString().substring(0, 19),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Scan QR Code Alat',
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
                      if (_isMaintenanceFormOpen || _isProcessingScan) return;

                      final code = capture.barcodes.firstOrNull?.rawValue;

                      if (code != null && code.isNotEmpty) {
                        _isProcessingScan = true;
                        _isMaintenanceFormOpen = true;

                        await _cameraController.stop();

                        await _showMaintenanceForm(code);

                        _isMaintenanceFormOpen = false;
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
    );
  }

Widget _tabRiwayat() {
  return RefreshIndicator(
    onRefresh: _refreshUi,
    child: BlocBuilder<RiwayatBloc, RiwayatState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _panel(
              child: Column(
                children: [
                  TextField(
                    controller: _searchRiwayatCtrl,
                    onChanged: _onSearchRiwayatChanged,
                    decoration: InputDecoration(
                      hintText: 'Cari No Seri / Outlet / Teknisi',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchRiwayatCtrl.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchRiwayatCtrl.clear();
                                setState(() {});
                                _getRiwayatData();
                              },
                              icon: const Icon(Icons.close_rounded),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 560;

                      if (isMobile) {
                        return Column(
                          children: [
                            _dateFilterField(
                              label: 'Tanggal Mulai',
                              controller: _dateFromCtrl,
                            ),
                            const SizedBox(height: 10),
                            _dateFilterField(
                              label: 'Tanggal Akhir',
                              controller: _dateToCtrl,
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: _dateFilterField(
                              label: 'Tanggal Mulai',
                              controller: _dateFromCtrl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dateFilterField(
                              label: 'Tanggal Akhir',
                              controller: _dateToCtrl,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {
                        _searchRiwayatCtrl.clear();
                        _dateFromCtrl.clear();
                        _dateToCtrl.clear();
                        setState(() {});
                        context.read<RiwayatBloc>().add(
                              const RiwayatEvent.getRiwayats(),
                            );
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            state.when(
              initial: () {
                context.read<RiwayatBloc>().add(
                      const RiwayatEvent.getRiwayats(),
                    );
                return const SizedBox.shrink();
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (message) => _RiwayatError(
                message: message,
                onRefresh: () {
                  context.read<RiwayatBloc>().add(
                        RiwayatEvent.refresh(
                          from: _dateFromCtrl.text.trim().isEmpty
                              ? null
                              : _dateFromCtrl.text.trim(),
                          to: _dateToCtrl.text.trim().isEmpty
                              ? null
                              : _dateToCtrl.text.trim(),
                          search: _searchRiwayatCtrl.text.trim().isEmpty
                              ? null
                              : _searchRiwayatCtrl.text.trim(),
                        ),
                      );
                },
              ),
              success: (message) => Center(child: Text(message)),
              loaded: (data, from, to, search) {
                if (data.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: Text('Data tidak ditemukan')),
                  );
                }

                return Column(
                  children: data
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _RiwayatCard(
                            item: item,
                            onEdit: () => _showEditForm(item),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        );
      },
    ),
  );
}
  Widget _tabAlatTerpasang() {
    return RefreshIndicator(
      onRefresh: _refreshUi,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _filterPanel(
            controller: _searchTerpasangCtrl,
            hint: 'Cari No Seri / Outlet',
            onSearch: () => setState(() {}),
          ),
          const SizedBox(height: 12),
          ..._alatTerpasang.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _TerpasangCard(
                item: item,
                onMove: () => _showMoveForm(item),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterPanel({
    required TextEditingController controller,
    required String hint,
    required VoidCallback onSearch,
  }) {
    return _panel(
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
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

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
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

  Widget _submitButton({
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
        label: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _readonlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.bg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Manajemen Alat'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Scan'),
            Tab(text: 'Riwayat'),
            Tab(text: 'Alat Terpasang'),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: TabBarView(
            controller: _tabController,
            children: [
              _tabScan(),
              _tabRiwayat(),
              _tabAlatTerpasang(),
            ],
          ),
        ),
      ),
    );
  }
}



class _RiwayatUiItem {
  final String tanggal;
  final String jam;
  final String outlet;
  final String noseri;
  final String teknisi;
  final String qcAwal;
  final String hasil;
  final String keterangan;
  final String lokasi;

  const _RiwayatUiItem({
    required this.tanggal,
    required this.jam,
    required this.outlet,
    required this.noseri,
    required this.teknisi,
    required this.qcAwal,
    required this.hasil,
    required this.keterangan,
    required this.lokasi,
  });
}

class _AlatUiItem {
  final String outlet;
  final String noseri;
  final String status;
  final String kondisi;
  final String tanggalInstall;

  const _AlatUiItem({
    required this.outlet,
    required this.noseri,
    required this.status,
    required this.kondisi,
    required this.tanggalInstall,
  });
}

class _RiwayatCard extends StatelessWidget {
  final MaintenanceModel item;
  final VoidCallback onEdit;

  const _RiwayatCard({
    required this.item,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _DateBadge(
                  date: item.tglMt ?? '-',
                  time: item.jamMt ?? '-',
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_rounded),
                color: AppTheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _InfoText(label: 'Outlet', value: item.displayOutlet),
          _InfoText(label: 'No Seri', value: item.displayNoSeri),
          _InfoText(label: 'Teknisi', value: item.displayTeknisi),
          _InfoText(label: 'QC Awal', value: item.displayQc),
          _InfoText(label: 'Hasil', value: item.displayHasil),
          _InfoText(label: 'Keterangan', value: item.ketMt ?? '-'),
          _InfoText(label: 'Lokasi', value: item.lokasiMt ?? '-'),
        ],
      ),
    );
  }
}

class _RiwayatError extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;

  const _RiwayatError({
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 44,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Muat Ulang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TerpasangCard extends StatelessWidget {
  final _AlatUiItem item;
  final VoidCallback onMove;

  const _TerpasangCard({
    required this.item,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoText(label: 'Outlet', value: item.outlet),
          _InfoText(label: 'No Seri', value: item.noseri),
          _InfoText(label: 'Status', value: item.status),
          _InfoText(label: 'Kondisi', value: item.kondisi),
          _InfoText(label: 'Tanggal Install', value: item.tanggalInstall),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onMove,
              icon: const Icon(Icons.compare_arrows_rounded),
              label: const Text('Pindah'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  final String date;
  final String time;

  const _DateBadge({
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        const Icon(Icons.event_rounded, size: 18, color: AppTheme.primary),
        Text(
          '$date  $time',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}

class _BaseCard extends StatelessWidget {
  final Widget child;

  const _BaseCard({required this.child});

  @override
  Widget build(BuildContext context) {
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
}

class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        '$label : $value',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppTheme.textMuted,
        ),
      ),
    );
  }
}

class _BottomSheetContainer extends StatelessWidget {
  final Widget child;

  const _BottomSheetContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SafeArea(
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  final String title;

  const _SheetTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 18,
        color: AppTheme.textDark,
      ),
    );
  }
}