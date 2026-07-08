import 'package:flutter/material.dart';
import 'package:yofa/page/cuti/model/cuti_models.dart';
import '../../theme/app_theme.dart';

class EditCutiPage extends StatefulWidget {
   final CutiItem item;
  const EditCutiPage({super.key, required this.item});

  @override
  State<EditCutiPage> createState() => _EditCutiPageState();
}

class _EditCutiPageState extends State<EditCutiPage> {
  late DateTime _mulai;
  late DateTime _selesai;
  late DateTime _mulaiKerja;

  late TextEditingController _jumlahCtrl;
  late TextEditingController _alasanCtrl;

  @override
  void initState() {
    super.initState();
    _mulai = widget.item.mulai;
    _selesai = widget.item.sampai;
    _mulaiKerja = widget.item.mulaiKerja;
    _jumlahCtrl = TextEditingController(text: '${widget.item.jumlah}');
    _alasanCtrl = TextEditingController(text: widget.item.alasan);
  }

  @override
  void dispose() {
    _jumlahCtrl.dispose();
    _alasanCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  Future<void> _pickDate(DateTime current, void Function(DateTime) onPick) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked == null) return;
    setState(() => onPick(picked));
  }

  void _save() {
    // TODO: call API update
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perubahan disimpan')),
    );
    Navigator.pop(context);
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

  Widget _tile(String label, String value, VoidCallback onTap, {IconData icon = Icons.event_outlined}) {
    return InkWell(
      onTap: onTap,
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
            Icon(icon, color: AppTheme.primary, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6F646B)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Edit Cuti'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanggal Mulai', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                _tile('Mulai', _fmt(_mulai), () => _pickDate(_mulai, (d) => _mulai = d)),
                const SizedBox(height: 12),
                const Text('Tanggal Selesai', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                _tile('Selesai', _fmt(_selesai), () => _pickDate(_selesai, (d) => _selesai = d)),
                const SizedBox(height: 12),
                const Text('Mulai Kerja', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                _tile('Mulai kerja', _fmt(_mulaiKerja), () => _pickDate(_mulaiKerja, (d) => _mulaiKerja = d),
                    icon: Icons.work_outline_rounded),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _jumlahCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Jumlah hari',
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
                const Text('Alasan', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _alasanCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Masukkan alasan...',
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
    );
  }
}
