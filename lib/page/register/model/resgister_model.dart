import 'dart:convert';

class RegisterModel {
  final int? id;
  final String? name;
  final String? email;
  final String? noHp;
  final String? address;
  final String? role;
  final String? tipePelanggan;
  final String? jenisInstitusi;
  final int? marketingId;
  final String? createdAt;
  final String? updatedAt;

  RegisterModel({
    this.id,
    this.name,
    this.email,
    this.noHp,
    this.address,
    this.role,
    this.tipePelanggan,
    this.jenisInstitusi,
    this.marketingId,
    this.createdAt,
    this.updatedAt,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['id'] is int ? map['id'] : int.tryParse('${map['id']}'),
      name: map['name']?.toString(),
      email: map['email']?.toString(),
      noHp: map['no_hp']?.toString(),
      address: map['address']?.toString(),
      role: map['role']?.toString(),
      tipePelanggan: map['tipe_pelanggan']?.toString(),
      jenisInstitusi: map['jenis_institusi']?.toString(),
      marketingId: map['marketing_id'] is int
          ? map['marketing_id']
          : int.tryParse('${map['marketing_id']}'),
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'no_hp': noHp,
      'address': address,
      'role': role,
      'tipe_pelanggan': tipePelanggan,
      'jenis_institusi': jenisInstitusi,
      'marketing_id': marketingId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory RegisterModel.fromJson(String source) {
    return RegisterModel.fromMap(json.decode(source));
  }

  String toJson() => json.encode(toMap());
}