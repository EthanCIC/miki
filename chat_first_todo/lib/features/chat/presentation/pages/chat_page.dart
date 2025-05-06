import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/ui/theme/app_theme.dart';

/// 聊天頁面
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: '您好！我是 Miki，您的個人助理。我可以幫您管理待辦事項、回答問題，以及提供各種幫助。有什麼我可以協助您的嗎？',
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text.trim(),
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _messageController.clear();
    });

    // 自動滾動到底部
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // TODO: 實現 API 調用並處理響應
    // 模擬響應，將來會替換為實際 API 調用
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: '我了解了。這是一個模擬回應，未來會由實際的 API 調用來處理您的請求。',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });

      // 自動滾動到底部
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('智能聊天'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 聊天消息區域
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, isDarkMode);
              },
            ),
          ),

          // 底部輸入區域
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkSurface : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '輸入訊息...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.large),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? AppColors.darkCardColor
                          : const Color(0xFFE5E5EA),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                    tooltip: '發送',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: const Icon(Icons.assistant, color: Colors.white, size: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: message.isUser
                    ? AppColors.primary
                    : isDarkMode
                        ? AppColors.darkCardColor
                        : const Color(0xFFE5E5EA),
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.body(isDarkMode).copyWith(
                      color: message.isUser
                          ? Colors.white
                          : isDarkMode
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: AppTextStyles.caption2(isDarkMode).copyWith(
                      color: message.isUser
                          ? Colors.white.withOpacity(0.7)
                          : isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: AppSpacing.sm),
            CircleAvatar(
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}

/// 聊天消息模型
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
