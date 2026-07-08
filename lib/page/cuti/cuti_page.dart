import 'package:flutter/material.dart';
import 'package:yofa/page/cuti/model/cuti_models.dart';
import '../../theme/app_theme.dart';
import 'tambah_cuti_page.dart';
import 'edit_cuti_page.dart';
import 'upload_surat_izin_page.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTimeRange? _range;

  // dummy list
final List<CutiItem> _items = [
  CutiItem(
    id: 1,
    jenis: CutiJenis.tahunan,
    status: CutiStatus.menunggu,
    mulai: DateTime(2026, 1, 10),
    sampai: DateTime(2026, 1, 12),
    mulaiKerja: DateTime(2026, 1, 13),
    jumlah: 3,
    alasan: 'Acara keluarga',
    suratAda: null,
  ),
  // dst...
];


  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String _fmtDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  Future<void> _pickRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDateRange: _range ??
          DateTimeRange(
            start: DateTime(now.year, now.month, 1),
            end: DateTime(now.year, now.month, now.day),
          ),
    );
    if (picked == null) return;
    setState(() => _range = picked);
  }

  void _clearRange() => setState(() => _range = null);

List<CutiItem> get _filtered {
  final q = _searchCtrl.text.trim().toLowerCase();

  bool matchRange(CutiItem it) {
    if (_range == null) return true;
    final s = it.mulai;
    final e = it.sampai;
    return !(e.isBefore(_range!.start) || s.isAfter(_range!.end));
  }

  bool matchSearch(CutiItem it) {
    if (q.isEmpty) return true;
    return it.alasan.toLowerCase().contains(q) ||
        it.jenisLabel.toLowerCase().contains(q) ||
        it.statusLabel.toLowerCase().contains(q);
  }

  return _items.where((it) => matchRange(it) && matchSearch(it)).toList();
}


  void _openTambah() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahCutiPage()),
    );
  }

  void _openEdit(CutiItem item) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => EditCutiPage(item: item)));
  }

    
  void _openUpload(CutiItem item) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => UploadSuratIzinPage(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Cuti'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        onPressed: _openTambah,
        child: const Icon(Icons.add_rounded),
      ),
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                // search
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            hintText: 'Cari alasan / status / jenis...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchCtrl.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // range picker pill
                InkWell(
                  onTap: _pickRange,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range_outlined, color: AppTheme.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _range == null
                                ? 'Filter range tanggal'
                                : '${_fmtDate(_range!.start)} - ${_fmtDate(_range!.end)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: _range == null ? const Color(0xFF6F646B) : AppTheme.textDark,
                            ),
                          ),
                        ),
                        if (_range != null)
                          IconButton(
                            onPressed: _clearRange,
                            icon: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                          )
                        else
                          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // list
          Expanded(
            child: list.isEmpty
                ? const Center(child: Text('Data cuti kosong'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final it = list[i];
                      final showUpload = it.jenis == _CutiJenis.mendadak;
                      final showEdit = it.jenis == _CutiJenis.tahunan;

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
                            // top row badges + action
                            Row(
                              children: [
                                _badgeJenis(it.jenisLabel),
                                const SizedBox(width: 8),
                                _badgeStatus(it.status),
                                const Spacer(),

                                if (showUpload)
                                  _iconAction(
                                    icon: Icons.upload_file_rounded,
                                    tooltip: 'Upload Surat Izin',
                                    onTap: () => _openUpload(it),
                                  ),

                                if (showEdit) ...[
                                  const SizedBox(width: 8),
                                  _iconAction(
                                    icon: Icons.edit_outlined,
                                    tooltip: 'Edit Cuti',
                                    onTap: () => _openEdit(it),
                                  ),
                                ],
                              ],
                            ),

                            const SizedBox(height: 10),

                            _infoRow('Cuti', '${_fmtDate(it.mulai)} - ${_fmtDate(it.sampai)}'),
                            const SizedBox(height: 6),
                            _infoRow('Mulai Kerja', _fmtDate(it.mulaiKerja)),
                            const SizedBox(height: 6),
                            _infoRow('Jumlah', '${it.jumlah} hari'),
                            const SizedBox(height: 6),
                            _infoRow('Alasan', it.alasan),

                            if (it.jenis == _CutiJenis.mendadak) ...[
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4ECF2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: const Color(0xFFEADDE6)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.medical_information_outlined,
                                        color: AppTheme.primary, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Surat dokter: ${it.suratAda == true ? "Sudah" : "Belum"}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: AppTheme.textDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6F646B),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconAction({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF4ECF2),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEADDE6)),
        ),
        child: Tooltip(
          message: tooltip,
          child: Icon(icon, color: AppTheme.primary),
        ),
      ),
    );
  }

  Widget _badgeJenis(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF4ECF2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: AppTheme.primary,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _badgeStatus(CutiStatus status) {
    Color bg;
    Color fg;

    switch (status) {
      case CutiStatus.menunggu:
        bg = const Color(0xFFFFF3CD);
        fg = const Color(0xFF8A6D1D);
        break;
      case CutiStatus.disetujui:
        bg = const Color(0xFFD1FADF);
        fg = const Color(0xFF11643A);
        break;
      case CutiStatus.ditolak:
        bg = const Color(0xFFFAD1D1);
        fg = const Color(0xFF7A1A1A);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: bg.withOpacity(0.9)),
      ),
      child: Text(
        status.label, // dari extension di cuti_models.dart
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: fg,
          fontSize: 12,
        ),
      ),
    );
  }

}

// ===== Models (dummy) =====
enum _CutiJenis { tahunan, mendadak }
enum _CutiStatus { menunggu, ditolak, disetujui }

extension _CutiStatusLabel on _CutiStatus {
  String get label {
    switch (this) {
      case _CutiStatus.menunggu:
        return 'Menunggu';
      case _CutiStatus.ditolak:
        return 'Ditolak';
      case _CutiStatus.disetujui:
        return 'Disetujui';
    }
  }
}

class _CutiItem {
  final int id;
  final _CutiJenis jenis;
  final _CutiStatus status;
  final DateTime mulai;
  final DateTime sampai;
  final DateTime mulaiKerja;
  final int jumlah;
  final String alasan;

  /// hanya relevan untuk mendadak
  final bool? suratAda;

  const _CutiItem({
    required this.id,
    required this.jenis,
    required this.status,
    required this.mulai,
    required this.sampai,
    required this.mulaiKerja,
    required this.jumlah,
    required this.alasan,
    required this.suratAda,
  });

  String get jenisLabel => jenis == _CutiJenis.tahunan ? 'Tahunan' : 'Mendadak';
  String get statusLabel => status.label;
}
