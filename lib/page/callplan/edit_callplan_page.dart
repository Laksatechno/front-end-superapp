import 'package:flutter/material.dart';
import 'package:yofa/models/laporanharianmodels/laporan_harian_models.dart';
import 'package:yofa/page/callplan/model/callplan_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/page/callplan/bloc/callplan_bloc.dart';
import '../../theme/app_theme.dart';

class EditCallplanPage extends StatefulWidget {
  final CallplanItem item;
  const EditCallplanPage({super.key, required this.item});

  @override
  State<EditCallplanPage> createState() => _EditCallplanPageState();
}

class _EditCallplanPageState extends State<EditCallplanPage> {
  late DateTime _date;
  late TextEditingController _outletCtrl;
  late TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();
    _date = DateTime(widget.item.tanggalCp.year, widget.item.tanggalCp.month, widget.item.tanggalCp.day);
    _outletCtrl = TextEditingController(text: widget.item.outlet); // 1 outlet saja
    _noteCtrl = TextEditingController(text: widget.item.description);
  }

  @override
  void dispose() {
    _outletCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(DateTime.now().year - 2),
      lastDate: DateTime(DateTime.now().year + 2),
      helpText: 'Ubah Tanggal',
    );
    if (picked == null) return;
    setState(() => _date = DateTime(picked.year, picked.month, picked.day));
  }

  void _save() {
    final outlet = _outletCtrl.text.trim();

    if (outlet.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama outlet wajib diisi')),
      );
      return;
    }

    if (outlet.contains(',')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Edit hanya untuk 1 outlet (tanpa koma).')),
      );
      return;
    }

    context.read<CallplanBloc>().add(
          CallplanEvent.update(
            id: widget.item.id,
            tanggalCp: _date,
            outlet: outlet,
            description: _noteCtrl.text.trim(),
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
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Edit Callplan'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<CallplanBloc, CallplanState>(
    listener: (context, state) {
      state.whenOrNull(
        success: (msg ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
          Navigator.of(context).pop(); // kembali ke halaman sebelumnya
        },
        error: (msg) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        },
      );
    },
  child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
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
                        Text(
                          formatDate(_date),
                          style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('Nama Outlet (1 outlet)', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _outletCtrl,
                  decoration: InputDecoration(
                    hintText: 'Nama outlet...',
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xFFF9F6F8),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                const Text('Keterangan', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _noteCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Tulis keterangan...',
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xFFF9F6F8),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    enabledBorder: OutlineInputBorder(
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
              onPressed: _save,
              child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    ),
    );
  }
}