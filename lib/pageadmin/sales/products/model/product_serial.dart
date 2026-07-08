class ProductSerial {
  final int id;
  final int productId;
  final int batchId;
  final String serialNo;
  final String status; // IN/OUT dll
  final int? saleDetailId;
  final DateTime? receivedAt;
  final DateTime? soldAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductSerial({
    required this.id,
    required this.productId,
    required this.batchId,
    required this.serialNo,
    required this.status,
    required this.saleDetailId,
    required this.receivedAt,
    required this.soldAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductSerial.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) {
      if (v == null) return null;
      return DateTime.tryParse(v.toString());
    }

    return ProductSerial(
      id: (json['id'] ?? 0) as int,
      productId: (json['product_id'] ?? 0) as int,
      batchId: (json['batch_id'] ?? 0) as int,
      serialNo: (json['serial_no'] ?? '') as String,
      status: (json['status'] ?? '') as String,
      saleDetailId: json['sale_detail_id'] == null ? null : (json['sale_detail_id'] as int),
      receivedAt: parseDt(json['received_at']),
      soldAt: parseDt(json['sold_at']),
      createdAt: parseDt(json['created_at']),
      updatedAt: parseDt(json['updated_at']),
    );
  }
}