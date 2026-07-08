

import 'package:yofa/pageadmin/sales/products/model/products_model.dart';

class ProductPageResponse {
  final int currentPage;
  final List<Product> items;
  final int lastPage;
  final int perPage;
  final int total;

  const ProductPageResponse({
    required this.currentPage,
    required this.items,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory ProductPageResponse.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map<String, dynamic>?);
    final list = (data?['data'] as List?) ?? const [];

    int parseInt(dynamic v, {int def = 0}) {
      if (v == null) return def;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? def;
    }

    return ProductPageResponse(
      currentPage: parseInt(data?['current_page'], def: 1),
      items: list.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList(),
      lastPage: parseInt(data?['last_page'], def: 1),
      perPage: parseInt(data?['per_page'], def: 10),
      total: parseInt(data?['total'], def: list.length),
    );
  }
}