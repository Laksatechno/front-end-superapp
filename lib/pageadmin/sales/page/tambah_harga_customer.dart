import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/sales/products/bloc/product_bloc.dart';
import 'package:yofa/pageadmin/sales/products/model/product_page_response.dart';
import 'package:yofa/theme/app_theme.dart';

import '../products/model/products_model.dart';

class TambahHargaCustomer extends StatefulWidget {
  final int customerId;
  final String customerName;

  const TambahHargaCustomer({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  State<TambahHargaCustomer> createState() => _TambahHargaCustomerState();
}

class _TambahHargaCustomerState extends State<TambahHargaCustomer> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _hargaCtrl = TextEditingController();
  final TextEditingController _diskonCtrl = TextEditingController();

  Product? _selectedProduct;
  String? _discountType;

  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(
          const ProductEvent.getProducts(
            page: 1,
            perPage: 200,
          ),
        );
  }

  @override
  void dispose() {
    _hargaCtrl.dispose();
    _diskonCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'customer_id': widget.customerId,
      'product_id': _selectedProduct!.id,
      'price': int.parse(_hargaCtrl.text),
      'discount_type': _discountType,
      'discount_value': _diskonCtrl.text.trim().isEmpty
          ? null
          : double.parse(
              _diskonCtrl.text
                  .trim()
                  .replaceAll(',', '.'),
            ),
    };

    debugPrint(payload.toString());

    Navigator.pop(context, true);
  }

  void _showProductPicker(List<Product> products) {
  final searchCtrl = TextEditingController();
  List<Product> filtered = List.from(products);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppTheme.bg,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    const Text(
                      'Pilih Produk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: searchCtrl,
                      autofocus: true,
                      onChanged: (value) {
                        final q = value.trim().toLowerCase();

                        setSheetState(() {
                          filtered = products.where((e) {
                            return e.name.toLowerCase().contains(q);
                          }).toList();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari produk...',
                        prefixIcon: const Icon(Icons.search_rounded),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Expanded(
                      child: filtered.isEmpty
                          ? const Center(
                              child: Text('Produk tidak ditemukan'),
                            )
                          : ListView.separated(
                              itemCount: filtered.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final item = filtered[index];

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedProduct = item;
                                    });
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppTheme.border,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.inventory_2_outlined,
                                          color: AppTheme.primary,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            item.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: AppTheme.textDark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
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
        title: const Text('Tambah Harga Customer'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            final errorMessage = state.maybeWhen(
              error: (message) => message,
              orElse: () => null,
            );

          final products = state.maybeWhen(
            loaded: (
              data,
              page,
              perPage,
              search,
              selected,
            ) {
              return data.items;
            },
            orElse: () => <Product> [],
          );

            if (isLoading ) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (errorMessage != null && errorMessage.isNotEmpty) {
              return _ErrorState(
                message: errorMessage,
                onRefresh: () async {
                  context.read<ProductBloc>().add(
                        const ProductEvent.refresh(
                          page: 1,
                          perPage: 200,
                        ),
                      );
                },
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _InfoCustomer(
                        customerName: widget.customerName,
                        customerId: widget.customerId,
                      ),

                      const SizedBox(height: 18),

                      FormField<Product>(
                        validator: (_) {
                          if (_selectedProduct == null) {
                            return 'Produk wajib dipilih';
                          }
                          return null;
                        },
                        builder: (field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _showProductPicker(products),
                                borderRadius: BorderRadius.circular(16),
                                child: InputDecorator(
                                  decoration: _inputDecoration(
                                    label: 'Produk',
                                    hint: 'Pilih produk',
                                    icon: Icons.inventory_2_outlined,
                                  ).copyWith(
                                    errorText: field.errorText,
                                  ),
                                  child: Text(
                                    _selectedProduct?.name ?? 'Pilih produk',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: _selectedProduct == null
                                          ? AppTheme.hint
                                          : AppTheme.textDark,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _hargaCtrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: _inputDecoration(
                          label: 'Harga',
                          hint: 'Masukkan harga customer',
                          icon: Icons.payments_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Harga wajib diisi';
                          }

                          final price = int.tryParse(value) ?? 0;

                          if (price <= 0) {
                            return 'Harga harus lebih dari 0';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      DropdownButtonFormField<String>(
                        value: _discountType,
                        isExpanded: true,
                        decoration: _inputDecoration(
                          label: 'Tipe Diskon (Opsional)',
                          hint: 'Pilih tipe diskon',
                          icon: Icons.discount_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'percentage',
                            child: Text('Persentase (%)'),
                          ),
                          DropdownMenuItem(
                            value: 'nominal',
                            child: Text('Nominal (Rp)'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _discountType = value;
                            _diskonCtrl.clear();
                          });
                        },
                      ),

                      const SizedBox(height: 14),

                      TextFormField(
                        controller: _diskonCtrl,
                        enabled: _discountType != null,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+[,.]?\d{0,2}'),
                          ),
                        ],
                        decoration: _inputDecoration(
                          label: 'Nilai Diskon (Opsional)',
                          hint: _discountType == 'percentage'
                              ? 'Contoh: 10,5'
                              : 'Contoh: 5000,75',
                          icon: Icons.percent_rounded,
                        ),
                        validator: (value) {
                          if (_discountType == null) return null;

                          if (value == null || value.trim().isEmpty) {
                            return 'Nilai diskon wajib diisi';
                          }

                          final normalized = value.replaceAll(',', '.');
                          final val = double.tryParse(normalized) ?? 0;

                          if (val <= 0) {
                            return 'Nilai diskon harus lebih dari 0';
                          }

                          if (_discountType == 'percentage' && val > 100) {
                            return 'Persentase maksimal 100';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _save,
                          icon: const Icon(Icons.save_rounded),
                          label: const Text('Simpan'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppTheme.primary),
      filled: true,
      fillColor: const Color(0xFFFBF8FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppTheme.primary,
          width: 1.4,
        ),
      ),
    );
  }
}

class _InfoCustomer extends StatelessWidget {
  final int customerId;
  final String customerName;

  const _InfoCustomer({
    required this.customerId,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person_outline,
            color: AppTheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              customerName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRefresh;

  const _ErrorState({
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 54,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Muat ulang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}