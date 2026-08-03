import 'dart:convert';

class RegisterModel {
  final int? id;
  final String? namaInstansi;
  final String? namaPic;
  final String? nomorPic;
  final String? alamat;
  final String? email;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  RegisterModel({
    this.id,
    this.namaInstansi,
    this.namaPic,
    this.nomorPic,
    this.alamat,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['id'] is int ? map['id'] : int.tryParse('${map['id']}'),
      namaInstansi: map['nama_instansi']?.toString(),
      namaPic: map['nama_pic']?.toString(),
      nomorPic: map['nomor_pic']?.toString(),
      alamat: map['alamat']?.toString(),
      email: map['email']?.toString(),
      role: map['role']?.toString(),
      createdAt: map['created_at']?.toString(),
      updatedAt: map['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_instansi': namaInstansi,
      'nama_pic': namaPic,
      'nomor_pic': nomorPic,
      'alamat': alamat,
      'email': email,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory RegisterModel.fromJson(String source) {
    return RegisterModel.fromMap(json.decode(source));
  }

  String toJson() => json.encode(toMap());
}