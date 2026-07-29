import 'dart:convert';

class KunjunganModel {
  final String? message;
  final List<KunjunganData>? data;

  KunjunganModel({this.message, this.data});

  factory KunjunganModel.fromMap(Map<String, dynamic> json) => KunjunganModel(
        message: json['message'],
        data: json['data'] == null
            ? null
            : List<KunjunganData>.from(
                json['data']!.map((x) => KunjunganData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class KunjunganData {
  final int? visitId;
  final String? employeesId;
  final String? visitDate;
  final String? visitTime;
  final String? checkOutTime;
  final String? photoIn;
  final String? photoOut;
  final String? latitudeIn;
  final String? latitudeOut;
  final String? notes;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final KunjunganEmployee? employee;

  KunjunganData({
    this.visitId,
    this.employeesId,
    this.visitDate,
    this.visitTime,
    this.checkOutTime,
    this.photoIn,
    this.photoOut,
    this.latitudeIn,
    this.latitudeOut,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory KunjunganData.fromJson(String str) =>
      KunjunganData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KunjunganData.fromMap(Map<String, dynamic> json) => KunjunganData(
        visitId: json['visit_id'] != null
            ? int.tryParse(json['visit_id'].toString())
            : null,
        employeesId: json['employees_id']?.toString(),
        visitDate: json['visit_date'],
        visitTime: json['visit_time']?.toString(),
        checkOutTime: json['check_out_time']?.toString(),
        photoIn: json['photo_in']?.toString(),
        photoOut: json['photo_out']?.toString(),
        latitudeIn: json['latitude_longtitude_in']?.toString(),
        latitudeOut: json['latitude_longtitude_out']?.toString(),
        notes: json['notes']?.toString(),
        status: json['status']?.toString(),
        employee: json['employee'] != null
            ? KunjunganEmployee.fromMap(json['employee'])
            : null,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        'visit_id': visitId,
        'employees_id': employeesId,
        'visit_date': visitDate,
        'visit_time': visitTime,
        'check_out_time': checkOutTime,
        'photo_in': photoIn,
        'photo_out': photoOut,
        'latitude_longtitude_in': latitudeIn,
        'latitude_longtitude_out': latitudeOut,
        'notes': notes,
        'status': status,
        'employee': employee?.toMap(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class KunjunganEmployee {
  final int? employeeId;
  final String? employeeName;

  KunjunganEmployee({this.employeeId, this.employeeName});

  factory KunjunganEmployee.fromMap(Map<String, dynamic> json) =>
      KunjunganEmployee(
        employeeId: json['employee_id'],
        employeeName: json['employees_name'],
      );

  Map<String, dynamic> toMap() => {
        'employee_id': employeeId,
        'employees_name': employeeName,
      };
}
