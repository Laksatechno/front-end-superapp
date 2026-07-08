import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';

class CallplanItem {
  final int id;
  final DateTime tanggalCp;
  final String outlet;
  final String description;

  const CallplanItem({
    required this.id,
    required this.tanggalCp,
    required this.outlet,
    required this.description,
  });

  ///  from JSON / API
  factory CallplanItem.fromMap(Map<String, dynamic> map) {
    return CallplanItem(
      id: map['callplan_id'] ?? 0,
      tanggalCp: DateTime.parse(map['tanggal_cp']),
      outlet: map['nama_outlet'] ?? '',
      description: map['description'] ?? '',
    );
  }

  /// 🔥 untuk kirim ke API
  Map<String, dynamic> toMap() {
    return {
      'callplan_id': id,
      'tanggal_cp': tanggalCp.toIso8601String(),
      'nama_outlet': outlet,
      'description': description,
    };
  }

  CallplanItem copyWith({
    int? id,
    DateTime? tanggalCp,
    String? outlet,
    String? description,
  }) {
    return CallplanItem(
      id: id ?? this.id,
      tanggalCp: tanggalCp ?? this.tanggalCp,
      outlet: outlet ?? this.outlet,
      description: description ?? this.description,
    );
  }
}