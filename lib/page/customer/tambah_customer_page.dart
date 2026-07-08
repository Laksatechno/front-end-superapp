import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TambahCustomerPage extends StatefulWidget {
  const TambahCustomerPage({super.key});

  @override
  State<TambahCustomerPage> createState() => _TambahCustomerPageState();
}

class _TambahCustomerPageState extends State<TambahCustomerPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  String _type = 'Reguler';
  String _area = 'Jakarta';

  final List<String> _types = ['Reguler', 'Subdis', 'PMI'];
  final List<String> _areas = ['Jakarta', 'Bogor', 'Depok', 'Tangerang', 'Bekasi'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
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

  InputDecoration _dec(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF9F6F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      prefixIcon: icon == null ? null : Icon(icon, color: AppTheme.primary, size: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
      ),
    );
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama customer wajib diisi')));
      return;
    }
    if (_phoneCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No HP wajib diisi')));
      return;
    }
    if (_addressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Alamat wajib diisi')));
      return;
    }

    // TODO: call API save customer
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Customer tersimpan')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Tambah Customer'),
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
                const Text('Nama Customer', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(controller: _nameCtrl, decoration: _dec('Masukkan nama customer...', icon: Icons.person_outline)),

                const SizedBox(height: 12),
                const Text('No HP', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _dec('Masukkan no hp...', icon: Icons.phone_iphone_rounded),
                ),

                const SizedBox(height: 12),
                const Text('Email', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _dec('Masukkan email...', icon: Icons.email_outlined),
                ),

                const SizedBox(height: 12),
                const Text('Alamat', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _addressCtrl,
                  maxLines: 3,
                  decoration: _dec('Masukkan alamat...', icon: Icons.location_on_outlined),
                ),

                const SizedBox(height: 12),
                const Text('Tipe Pelanggan', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _type,
                  items: _types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _type = v ?? _type),
                  decoration: _dec('Pilih tipe...', icon: Icons.badge_outlined),
                ),

                const SizedBox(height: 12),
                const Text('Area', style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _area,
                  items: _areas.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _area = v ?? _area),
                  decoration: _dec('Pilih area...', icon: Icons.map_outlined),
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
              child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    );
  }
}
