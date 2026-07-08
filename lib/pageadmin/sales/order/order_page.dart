
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/pageadmin/sales/customer/bloc/customer_bloc.dart';
import 'package:yofa/pageadmin/sales/getproducts/bloc/customer_products_bloc.dart';
import 'package:yofa/pageadmin/sales/getproducts/model/customer_product_price_model.dart';
import 'package:yofa/pageadmin/sales/marketing/bloc/marketing_bloc.dart';
import 'package:yofa/pageadmin/sales/order/bloc/save_sale_bloc.dart';
import 'package:yofa/pageadmin/sales/order/model/save_sale_models.dart';
import 'package:yofa/pageadmin/sales/qtybatchproduct/bloc/product_batch_bloc.dart';
import 'package:yofa/pageadmin/sales/qtybatchproduct/model/product_batch_models.dart'
    as api;
import 'package:yofa/pageadmin/sales/tagihansales/tagihan_sales.dart';
import 'package:yofa/theme/app_theme.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  BuildContext? _cartSheetCtx;

  SaveSaleRequest _buildSaveSaleRequest() {
    final customerId = _selectedCustomer!.id;
    final taxStatus = _mapTaxToApi(_tax!);
    final dueDate = _mapTempoToDueDate(_tempo!);
    final ship = _shippingValue();

    final items = _cart.map((c) {
      // batches dari picked
      final allocations = c.picks.map((p) {
        return SaleBatchAllocation(
          productBatchId: p.batch.id,
          qty: p.take,
          serials: const [], // kalau nanti serialized, isi list serial di sini
        );
      }).toList();

      return SaleItemRequest(
        productId: c.product.id,
        quantity: c.qty,
        price: c.price,
        diskonBarang: c.discountAmount, // diskon nominal per item
        batches: allocations,
      );
    }).toList();

    return SaveSaleRequest(
      customerId: customerId,
      taxStatus: taxStatus,
      dueDate: dueDate,
      shippingFee: ship,
      marketingId: _marketingId!, // wajib
      items: items,
    );
  }

  String _mapTaxToApi(String ui) {
    // ui: 'PPN' / 'NonPPn'
    return (ui.toLowerCase() == 'ppn') ? 'ppn' : 'non-ppn';
  }

  String? _mapTempoToDueDate(String ui) {
    // ui: 'Cash' / '1 Bulan' / '2 Bulan'
    if (ui.toLowerCase() == 'cash') return '3';
    if (ui.startsWith('1')) return '1';
    if (ui.startsWith('2')) return '2';
    return null; // kalau nanti ada '3 Bulan' tinggal return '3'
  }

  final List<Marketing> _markings = const [
    Marketing(id: 1, name: 'Marketing 1'),
    Marketing(id: 2, name: 'Marketing 2'),
    Marketing(id: 3, name: 'Marketing 3'),
    Marketing(id: 4, name: 'Marketing 4'),
  ];

  // ===== State Selected =====
  OrderCustomer? _selectedCustomer;
  Product? _selectedProduct;

  // ===== Produk khusus customer (dari API) =====
  List<CustomerProductPrice> _customerProductPrices = [];
  List<Batch> _apiBatches = [];
  // batch selection
  bool _batchReady = false; // true setelah "Gunakan Batch"
  List<BatchPick> _pickedBatches = [];

  // cart
  final List<CartItem> _cart = [];

  // invoice options
  String? _tempo; // null = tampilkan hint
  String? _tax;
  int? _marketingId;

  // ===== Controllers =====
  final _stockCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _discountCtrl = TextEditingController();
  final _shippingCtrl = TextEditingController();

  String _discountType = 'Persen'; // Persen / Nominal

  @override
  void dispose() {
    _stockCtrl.dispose();
    _priceCtrl.dispose();
    _qtyCtrl.dispose();
    _discountCtrl.dispose();
    _shippingCtrl.dispose();
    
    super.dispose();
  }

  // ===== Helpers =====
  Color get _softPurple => const Color(0xFFF4ECF2);
  Color get _softBorder => const Color(0xFFEFE6EC);

  int _qtyValue() => int.tryParse(_qtyCtrl.text.trim()) ?? 0;
  int _discountValue() => int.tryParse(_discountCtrl.text.trim()) ?? 0;
  int _shippingValue() => int.tryParse(_shippingCtrl.text.trim()) ?? 0;

  int _calcDiscountAmount({required int price, required int qty}) {
    final subtotal = price * qty;
    final d = _discountValue();

    if (_discountType == 'Persen') {
      final p = d.clamp(0, 100);
      return ((subtotal * p) / 100).round();
    } else {
      return d.clamp(0, subtotal);
    }
  }

  int _cartSubtotal() {
    int sum = 0;
    for (final it in _cart) {
      sum += it.price * it.qty;
    }
    return sum;
  }

  int _cartDiscountTotal() {
    int sum = 0;
    for (final it in _cart) {
      sum += it.discountAmount;
    }
    return sum;
  }

  int _cartGrandTotal() {
    final subtotal = _cartSubtotal();
    final disc = _cartDiscountTotal();
    final ship = _shippingValue();
    return (subtotal - disc) + ship;
  }

  void _resetProductFormKeepCustomer() {
    setState(() {
      _selectedProduct = null;
      _stockCtrl.text = '';
      _priceCtrl.text = '';
      _qtyCtrl.text = '';
      _discountCtrl.text = '';
      _discountType = 'Persen';
      _batchReady = false;
      _pickedBatches = [];
    });
  }

  // ===== UI Blocks =====
  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        color: AppTheme.textDark,
        fontSize: 12.5,
      ),
    ),
  );

  InputDecoration _fieldDeco({
    required String hint,
    Widget? prefix,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefix,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: _softBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: _softBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
      ),
    );
  }

  Widget _pillBadge(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : _softPurple,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 11.5,
          color: solid ? Colors.white : AppTheme.primary,
        ),
      ),
    );
  }

  // ===== Picker Modals =====
  Future<void> _pickCustomer() async {
    final picked = await _showSearchPicker<OrderCustomer>(
      title: 'Pilih Customer',
      hint: 'Cari customer...',
      items:
          _customersFromCustomerBloc(), //  dari CustomerBloc (fungsi helper di bawah)
      itemLabel: (c) => c.name,
      itemSub: (c) => 'ID: ${c.id}',
      leadingIcon: Icons.person_search_rounded,
    );

    print(picked);

    if (picked == null) return;

    // set customer + reset form produk
    setState(() {
      _selectedCustomer = picked;
      _customerProductPrices = [];
    });

    _resetProductFormKeepCustomer();

    //  otomatis load produk khusus customer
    context.read<CustomerProductsBloc>().add(
      CustomerProductsEvent.getByCustomer(customerId: picked.id),
    );
  }

  Future<void> _pickProduct() async {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih customer dulu')));
      return;
    }

    // pastikan data produk customer sudah ada
    final cpsState = context.read<CustomerProductsBloc>().state;
    print (cpsState);

    List<CustomerProductPrice> list = cpsState.maybeWhen(
      loaded: (customerId, data) {
        // safety: pastikan sesuai customer yg dipilih
        if (customerId != _selectedCustomer!.id)
          return <CustomerProductPrice>[];
        return data;
      },
      orElse: () => [],
    );

    if (list.isEmpty) {
      // kalau belum loaded, trigger load ulang
      context.read<CustomerProductsBloc>().add(
        CustomerProductsEvent.getByCustomer(customerId: _selectedCustomer!.id),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Memuat produk customer...')),
      );
      return;
    }

    // cache
    _customerProductPrices = list;

    // konversi ke Product UI (harga = price khusus customer)
    final products = list
        .map(
          (it) => Product(
            id: it.product.id,
            name: it.product.name,
            stock: it.product.totalStock ?? it.product.stock,
            price: it.price,
          ),
        )
        .toList();

    final picked = await _showSearchPicker<Product>(
      title: 'Pilih Produk',
      hint: 'Cari produk...',
      items: products,
      itemLabel: (p) => p.name,
      itemSub: (p) => 'Stok: ${p.stock} • Harga: Rp ${p.price}',
      leadingIcon: Icons.inventory_2_outlined,
      trailingBuilder: (p) => _pillBadge('Stok ${p.stock}'),
    );

    if (picked != null) {
      setState(() {
        _selectedProduct = picked;
        _stockCtrl.text = '${picked.stock}';
        _priceCtrl.text = '${picked.price}';
        _qtyCtrl.text = '';
        _discountCtrl.text = '';
        _discountType = 'Persen';
        _batchReady = false;
        _pickedBatches = [];
        _apiBatches = [];
      });

      //  auto fetch batch dari API begitu produk dipilih
      context.read<ProductBatchBloc>().add(
        ProductBatchEvent.getBatches(productId: picked.id),
      );
    }
  }

  Future<T?> _showSearchPicker<T>({
    required String title,
    required String hint,
    required List<T> items,
    required String Function(T) itemLabel,
    required String Function(T) itemSub,
    required IconData leadingIcon,
    Widget Function(T)? trailingBuilder,
  }) async {
    final searchCtrl = TextEditingController();
    List<T> filtered = List.of(items);

    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: SizedBox(
              height: MediaQuery.of(ctx).size.height * 0.82,
              child: StatefulBuilder(
                builder: (ctx, setLocal) {
                  void applyFilter(String q) {
                    final qq = q.trim().toLowerCase();
                    setLocal(() {
                      filtered = qq.isEmpty
                          ? List.of(items)
                          : items
                                .where(
                                  (e) =>
                                      itemLabel(e).toLowerCase().contains(qq),
                                )
                                .toList();
                    });
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text(
                                'Tutup',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: TextField(
                          controller: searchCtrl,
                          onChanged: applyFilter,
                          decoration: _fieldDeco(
                            hint: hint,
                            prefix: const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF9B8F97),
                            ),
                            suffix: searchCtrl.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      searchCtrl.clear();
                                      applyFilter('');
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Color(0xFF9B8F97),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const Divider(height: 1, color: Color(0xFFEFE6EC)),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (_, i) {
                            final it = filtered[i];
                            return InkWell(
                              onTap: () => Navigator.pop(ctx, it),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: _softBorder),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x07000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: _softPurple,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFEADDE6),
                                        ),
                                      ),
                                      child: Icon(
                                        leadingIcon,
                                        color: AppTheme.primary,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemLabel(it),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: AppTheme.textDark,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            itemSub(it),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF7C6F77),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (trailingBuilder != null)
                                      trailingBuilder(it),
                                  ],
                                ),
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
          ),
        );
      },
    );

    searchCtrl.dispose();
    return result;
  }

  // ===== Batch Modal =====
  Future<void> _openBatchModal() async {
    if (_selectedProduct == null) return;

    final product = _selectedProduct!;
    final bloc = context.read<ProductBatchBloc>();

    List<Batch> batchesFromState(ProductBatchState s) {
      return s.maybeWhen(
        loaded: (productId, prod, batches) {
          if (productId != product.id) return <Batch>[];
          return _mapApiBatchesToUi(batches);
        },
        orElse: () => <Batch>[],
      );
    }

    // ambil dari state jika sudah ada
    List<Batch> batches = batchesFromState(bloc.state);

    // kalau belum ada, fetch lalu tunggu
    if (batches.isEmpty) {
      bloc.add(ProductBatchEvent.getBatches(productId: product.id));

      final next = await bloc.stream.firstWhere((s) {
        return s.maybeWhen(
          loaded: (_, __, ___) => true,
          error: (_) => true,
          orElse: () => false,
        );
      });

      if (!mounted) return;

      final err = next.maybeWhen(error: (m) => m, orElse: () => null);
      if (err != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(err)));
        return;
      }

      batches = batchesFromState(next);
    }

    if (!mounted) return;

    if (batches.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Batch kosong untuk produk ini')),
      );
      return;
    }

    // bottomsheet pakai widget sendiri agar controller aman
    final result = await showModalBottomSheet<List<BatchPick>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return _BatchPickerSheet(
          productName: product.name,
          productPrice: product.price,
          softPurple: _softPurple,
          softBorder: _softBorder,
          batches: batches,
        );
      },
    );

    if (!mounted) return;

    if (result != null && result.isNotEmpty) {
      final sum = result.fold<int>(0, (a, b) => a + b.take);
      setState(() {
        _pickedBatches = result;
        _batchReady = true;
        _qtyCtrl.text = '$sum';
      });
    }
  }

  // ===== Add to Cart =====
  void _addToCart() {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih customer dulu')));
      return;
    }
    if (_selectedProduct == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih produk dulu')));
      return;
    }
    if (!_batchReady) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih batch dulu')));
      return;
    }

    final product = _selectedProduct!;
    final qty = _qtyValue();
    if (qty <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Jumlah harus > 0')));
      return;
    }

    final price = product.price;
    final disc = _calcDiscountAmount(price: price, qty: qty);

    setState(() {
      _cart.add(
        CartItem(
          product: product,
          qty: qty,
          price: price,
          discountType: _discountType,
          discountValue: _discountValue(),
          discountAmount: disc,
          picks: List.of(_pickedBatches),
        ),
      );
    });

    _resetProductFormKeepCustomer();
  }

  // ===== Cart Sheet =====
void _openCartSheet() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (ctx) {
      _cartSheetCtx = ctx;

      return SafeArea(
        child: StatefulBuilder(
          builder: (ctx, setLocal) {
            Widget cartRow(CartItem it, int idx) {
              final subtotal = it.price * it.qty;
              final total = subtotal - it.discountAmount;

              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _softBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x07000000),
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            it.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _pillBadge('Qty ${it.qty}', solid: true),
                              _pillBadge('Rp ${it.price}'),
                              _pillBadge('Subtotal Rp $subtotal'),
                              _pillBadge('Diskon Rp ${it.discountAmount}'),
                              _pillBadge('Total Rp $total', solid: true),
                            ],
                          ),
                          if (it.picks.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              'Batch: ${it.picks.map((e) => '${e.batch.nieType} (${e.take})').join(', ')}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6F646B),
                                fontSize: 12,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        setState(() => _cart.removeAt(idx));
                        setLocal(() {});
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _softPurple,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEADDE6)),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            Widget selectGroup({
              required String title,
              required List<String> options,
              required String? value,
              required String hintText,
              required ValueChanged<String> onChanged,
            }) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(title),
                  DropdownButtonFormField<String>(
                    value: (value == null || value.isEmpty) ? null : value,
                    hint: Text(
                      hintText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF9B8F97),
                      ),
                    ),
                    isExpanded: true,
                    items: options.map((o) {
                      return DropdownMenuItem(
                        value: o,
                        child: Text(
                          o,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      onChanged(v);
                      setLocal(() {});
                    },
                    decoration: _fieldDeco(hint: hintText),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF9B8F97),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                    dropdownColor: Colors.white,
                  ),
                ],
              );
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(ctx).size.height * 0.90,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Keranjang',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _cartSheetCtx = null;
                              Navigator.pop(ctx);
                            },
                            child: const Text(
                              'Tutup',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1, color: Color(0xFFEFE6EC)),

                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_cart.isEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: _softBorder),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Keranjang kosong',
                                    style: TextStyle(
                                      color: Color(0xFF7C6F77),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _cart.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (_, i) => cartRow(_cart[i], i),
                              ),

                            const SizedBox(height: 18),

                            _label('Marketing'),
                            BlocBuilder<MarketingBloc, MarketingState>(
                              builder: (context, mState) {
                                return mState.when(
                                  initial: () => const SizedBox(),
                                  loading: () {
                                    return DropdownButtonFormField<int>(
                                      value: _marketingId,
                                      hint: const Text(
                                        'Memuat Marketing...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF9B8F97),
                                        ),
                                      ),
                                      items: const [],
                                      onChanged: null,
                                      decoration: _fieldDeco(
                                        hint: 'Memuat Marketing...',
                                      ),
                                    );
                                  },
                                  error: (msg) {
                                    return Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.red.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            msg,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<MarketingBloc>()
                                                  .add(
                                                    const MarketingEvent.get(),
                                                  );
                                            },
                                            child: const Text('Coba lagi'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  loaded: (items) {
                                    return DropdownButtonFormField<int>(
                                      value: _marketingId,
                                      hint: const Text(
                                        'Pilih Marketing',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF9B8F97),
                                        ),
                                      ),
                                      isExpanded: true,
                                      items: items.map((m) {
                                        return DropdownMenuItem<int>(
                                          value: m.id,
                                          child: Text(
                                            m.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (v) {
                                        if (v == null) return;
                                        setState(() => _marketingId = v);
                                        setLocal(() {});
                                      },
                                      decoration: _fieldDeco(
                                        hint: 'Pilih Marketing',
                                      ),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF9B8F97),
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.textDark,
                                      ),
                                      dropdownColor: Colors.white,
                                    );
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 14),

                            selectGroup(
                              title: 'Jenis Tempo',
                              hintText: 'Pilih Jenis Tempo',
                              options: const ['Cash', '1 Bulan', '2 Bulan'],
                              value: _tempo,
                              onChanged: (v) => setState(() => _tempo = v),
                            ),

                            const SizedBox(height: 14),

                            selectGroup(
                              title: 'Jenis Tax',
                              hintText: 'Pilih Tax',
                              options: const ['NPPN', 'PPN'],
                              value: _tax,
                              onChanged: (v) => setState(() => _tax = v),
                            ),

                            const SizedBox(height: 14),

                            _label('Biaya Pengiriman'),
                            TextField(
                              controller: _shippingCtrl,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: _fieldDeco(
                                hint: '0',
                                prefix: const Icon(
                                  Icons.local_shipping_outlined,
                                  color: Color(0xFF9B8F97),
                                ),
                              ),
                              onChanged: (_) => setLocal(() {}),
                            ),

                            const SizedBox(height: 14),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _softPurple,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFEADDE6),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Ringkasan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: AppTheme.textDark,
                                          ),
                                        ),
                                      ),
                                      _pillBadge(
                                        'Item ${_cart.length}',
                                        solid: true,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  _sumRow('Subtotal', 'Rp ${_cartSubtotal()}'),
                                  _sumRow(
                                    'Diskon',
                                    '- Rp ${_cartDiscountTotal()}',
                                  ),
                                  _sumRow(
                                    'Pengiriman',
                                    'Rp ${_shippingValue()}',
                                  ),
                                  const Divider(
                                    height: 14,
                                    color: Color(0xFFEADDE6),
                                  ),
                                  _sumRow(
                                    'Total',
                                    'Rp ${_cartGrandTotal()}',
                                    strong: true,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: _cart.isEmpty
                                    ? null
                                    : () {
                                        if (_selectedCustomer == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pilih customer dulu',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        if (_tempo == null || _tax == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pilih Jenis Tempo dan Jenis Tax dulu',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        if (_marketingId == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pilih Marketing dulu',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        final req = _buildSaveSaleRequest();

                                        context.read<SaveSaleBloc>().add(
                                              SaveSaleEvent.submit(req),
                                            );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor:
                                      const Color(0xFFD8C3D2),
                                  disabledForegroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'Buat Penjualan',
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  ).whenComplete(() {
    _cartSheetCtx = null;
  });
}

  static Widget _sumRow(String left, String right, {bool strong = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              style: TextStyle(
                fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
                color: const Color(0xFF6F646B),
              ),
            ),
          ),
          Text(
            right,
            style: TextStyle(
              fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Main UI =====
  @override
  Widget build(BuildContext context) {
    final canPickBatch = _selectedProduct != null;
    final canAddItem = _selectedProduct != null && _batchReady;

    return BlocListener<SaveSaleBloc, SaveSaleState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            // optional: tampilkan loading overlay / snackbar
            final sheetCtx = _cartSheetCtx;
            if (sheetCtx != null) {
              //  tutup sheet saat loading
              Navigator.of(sheetCtx).pop();
              _cartSheetCtx = null;
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Sedang diproses...')));
          },
          success: (res) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  res.message.isNotEmpty
                      ? res.message
                      : 'Penjualan berhasil dibuat',
                ),
              ),
            );

            // reset form (sesuaikan kebutuhan)
            setState(() {
              _cart.clear();
              _pickedBatches = [];
              _batchReady = false;
              _tempo = null;
              _tax = null;
              _marketingId = null;
              _shippingCtrl.text = '';
              _selectedProduct = null;
              _stockCtrl.text = '';
              _priceCtrl.text = '';
              _qtyCtrl.text = '';
              _discountCtrl.text = '';
            });

            // reset state bloc biar bersih
            context.read<SaveSaleBloc>().add(const SaveSaleEvent.reset());
            //  tampil di TagihanSales
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TagihanSales()));
          },
          error: (msg) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        appBar: AppBar(
          title: const Text('Tambah Penjualan'),
          backgroundColor: AppTheme.primary,
          foregroundColor: Colors.white,
          actions: [
            InkWell(
              onTap: _openCartSheet,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (_cart.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${_cart.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.primary,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CustomerProductsBloc, CustomerProductsState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (customerId, data) {
                    if (_selectedCustomer?.id == customerId) {
                      setState(() => _customerProductPrices = data);
                    }
                  },
                  error: (msg) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(msg)));
                  },
                  orElse: () {},
                );
              },
            ),
          ],
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            children: [
              // Customer
          _label('Customer'),
          InkWell(
            onTap: _pickCustomer,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _softBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _softPurple,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEADDE6)),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      _selectedCustomer?.name ?? 'Pilih customer (search)...',
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

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF9B8F97),
                  ),
                ],
              ),
            ),
          ),

              const SizedBox(height: 14),

              // Produk
              _label('Produk'),
              InkWell(
                onTap: _pickProduct,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _softBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _softPurple,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFEADDE6)),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedProduct?.name ?? 'Pilih produk (search)...',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: _selectedProduct == null
                                ? const Color(0xFF9B8F97)
                                : AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_selectedProduct != null)
                        _pillBadge('Stok ${_selectedProduct!.stock}'),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF9B8F97),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Stock + Price
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Stok'),
                        TextField(
                          controller: _stockCtrl,
                          readOnly: true,
                          decoration: _fieldDeco(hint: '0'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Harga'),
                        TextField(
                          controller: _priceCtrl,
                          readOnly: true,
                          decoration: _fieldDeco(hint: '0'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Qty
              _label('Jumlah'),
              TextField(
                controller: _qtyCtrl,
                keyboardType: TextInputType.number,
                decoration: _fieldDeco(
                  hint: '0',
                  prefix: const Icon(
                    Icons.numbers_rounded,
                    color: Color(0xFF9B8F97),
                  ),
                  suffix: _batchReady
                      ? _pillBadge('Dari batch', solid: true)
                      : null,
                ),
              ),

              const SizedBox(height: 14),

              // Diskon type + value
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Jenis Diskon'),
                        DropdownButtonFormField<String>(
                          value: _discountType,
                          items: const [
                            DropdownMenuItem(
                              value: 'Persen',
                              child: Text('Persen'),
                            ),
                            DropdownMenuItem(
                              value: 'Nominal',
                              child: Text('Nominal'),
                            ),
                          ],
                          onChanged: (v) =>
                              setState(() => _discountType = v ?? 'Persen'),
                          decoration: _fieldDeco(hint: ''),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Diskon'),
                        TextField(
                          controller: _discountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _fieldDeco(
                            hint: _discountType == 'Persen'
                                ? '0 - 100'
                                : 'Nominal (Rp)',
                            prefix: Icon(
                              _discountType == 'Persen'
                                  ? Icons.percent_rounded
                                  : Icons.payments_outlined,
                              color: const Color(0xFF9B8F97),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Buttons: Batch & Add
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: canPickBatch ? _openBatchModal : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primary,
                        disabledBackgroundColor: const Color(0xFFF2EFF1),
                        disabledForegroundColor: const Color(0xFFB9AAB3),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(color: _softBorder),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        _batchReady ? 'Batch Dipilih' : 'Pilih Batch',
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: canAddItem ? _addToCart : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFD8C3D2),
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Tambah Barang',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // hint kecil
              if (_selectedProduct != null && !_batchReady)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _softPurple,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEADDE6)),
                  ),
                  child: const Text(
                    'Langkah: Pilih Batch terlebih dahulu, lalu tombol "Tambah Barang" akan aktif.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F646B),
                      height: 1.2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<OrderCustomer> _customersFromCustomerBloc() {
    final state = context.read<CustomerBloc>().state;

    return state.maybeWhen(
      loaded: (data, page, perPage, filterType, status) {
        return data.map((c) => OrderCustomer(id: c.id, name: c.name)).toList();
      },
      orElse: () => [],
    );
  }

  List<Batch> _mapApiBatchesToUi(List<api.ProductBatch> batches) {
    return batches.map((b) {
      final remainInt = (b.qtyOnHand)
          .round(); // qty_on_hand string -> double -> int

      // UI kamu memakai "nieType" untuk kolom Batch, kita gabungkan NIE + TypeModel + BatchNo biar informatif
      final nieType = [
        b.nie.trim(),
        if (b.typeModel.trim().isNotEmpty) 'Tipe ${b.typeModel.trim()}',
        if (b.batchNo.trim().isNotEmpty) b.batchNo.trim(),
      ].where((e) => e.isNotEmpty).join(' • ');

      final exp = b.expDate == null
          ? '-'
          : '${b.expDate!.month.toString().padLeft(2, '0')}/${b.expDate!.year}';

      return Batch(id: b.id, nieType: nieType, exp: exp, remain: remainInt);
    }).toList();
  }
}

class _marketingList {
  final List<Marketing> marketing;

  const _marketingList({required this.marketing});
}

class Marketing {
  final int id;
  final String name;

  const Marketing({required this.id, required this.name});
}

class _BatchPickerSheet extends StatefulWidget {
  final String productName;
  final int productPrice;
  final Color softPurple;
  final Color softBorder;
  final List<Batch> batches;

  const _BatchPickerSheet({
    required this.productName,
    required this.productPrice,
    required this.softPurple,
    required this.softBorder,
    required this.batches,
  });

  @override
  State<_BatchPickerSheet> createState() => _BatchPickerSheetState();
}

class _BatchPickerSheetState extends State<_BatchPickerSheet> {
  late final Map<int, TextEditingController> takeCtrls;

  @override
  void initState() {
    super.initState();
    takeCtrls = {
      for (final b in widget.batches) b.id: TextEditingController(text: '0'),
    };
  }

  @override
  void dispose() {
    for (final c in takeCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  int _sumTake() {
    int s = 0;
    for (final b in widget.batches) {
      final v = int.tryParse(takeCtrls[b.id]!.text.trim()) ?? 0;
      s += v;
    }
    return s;
  }

  int _totalStock() => widget.batches.fold(0, (a, b) => a + b.remain);

  Widget _pillBadge(String text, {bool solid = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: solid ? AppTheme.primary : widget.softPurple,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFEADDE6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 11.5,
          color: solid ? Colors.white : AppTheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final batches = widget.batches;
    final totalStock = _totalStock();

    Widget headerCell(String text, {double flex = 1}) {
      return Expanded(
        flex: (flex * 10).round(),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
            fontSize: 11.5,
          ),
        ),
      );
    }

    Widget bodyCell(String text, {double flex = 1, Color? color}) {
      return Expanded(
        flex: (flex * 10).round(),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: color ?? const Color(0xFF6F646B),
            fontSize: 11.5,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 12, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pilih Batch',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Tutup',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.softPurple,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEADDE6)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              _pillBadge('Total Stok $totalStock'),
                              const SizedBox(width: 8),
                              _pillBadge(
                                'Harga Rp ${widget.productPrice}',
                                solid: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _pillBadge('Ambil: ${_sumTake()}', solid: true),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: widget.softBorder),
                ),
                child: Row(
                  children: [
                    headerCell('Batch', flex: 2.2),
                    headerCell('EXP', flex: 1.2),
                    headerCell('Sisa', flex: 0.9),
                    headerCell('Ambil', flex: 1.1),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: batches.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final b = batches[i];
                  final ctrl = takeCtrls[b.id]!;
                  return Container(
                    key: ValueKey('batch_row_${b.id}'),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: widget.softBorder),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x06000000),
                          blurRadius: 8,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        bodyCell(b.nieType, flex: 2.2),
                        bodyCell(b.exp, flex: 1.2),
                        bodyCell(
                          '${b.remain}',
                          flex: 0.9,
                          color: AppTheme.primary,
                        ),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 38,
                            child: TextField(
                              key: ValueKey('take_${b.id}'),
                              controller: ctrl,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (val) {
                                if (!mounted) return;

                                int v = int.tryParse(val.trim()) ?? 0;
                                if (v > b.remain) v = b.remain;

                                final txt = '$v';
                                if (ctrl.text != txt) {
                                  ctrl.value = TextEditingValue(
                                    text: txt,
                                    selection: TextSelection.collapsed(
                                      offset: txt.length,
                                    ),
                                  );
                                }

                                setState(() {}); // update badge "Ambil: x"
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF9F6F8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: widget.softBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: widget.softBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppTheme.primary,
                                    width: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      final picks = <BatchPick>[];
                      int sum = 0;

                      for (final b in batches) {
                        final v =
                            int.tryParse(takeCtrls[b.id]!.text.trim()) ?? 0;

                        if (v > b.remain) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Ambil melebihi sisa stok pada ${b.nieType}',
                              ),
                            ),
                          );
                          return;
                        }

                        if (v > 0) {
                          picks.add(BatchPick(batch: b, take: v));
                          sum += v;
                        }
                      }

                      if (sum <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Isi kolom Ambil minimal 1'),
                          ),
                        );
                        return;
                      }

                      Navigator.pop(context, picks);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Gunakan Batch',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Models =====
class OrderCustomer {
  final int id;
  final String name;
  const OrderCustomer({required this.id, required this.name});
}

class Product {
  final int id;
  final String name;
  final int stock;
  final int price;
  const Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
  });
}

class Batch {
  final int id;
  final String nieType;
  final String exp;
  final int remain;
  const Batch({
    required this.id,
    required this.nieType,
    required this.exp,
    required this.remain,
  });
}

class BatchPick {
  final Batch batch;
  final int take;
  BatchPick({required this.batch, required this.take});
}

class CartItem {
  final Product product;
  final int qty;
  final int price;

  final String discountType; // Persen / Nominal
  final int discountValue;
  final int discountAmount;

  final List<BatchPick> picks;

  CartItem({
    required this.product,
    required this.qty,
    required this.price,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
    required this.picks,
  });
}
