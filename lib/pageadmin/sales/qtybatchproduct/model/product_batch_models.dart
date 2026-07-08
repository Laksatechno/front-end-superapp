class ProductBatchResponse {
  final String status;
  final String message;
  final ProductLite product;
  final List<ProductBatch> batches;

  ProductBatchResponse({
    required this.status,
    required this.message,
    required this.product,
    required this.batches,
  });

  factory ProductBatchResponse.fromJson(Map<String, dynamic> json) {
    final productMap = (json['product'] as Map?)?.cast<String, dynamic>() ?? const {};
    final batchList = (json['batches'] as List?) ?? const [];

    return ProductBatchResponse(
      status: (json['status'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      product: ProductLite.fromJson(productMap),
      batches: batchList
          .whereType<Map>()
          .map((e) => ProductBatch.fromJson(e.cast<String, dynamic>()))
          .toList(),
    );
  }
}

class ProductLite {
  final int id;
  final String name;
  final int totalStock;

  ProductLite({
    required this.id,
    required this.name,
    required this.totalStock,
  });

  factory ProductLite.fromJson(Map<String, dynamic> json) {
    return ProductLite(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      totalStock: _asInt(json['total_stock']),
    );
  }
}

class ProductBatch {
  final int id;
  final String batchNo;
  final String nie;
  final String typeModel;
  final DateTime? expDate;
  final double qtyOnHand;

  ProductBatch({
    required this.id,
    required this.batchNo,
    required this.nie,
    required this.typeModel,
    required this.expDate,
    required this.qtyOnHand,
  });

  factory ProductBatch.fromJson(Map<String, dynamic> json) {
    return ProductBatch(
      id: _asInt(json['id']),
      batchNo: (json['batch_no'] ?? '').toString(),
      nie: (json['nie'] ?? '').toString(),
      typeModel: (json['type_model'] ?? '').toString(),
      expDate: _asDate(json['exp_date']),
      qtyOnHand: _asDouble(json['qty_on_hand']),
    );
  }
}

// ===== helpers =====
int _asInt(dynamic v) {
  if (v is int) return v;
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

double _asDouble(dynamic v) {
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v?.toString() ?? '') ?? 0.0;
}

DateTime? _asDate(dynamic v) {
  if (v == null) return null;
  return DateTime.tryParse(v.toString());
}