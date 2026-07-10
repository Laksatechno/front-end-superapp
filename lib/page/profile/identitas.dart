import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/datasources/auth/auth_local_datasource.dart';
import 'package:yofa/models/response/auth_response_model.dart';

class IdentitasPage extends StatefulWidget {
  const IdentitasPage({super.key});

  @override
  State<IdentitasPage> createState() => _IdentitasPageState();
}

class _IdentitasPageState extends State<IdentitasPage> {
  late Future<AuthResponseModel?> user;

  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _alamatC = TextEditingController();

  bool _isSaving = false;
  bool _didFill = false;

  @override
  void initState() {
    super.initState();
    user = AuthLocalDatasource().getAuthData();
    
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    super.dispose();
  }

  void _fillControllersOnce(User u) {
    if (_didFill) return;
    _didFill = true;

    _nameC.text = u.name ?? '';
    _emailC.text = u.email ?? '';
    _phoneC.text = (u.noHp?? '').toString();
    _alamatC.text = u.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Diri'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<AuthResponseModel?>(
        future: user,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final auth = snap.data;
          if (auth == null || auth.user == null) {
            return const Center(
              child: Text('Data user tidak ditemukan. Silakan login ulang.'),
            );
          }

          final u = auth.user!;
          final emp = auth.employee;
          print ('IdentitasPage: user role = ${emp?.position?.name} ${u.role}');

          _fillControllersOnce(u);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _sectionTitle('Akun'),
                // _fieldReadOnly('User ID', u.id?.toString() ?? '-'),

                _fieldEditable(
                  label: 'Email',
                  controller: _emailC,
                  hint: 'Masukkan email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    final val = (v ?? '').trim();
                    if (val.isEmpty) return 'Email wajib diisi';
                    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(val);
                    if (!ok) return 'Format email tidak valid';
                    return null;
                  },
                ),

                _fieldEditable(
                  label: 'Nama',
                  controller: _nameC,
                  hint: 'Masukkan nama',
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Nama wajib diisi';
                    if (v.trim().length < 3) return 'Nama minimal 3 karakter';
                    return null;
                  },
                ),

                _fieldEditable(
                  label: 'No. HP',
                  controller: _phoneC,
                  hint: 'Masukkan no hp (opsional)',
                  keyboardType: TextInputType.phone,
                ),

                _fieldEditable(
                  label: 'Alamat',
                  controller: _alamatC,
                  hint: 'Masukkan alamat (opsional)',
                  keyboardType: TextInputType.streetAddress,
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                            //  belum pakai bloc / API
                            if (!(_formKey.currentState?.validate() ?? false)) return;

                            setState(() => _isSaving = true);

                            // simulasi proses saja (nanti ganti ke API/bloc)
                            Future.delayed(const Duration(milliseconds: 600), () {
                              if (!mounted) return;
                              setState(() => _isSaving = false);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Siap update (belum terhubung API): '
                                    '${_nameC.text.trim()} | ${_emailC.text.trim()} | ${_phoneC.text.trim()}',
                                  ),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Perbarui Data',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                  ),
                ),

                // ✅ Section karyawan hanya kalau ada employee
                if (emp != null) ...[
                  const SizedBox(height: 22),
                  _sectionTitle('Karyawan'),
                  _fieldReadOnly('Employee ID', emp.id?.toString() ?? '-'),
                  _fieldReadOnly('Kode', emp.employeesCode ?? '-'),
                  _fieldReadOnly('Nama Karyawan', emp.employeesName ?? '-'),
                  _fieldReadOnly('Email Karyawan', emp.employeesEmail ?? '-'),
                  _fieldReadOnly('Position', emp.position?.name ?? '-'),
                  _fieldReadOnly('Shift', emp.shift?.name ?? '-'),
                  _fieldReadOnly(
                    'Jam Shift',
                    (emp.shift?.start != null && emp.shift?.end != null)
                        ? '${_hhmm(emp.shift!.start!)} - ${_hhmm(emp.shift!.end!)}'
                        : '-',
                  ),
                  _fieldReadOnly('Kantor', emp.building?.name ?? '-'),
                  _fieldReadOnly('Alamat Kantor', emp.building?.address ?? '-'),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: AppTheme.textDark,
        ),
      ),
    );
  }

  Widget _fieldReadOnly(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F646B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldEditable({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFE6EC)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String _hhmm(String time) {
    if (time.length >= 5) return time.substring(0, 5);
    return time;
  }
}
