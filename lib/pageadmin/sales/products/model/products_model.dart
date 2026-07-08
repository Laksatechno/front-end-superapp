import 'product_batch.dart';
import 'product_serial.dart';

class Product {
  final int id;
  final String name;
  final int stock;
  final bool isSerialized;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int isEditable; // API: 0/1
  final int totalStock;

  final List<ProductBatch> batches;
  final List<ProductSerial> serials;

  const Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.isSerialized,
    required this.createdAt,
    required this.updatedAt,
    required this.isEditable,
    required this.totalStock,
    required this.batches,
    required this.serials,
  });

factory Product.fromJson(Map<String, dynamic> json) {

  int parseInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) {
      final d = double.tryParse(v);
      if (d != null) return d.toInt();
    }
    return 0;
  }

  bool parseBool(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    if (v is int) return v == 1;
    if (v is String) return v == "1" || v.toLowerCase() == "true";
    return false;
  }

  DateTime? parseDt(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }

  final batchesJson = (json['batches'] as List?) ?? [];
  final serialsJson = (json['serials'] as List?) ?? [];

  return Product(
    id: parseInt(json['id']),
    name: json['name']?.toString() ?? '',
    stock: parseInt(json['stock']), // fix untuk "10.0000"
    isSerialized: parseBool(json['is_serialized']),
    createdAt: parseDt(json['created_at']),
    updatedAt: parseDt(json['updated_at']),
    isEditable: parseInt(json['is_editable']),
    totalStock: parseInt(json['total_stock']),
    batches: batchesJson
        .map((e) => ProductBatch.fromJson(e as Map<String, dynamic>))
        .toList(),
    serials: serialsJson
        .map((e) => ProductSerial.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

}

class CreateProductRequest {
  final String name;
  final int stock;
  final bool isSerialized;

  CreateProductRequest({
    required this.name,
    required this.stock,
    required this.isSerialized,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "stock": stock,
      "is_serialized": isSerialized,
    };
  }
}


class CreateBatchRequest {
  final int productId;
  final String batchNo;
  final int qty;
  final String? nie;
  final String? typeModel;
  final DateTime? expDate;
  final List<String>? serialNumbers;

  CreateBatchRequest({
    required this.productId,
    required this.batchNo,
    required this.qty,
    this.nie,
    this.typeModel,
    this.expDate,
    this.serialNumbers,
  });

  Map<String, dynamic> toJson() {
    return {
      "batch_no": batchNo,
      "qty": qty,
      "nie": nie,
      "type_model": typeModel,
      "exp_date": expDate?.toIso8601String().split('T').first,
      "serial_numbers": serialNumbers,
    };
  }

  factory CreateBatchRequest.fromJson(Map<String, dynamic> json) {
    int parseQty(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString().split('.').first) ?? 0;
    }

    return CreateBatchRequest(
      productId: json['product_id'] ?? 0,
      batchNo: json['batch_no'] ?? '',
      qty: parseQty(json['qty']),
      nie: json['nie'],
      typeModel: json['type_model'],
      expDate: json['exp_date'] == null
          ? null
          : DateTime.tryParse(json['exp_date']),
      serialNumbers: (json['serial_numbers'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}