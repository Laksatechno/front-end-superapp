import 'package:flutter/material.dart';
import 'package:yofa/core/constants/variables.dart';
import 'package:yofa/pageadmin/sales/getproducts/model/customer_product_price_model.dart';
import 'package:yofa/pagecustomer/order/checkout_page.dart';
import 'package:yofa/theme/app_theme.dart';

class ProductDetailsPage extends StatefulWidget {
  final CustomerProductPrice product;
  final Function(int) addToCart;
  final List<CustomerProductPrice> products;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.addToCart,
    required this.products,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int qty = 1;

  int _price(CustomerProductPrice item) {
    final value = item.price;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString().replaceAll('.00', '')) ?? 0;
  }

  String _name(CustomerProductPrice item) {
    return item.product.name.isEmpty ? '-' : item.product.name;
  }

  String _image(CustomerProductPrice item) {
    final imageUrl = item.product.imageUrl;
    return (imageUrl != null && imageUrl.isNotEmpty) ? imageUrl : '';
  }

  String _description(CustomerProductPrice item) {
    if (item.product.description?.isNotEmpty == true) {
      return item.product.description!;
    }
      print('Product Description: ${item.product.description}');
    return 'Deskripsi produk akan segera tersedia.';
  }


  String currency(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        )}';
  }

  void _addToCart() {
    final index = widget.products.indexOf(widget.product);
    if (index != -1) {
      // Tambahkan item ke keranjang sebanyak qty yang dipilih
      for (var i = 0; i < qty; i++) {
        widget.addToCart(index);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menambahkan $qty produk ke keranjang'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _buyNow() {
    final index = widget.products.indexOf(widget.product);
    if (index != -1) {
      // Filter hanya produk yang dipilih (qty > 0)
      final selectedItems = <Map<String, dynamic>>[];
      selectedItems.add({
        'id': widget.product.id,
        'product_id': widget.product.productId,
        'name': _name(widget.product),
        'price': _price(widget.product),
        'qty': qty,
        'image': _image(widget.product),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CheckoutPage(items: selectedItems),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _name(widget.product),
          style: const TextStyle(
            color: AppTheme.bg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: _image(widget.product).isNotEmpty
                  ? Image.network(
                      Variables.storageUrl + _image(widget.product),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                    )
                  : _buildPlaceholderImage(),
            ),
            const SizedBox(height: 16),
            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name(widget.product),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currency(_price(widget.product)),
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _description(widget.product),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Quantity Selector
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: AppTheme.bg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (qty > 1) qty--;
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      qty.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.textDark,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Add to Cart Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _addToCart,
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
              ),
              const SizedBox(width: 12),
              // Buy Now Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _buyNow,
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
                    'Beli Langsung',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
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