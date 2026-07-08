import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yofa/theme/app_theme.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'message':
          'Halo Admin, saya ingin menanyakan status pesanan saya.',
      'isMe': true,
      'time': '09:12',
    },
    {
      'message':
          'Halo kak 👋\nBaik, mohon informasikan nomor pesanan nya ya.',
      'isMe': false,
      'time': '09:13',
    },
    {
      'message': 'INVOICE 10024',
      'isMe': true,
      'time': '09:14',
    },
    {
      'message':
          'Baik kak, pesanan sedang diproses pengiriman 😊',
      'isMe': false,
      'time': '09:15',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'message': text,
        'isMe': true,
        'time':
            '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
      });
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 120), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  bool get _isDesktop => MediaQuery.of(context).size.width >= 1000;

  bool get _isTablet =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1000;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
        titleSpacing: 0,
        title: Row(
          children: [
            Hero(
              tag: 'admin-avatar',
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.25),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                  ),
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Admin Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
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

                      /// blur bubble background
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
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          18,
                          16,
                          20,
                        ),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final item = _messages[index];

                          return _MessageBubble(
                            message: item['message'],
                            isMe: item['isMe'],
                            time: item['time'],
                          );
                        },
                      ),
                    ],
                  ),
                ),

                /// INPUT
                Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    MediaQuery.of(context).padding.bottom + 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: AppTheme.border.withOpacity(0.7),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.bg,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: AppTheme.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: AppTheme.primary,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _messageController,
                                  minLines: 1,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.newline,
                                  decoration: const InputDecoration(
                                    hintText: 'Tulis pesan...',
                                    hintStyle: TextStyle(
                                      color: AppTheme.hint,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.image_outlined,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      InkWell(
                        onTap: _sendMessage,
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
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withOpacity(0.35),
                                blurRadius: 14,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bgBubble({
    required double size,
    required Color color,
  }) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
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
  final String message;
  final bool isMe;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.78,
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              16,
              14,
              16,
              10,
            ),
            decoration: BoxDecoration(
              color: isMe ? AppTheme.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(22),
                topRight: const Radius.circular(22),
                bottomLeft: Radius.circular(isMe ? 22 : 6),
                bottomRight: Radius.circular(isMe ? 6 : 22),
              ),
              border: Border.all(
                color: isMe
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
                  message,
                  style: TextStyle(
                    height: 1.45,
                    fontSize: 14,
                    color: isMe
                        ? Colors.white
                        : AppTheme.textDark,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: isMe
                            ? Colors.white70
                            : AppTheme.textMuted,
                      ),
                    ),

                    if (isMe) ...[
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
      ),
    );
  }
}