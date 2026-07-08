class MarketingUser {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? foto;
  final String? noHp;
  final String? address;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  MarketingUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.foto,
    required this.noHp,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MarketingUser.fromJson(Map<String, dynamic> json) {
    return MarketingUser(
      id: _asInt(json['id']),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
      foto: json['foto']?.toString(),
      noHp: json['no_hp']?.toString(),
      address: json['address']?.toString(),
      createdAt: _asDate(json['created_at']),
      updatedAt: _asDate(json['updated_at']),
    );
  }
}

int _asInt(dynamic v) {
  if (v is int) return v;
  return int.tryParse(v?.toString() ?? '') ?? 0;
}

DateTime? _asDate(dynamic v) {
  if (v == null) return null;
  return DateTime.tryParse(v.toString());
}