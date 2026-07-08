import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/pageadmin/sales/getproducts/model/customer_product_price_model.dart';
import 'package:yofa/pagecustomer/order/checkout_page.dart';
import 'package:yofa/pagecustomer/product/bloc/productuser_bloc.dart';
import 'package:yofa/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class OrderCustomerPage extends StatefulWidget {
  const OrderCustomerPage({super.key});

  @override
  State<OrderCustomerPage> createState() => _OrderCustomerPageState();
}

class _OrderCustomerPageState extends State<OrderCustomerPage> {
  final Map<int, int> cart = {};

  @override
  void initState() {
    super.initState();
    context.read<ProductUserBloc>().add(
          const ProductUserEvent.getProductsByUser(),
        );
  }

  int totalItem() => cart.values.fold(0, (sum, qty) => sum + qty);

  int totalPrice(List<CustomerProductPrice> products) {
    int total = 0;
    cart.forEach((index, qty) {
      if (index < products.length) {
        total += _price(products[index]) * qty;
      }
    });
    return total;
  }

  int _price(CustomerProductPrice item) {
    final value = item.price;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString().replaceAll('.00', '')) ?? 0;
  }

  String _name(CustomerProductPrice item) {
    return item.product.name.isEmpty ? '-' : item.product.name;
  }

  String _productId(CustomerProductPrice item) {
    return item.productId.toString();
  }

String _image(CustomerProductPrice item) {
  final imageUrl = item.product.imageUrl;
  return (imageUrl != null && imageUrl.isNotEmpty) ? imageUrl : '';
}

  String currency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        )}';
  }

  void addToCart(int index) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + 1;
    });
  }

  void removeFromCart(int index) {
    if (!cart.containsKey(index)) return;
    setState(() {
      if (cart[index] == 1) {
        cart.remove(index);
      } else {
        cart[index] = cart[index]! - 1;
      }
    });
  }

  void showQtyDialog(int index, int currentQty) {
    final controller = TextEditingController(text: currentQty.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Ubah Quantity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Masukkan qty',
              filled: true,
              fillColor: AppTheme.bg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim()) ?? 0;
                setState(() {
                  if (value <= 0) {
                    cart.remove(index);
                  } else {
                    cart[index] = value;
                  }
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    context.read<ProductUserBloc>().add(const ProductUserEvent.refresh());
  }

  void _navigateToCheckout(List<CustomerProductPrice> products) {
    // Filter hanya produk yang dipilih (qty > 0)
    final selectedItems = <Map<String, dynamic>>[];
    
    cart.forEach((index, qty) {
      if (qty > 0 && index < products.length) {
        final product = products[index];
        selectedItems.add({
          'id': product.id,
          'product_id': product.productId,
          'name': _name(product),
          'price': _price(product),
          'qty': qty,
          'image': _image(product),
        });
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(items: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductUserBloc, ProductUserState>(
      builder: (context, state) {
        final products = state.maybeWhen(
          loaded: (data) => data,
          orElse: () => <CustomerProductPrice>[],
        );
        return Scaffold(
          backgroundColor: AppTheme.bg,
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Order Menu',
              style: TextStyle(
                color: AppTheme.bg,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: totalItem() == 0
                        ? null
                        : () => _navigateToCheckout(products),
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                  if (totalItem() > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            totalItem().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
          bottomNavigationBar: totalItem() > 0
              ? SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${totalItem()} item di keranjang',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                currency(totalPrice(products)),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateToCheckout(products),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppTheme.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          body: state.when(
            initial: () => const SizedBox(),
            loading: () {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final crossAxisCount = width >= 1100
                      ? 5
                      : width >= 800
                          ? 4
                          : width >= 600
                              ? 3
                              : 2;

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: width >= 600 ? 0.78 : 0.68,
                    ),
                    itemBuilder: (context, index) {
                      return const _ProductCardSkeleton();
                    },
                  );
                },
              );
            },
            error: (message) => _ErrorView(
              message: message,
              onRefresh: _refresh,
            ),
            loaded: (data) {
              if (data.isEmpty) {
                return _EmptyView(onRefresh: _refresh);
              }
              return RefreshIndicator(
                color: AppTheme.primary,
                onRefresh: _refresh,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width >= 1100
                        ? 5
                        : width >= 800
                            ? 4
                            : width >= 600
                                ? 3
                                : 2;
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: width >= 600 ? 0.78 : 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        final qty = cart[index] ?? 0;
                        return _ProductCard(
                          productId: _productId(item),
                          name: _name(item),
                          image: _image(item),
                          price: currency(_price(item)),
                          qty: qty,
                          onAdd: () => addToCart(index),
                          onRemove: () => removeFromCart(index),
                          onTapQty: () => showQtyDialog(index, qty),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 12,
                    width: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String productId;
  final String name;
  final String image;
  final String price;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onTapQty;

  const _ProductCard({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
    required this.onTapQty,
  });

  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: image.isNotEmpty
                  ? Image.network(Variables.storageUrl +
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 14),
                qty == 0
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            '+ Keranjang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppTheme.bg,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: onRemove,
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                            GestureDetector(
                              onTap: onTapQty,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppTheme.border),
                                ),
                                child: Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: onAdd,
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      color: const Color(0xffF5F7FA),
      child: Center(
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.medical_services_rounded,
            size: 38,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppTheme.primary,
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 180),
          Icon(
            Icons.inventory_2_outlined,
            size: 72,
            color: AppTheme.hint,
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'Produk belum tersedia',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final Future<void> Function() onRefresh;

  const _ErrorView({
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
              size: 72,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.textMuted),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () => onRefresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Muat Ulang'),
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