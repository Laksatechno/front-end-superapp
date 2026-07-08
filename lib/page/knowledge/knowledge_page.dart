import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yofa/models/knowledgemodels/knowledge_models.dart';
import '../../theme/app_theme.dart';
import 'soal_page.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  Timer? _ticker;

  // Dummy data (nanti ganti dari API)
  final List<KnowledgeSchedule> _items = [
    KnowledgeSchedule(
      id: 1,
      code: '2026_01_w2',
      durationMinutes: 7,
      startAt: DateTime(2026, 1, 17, 8, 0),
      endAt: DateTime(2026, 1, 17, 8, 16),
      score: 118,
      scoreLabel: 'Baik',
      grade: 'B',
      suggestion: 'Diperhatikan ejaan',
    ),
    KnowledgeSchedule(
      id: 2,
      code: '2026_01_w1',
      durationMinutes: 7,
      startAt: DateTime(2026, 1, 10, 8, 0),
      endAt: DateTime(2026, 1, 10, 8, 16),
      score: 90,
      scoreLabel: 'Cukup',
      grade: 'C',
      suggestion: 'Perbanyak latihan',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // supaya countdown update
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _fmtDateTime(DateTime d) {
    const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final dayName = days[d.weekday % 7];
    final mon = months[d.month - 1];
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$dayName, ${d.day} $mon ${d.year}, $hh.$mm';
  }

  String _fmtCountdown(Duration r) {
    final s = r.inSeconds;
    final h = (s ~/ 3600);
    final m = (s % 3600) ~/ 60;
    final sec = s % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void _openSoal(KnowledgeSchedule s) {
    // contoh list soal (nanti dari API)
    final questions = List.generate(
      8,
      (i) => KnowledgeQuestion(
        id: i + 1,
        question: 'Soal ${i + 1}. Jelaskan singkat terkait materi ${s.code}...',
        hint: 'Tulis jawaban kamu di sini',
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SoalPage(
          schedule: s,
          questions: questions,
        ),
      ),
    );
  }

  Widget _badgeRed(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w900,
        color: Color(0xFFE63B5C),
      ),
    );
  }

  Widget _softLine() => const Divider(height: 18, color: Color(0xFFEFE6EC));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text('Knowledge'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final it = _items[i];
          return _KnowledgeCard(
            item: it,
            fmtDateTime: _fmtDateTime,
            fmtCountdown: _fmtCountdown,
            badgeRed: _badgeRed,
            softLine: _softLine,
            onStart: () => _openSoal(it),
          );
        },
      ),
    );
  }
}

class _KnowledgeCard extends StatelessWidget {
  final KnowledgeSchedule item;
  final String Function(DateTime) fmtDateTime;
  final String Function(Duration) fmtCountdown;
  final Widget Function(String) badgeRed;
  final Widget Function() softLine;
  final VoidCallback onStart;

  const _KnowledgeCard({
    required this.item,
    required this.fmtDateTime,
    required this.fmtCountdown,
    required this.badgeRed,
    required this.softLine,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive;
    final isExpired = item.isExpired;

    final leftTitleStyle = const TextStyle(
      fontWeight: FontWeight.w900,
      color: AppTheme.textDark,
      fontSize: 14,
    );

    final subStyle = const TextStyle(
      fontWeight: FontWeight.w800,
      color: Color(0xFF6F646B),
      height: 1.25,
    );

    // label countdown/status
    final statusWidget = isActive
        ? badgeRed('Sisa: ${fmtCountdown(item.remaining)}')
        : (isExpired ? badgeRed('Waktu Habis') : const Text(
            'Belum Mulai',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF6F646B),
            ),
          ));

    final btnText = isActive ? 'Mulai Test' : 'Tertutup';
    final btnColor = isActive ? AppTheme.primary : const Color(0xFFFFA0B8);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jadwal Knowledge', style: leftTitleStyle.copyWith(color: const Color(0xFFE63B5C))),
                const SizedBox(height: 10),
                softLine(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // KIRI
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.description_outlined, color: AppTheme.primary, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.code,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF6F646B),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Durasi: ${item.durationMinutes} menit', style: subStyle),
                          const SizedBox(height: 8),
                          statusWidget,
                          const SizedBox(height: 8),
                          Text(
                            'Score: ${item.score == null ? '-' : '${item.score}/${item.scoreLabel ?? ''}'}',
                            style: subStyle,
                          ),
                          Text('Grade: ${item.grade ?? '-'}', style: subStyle),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // KANAN
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.access_time_rounded, color: AppTheme.primary, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Jadwal',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF6F646B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Mulai: ${fmtDateTime(item.startAt)}', style: subStyle),
                          const SizedBox(height: 6),
                          Text('Selesai: ${fmtDateTime(item.endAt)}', style: subStyle),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                softLine(),
                Text(
                  'Saran: ${item.suggestion}',
                  style: subStyle.copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isActive ? onStart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: btnColor,
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(btnText, style: const TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
