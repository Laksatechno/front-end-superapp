class ShiftModel {
  final bool? success;
  final String? message;
  final List<ShiftData>? data;

  ShiftModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShiftModel.fromMap(Map<String, dynamic> map) {
    return ShiftModel(
      success: map['success'],
      message: map['message'],
      data: map['data'] != null
          ? List<ShiftData>.from(
              (map['data'] as List).map((x) => ShiftData.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }
}

class ShiftData {
  final int? id;
  final String? namaShift;
  final String? jamMasuk;
  final String? jamKeluar;
  final String? createdAt;
  final String? updatedAt;

  ShiftData({
    this.id,
    this.namaShift,
    this.jamMasuk,
    this.jamKeluar,
    this.createdAt,
    this.updatedAt,
  });

  factory ShiftData.fromMap(Map<String, dynamic> map) {
    return ShiftData(
      id: map['id'],
      namaShift: map['nama_shift'],
      jamMasuk: map['jam_masuk'],
      jamKeluar: map['jam_keluar'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_shift': namaShift,
      'jam_masuk': jamMasuk,
      'jam_keluar': jamKeluar,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
