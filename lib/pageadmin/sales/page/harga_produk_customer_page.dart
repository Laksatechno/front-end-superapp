import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/sales/customer/bloc/customer_bloc.dart';
import 'package:yofa/pageadmin/sales/getproducts/bloc/customer_products_bloc.dart';
import 'package:yofa/pageadmin/sales/getproducts/model/customer_product_price_model.dart';
import 'package:yofa/pageadmin/sales/page/tambah_harga_customer.dart';
import 'package:yofa/theme/app_theme.dart';

class HargaProdukCustomerPage extends StatefulWidget {
  const HargaProdukCustomerPage({super.key});

  @override
  State<HargaProdukCustomerPage> createState() =>
      _HargaProdukCustomerPageState();
}

class _HargaProdukCustomerPageState extends State<HargaProdukCustomerPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  CustomerPickerItem? _selectedCustomer;
  List<CustomerProductPrice> _customerProductPrices = [];

  @override
  void initState() {
    super.initState();

  context.read<CustomerBloc>().add(
        const CustomerEvent.getCustomers(
          page: 1,
          perPage: 200,
        ),
      );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<CustomerProductPrice> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();

    if (q.isEmpty) return _customerProductPrices;

    return _customerProductPrices.where((e) {
      return e.product.name.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _refresh() async {
    if (_selectedCustomer == null) return;

    context.read<CustomerProductsBloc>().add(
          CustomerProductsEvent.getByCustomer(
            customerId: _selectedCustomer!.id,
          ),
        );
  }

  Future<void> _goToTambahHargaCustomer() async {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih customer terlebih dahulu'),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahHargaCustomer(
          customerId: _selectedCustomer!.id,
          customerName: _selectedCustomer!.name,
        ),
      ),
    );

    if (result == true) {
      _refresh();
    }
  }

  void _pickCustomer(List<CustomerPickerItem> customers) {
    final searchCtrl = TextEditingController();
    List<CustomerPickerItem> filtered = List.from(customers);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
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
                      Container(
                        width: 46,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppTheme.border,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Pilih Customer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextField(
                        controller: searchCtrl,
                        onChanged: (value) {
                          final q = value.trim().toLowerCase();

                          setSheetState(() {
                            filtered = customers.where((e) {
                              return e.name.toLowerCase().contains(q);
                            }).toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari customer...',
                          prefixIcon: const Icon(Icons.search_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: AppTheme.border,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Expanded(
                        child: filtered.isEmpty
                            ? const Center(
                                child: Text(
                                  'Customer tidak ditemukan',
                                  style: TextStyle(
                                    color: AppTheme.textMuted,
                                  ),
                                ),
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
                                        _selectedCustomer = item;
                                        _customerProductPrices = [];
                                        _searchCtrl.clear();
                                      });

                                      context
                                          .read<CustomerProductsBloc>()
                                          .add(
                                            CustomerProductsEvent
                                                .getByCustomer(
                                              customerId: item.id,
                                            ),
                                          );

                                      Navigator.pop(context);
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppTheme.border,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 42,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primary
                                                  .withOpacity(0.08),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.person_outline,
                                              color: AppTheme.primary,
                                            ),
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
    ).whenComplete(() {
      searchCtrl.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Harga Produk Per Customer'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'fab_tambah_harga_customer',
          onPressed: _selectedCustomer == null
              ? null
              : _goToTambahHargaCustomer,
          backgroundColor: _selectedCustomer == null
              ? Colors.grey.shade400
              : AppTheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          child: const Icon(Icons.add_rounded),
        ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CustomerProductsBloc, CustomerProductsState>(
            listener: (context, state) {
              state.maybeWhen(
                loaded: (customerId, data) {
                  if (_selectedCustomer?.id == customerId) {
                    setState(() {
                      _customerProductPrices = data;
                    });
                  }
                },
                error: (msg) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(msg)),
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, customerState) {
          final customers = customerState.maybeWhen(
            loaded: (
              data,
              page,
              perPage,
              filterType,
              status,
            ) {
              return data.map((e) {
                return CustomerPickerItem(
                  id: e.id,
                  name: e.name,
                );
              }).toList();
            },
            orElse: () => <CustomerPickerItem>[],
          );

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: customers.isEmpty
                            ? null
                            : () {
                                if (customers.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Data customer belum tersedia',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                _pickCustomer(customers);
                              },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFEFE6EC),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: AppTheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  customers.isEmpty
                                      ? 'Memuat customer...'
                                      : _selectedCustomer?.name ??
                                          'Pilih customer...',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: _selectedCustomer == null
                                        ? const Color(0xFF9B8F97)
                                        : AppTheme.textDark,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppTheme.textMuted,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFEFE6EC),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF6F646B),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchCtrl,
                                enabled: _selectedCustomer != null,
                                onChanged: (_) => setState(() {}),
                                decoration: const InputDecoration(
                                  hintText: 'Cari produk...',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            if (_searchCtrl.text.isNotEmpty)
                              IconButton(
                                onPressed: () {
                                  _searchCtrl.clear();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF6F646B),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: BlocBuilder<CustomerProductsBloc,
                      CustomerProductsState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                      final errorMessage = state.maybeWhen(
                        error: (message) => message,
                        orElse: () => null,
                      );

                      if (_selectedCustomer == null) {
                        return const _EmptyState(
                          icon: Icons.person_search_rounded,
                          title: 'Pilih customer terlebih dahulu',
                          subtitle:
                              'Produk dan harga customer akan tampil setelah customer dipilih.',
                        );
                      }

                      if (isLoading && _customerProductPrices.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (errorMessage != null &&
                          _customerProductPrices.isEmpty) {
                        return _ErrorState(
                          message: errorMessage,
                          onRefresh: _refresh,
                        );
                      }

                      if (list.isEmpty) {
                        return const _EmptyState(
                          icon: Icons.inventory_2_outlined,
                          title: 'Produk tidak ditemukan',
                          subtitle:
                              'Tidak ada produk untuk customer ini atau pencarian tidak sesuai.',
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                          itemCount: list.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, i) {
                            final it = list[i];

                            return _ProductCustomerCard(
                              item: it,
                              onEdit: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'TODO: edit harga "${it.product.name}"',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomerPickerItem {
  final int id;
  final String name;

  const CustomerPickerItem({
    required this.id,
    required this.name,
  });
}

class _ProductCustomerCard extends StatelessWidget {
  final CustomerProductPrice item;
  final VoidCallback onEdit;

  const _ProductCustomerCard({
    required this.item,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final productName = product.name.trim().isEmpty ? '-' : product.name;
    final stock = product.totalStock ?? product.stock;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEFE6EC),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: AppTheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Stok: $stock',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Harga customer: Rp ${item.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primary,
                  ),
                ),
                if (item.discountType != null &&
                    item.discountType!.trim().isNotEmpty &&
                    item.discountValue != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Diskon: ${item.discountType} ${item.discountValue}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6F646B),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF4ECF2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFEADDE6),
                ),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 100),
        Icon(
          icon,
          size: 64,
          color: AppTheme.primary,
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppTheme.textMuted,
          ),
        ),
      ],
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
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 100),
        const Icon(
          Icons.error_outline_rounded,
          size: 64,
          color: AppTheme.primary,
        ),
        const SizedBox(height: 14),
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
    );
  }
}