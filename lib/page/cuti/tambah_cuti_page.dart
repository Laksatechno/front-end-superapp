import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TambahCutiPage extends StatefulWidget {
  const TambahCutiPage({super.key});

  @override
  State<TambahCutiPage> createState() => _TambahCutiPageState();
}

class _TambahCutiPageState extends State<TambahCutiPage> {
  DateTime? _mulai;
  DateTime? _selesai;
  DateTime? _mulaiKerja;

  final TextEditingController _jumlahCtrl = TextEditingController(text: '1');
  final TextEditingController _alasanCtrl = TextEditingController();

  String _jenis = 'tahunan'; // 'tahunan' | 'mendadak'

  // dummy file name (tanpa plugin)
  String? _fileName;

  @override
  void dispose() {
    _jumlahCtrl.dispose();
    _alasanCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime? d) {
    if (d == null) return '-';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  Future<void> _pickDate(void Function(DateTime) onPick, {DateTime? initial}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (picked == null) return;
    onPick(picked);
  }

  void _pickFileDummy() {
    // TODO: pakai file_picker kalau mau real upload
    setState(() => _fileName = 'surat_izin.pdf');
  }

  void _submit() {
    if (_mulai == null || _selesai == null || _mulaiKerja == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi tanggal mulai, selesai, dan mulai kerja')),
      );
      return;
    }
    if (_alasanCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alasan wajib diisi')),
      );
      return;
    }

    // TODO: call API submit cuti (+ file kalau mendadak)
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pengajuan Terkirim'),
        content: const Text('Permohonan izin berhasil diajukan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context); // balik ke CutiPage
            },
            child: const Text('OK'),
          ),
        ],
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

  Widget _pickerTile({
    required String label,
    required String value,
    required VoidCallback onTap,
    IconData icon = Icons.event_outlined,
  }) {
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
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: value == '-' ? const Color(0xFF6F646B) : AppTheme.textDark,
                ),
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
    final isMendadak = _jenis == 'mendadak';

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Tambah Cuti'),
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
                _pickerTile(
                  label: 'Mulai',
                  value: _fmt(_mulai),
                  onTap: () => _pickDate((d) => setState(() => _mulai = d), initial: _mulai),
                ),
                const SizedBox(height: 12),

                const Text('Tanggal Selesai', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                _pickerTile(
                  label: 'Selesai',
                  value: _fmt(_selesai),
                  onTap: () => _pickDate((d) => setState(() => _selesai = d), initial: _selesai),
                ),
                const SizedBox(height: 12),

                const Text('Mulai Kerja', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                _pickerTile(
                  label: 'Mulai kerja',
                  value: _fmt(_mulaiKerja),
                  onTap: () => _pickDate((d) => setState(() => _mulaiKerja = d), initial: _mulaiKerja),
                  icon: Icons.work_outline_rounded,
                ),
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
                    hintText: 'Masukkan alasan cuti...',
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

          const SizedBox(height: 12),

          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jenis Cuti', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _jenisChip(
                        label: 'Tahunan',
                        active: _jenis == 'tahunan',
                        onTap: () => setState(() => _jenis = 'tahunan'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _jenisChip(
                        label: 'Mendadak',
                        active: _jenis == 'mendadak',
                        onTap: () => setState(() => _jenis = 'mendadak'),
                      ),
                    ),
                  ],
                ),

                if (isMendadak) ...[
                  const SizedBox(height: 12),
                  const Text('Upload Surat Izin (Opsional)',
                      style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickFileDummy,
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
                          const Icon(Icons.upload_file_rounded, color: AppTheme.primary, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _fileName ?? 'Pilih file surat izin',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: _fileName == null ? const Color(0xFF6F646B) : AppTheme.textDark,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right_rounded, color: Color(0xFF6F646B)),
                        ],
                      ),
                    ),
                  ),
                ],
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
              onPressed: _submit,
              child: const Text('Ajukan Permohonan Izin', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _jenisChip({required String label, required bool active, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? const Color(0xFFF4ECF2) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? const Color(0xFFEADDE6) : const Color(0xFFEFE6EC)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: active ? AppTheme.primary : const Color(0xFF6F646B),
          ),
        ),
      ),
    );
  }
}
