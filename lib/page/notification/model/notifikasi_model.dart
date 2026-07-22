class NotifikasiModel {
  final int id;
  final int userId;
  final String category;
  final String title;
  final String body;
  final int isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotifikasiModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      isRead: json['is_read'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category': category,
      'title': title,
      'body': body,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  NotifikasiModel copyWith({
    int? id,
    int? userId,
    String? category,
    String? title,
    String? body,
    int? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotifikasiModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
