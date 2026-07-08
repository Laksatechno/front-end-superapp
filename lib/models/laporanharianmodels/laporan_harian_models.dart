import 'package:flutter/material.dart';

enum LaporanStatus { draft, submitted }

extension LaporanStatusX on LaporanStatus {
  String get label => this == LaporanStatus.submitted ? 'Submitted' : 'Draft';

  Color get bg => this == LaporanStatus.submitted
      ? const Color(0xFFD1FADF)
      : const Color(0xFFF4ECF2);

  Color get fg => this == LaporanStatus.submitted
      ? const Color(0xFF11643A)
      : const Color(0xFF6B2C5B);
}

class LaporanHarianItem {
  final int id;
  final DateTime date;
  final LaporanStatus status;
  final String activity;
  final DateTime? lastSavedAt;

  const LaporanHarianItem({
    required this.id,
    required this.date,
    required this.status,
    required this.activity,
    required this.lastSavedAt,
  });

  LaporanHarianItem copyWith({
    LaporanStatus? status,
    String? activity,
    DateTime? lastSavedAt,
  }) {
    return LaporanHarianItem(
      id: id,
      date: date,
      status: status ?? this.status,
      activity: activity ?? this.activity,
      lastSavedAt: lastSavedAt ?? this.lastSavedAt,
    );
  }
}

String formatDate(DateTime d) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];
  final m = months[d.month - 1];
  return '${d.day.toString().padLeft(2, '0')} $m ${d.year}';
}

String formatTime(DateTime d) {
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}
