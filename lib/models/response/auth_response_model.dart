import 'dart:convert';

class AuthResponseModel {
  final String? status;
  final String? message;
  final String? token;
  final User? user;
  final Employee? employee;

  AuthResponseModel({
    this.status,
    this.message,
    this.token,
    this.user,
    this.employee,
  });


  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        employee:
            json["employee"] == null ? null : Employee.fromMap(json["employee"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "token": token,
        "user": user?.toMap(),
        "employee": employee?.toMap(),
      };

  AuthResponseModel copyWith({
    String? status,
    String? message,
    String? token,
    User? user,
    Employee? employee,
  }) {
    return AuthResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
      employee: employee ?? this.employee,
    );
  }
}

class Employee {
  final int? id;
  final String? employeesCode;
  final String? employeesEmail;
  final String? employeesName;
  final int? positionId;
  final int? shiftId;
  final int? buildingId;

  final Position? position;
  final Shift? shift;
  final Building? building;

  Employee({
    this.id,
    this.employeesCode,
    this.employeesEmail,
    this.employeesName,
    this.positionId,
    this.shiftId,
    this.buildingId,
    this.position,
    this.shift,
    this.building,
  });

  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeesCode: json["employees_code"],
        employeesEmail: json["employees_email"],
        employeesName: json["employees_name"],
        positionId: json["position_id"],
        shiftId: json["shift_id"],
        buildingId: json["building_id"],
        position:
            json["position"] == null ? null : Position.fromMap(json["position"]),
        shift: json["shift"] == null ? null : Shift.fromMap(json["shift"]),
        building:
            json["building"] == null ? null : Building.fromMap(json["building"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "employees_code": employeesCode,
        "employees_email": employeesEmail,
        "employees_name": employeesName,
        "position_id": positionId,
        "shift_id": shiftId,
        "building_id": buildingId,
        "position": position?.toMap(),
        "shift": shift?.toMap(),
        "building": building?.toMap(),
      };
}

class Shift {
  final int? id;
  final String? name;
  final String? start; // "08:00:00"
  final String? end;   // "16:00:00"

  Shift({this.id, this.name, this.start, this.end});

  factory Shift.fromMap(Map<String, dynamic> json) => Shift(
        id: json["id"],
        name: json["name"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "start": start,
        "end": end,
      };
}

class Position {
  final int? id;
  final String? name;

  Position({this.id, this.name});

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Building {
  final int? id;
  final String? name;
  final String? address;

  Building({this.id, this.name, this.address});

  factory Building.fromMap(Map<String, dynamic> json) => Building(
        id: json["id"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? address;

  final DateTime? emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? noHp; 
  final String? role;
  final dynamic department;
  final dynamic faceEmbedding;
  final dynamic foto;

  User({
    this.id,
    this.name,
    this.email,
    this.address,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
    this.noHp,
    this.role,
    this.department,
    this.faceEmbedding,
    this.foto,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.tryParse(json["email_verified_at"]),
        address: json["address"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),


        noHp: (json["no_hp"] ??
                json["phone"] ??
                json["nohp"] ??
                json["noHp"])
            ?.toString(),

        role: json["role"],
        department: json["department"],
        faceEmbedding: json["face_embedding"],
        foto: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),

        "no_hp": noHp,

        "role": role,
        "department": department,
        "face_embedding": faceEmbedding,
        "image_url": foto,
      };
}

