class PaymentModel {
  final int id;
  final int salesId;
  final String photo;
  final String? pph;
  final String? ppn;
  final String updatedAt;
  final String createdAt;

  const PaymentModel({
    required this.id,
    required this.salesId,
    required this.photo,
    this.pph,
    this.ppn,
    required this.updatedAt,
    required this.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      salesId: int.tryParse(json['sales_id']?.toString() ?? '') ?? 0,
      photo: (json['photo'] ?? '').toString(),
      pph: json['pph']?.toString(),
      ppn: json['ppn']?.toString(),
      updatedAt: (json['updated_at'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sales_id': salesId,
      'photo': photo,
      'pph': pph,
      'ppn': ppn,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
