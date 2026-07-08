import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yofa/models/knowledgemodels/knowledge_models.dart';
import '../../theme/app_theme.dart';

class SoalPage extends StatefulWidget {
  final KnowledgeSchedule schedule;
  final List<KnowledgeQuestion> questions;

  const SoalPage({
    super.key,
    required this.schedule,
    required this.questions,
  });

  @override
  State<SoalPage> createState() => _SoalPageState();
}

class _SoalPageState extends State<SoalPage> with WidgetsBindingObserver {
  final PageController _pageCtrl = PageController();
  final TextEditingController _answerCtrl = TextEditingController();

  late final List<String> _answers;
  int _index = 0;
  bool _submitted = false;

  Timer? _ticker; // optional, untuk update UI kalau mau (mis. time left)
  bool get _isLast => _index == widget.questions.length - 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _answers = List.filled(widget.questions.length, '');

    _answerCtrl.addListener(() {
      if (!mounted) return;
      setState(() {});
    });

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });

    // set initial text
    _answerCtrl.text = _answers[_index];
  }

  @override
  void dispose() {
    _ticker?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    // safety: auto submit saat dispose kalau belum
    if (!_submitted) {
      // ignore: unawaited_futures
      _submit(auto: true);
    }

    _answerCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // auto-submit kalau app ditutup / background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      if (!_submitted) {
        // ignore: unawaited_futures
        _submit(auto: true);
      }
    }
  }

  void _saveCurrentAnswer() {
    _answers[_index] = _answerCtrl.text.trim();
  }

  Future<void> _next() async {
    if (_submitted) return;

    _saveCurrentAnswer();
    if (_answers[_index].isEmpty) return;

    if (!_isLast) {
      setState(() => _index++);
      await _pageCtrl.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      _answerCtrl.text = _answers[_index];
    }
  }

  Future<void> _submit({bool auto = false}) async {
    if (_submitted) return;

    _saveCurrentAnswer();

    // boleh autosubmit walau ada kosong (sesuai requirement)
    // kalau manual submit, paksa soal terakhir harus terisi
    if (!auto && _answers[_index].isEmpty) return;

    setState(() => _submitted = true);

    // TODO: kirim ke API
    // payload: schedule.id, answers, timestamp, dll.

    if (!mounted) return;

    if (auto) {
      // jangan tampilkan dialog kalau autosubmit (biar gak crash saat app background)
      return;
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Selesai', style: TextStyle(fontWeight: FontWeight.w900)),
        content: Text('Jawaban kamu sudah tersubmit untuk ${widget.schedule.code}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );

    if (!mounted) return;
    Navigator.pop(context); // balik ke KnowledgePage
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFE6EC)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_index];
    final canNextOrSubmit = _answerCtrl.text.trim().isNotEmpty && !_submitted;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text('Soal ${_index + 1}/${widget.questions.length}'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.schedule.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    q.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6F646B),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: PageView.builder(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.questions.length,
              itemBuilder: (_, i) {
                // hanya render 1 UI input (kita pakai controller tunggal)
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: _card(
                    child: TextField(
                      controller: _answerCtrl,
                      enabled: !_submitted,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: q.hint.isEmpty ? 'Tulis jawaban...' : q.hint,
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFF9F6F8),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEFE6EC)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: AppTheme.primary, width: 1.2),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: (!_isLast && canNextOrSubmit) ? _next : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFBDA7B8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Berikutnya', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: (_isLast && canNextOrSubmit) ? () => _submit(auto: false) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE63B5C),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFFFA0B8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
