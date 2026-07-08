import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yofa/models/laporanharianmodels/laporan_harian_models.dart';
import '../../theme/app_theme.dart';

class EditLaporanHarianPage extends StatefulWidget {
  final LaporanHarianItem item;
  const EditLaporanHarianPage({super.key, required this.item});

  @override
  State<EditLaporanHarianPage> createState() => _EditLaporanHarianPageState();
}

class _EditLaporanHarianPageState extends State<EditLaporanHarianPage> {
  late TextEditingController _activityCtrl;
  Timer? _debounce;
  DateTime? _lastSavedAt;

  bool get _readonly => widget.item.status == LaporanStatus.submitted;

  @override
  void initState() {
    super.initState();
    _activityCtrl = TextEditingController(text: widget.item.activity);
    _lastSavedAt = widget.item.lastSavedAt;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _activityCtrl.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    if (_readonly) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _lastSavedAt = DateTime.now());
      // TODO: autosave draft
    });
  }

  void _saveDraft() {
    if (_readonly) return;

    final updated = widget.item.copyWith(
      activity: _activityCtrl.text,
      lastSavedAt: DateTime.now(),
    );

    Navigator.pop(context, updated);
  }

  void _submit() {
    final text = _activityCtrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aktivitas wajib diisi')));
      return;
    }

    final updated = widget.item.copyWith(
      status: LaporanStatus.submitted,
      activity: text,
      lastSavedAt: DateTime.now(),
    );

    Navigator.pop(context, updated);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final savedText = _lastSavedAt == null ? '-' : '${formatDate(_lastSavedAt!)} ${formatTime(_lastSavedAt!)}';

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Edit Laporan Harian'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          if (!_readonly)
            TextButton(
              onPressed: _saveDraft,
              child: const Text('Simpan Draft', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F6F8),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEFE6EC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded, color: AppTheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Text(formatDate(widget.item.date),
                          style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                      const Spacer(),
                      Text(_readonly ? 'Submitted' : 'Draft',
                          style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6F646B))),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4ECF2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEADDE6)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _readonly
                              ? 'Laporan sudah submitted. Aktivitas tidak bisa diubah.'
                              : 'Draft siap. Perubahan tersimpan otomatis.\nTerakhir tersimpan: $savedText',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF6F646B),
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                const Text('Aktivitas Hari Ini', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _activityCtrl,
                  enabled: !_readonly,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  onChanged: _onChanged,
                  decoration: InputDecoration(
                    hintText: 'Tulis aktivitas...',
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xFFF9F6F8),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          if (!_readonly)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _submit,
                child: const Text('Submit Laporan', style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
        ],
      ),
    );
  }
}
