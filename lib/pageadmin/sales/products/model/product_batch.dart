class ProductBatch {
  final int id;
  final int productId;
  final String batchNo;
  final String? serialNo;
  final String? nie;
  final String? typeModel;
  final String? mfgDate; // bisa string ISO / yyyy-MM-dd
  final String? expDate; // bisa string ISO / yyyy-MM-dd
  final String qtyOnHand; // API: "1.0000"
  final String qtyCommitted; // API: "0.0000"
  final String? importMonth;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductBatch({
    required this.id,
    required this.productId,
    required this.batchNo,
    required this.serialNo,
    required this.nie,
    required this.typeModel,
    required this.mfgDate,
    required this.expDate,
    required this.qtyOnHand,
    required this.qtyCommitted,
    required this.importMonth,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductBatch.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(dynamic v) {
      if (v == null) return null;
      return DateTime.tryParse(v.toString());
    }

    return ProductBatch(
      id: (json['id'] ?? 0) as int,
      productId: (json['product_id'] ?? 0) as int,
      batchNo: (json['batch_no'] ?? '') as String,
      serialNo: json['serial_no']?.toString(),
      nie: json['nie']?.toString(),
      typeModel: json['type_model']?.toString(),
      mfgDate: json['mfg_date']?.toString(),
      expDate: json['exp_date']?.toString(),
      qtyOnHand: (json['qty_on_hand'] ?? '0').toString(),
      qtyCommitted: (json['qty_committed'] ?? '0').toString(),
      importMonth: json['import_month']?.toString(),
      notes: json['notes']?.toString(),
      createdAt: parseDt(json['created_at']),
      updatedAt: parseDt(json['updated_at']),
    );
  }
}