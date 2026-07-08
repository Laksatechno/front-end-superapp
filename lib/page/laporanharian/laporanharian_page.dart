import 'package:flutter/material.dart';
import 'package:yofa/models/laporanharianmodels/laporan_harian_models.dart';
import '../../theme/app_theme.dart';
import 'tambah_laporan_harian_page.dart';
import 'detail_laporan_harian_page.dart';
import 'edit_laporan_harian_page.dart';

class LaporanHarianPage extends StatefulWidget {
  const LaporanHarianPage({super.key});

  @override
  State<LaporanHarianPage> createState() => _LaporanHarianPageState();
}

class _LaporanHarianPageState extends State<LaporanHarianPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTimeRange? _range;

  final List<LaporanHarianItem> _items = [
    LaporanHarianItem(
      id: 1,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: LaporanStatus.submitted,
      activity: 'Kunjungan outlet A\nFollow up customer B\nRekap order harian',
      lastSavedAt: DateTime.now().subtract(const Duration(days: 1, minutes: 10)),
    ),
    LaporanHarianItem(
      id: 2,
      date: DateTime.now(),
      status: LaporanStatus.draft,
      activity: 'Draft aktivitas hari ini...',
      lastSavedAt: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _matchRange(DateTime date) {
    if (_range == null) return true;
    final start = DateTime(_range!.start.year, _range!.start.month, _range!.start.day);
    final end = DateTime(_range!.end.year, _range!.end.month, _range!.end.day, 23, 59, 59);
    return !date.isBefore(start) && !date.isAfter(end);
  }

  List<LaporanHarianItem> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _items.where((it) {
      final matchSearch = q.isEmpty
          ? true
          : formatDate(it.date).toLowerCase().contains(q) ||
              it.activity.toLowerCase().contains(q) ||
              it.status.label.toLowerCase().contains(q);

      return matchSearch && _matchRange(it.date);
    }).toList();
  }

  Future<void> _pickRange() async {
    final now = DateTime.now();
    final initial = _range ??
        DateTimeRange(
          start: DateTime(now.year, now.month, 1),
          end: DateTime(now.year, now.month, now.day),
        );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 1),
      initialDateRange: initial,
      helpText: 'Filter Range Tanggal',
    );

    if (picked == null) return;
    setState(() => _range = picked);
  }

  void _clearRange() => setState(() => _range = null);

  void _openTambah() async {
    final res = await Navigator.push<LaporanHarianItem>(
      context,
      MaterialPageRoute(builder: (_) => const TambahLaporanHarianPage()),
    );

    if (!mounted) return;
    if (res != null) {
      setState(() => _items.insert(0, res));
    }
  }

  void _openDetail(LaporanHarianItem item) async {
    // kalau balik membawa update (misal submit/edit), kita replace itemnya
    final res = await Navigator.push<LaporanHarianItem>(
      context,
      MaterialPageRoute(builder: (_) => DetailLaporanHarianPage(item: item)),
    );
    if (!mounted) return;
    if (res != null) {
      setState(() {
        final idx = _items.indexWhere((e) => e.id == res.id);
        if (idx != -1) _items[idx] = res;
      });
    }
  }

  void _openEdit(LaporanHarianItem item) async {
    final res = await Navigator.push<LaporanHarianItem>(
      context,
      MaterialPageRoute(builder: (_) => EditLaporanHarianPage(item: item)),
    );
    if (!mounted) return;
    if (res != null) {
      setState(() {
        final idx = _items.indexWhere((e) => e.id == res.id);
        if (idx != -1) _items[idx] = res;
      });
    }
  }

  Widget _badge(LaporanStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: status.fg,
          fontSize: 11.5,
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Laporan Harian'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Filter Range Tanggal',
            onPressed: _pickRange,
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          IconButton(
            tooltip: 'Tambah Laporan',
            onPressed: _openTambah,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          // Search + range info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                // search
                _card(
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded, color: Color(0xFF6F646B)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            hintText: 'Cari tanggal / status / aktivitas...',
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

                // range pill
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickRange,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4ECF2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEADDE6)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range_rounded, color: AppTheme.primary, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _range == null
                                      ? 'Semua Tanggal'
                                      : '${formatDate(_range!.start)} - ${formatDate(_range!.end)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                              ),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (_range != null)
                      InkWell(
                        onTap: _clearRange,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFEFE6EC)),
                          ),
                          child: const Icon(Icons.close_rounded, color: Color(0xFF6F646B)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: list.isEmpty
                ? const Center(child: Text('Belum ada laporan'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final it = list[i];
                      return _LaporanCard(
                        item: it,
                        badge: _badge(it.status),
                        onDetail: () => _openDetail(it),
                        onEdit: () => _openEdit(it),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _LaporanCard extends StatelessWidget {
  final LaporanHarianItem item;
  final Widget badge;
  final VoidCallback onDetail;
  final VoidCallback onEdit;

  const _LaporanCard({
    required this.item,
    required this.badge,
    required this.onDetail,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isDraft = item.status == LaporanStatus.draft;

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.description_outlined, color: AppTheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDate(item.date),
                  style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                ),
                const SizedBox(height: 6),
                Text(
                  item.activity,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F646B),
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              badge,
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _miniBtn(
                    label: 'Detail',
                    icon: Icons.visibility_outlined,
                    onTap: onDetail,
                  ),
                  if (isDraft) ...[
                    const SizedBox(width: 8),
                    _miniBtn(
                      label: 'Edit',
                      icon: Icons.edit_outlined,
                      onTap: onEdit,
                      solid: true,
                    ),
                  ]
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniBtn({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool solid = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: solid ? AppTheme.primary : const Color(0xFFF4ECF2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEADDE6)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: solid ? Colors.white : AppTheme.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: solid ? Colors.white : AppTheme.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
