import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> with TickerProviderStateMixin {
  late final TabController _tab;

  // Search controllers
  final _searchDailyCtrl = TextEditingController();
  final _searchVisitCtrl = TextEditingController();

  String _qDaily = '';
  String _qVisit = '';

  // Filter state - Harian
  DateTimeRange? _dailyRange;
  String _dailyStatus = 'Semua'; // Semua/Hadir/Sakit/Izin/Terlambat (bebas)
  bool _dailyHadir = true;
  bool _dailySakit = true;

  // Filter state - Kunjungan
  DateTimeRange? _visitRange;
  bool _visitCallplan = true;
  bool _visitUnplan = true;

  // Dummy data
  final List<_DailyHistory> _dailyAll = [
    _DailyHistory(
      dateText: 'Senin, 19 Jan 2026',
      inTime: '08:02',
      outTime: '16:11',
      status: 'Hadir',
      note: 'On time, laporan harian lengkap',
    ),
    _DailyHistory(
      dateText: 'Selasa, 20 Jan 2026',
      inTime: '—',
      outTime: '—',
      status: 'Sakit',
      note: 'Surat dokter terlampir',
    ),
    _DailyHistory(
      dateText: 'Rabu, 21 Jan 2026',
      inTime: '08:22',
      outTime: '16:05',
      status: 'Terlambat',
      note: 'Macet area tol',
    ),
  ];

  final List<_VisitHistory> _visitAll = [
    _VisitHistory(
      dateText: 'Senin, 19 Jan 2026',
      timeText: '10:15',
      type: 'Callplan',
      outlet: 'PMI Sleman',
      note: 'Follow up penawaran & cek stok',
    ),
    _VisitHistory(
      dateText: 'Senin, 19 Jan 2026',
      timeText: '14:40',
      type: 'Unplan',
      outlet: 'RS PKU Yogyakarta',
      note: 'Kunjungan dadakan, edukasi produk',
    ),
    _VisitHistory(
      dateText: 'Selasa, 20 Jan 2026',
      timeText: '09:10',
      type: 'Callplan',
      outlet: 'PMI Gunungkidul',
      note: 'Demo alat + negosiasi harga',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _searchDailyCtrl.dispose();
    _searchVisitCtrl.dispose();
    super.dispose();
  }

  // ===== Helpers UI =====
  Color _badgeBgSoft() => const Color(0xFFF4ECF2);

  Color _badgeColorByStatus(String status) {
    // tetap nuansa ungu (soft)
    // kamu bisa map lebih detail
    return AppTheme.primary;
  }

  String _formatRange(DateTimeRange r) {
    String two(int n) => n.toString().padLeft(2, '0');
    final a = '${two(r.start.day)}/${two(r.start.month)}/${r.start.year}';
    final b = '${two(r.end.day)}/${two(r.end.month)}/${r.end.year}';
    return '$a - $b';
  }

  Widget _pillBadge(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : _badgeBgSoft(),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 11.5,
          color: solid ? Colors.white : AppTheme.primary,
        ),
      ),
    );
  }

  Widget _searchBar({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF9B8F97)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                isDense: true,
                hintStyle: const TextStyle(color: Color(0xFF9B8F97)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topActions({
    required VoidCallback onFilter,
    required VoidCallback onDownload,
  }) {
    Widget iconBtn(IconData icon, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEFE6EC)),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 20),
        ),
      );
    }

    return Row(
      children: [
        iconBtn(Icons.tune_rounded, onFilter),
        const SizedBox(width: 10),
        iconBtn(Icons.download_rounded, onDownload),
      ],
    );
  }

  // ===== Filter Dialogs =====
  Future<void> _openDailyFilter() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        DateTimeRange? tempRange = _dailyRange;
        bool hadir = _dailyHadir;
        bool sakit = _dailySakit;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text(
            'Filter Harian',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: StatefulBuilder(
            builder: (ctx, setLocal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Range tanggal
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDateRangePicker(
                        context: ctx,
                        firstDate: DateTime(now.year - 2),
                        lastDate: DateTime(now.year + 1),
                        initialDateRange: tempRange,
                      );
                      if (picked != null) setLocal(() => tempRange = picked);
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F6F8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEFE6EC)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_rounded, color: AppTheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              tempRange == null ? 'Pilih range tanggal' : _formatRange(tempRange!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Status hadir / sakit (sesuai request)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F6F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                value: hadir,
                                onChanged: (v) => setLocal(() => hadir = v ?? true),
                                title: const Text('Hadir',
                                    style: TextStyle(fontWeight: FontWeight.w800)),
                                activeColor: AppTheme.primary,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                value: sakit,
                                onChanged: (v) => setLocal(() => sakit = v ?? true),
                                title: const Text('Sakit',
                                    style: TextStyle(fontWeight: FontWeight.w800)),
                                activeColor: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _dailyRange = null;
                  _dailyHadir = true;
                  _dailySakit = true;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dailyRange = tempRange;
                  _dailyHadir = hadir;
                  _dailySakit = sakit;
                });
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Terapkan', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openVisitFilter() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        DateTimeRange? tempRange = _visitRange;
        bool callplan = _visitCallplan;
        bool unplan = _visitUnplan;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text(
            'Filter Kunjungan',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: StatefulBuilder(
            builder: (ctx, setLocal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Callplan / Unplan
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F6F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          value: callplan,
                          onChanged: (v) => setLocal(() => callplan = v ?? true),
                          title: const Text('Callplan',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                          activeColor: AppTheme.primary,
                        ),
                        CheckboxListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          value: unplan,
                          onChanged: (v) => setLocal(() => unplan = v ?? true),
                          title: const Text('Unplan',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                          activeColor: AppTheme.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Range tanggal
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDateRangePicker(
                        context: ctx,
                        firstDate: DateTime(now.year - 2),
                        lastDate: DateTime(now.year + 1),
                        initialDateRange: tempRange,
                      );
                      if (picked != null) setLocal(() => tempRange = picked);
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F6F8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFEFE6EC)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_rounded, color: AppTheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              tempRange == null ? 'Pilih range tanggal' : _formatRange(tempRange!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _visitRange = null;
                  _visitCallplan = true;
                  _visitUnplan = true;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _visitRange = tempRange;
                  _visitCallplan = callplan;
                  _visitUnplan = unplan;
                });
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Terapkan', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        );
      },
    );
  }

  // ===== Data filter (dummy) =====
  List<_DailyHistory> get _dailyFiltered {
    var list = _dailyAll;

    // Search
    if (_qDaily.trim().isNotEmpty) {
      final q = _qDaily.toLowerCase();
      list = list.where((e) {
        return e.dateText.toLowerCase().contains(q) ||
            e.status.toLowerCase().contains(q) ||
            e.note.toLowerCase().contains(q);
      }).toList();
    }

    // Filter hadir/sakit
    list = list.where((e) {
      if (e.status.toLowerCase().contains('hadir') && !_dailyHadir) return false;
      if (e.status.toLowerCase().contains('sakit') && !_dailySakit) return false;
      // status lain (terlambat/izin) tetap tampil
      return true;
    }).toList();

    return list;
  }

  List<_VisitHistory> get _visitFiltered {
    var list = _visitAll;

    // Search
    if (_qVisit.trim().isNotEmpty) {
      final q = _qVisit.toLowerCase();
      list = list.where((e) {
        return e.dateText.toLowerCase().contains(q) ||
            e.timeText.toLowerCase().contains(q) ||
            e.outlet.toLowerCase().contains(q) ||
            e.note.toLowerCase().contains(q) ||
            e.type.toLowerCase().contains(q);
      }).toList();
    }

    // Filter callplan/unplan
    list = list.where((e) {
      if (e.type.toLowerCase() == 'callplan' && !_visitCallplan) return false;
      if (e.type.toLowerCase() == 'unplan' && !_visitUnplan) return false;
      return true;
    }).toList();

    return list;
  }

  // ===== Cards =====
  Widget _dailyCard(_DailyHistory it) {
    final badgeColor = _badgeColorByStatus(it.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
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
                  it.dateText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _badgeBgSoft(),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFEADDE6)),
                ),
                child: Text(
                  it.status,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 11.5,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _pillBadge('${it.inTime} - ${it.outTime}', solid: true),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  it.note,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6F646B),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visitCard(_VisitHistory it) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
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
              _pillBadge(it.type), // Callplan / Unplan (badge soft)
              const Spacer(),
              _pillBadge(it.timeText, solid: true),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            it.outlet,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            it.dateText,
            style: const TextStyle(
              color: Color(0xFF7C6F77),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            it.note,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF6F646B),
              fontWeight: FontWeight.w700,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBodyDaily() {
    final list = _dailyFiltered;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Row(
            children: [
              Expanded(
                child: _searchBar(
                  controller: _searchDailyCtrl,
                  hint: 'Cari tanggal / status / keterangan...',
                  onChanged: (v) => setState(() => _qDaily = v),
                ),
              ),
              const SizedBox(width: 10),
              _topActions(
                onFilter: _openDailyFilter,
                onDownload: () {
                  // TODO: download harian
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Download Harian')),
                  );
                },
              ),
            ],
          ),
        ),

        // chip ringkas filter aktif
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (_dailyRange != null) ...[
                  _pillBadge(_formatRange(_dailyRange!)),
                  const SizedBox(width: 8),
                ],
                if (!_dailyHadir || !_dailySakit) ...[
                  _pillBadge('Hadir: ${_dailyHadir ? "ON" : "OFF"}'),
                  const SizedBox(width: 8),
                  _pillBadge('Sakit: ${_dailySakit ? "ON" : "OFF"}'),
                ],
              ],
            ),
          ),
        ),

        Expanded(
          child: list.isEmpty
              ? const Center(
                  child: Text(
                    'Data harian tidak ditemukan',
                    style: TextStyle(
                      color: Color(0xFF7C6F77),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _dailyCard(list[i]),
                ),
        ),
      ],
    );
  }

  Widget _tabBodyVisit() {
    final list = _visitFiltered;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: Row(
            children: [
              Expanded(
                child: _searchBar(
                  controller: _searchVisitCtrl,
                  hint: 'Cari outlet / tanggal / keterangan...',
                  onChanged: (v) => setState(() => _qVisit = v),
                ),
              ),
              const SizedBox(width: 10),
              _topActions(
                onFilter: _openVisitFilter,
                onDownload: () {
                  // TODO: download kunjungan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Download Kunjungan')),
                  );
                },
              ),
            ],
          ),
        ),

        // chip ringkas filter aktif
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if (_visitRange != null) ...[
                  _pillBadge(_formatRange(_visitRange!)),
                  const SizedBox(width: 8),
                ],
                if (!_visitCallplan || !_visitUnplan) ...[
                  _pillBadge('Callplan: ${_visitCallplan ? "ON" : "OFF"}'),
                  const SizedBox(width: 8),
                  _pillBadge('Unplan: ${_visitUnplan ? "ON" : "OFF"}'),
                ],
              ],
            ),
          ),
        ),

        Expanded(
          child: list.isEmpty
              ? const Center(
                  child: Text(
                    'Data kunjungan tidak ditemukan',
                    style: TextStyle(
                      color: Color(0xFF7C6F77),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _visitCard(list[i]),
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
        title: const Text('Riwayat'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tab,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.w900),
          tabs: const [
            Tab(text: 'Harian'),
            Tab(text: 'Kunjungan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _tabBodyDaily(),
          _tabBodyVisit(),
        ],
      ),
    );
  }
}

// ===== MODELS (dummy) =====
class _DailyHistory {
  final String dateText;
  final String inTime;
  final String outTime;
  final String status;
  final String note;

  _DailyHistory({
    required this.dateText,
    required this.inTime,
    required this.outTime,
    required this.status,
    required this.note,
  });
}

class _VisitHistory {
  final String dateText;
  final String timeText;
  final String type; // Callplan / Unplan
  final String outlet;
  final String note;

  _VisitHistory({
    required this.dateText,
    required this.timeText,
    required this.type,
    required this.outlet,
    required this.note,
  });
}
