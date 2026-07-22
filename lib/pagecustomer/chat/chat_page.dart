import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yofa/theme/app_theme.dart';

enum ChatRecipient {
  ai,
  admin,
  marketing,
  superadmin,
}

class ChatMessage {
  final String message;
  final bool isMe;
  final String time;
  final String role;
  final String senderName;

  const ChatMessage({
    required this.message,
    required this.isMe,
    required this.time,
    required this.role,
    required this.senderName,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  ChatRecipient _currentRecipient = ChatRecipient.ai;

  bool _isSending = false;

  // Untuk pengujian saja.
  // Jalankan dengan:
  // flutter run --dart-define=OPENAI_API_KEY=sk-xxxxx
  static const String _aiApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
  );

  static const String _aiBaseUrl = 'https://api.tokengo.com/v1';
  static const String _aiModel = 'minimax/minimax-m2.5';

final List<ChatMessage> _messages = [
  const ChatMessage(
    message: 'Halo! Saya adalah AI Customer Service. Ada yang bisa saya bantu?',
    isMe: false,
    time: '09:00',
    role: 'ai',
    senderName: 'AI Assistant',
  ),
];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String get _recipientName {
    switch (_currentRecipient) {
      case ChatRecipient.ai:
        return 'AI Assistant';
      case ChatRecipient.admin:
        return 'Admin';
      case ChatRecipient.marketing:
        return 'Marketing';
      case ChatRecipient.superadmin:
        return 'Superadmin';
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _isSending) return;

    final userMessage = ChatMessage(
      message: text,
      isMe: true,
      time: _formatTime(DateTime.now()),
      role: 'customer',
      senderName: 'Anda',
    );

    setState(() {
      _messages.add(userMessage);
      _isSending = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      switch (_currentRecipient) {
        case ChatRecipient.ai:
          await _getAIResponse();
          break;

        case ChatRecipient.admin:
        case ChatRecipient.marketing:
        case ChatRecipient.superadmin:
          _addTemporaryRoleResponse();
          break;
      }
    } catch (error) {
      _addSystemMessage(
        'Maaf, terjadi kesalahan saat menghubungi AI.\n$error',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }

      _scrollToBottom();
    }
  }

  Future<void> _getAIResponse() async {
    // if (_aiApiKey.isEmpty) {
    //   throw Exception(
    //     'OPENAI_API_KEY belum diatur. Jalankan aplikasi menggunakan '
    //     '--dart-define=OPENAI_API_KEY=API_KEY_ANDA',
    //   );
    // }

    final inputMessages = _messages
        .where((message) => message.role == 'customer' || message.role == 'ai')
        .map(
          (message) => {
            'role': message.role == 'customer' ? 'user' : 'assistant',
            'content': message.message,
          },
        )
        .toList();

    final response = await http.post(
      Uri.parse('$_aiBaseUrl/chat/completions'),
      headers: {
        'Authorization': 'Bearer 3qghxhqx5TZdov44ye5eTpxOilUcXC4Kt1u0klWHrxwGCTbA',
        'Content-Type': 'application/json',
      },
      // 'Authorization': 'Bearer $_aiApiKey
      body: jsonEncode({
        'model': _aiModel,
        'instructions': '''
Anda adalah AI Customer Service YOFA.

Tugas Anda:
1. Menjawab pertanyaan pelanggan dengan ramah dan ringkas.
2. Gunakan bahasa Indonesia.
3. Jangan mengarang status pesanan, harga, stok, atau promo.
4. Jika data tidak tersedia, katakan bahwa informasi perlu diperiksa admin.
5. Jika masalah membutuhkan manusia, arahkan pelanggan ke Admin.
''',
        'input': inputMessages,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final errorMessage = _extractErrorMessage(response.body);

      throw Exception(
        '${response.statusCode}: $errorMessage',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final answer = _extractAIText(data);

    if (answer.isEmpty) {
      throw Exception('AI tidak mengembalikan jawaban.');
    }

    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: answer,
          isMe: false,
          time: _formatTime(DateTime.now()),
          role: 'ai',
          senderName: 'AI Assistant',
        ),
      );
    });
  }

  String _extractAIText(Map<String, dynamic> data) {
    final output = data['output'];

    if (output is! List) return '';

    final textParts = <String>[];

    for (final outputItem in output) {
      if (outputItem is! Map<String, dynamic>) continue;

      final content = outputItem['content'];

      if (content is! List) continue;

      for (final contentItem in content) {
        if (contentItem is! Map<String, dynamic>) continue;

        if (contentItem['type'] == 'output_text' &&
            contentItem['text'] is String) {
          textParts.add(contentItem['text'] as String);
        }
      }
    }

    return textParts.join('\n').trim();
  }

  String _extractErrorMessage(String responseBody) {
    try {
      final data = jsonDecode(responseBody);

      if (data is Map<String, dynamic>) {
        final error = data['error'];

        if (error is Map<String, dynamic> && error['message'] is String) {
          return error['message'] as String;
        }
      }
    } catch (_) {
      // Gunakan response body asli apabila bukan JSON.
    }

    return responseBody;
  }

  void _addTemporaryRoleResponse() {
    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message:
              'Pesan untuk $_recipientName sudah dicatat. '
              'Fitur chat langsung dengan $_recipientName '
              'akan dihubungkan ke backend pada tahap berikutnya.',
          isMe: false,
          time: _formatTime(DateTime.now()),
          role: _currentRecipient.name,
          senderName: _recipientName,
        ),
      );
    });
  }

  void _addSystemMessage(String message) {
    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          message: message,
          isMe: false,
          time: _formatTime(DateTime.now()),
          role: 'system',
          senderName: 'Sistem',
        ),
      );
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _showRecipientSelector() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ChatRecipient.values.map((recipient) {
              final selected = recipient == _currentRecipient;

              return ListTile(
                leading: Icon(
                  _getRecipientIcon(recipient),
                  color: selected ? AppTheme.primary : Colors.grey,
                ),
                title: Text(_getRecipientLabel(recipient)),
                trailing: selected
                    ? const Icon(
                        Icons.check_circle,
                        color: AppTheme.primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _currentRecipient = recipient;
                  });

                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _getRecipientLabel(ChatRecipient recipient) {
    switch (recipient) {
      case ChatRecipient.ai:
        return 'AI Assistant';
      case ChatRecipient.admin:
        return 'Admin';
      case ChatRecipient.marketing:
        return 'Marketing';
      case ChatRecipient.superadmin:
        return 'Superadmin';
    }
  }

  IconData _getRecipientIcon(ChatRecipient recipient) {
    switch (recipient) {
      case ChatRecipient.ai:
        return Icons.smart_toy_rounded;
      case ChatRecipient.admin:
        return Icons.support_agent_rounded;
      case ChatRecipient.marketing:
        return Icons.campaign_rounded;
      case ChatRecipient.superadmin:
        return Icons.admin_panel_settings_rounded;
    }
  }

  bool get _isDesktop => MediaQuery.sizeOf(context).width >= 1000;

  bool get _isTablet {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 650 && width < 1000;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = double.infinity;

    if (_isDesktop) {
      maxWidth = 850;
    } else if (_isTablet) {
      maxWidth = 650;
    }

    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withOpacity(0.15),
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
              child: Icon(
                _getRecipientIcon(_currentRecipient),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: _showRecipientSelector,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _recipientName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _currentRecipient == ChatRecipient.ai
                          ? 'Online • Model: $_aiModel'
                          : 'Pilih tujuan percakapan',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: _showRecipientSelector,
              icon: const Icon(Icons.expand_more_rounded),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFF9F5F8),
                                Color(0xFFF5EEF3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -50,
                        right: -40,
                        child: _bgBubble(
                          size: 180,
                          color: AppTheme.primary.withOpacity(0.08),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: -50,
                        child: _bgBubble(
                          size: 200,
                          color: Colors.purple.withOpacity(0.06),
                        ),
                      ),
                      ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
                        itemCount: _messages.length + (_isSending ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (_isSending && index == _messages.length) {
                            return const _TypingBubble();
                          }

                          return _MessageBubble(
                            data: _messages[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _buildInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.paddingOf(context).bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppTheme.border.withOpacity(0.7),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.bg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppTheme.border),
              ),
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 5,
                enabled: !_isSending,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  hintText: 'Tulis pesan...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: _isSending ? null : _sendMessage,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.primary,
                    Color(0xFF7E3D82),
                  ],
                ),
              ),
              child: _isSending
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.send_rounded,
                      color: AppTheme.primary,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bgBubble({
    required double size,
    required Color color,
  }) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage data;

  const _MessageBubble({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: data.isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: data.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!data.isMe)
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 4),
                child: Text(
                  data.senderName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.78,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                decoration: BoxDecoration(
                  color: data.isMe ? AppTheme.primary : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(22),
                    topRight: const Radius.circular(22),
                    bottomLeft: Radius.circular(data.isMe ? 22 : 6),
                    bottomRight: Radius.circular(data.isMe ? 6 : 22),
                  ),
                  border: Border.all(
                    color: data.isMe
                        ? AppTheme.primary
                        : AppTheme.border,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.message,
                      style: TextStyle(
                        height: 1.45,
                        fontSize: 14,
                        color: data.isMe
                            ? Colors.white
                            : AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.time,
                          style: TextStyle(
                            fontSize: 11,
                            color: data.isMe
                                ? Colors.white70
                                : AppTheme.textMuted,
                          ),
                        ),
                        if (data.isMe) ...[
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.done_all_rounded,
                            size: 16,
                            color: Colors.white70,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}