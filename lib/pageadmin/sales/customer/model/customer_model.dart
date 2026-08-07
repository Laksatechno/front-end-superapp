class CustomerPageResult {
  final List<Customer> customers;
  final int lastPage;

  CustomerPageResult({required this.customers, required this.lastPage});
}

class Customer {
  final int id;
  final int? areaId;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String tipePelanggan;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Area? area;

  Customer({
    required this.id,
    this.areaId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.tipePelanggan,
    this.createdAt,
    this.updatedAt,
    this.area,
  });

  factory Customer.fromMap(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] is int
          ? json['id']
          : int.tryParse('${json['id']}') ?? 0,

      areaId: json['area_id'] == null
          ? null
          : (json['area_id'] is int
              ? json['area_id']
              : int.tryParse('${json['area_id']}')),

      name: (json['name'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      tipePelanggan: (json['tipe_pelanggan'] ?? '').toString(),

      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),

      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.tryParse(json['updated_at'].toString()),

      area: json['area'] != null &&
              json['area'] is Map<String, dynamic>
          ? Area.fromMap(json['area'])
          : null,
    );
  }
}

class Area {
  final int id;
  final String name;

  Area({
    required this.id,
    required this.name,
  });

  factory Area.fromMap(Map<String, dynamic> json) {
    return Area(
      id: json['id'] is int
          ? json['id']
          : int.tryParse('${json['id']}') ?? 0,

      name: (json['name'] ?? '-').toString().isEmpty
          ? '-'
          : json['name'].toString(),
    );
  }
}

class LinkedUser {
  final int id;
  final String name;
  final String email;
  final String role;

  LinkedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory LinkedUser.fromMap(Map<String, dynamic> json) {
    return LinkedUser(
      id: json['id'] is int
          ? json['id']
          : int.tryParse('${json['id']}') ?? 0,
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }
}

class CustomerDetail {
  final int id;
  final int? areaId;
  final int? userId;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String tipePelanggan;
  final LinkedUser? user;
  final Area? area;

  CustomerDetail({
    required this.id,
    this.areaId,
    this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
    required this.tipePelanggan,
    this.user,
    this.area,
  });

  factory CustomerDetail.fromMap(Map<String, dynamic> json) {
    final userJson = json['user'];
    return CustomerDetail(
      id: json['id'] is int
          ? json['id']
          : int.tryParse('${json['id']}') ?? 0,

      areaId: json['area_id'] == null
          ? null
          : (json['area_id'] is int
              ? json['area_id']
              : int.tryParse('${json['area_id']}')),

      userId: json['user_id'] == null
          ? null
          : (json['user_id'] is int
              ? json['user_id']
              : int.tryParse('${json['user_id']}')),

      name: (json['name'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      tipePelanggan: (json['tipe_pelanggan'] ?? '').toString(),

      user: userJson is Map<String, dynamic>
          ? LinkedUser.fromMap(userJson)
          : null,

      area: json['area'] is Map<String, dynamic>
          ? Area.fromMap(json['area'])
          : null,
    );
  }
}
