import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../theme/app_theme.dart';

class ScanAlatPage extends StatefulWidget {
  const ScanAlatPage({super.key});

  @override
  State<ScanAlatPage> createState() => _ScanAlatPageState();
}

class _ScanAlatPageState extends State<ScanAlatPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  final MobileScannerController cameraController = MobileScannerController();
  // ===== RIWAYAT FILTER =====
  final TextEditingController _searchHistoryCtrl = TextEditingController();
  final TextEditingController _dateFromCtrl = TextEditingController(text: 'Tanggal Awal');
  final TextEditingController _dateToCtrl = TextEditingController(text: '22-01-2026');

  // ===== ALAT TERPASANG FILTER =====
  int _showEntries = 10;
  final TextEditingController _searchInstalledCtrl = TextEditingController();

  // dummy data
  final List<_HistoryItem> _histories = const [
    _HistoryItem(
      dateLabel: '22 Januari 2026',
      time: '11:14:42',
      outlet: 'PT. Indo Genesis',
      serial: 'Ma23030440001',
      technician: 'Putera Annyasep Dumas',
      qc: '25',
      result: '25',
    ),
    _HistoryItem(
      dateLabel: '21 Januari 2026',
      time: '10:05:12',
      outlet: 'Puskesmas Cangkringan',
      serial: 'Ma23070340002',
      technician: 'Gilardo Destri Abu Bakar',
      qc: '9.5',
      result: '9.5',
    ),
  ];

  final List<_InstalledItem> _installed = const [
    _InstalledItem(outlet: 'BLUD Brebes', serial: 'Ma23070340002'),
    _InstalledItem(outlet: 'Bu Eli Hartati', serial: 'Mc24040760001'),
    _InstalledItem(outlet: 'Bu Rukiyah', serial: 'Ma23034440005'),
    _InstalledItem(outlet: 'CV. Labcore', serial: 'Mc24040760007'),
  ];

  bool _isScanning = false;

  String _last13Digits(String value) {
    final onlyDigits = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (onlyDigits.length <= 13) {
      return onlyDigits;
    }

    return onlyDigits.substring(onlyDigits.length - 13);
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _searchHistoryCtrl.dispose();
    _searchInstalledCtrl.dispose();
    _dateFromCtrl.dispose();
    _dateToCtrl.dispose();
    cameraController.dispose();
    super.dispose();
  }

  // ====== UI HELPERS ======
  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _pill({
    required String text,
    Color bg = const Color(0xFFF4ECF2),
    Color fg = AppTheme.primary,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w900, color: fg, fontSize: 12),
      ),
    );
  }

  Widget _primaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    bool secondary = false,
  }) {
    final bg = secondary ? const Color(0xFF5C6B7A) : AppTheme.primary;
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return;
    final dd = picked.day.toString().padLeft(2, '0');
    final mm = picked.month.toString().padLeft(2, '0');
    ctrl.text = '$dd-$mm-${picked.year}';
    if (mounted) setState(() {});
  }

  // ====== TAB: SCAN ======

  Widget _tabScan() {
    // hanya UI mock (sesuai screenshot)
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        _card(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _pill(
                        text: 'Maintenance',
                        bg: AppTheme.primary,
                        fg: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '22 Jan 2026',
                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '3:24:09 PM',
                        style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Lokasi Anda:',
                style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
              ),
              const SizedBox(height: 6),
              const Text(
                'Lokasi Anda: -7.813162787331573,\n110.436125185561889',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B), height: 1.2),
              ),
              const SizedBox(height: 12),
              const Text(
                'Barcode:',
                style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
              ),
              const SizedBox(height: 6),
              // 🔥 CAMERA VIEW
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                clipBehavior: Clip.hardEdge,
                child: MobileScanner(
                  controller: cameraController,
                  onDetect: (BarcodeCapture barcodeCapture) {
                    if (_isScanning) return;

                    final List<Barcode> barcodes = barcodeCapture.barcodes;

                    for (final barcode in barcodes) {
                      final String? code = barcode.rawValue;

                      if (code != null && code.trim().isNotEmpty) {
                        _isScanning = true;

                        final String resultCode = _last13Digits(code);

                        debugPrint('Barcode asli: $code');
                        debugPrint('13 digit terakhir: $resultCode');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Barcode: $resultCode'),
                          ),
                        );

                        // contoh jika mau isi ke TextEditingController
                        // barcodeCtrl.text = resultCode;

                        Future.delayed(const Duration(seconds: 1), () {
                          _isScanning = false;
                        });

                        break;
                      }
                    }
                  },
                ),
              ),

            const SizedBox(height: 10),
              const Text(
                'Customers :',
                style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B)),
              ),
              const SizedBox(height: 14),
              _primaryButton(
                text: 'Mulai Scan',
                icon: Icons.qr_code_scanner_rounded,
                onTap: () {
                  // TODO: mulai scan (camera / barcode)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('TODO: Mulai Scan')),
                  );
                },
              ),
              const SizedBox(height: 12),
              _primaryButton(
                text: 'Switch Camera',
                icon: Icons.cameraswitch_rounded,
                secondary: true,
                onTap: () {
                  cameraController.switchCamera();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ====== TAB: RIWAYAT ======
  Widget _tabRiwayat() {
    final q = _searchHistoryCtrl.text.trim().toLowerCase();
    final filtered = q.isEmpty
        ? _histories
        : _histories.where((e) {
            return e.serial.toLowerCase().contains(q) ||
                e.outlet.toLowerCase().contains(q) ||
                e.technician.toLowerCase().contains(q);
          }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        _card(
          child: Column(
            children: [
              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEFE6EC)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchHistoryCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Cari No Seri',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_searchHistoryCtrl.text.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          _searchHistoryCtrl.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Filter range
              Row(
                children: [
                  Expanded(
                    child: _dateField(
                      label: 'Filter Mulai',
                      controller: _dateFromCtrl,
                      onTap: () => _pickDate(_dateFromCtrl),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dateField(
                      label: 'Sampai',
                      controller: _dateToCtrl,
                      onTap: () => _pickDate(_dateToCtrl),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: _miniBtn(
                      text: 'Tampil',
                      icon: Icons.check_rounded,
                      bg: AppTheme.primary,
                      onTap: () {
                        // TODO: apply filter
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Filter diterapkan (UI)')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _miniBtn(
                      text: 'Clear',
                      icon: Icons.refresh_rounded,
                      bg: const Color(0xFF25B56B),
                      onTap: () {
                        _dateFromCtrl.text = 'Tanggal Awal';
                        _dateToCtrl.text = 'Tanggal Akhir';
                        _searchHistoryCtrl.clear();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _miniBtn(
                text: 'Cetak',
                icon: Icons.print_rounded,
                bg: const Color(0xFFE63B5C),
                onTap: () {
                  // TODO: print/download pdf
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('TODO: Cetak')),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // list history cards
        ...filtered.map((it) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _HistoryCard(item: it),
            )),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'Tidak ada data',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.45),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ====== TAB: ALAT TERPASANG ======
  Widget _tabAlatTerpasang() {
    final q = _searchInstalledCtrl.text.trim().toLowerCase();
    final filtered = q.isEmpty
        ? _installed
        : _installed.where((e) {
            return e.serial.toLowerCase().contains(q) ||
                e.outlet.toLowerCase().contains(q);
          }).toList();

    final list = filtered.take(_showEntries).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // show entries
              Row(
                children: [
                  const Text(
                    'Show',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B)),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _showEntries,
                        items: const [10, 25, 50, 100]
                            .map((v) => DropdownMenuItem(value: v, child: Text('$v')))
                            .toList(),
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _showEntries = v);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'entries',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // search field
              Row(
                children: [
                  const Text(
                    'Search:',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFEFE6EC)),
                      ),
                      child: TextField(
                        controller: _searchInstalledCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F6F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE6EC)),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text('Outlet',
                          style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('No Seri',
                          style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Aksi',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // rows
              // ...list.map((it) => Padding(
              //       padding: const EdgeInsets.only(bottom: 8),
              //       child: _InstalledRow(
              //         item: it,
              //         onInfo: () {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('Detail: ${it.serial}')),
              //           );
              //         },
              //         onRefresh: () {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('Refresh/Sync: ${it.serial}')),
              //           );
              //         },
              //       ),
              //     )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6F646B),
                    )),
                const SizedBox(height: 6),
                Text(controller.text,
                    style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.calendar_month_rounded, color: Color(0xFF6F646B)),
          ),
        ],
      ),
    );
  }

  Widget _miniBtn({
    required String text,
    required IconData icon,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 44,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(text, style: const TextStyle(fontWeight: FontWeight.w900)),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tab,
              labelColor: AppTheme.primary,
              unselectedLabelColor: const Color(0xFF8B7F86),
              indicatorColor: AppTheme.primary,
              indicatorWeight: 2.4,
              labelStyle: const TextStyle(fontWeight: FontWeight.w900),
              tabs: const [
                Tab(text: 'Scan'),
                Tab(text: 'Riwayat'),
                Tab(text: 'Alat\nTerpasang'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _tabScan(),
          _tabRiwayat(),
          _tabAlatTerpasang(),
        ],
      ),
    );
  }
}

// =================== WIDGETS ===================

class _HistoryItem {
  final String dateLabel;
  final String time;
  final String outlet;
  final String serial;
  final String technician;
  final String qc;
  final String result;

  const _HistoryItem({
    required this.dateLabel,
    required this.time,
    required this.outlet,
    required this.serial,
    required this.technician,
    required this.qc,
    required this.result,
  });
}

// =================== WIDGETS Alat Terpasang===================

class _AlatTerpasangItem {
  final String dateLabel;
  final String time;
  final String outlet;
  final String serial;

  const _AlatTerpasangItem({
    required this.dateLabel,
    required this.time,
    required this.outlet,
    required this.serial,
  });
}

class _AlatTerpasangCard extends StatelessWidget {
  final _AlatTerpasangItem item;
  const _AlatTerpasangCard({required this.item});

  Widget _badgeTime(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _badgeTime(item.time),
              const Spacer(),
              Text(item.dateLabel, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B))),
            ],
          ),
          const SizedBox(height: 12),
          Text(item.outlet, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B))),
          const SizedBox(height: 6),
          Text(item.serial, style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B))),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _HistoryItem item;
  const _HistoryCard({required this.item});

  Widget _badgeTime(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.dateLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                    fontSize: 14,
                  ),
                ),
              ),
              _badgeTime(item.time),
            ],
          ),
          const SizedBox(height: 10),
          Text('Outlet : ${item.outlet}',
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B))),
          const SizedBox(height: 4),
          Text('No. Seri : ${item.serial}',
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B))),
          const SizedBox(height: 4),
          Text('Teknisi : ${item.technician}',
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B))),
          const SizedBox(height: 4),
          Text('QC : ${item.qc} - Hasil : ${item.result}',
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B))),
        ],
      ),
    );
  }
}

class _InstalledItem {
  final String outlet;
  final String serial;
  const _InstalledItem({required this.outlet, required this.serial});
}

class _InstalledRow extends StatelessWidget {
  final _InstalledItem item;
  final VoidCallback onInfo;
  final VoidCallback onRefresh;

  const _InstalledRow({
    required this.item,
    required this.onInfo,
    required this.onRefresh,
  });

  Widget _iconBtn({
    required IconData icon,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              item.outlet,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6F646B)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item.serial,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.primary),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _iconBtn(icon: Icons.info_outline_rounded, bg: AppTheme.primary, onTap: onInfo),
                const SizedBox(width: 8),
                _iconBtn(icon: Icons.refresh_rounded, bg: const Color(0xFF25B56B), onTap: onRefresh),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
