import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/karyawanku/kelolakunjungan/datasource/kelola_kunjungan_ds.dart';
import 'package:yofa/pageadmin/karyawanku/kelolakunjungan/models/kunjungan_model.dart';
import 'package:yofa/pageadmin/karyawanku/kelolakunjungan/bloc/kelola_kunjungan_bloc.dart';
import 'package:yofa/theme/app_theme.dart';

class KelolakunjunganPage extends StatefulWidget {
  const KelolakunjunganPage({super.key});

  @override
  State<KelolakunjunganPage> createState() => _KelolakunjunganPageState();
}

class _KelolakunjunganPageState extends State<KelolakunjunganPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  DateTimeRange? _range;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) setState(() {});
    });
  }

  List<KunjunganData> _applySearch(List<KunjunganData> list) {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return list;
    return list.where((it) {
      final dateStr = (it.visitDate ?? '').toLowerCase();
      final timeIn = (it.visitTime ?? '').toLowerCase();
      final timeOut = (it.checkOutTime ?? '').toLowerCase();
      final status = (it.status ?? '').toLowerCase();
      final emp = (it.employee?.employeeName ?? '').toLowerCase();
      final notes = (it.notes ?? '').toLowerCase();
      return emp.contains(q) ||
          status.contains(q) ||
          dateStr.contains(q) ||
          timeIn.contains(q) ||
          timeOut.contains(q) ||
          notes.contains(q);
    }).toList();
  }

  Future<void> _openFilter(BuildContext pageCtx) async {
    await showModalBottomSheet(
      context: pageCtx,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 6,
            bottom: 16 + MediaQuery.of(pageCtx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              _filterTile(
                icon: Icons.date_range,
                title: 'Date Range',
                subtitle: _range == null
                    ? 'Semua tanggal'
                    : '${_fmtDate(_range!.start)}  -  ${_fmtDate(_range!.end)}',
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDateRangePicker(
                    context: pageCtx,
                    firstDate: DateTime(now.year - 2, 1, 1),
                    lastDate: DateTime(now.year + 1, 12, 31),
                    initialDateRange: _range,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSeed(
                            seedColor: AppTheme.primary,
                            brightness: Theme.of(context).brightness,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) setState(() => _range = picked);
                },
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => setState(() => _range = null),
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(pageCtx);
                        pageCtx.read<KelolaKunjunganBloc>().add(
                              KelolaKunjunganEvent.getKunjungan(dateRange: _range),
                            );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Terapkan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
  String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, '0')} ${_months[d.month - 1]} ${d.year}';

  DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    try { return DateTime.parse(s); } catch (_) { return null; }
  }

  Color _statusColor(String s) {
    final v = s.toLowerCase();
    if (v.contains('selesai') || v.contains('hadir')) return Colors.green;
    if (v.contains('proses') || v.contains('berlangsung')) return Colors.orange;
    return Colors.grey;
  }

  void _showPhoto(String title, String? url) {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Foto belum tersedia')));
      return;
    }
    final urlfoto = 'https://app.yofacorpora.com/$url';
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  urlfoto,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(child: Text('Gagal memuat foto')),
                  loadingBuilder: (c, w, p) => p == null ? w : const Center(child: CircularProgressIndicator()),
                ),
              ),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.55), borderRadius: BorderRadius.circular(999)),
                  child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLocation(String title, String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lokasi belum tersedia')));
      return;
    }
    final cleaned = raw.replaceAll(';', ',').replaceAll('|', ',').replaceAll(' ', ',');
    final parts = cleaned.split(',').where((e) => e.trim().isNotEmpty).toList();
    final lat = parts.length >= 1 ? double.tryParse(parts[0].trim()) ?? 0.0 : 0.0;
    final lng = parts.length >= 2 ? double.tryParse(parts[1].trim()) ?? 0.0 : 0.0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              _infoRow(Icons.map, 'Koordinat', '$lat, $lng'),
              const SizedBox(height: 8),
              _infoRow(Icons.location_on, 'Raw', raw),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Text('Preview Map\n($lat, $lng)',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade700)),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Tutup'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Aksi: buka maps (placeholder)'))),
                      icon: const Icon(Icons.directions),
                      label: const Text('Buka Maps'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _chip({required String label, required VoidCallback onClear, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.primary.withOpacity(0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          InkWell(
            onTap: onClear,
            borderRadius: BorderRadius.circular(999),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStat({required String title, required String value, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppTheme.primary.withOpacity(0.06),
          border: Border.all(color: AppTheme.primary.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primary, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppTheme.primary),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KelolaKunjunganBloc(KelolaKunjunganRemoteDatasource())
        ..add(const KelolaKunjunganEvent.started()),
      child: Builder(
        builder: (pageCtx) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Kunjungan Karyawanku'),
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  tooltip: 'Filter',
                  onPressed: () => _openFilter(pageCtx),
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFF7F7FB),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Cari nama / status / tanggal...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchCtrl.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close),
                            ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: AppTheme.primary.withOpacity(0.6)),
                      ),
                    ),
                  ),
                ),
                if (_range != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _chip(
                                label: '${_fmtDate(_range!.start)} - ${_fmtDate(_range!.end)}',
                                onClear: () {
                                  setState(() => _range = null);
                                  pageCtx.read<KelolaKunjunganBloc>().add(
                                        KelolaKunjunganEvent.getKunjungan(dateRange: _range),
                                      );
                                },
                                icon: Icons.date_range,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: BlocBuilder<KelolaKunjunganBloc, KelolaKunjunganState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        empty: () => Center(child: Text('Data tidak ditemukan', style: TextStyle(color: Colors.grey.shade700))),
                        error: (msg) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(msg, textAlign: TextAlign.center),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () => pageCtx.read<KelolaKunjunganBloc>().add(
                                        KelolaKunjunganEvent.getKunjungan(dateRange: _range),
                                      ),
                                  child: const Text('Coba Lagi'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        loaded: (items) {
                          final list = _applySearch(items);
                          return RefreshIndicator(
                            onRefresh: () async {
                              pageCtx.read<KelolaKunjunganBloc>().add(
                                    KelolaKunjunganEvent.refresh(dateRange: _range),
                                  );
                            },
                            child: list.isEmpty
                                ? ListView(
                                    children: [
                                      const SizedBox(height: 120),
                                      Center(child: Text('Data tidak ditemukan', style: TextStyle(color: Colors.grey.shade700))),
                                    ],
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                                    itemCount: list.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                                    itemBuilder: (_, i) {
                                      final it = list[i];
                                      final d = _parseDate(it.visitDate);
                                      final dateLabel = d == null ? (it.visitDate ?? '-') : _fmtDate(d);
                                      final statusText = it.status ?? '-';
                                      final statusColor = _statusColor(statusText);
                                      final empName = it.employee?.employeeName ?? '-';

                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey.shade200),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              offset: const Offset(0, 4),
                                              color: Colors.black.withOpacity(0.05),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(dateLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                                                        const SizedBox(height: 4),
                                                        Text(empName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                    decoration: BoxDecoration(
                                                      color: statusColor.withOpacity(0.12),
                                                      borderRadius: BorderRadius.circular(999),
                                                      border: Border.all(color: statusColor.withOpacity(0.25)),
                                                    ),
                                                    child: Text(
                                                      statusText,
                                                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (it.notes != null && it.notes!.isNotEmpty) ...[
                                                const SizedBox(height: 8),
                                                Text(it.notes!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                              ],
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Expanded(child: _miniStat(title: 'Jam Masuk', value: it.visitTime ?? '-', icon: Icons.login, onTap: () => _showPhoto('Foto Masuk', it.photoIn))),
                                                  const SizedBox(width: 10),
                                                  Expanded(child: _miniStat(title: 'Jam Keluar', value: it.checkOutTime ?? '-', icon: Icons.logout, onTap: () => _showPhoto('Foto Keluar', it.photoOut))),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              const Divider(height: 1),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _actionButton(
                                                      icon: Icons.location_on,
                                                      label: 'Lokasi Masuk',
                                                      onTap: () => _showLocation('Lokasi Masuk', it.latitudeIn),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: _actionButton(
                                                      icon: Icons.pin_drop,
                                                      label: 'Lokasi Keluar',
                                                      onTap: () => _showLocation('Lokasi Keluar', it.latitudeOut),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
