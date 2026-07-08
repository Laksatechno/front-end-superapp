import 'dart:convert';

class Alat {
  final int? id;
  final int? customerId;
  final String? noseri;
  final String? valueQc;
  final String? kalibrasi;
  final String? status;
  final String? condition;
  final String? detailsCondition;
  final String? description;
  final String? isService;
  final String? tanggalInstall;
  final String? createdAt;
  final String? updatedAt;

  final int? customerIdDetail;
  final int? areaId;
  final String? namaOutlet;
  final String? alamat;

  const Alat({
    this.id,
    this.customerId,
    this.noseri,
    this.valueQc,
    this.kalibrasi,
    this.status,
    this.condition,
    this.detailsCondition,
    this.description,
    this.isService,
    this.tanggalInstall,
    this.createdAt,
    this.updatedAt,
    this.customerIdDetail,
    this.areaId,
    this.namaOutlet,
    this.alamat,
  });

  String get displayOutlet => namaOutlet ?? '-';
  String get displayNoSeri => noseri ?? '-';
  String get displayQc =>
      valueQc == null || valueQc!.isEmpty ? '-' : valueQc!;

  factory Alat.fromMap(Map<String, dynamic> map) {
    final customer = map['customer'] is Map
        ? Map<String, dynamic>.from(map['customer'])
        : <String, dynamic>{};

    return Alat(
      id: int.tryParse('${map['id'] ?? ''}'),
      customerId: int.tryParse('${map['customer_id'] ?? ''}'),
      noseri: map['noseri']?.toString(),
      valueQc: map['value_qc']?.toString(),
      kalibrasi: map['kalibrasi']?.toString(),
      status: map['status']?.toString(),
      condition: map['condition']?.toString(),
      detailsCondition: map['details_condition']?.toString(),
      description: map['description']?.toString(),
      isService: map['is_service']?.toString(),
      tanggalInstall: map['tanggal_install']?.toString(),
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
      customerIdDetail: int.tryParse('${customer['id'] ?? ''}'),
      areaId: int.tryParse('${customer['area_id'] ?? ''}'),
      namaOutlet: customer['nama_outlet']?.toString() ??
          map['nama_outlet']?.toString() ??
          map['outlet']?.toString(),
      alamat: customer['alamat']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'noseri': noseri,
      'value_qc': valueQc,
      'kalibrasi': kalibrasi,
      'status': status,
      'condition': condition,
      'details_condition': detailsCondition,
      'description': description,
      'is_service': isService,
      'tanggal_install': tanggalInstall,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'customer': {
        'id': customerIdDetail,
        'area_id': areaId,
        'nama_outlet': namaOutlet,
        'alamat': alamat,
      },
    };
  }

  factory Alat.fromJson(String source) =>
      Alat.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}