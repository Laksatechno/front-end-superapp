import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/sales/products/bloc/product_bloc.dart';
import 'package:yofa/pageadmin/sales/products/model/products_model.dart';
import 'package:yofa/theme/app_theme.dart';

class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _stockCtrl = TextEditingController();

  bool _useSerial = false;

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

void _submit() {
  final name = _nameCtrl.text.trim();
  final stock = int.tryParse(_stockCtrl.text.trim()) ?? 0;

  if (name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nama product wajib diisi')),
    );
    return;
  }

  if (!_useSerial && stock <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stock wajib diisi (minimal 1)')),
    );
    return;
  }

  final request = CreateProductRequest(
    name: name,
    stock: _useSerial ? 0 : stock,
    isSerialized: _useSerial,
  );

  context.read<ProductBloc>().add(
        ProductEvent.addProduct(request: request),
      );

}

  @override
  void dispose() {
    _nameCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDeco(String hint, {IconData? icon}) {
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

Widget build(BuildContext context) {
  return BlocListener<ProductBloc, ProductState>(
    listener: (context, state) {
      state.maybeWhen(
        success: (product) {
          // reload list
          context.read<ProductBloc>().add(
                const ProductEvent.getProducts(page: 1, perPage: 10),
              );

          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Produk berhasil ditambahkan")),
          );
        },
        error: (msg) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        },
        orElse: () {},
      );
    },
    child: Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Tambah Barang'),
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
                  'Nama Product',
                  style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: _inputDeco('Masukkan nama product...', icon: Icons.inventory_2_outlined),
                ),

                const SizedBox(height: 12),

                // checkbox serial
                InkWell(
                  onTap: () {
                    setState(() {
                      _useSerial = !_useSerial;
                      if (_useSerial) _stockCtrl.clear();
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4ECF2),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEADDE6)),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _useSerial,
                          onChanged: (v) {
                            setState(() {
                              _useSerial = v ?? false;
                              if (_useSerial) _stockCtrl.clear();
                            });
                          },
                          activeColor: AppTheme.primary,
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Produk menggunakan no seri per unit',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // stock (hidden when serial)
                if (!_useSerial) ...[
                  const Text(
                    'Stock',
                    style: TextStyle(fontWeight: FontWeight.w900, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _stockCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco('Masukkan stock...', icon: Icons.numbers_outlined),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F6F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEFE6EC)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Stock disembunyikan karena input akan berdasarkan no seri per unit.',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF6F646B),
                            ),
                          ),
                        ),
                      ],
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
              child: const Text(
                'Tambah Barang',
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
