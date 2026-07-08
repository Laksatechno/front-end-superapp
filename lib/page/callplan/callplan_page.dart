import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/models/laporanharianmodels/laporan_harian_models.dart';
import 'package:yofa/page/callplan/bloc/callplan_bloc.dart';
import 'package:yofa/page/callplan/model/callplan_models.dart';
import '../../theme/app_theme.dart';
import 'tambah_callplan_page.dart';
import 'edit_callplan_page.dart';

class CallplanPage extends StatefulWidget {
  const CallplanPage({super.key});

  @override
  State<CallplanPage> createState() => _CallplanPageState();
}

class _CallplanPageState extends State<CallplanPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTimeRange? _range;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    context.read<CallplanBloc>().add(
          CallplanEvent.fetch(
            filterType: _searchCtrl.text,
            dateRange: _range,
          ),
        );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _matchRange(DateTime date) {
    if (_range == null) return true;
    final start =
        DateTime(_range!.start.year, _range!.start.month, _range!.start.day);
    final end = DateTime(
        _range!.end.year, _range!.end.month, _range!.end.day, 23, 59, 59);
    return !date.isBefore(start) && !date.isAfter(end);
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
    _fetch(); //  trigger API
  }

  void _clearRange() {
    setState(() => _range = null);
    _fetch(); //  trigger API
  }

  void _onDownload() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TODO: Download callplan')),
    );
  }

  Future<void> _openTambah() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahCallplanPage()),
    );

    _fetch(); //  reload API
  }

  Future<void> _openEdit(CallplanItem item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditCallplanPage(item: item)),
    );

    _fetch(); // reload API
  }

Future<void> _dialogdelete(CallplanItem item) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Hapus Callplan'),
        content: Text(
          'Yakin ingin menghapus callplan untuk "${item.outlet}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    if (!mounted) return;

    /// OPTIONAL: loading kecil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menghapus data...'),
        duration: Duration(seconds: 1),
      ),
    );

    context.read<CallplanBloc>().add(
          CallplanEvent.delete(id: item.id),
        );

  }
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
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Callplan'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Unduh',
            onPressed: _onDownload,
            icon: const Icon(Icons.download_rounded),
          ),
          IconButton(
            tooltip: 'Tambah',
            onPressed: _openTambah,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                /// SEARCH (UI TETAP)
                _card(
                  child: Row(
                    children: [
                      const Icon(Icons.search_rounded,
                          color: Color(0xFF6F646B)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => _fetch(), // 🔥 pakai API
                          decoration: const InputDecoration(
                            hintText:
                                'Cari outlet / tanggal / keterangan...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchCtrl.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            _fetch();
                          },
                          icon: const Icon(Icons.close_rounded,
                              color: Color(0xFF6F646B)),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                /// DATE RANGE (UI TETAP)
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickRange,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4ECF2),
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(color: const Color(0xFFEADDE6)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range_rounded,
                                  color: AppTheme.primary, size: 18),
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
                              const Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF6F646B)),
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
                            border:
                                Border.all(color: const Color(0xFFEFE6EC)),
                          ),
                          child: const Icon(Icons.close_rounded,
                              color: Color(0xFF6F646B)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          ///  DATA DARI BLOC (UI LIST TETAP)
          Expanded(
            child: BlocBuilder<CallplanBloc, CallplanState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),

                  loading: () => const Center(
                      child: CircularProgressIndicator()),

                  error: (msg) => Center(child: Text(msg)),
                  success: (msg) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(msg)),
                      );

                      _fetch();
                    });

                    return const SizedBox(); // 🔥 WAJIB
                  },

                  loaded: (list) {
                    final filtered = list.where((it) {
                      final q =
                          _searchCtrl.text.trim().toLowerCase();

                      final matchSearch = q.isEmpty
                          ? true
                          : formatDate(it.tanggalCp)
                                  .toLowerCase()
                                  .contains(q) ||
                              it.outlet.toLowerCase().contains(q) ||
                              it.description
                                  .toLowerCase()
                                  .contains(q);

                      return matchSearch &&
                          _matchRange(it.tanggalCp);
                    }).toList();

                    if (filtered.isEmpty) {
                      return const Center(
                          child: Text('Belum ada callplan'));
                    }

                    return ListView.separated(
                      padding:
                          const EdgeInsets.fromLTRB(16, 6, 16, 16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final it = filtered[i];
                        return _CallplanCard(
                          item: it,
                          onEdit: () => _openEdit(it),
                          onDelete: () => _dialogdelete(it),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}



class _CallplanCard extends StatelessWidget {
  final CallplanItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _CallplanCard({required this.item, required this.onEdit, required this.onDelete});

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.map_outlined, color: AppTheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pill(formatDate(item.tanggalCp), solid: false),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.outlet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.description.isEmpty ? '-' : item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6F646B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onEdit,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: onDelete,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
  
  Widget pill(String text, {bool solid = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: solid ? AppTheme.primary : const Color(0xFFF4ECF2),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0xFFEADDE6)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        color: solid ? Colors.white : AppTheme.primary,
        fontSize: 11.5,
      ),
    ),
  );
}
}