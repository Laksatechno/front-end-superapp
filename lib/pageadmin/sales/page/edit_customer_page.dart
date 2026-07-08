import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:yofa/pageadmin/sales/page/customer_page.dart' show CustomerItem;
import 'package:yofa/pageadmin/sales/area/bloc/area_bloc.dart';

class EditCustomerPage extends StatefulWidget {
  final CustomerItem item;
  const EditCustomerPage({super.key, required this.item});

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _addressCtrl;

  late String _type;
  String? _area;

  final List<String> _types = ['Reguler', 'Subdis', 'PMI'];

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.item.name);
    _phoneCtrl = TextEditingController(text: widget.item.phone);
    _emailCtrl = TextEditingController(text: widget.item.email);
    _addressCtrl = TextEditingController(text: widget.item.address);

    _type = widget.item.type;
    _area = widget.item.area;

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

  InputDecoration _dec(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFF9F6F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      prefixIcon: icon == null
          ? null
          : Icon(icon, color: AppTheme.primary, size: 20),
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

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama customer wajib diisi')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Perubahan tersimpan')));

    Navigator.pop(context);
  }

  Widget _areaDropdown() {
    return BlocBuilder<AreaBloc, AreaState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),

          loading: () => const Padding(
            padding: EdgeInsets.all(12),
            // child: Center(child: CircularProgressIndicator()),
            // pilih area dengan dropdown
              
          ),

          success: (areas) {
            return DropdownButtonFormField<String>(
              value: _area,
              items: areas
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _area = v),
              decoration: _dec('Pilih area...', icon: Icons.map_outlined),
            );
          },

          failure: (message) {
            return Text(message, style: const TextStyle(color: Colors.red));
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
        title: const Text('Edit Customer'),
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
                const Text(
                  'Nama Customer',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  decoration: _dec(
                    'Nama customer...',
                    icon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'No HP',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _dec(
                    'No HP...',
                    icon: Icons.phone_iphone_rounded,
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _dec('Email...', icon: Icons.email_outlined),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Alamat',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _addressCtrl,
                  maxLines: 3,
                  decoration: _dec(
                    'Alamat...',
                    icon: Icons.location_on_outlined,
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Tipe Pelanggan',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _type,
                  items: _types
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => _type = v ?? _type),
                  decoration: _dec('Pilih tipe...', icon: Icons.badge_outlined),
                ),

                const SizedBox(height: 12),
                const Text(
                  'Area',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 8),

                /// AREA DROPDOWN DARI BLOC
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
    );
  }
}
