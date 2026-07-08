class CustomerProductPrice {
  final int id;
  final int customerId;
  final int productId;
  final int price;

  final String? discountType;
  final int? discountValue;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final ProductLite product;

  CustomerProductPrice({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.price,
    required this.discountType,
    required this.discountValue,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory CustomerProductPrice.fromJson(Map<String, dynamic> json) {
    return CustomerProductPrice(
      id: _asInt(json['id']),
      customerId: _asInt(json['customer_id']),
      productId: _asInt(json['product_id']),
      price: _asInt(json['price']),
      discountType: json['discount_type']?.toString(),
      discountValue: json['discount_value'] == null ? null : _asInt(json['discount_value']),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
      product: ProductLite.fromJson((json['product'] as Map?)?.cast<String, dynamic>() ?? const {}),
    );
  }

  static int _asInt(dynamic v) {
    if (v is int) return v;
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  static DateTime? _asDate(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }
}

class ProductLite {
  final int id;
  final String name;
  final String? imageUrl;
  final int stock;
  final bool isSerialized;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final int? isEditable;
  final int? totalStock;

  ProductLite({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.stock,
    required this.isSerialized,
    required this.createdAt,
    required this.updatedAt,
    required this.isEditable,
    required this.totalStock,
  });

  factory ProductLite.fromJson(Map<String, dynamic> json) {
    return ProductLite(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? '').toString(),
      stock: _asInt(json['stock']),
      isSerialized: _asBool(json['is_serialized']),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
      isEditable: json['is_editable'] == null ? null : _asInt(json['is_editable']),
      totalStock: json['total_stock'] == null ? null : _asInt(json['total_stock']),
    );
  }

  static int _asInt(dynamic v) {
    if (v is int) return v;
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  static bool _asBool(dynamic v) {
    if (v is bool) return v;
    final s = (v ?? '').toString().toLowerCase();
    return s == '1' || s == 'true' || s == 'yes';
  }

  static DateTime? _asDate(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }
}