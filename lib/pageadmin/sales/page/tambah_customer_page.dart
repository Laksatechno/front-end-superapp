import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/pageadmin/sales/area/bloc/area_bloc.dart';

class TambahCustomerPage extends StatefulWidget {
  const TambahCustomerPage({super.key});

  @override
  State<TambahCustomerPage> createState() => _TambahCustomerPageState();
}

class _TambahCustomerPageState extends State<TambahCustomerPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  String _type = 'Reguler';
  int? _areaId;

  final List<String> _types = ['Reguler', 'Subdis', 'PMI'];

  @override
  void initState() {
    super.initState();
    context.read<AreaBloc>().add(const AreaEvent.started());
  }

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
      prefixIcon: icon == null ? null : Icon(icon, color: AppTheme.primary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.primary),
      ),
    );
  }

  void _save() {

    if (!_formKey.currentState!.validate()) return;

    if (_areaId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Area wajib dipilih')),
      );
      return;
    }



    /// TODO: kirim ke CustomerBloc / API

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Customer berhasil disimpan')),
    );

    Navigator.pop(context);
  }

  Widget _areaDropdown() {
    return BlocBuilder<AreaBloc, AreaState>(
      builder: (context, state) {

        return state.when(
          initial: () => const SizedBox(),

          loading: () => const Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator()),
          ),

          success: (areas) {

            return DropdownButtonFormField<int>(
              value: _areaId,

              items: areas.map((area) {
                return DropdownMenuItem<int>(
                  value: area.id,
                  child: Text(area.name),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _areaId = value;
                });
              },

              decoration: _dec('Pilih area...', icon: Icons.map_outlined),

              validator: (v) {
                if (v == null) {
                  return 'Area wajib dipilih';
                }
                return null;
              },
            );
          },

          failure: (message) {
            return Text(
              message,
              style: const TextStyle(color: Colors.red),
            );
          },
        );
      },
    );
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

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),

          children: [

            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Nama Customer',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _nameCtrl,
                    decoration: _dec(
                      'Masukkan nama customer...',
                      icon: Icons.person_outline,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'No HP',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: _dec(
                      'Masukkan no hp...',
                      icon: Icons.phone_iphone_rounded,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'No HP wajib diisi' : null,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Email',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _dec(
                      'Masukkan email...',
                      icon: Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Alamat',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _addressCtrl,
                    maxLines: 3,
                    decoration: _dec(
                      'Masukkan alamat...',
                      icon: Icons.location_on_outlined,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Alamat wajib diisi' : null,
                  ),
                  

                  const SizedBox(height: 12),

                  const Text(
                    'Tipe Pelanggan',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: _type,

                    items: _types.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),

                    onChanged: (v) {
                      setState(() {
                        _type = v ?? _type;
                      });
                    },

                    decoration: _dec(
                      'Pilih tipe...',
                      icon: Icons.badge_outlined,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Area',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark),
                  ),

                  const SizedBox(height: 8),

                  _areaDropdown(),

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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                onPressed: _save,

                child: const Text(
                  'Simpan',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}