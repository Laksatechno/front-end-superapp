class KnowledgeSchedule {
  final int id;
  final String code; // contoh: 2026_01_w2
  final int durationMinutes;
  final DateTime startAt;
  final DateTime endAt;

  final int? score;
  final String? scoreLabel; // contoh: "Baik"
  final String? grade; // contoh: "B"
  final String suggestion;

  const KnowledgeSchedule({
    required this.id,
    required this.code,
    required this.durationMinutes,
    required this.startAt,
    required this.endAt,
    required this.suggestion,
    this.score,
    this.scoreLabel,
    this.grade,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startAt) && now.isBefore(endAt);
  }

  bool get isExpired => DateTime.now().isAfter(endAt);

  Duration get remaining {
    final now = DateTime.now();
    if (now.isAfter(endAt)) return Duration.zero;
    return endAt.difference(now);
  }
}

class KnowledgeQuestion {
  final int id;
  final String question;
  final String hint;

  const KnowledgeQuestion({
    required this.id,
    required this.question,
    this.hint = '',
  });
}
