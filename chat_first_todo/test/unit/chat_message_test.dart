import 'package:flutter_test/flutter_test.dart';
import 'package:miki/data/models/chat_message.dart';

void main() {
  group('ChatMessage Model', () {
    test('should create a ChatMessage with correct default values', () {
      final message = ChatMessage(
        content: '測試消息',
        sender: SenderType.user,
      );

      expect(message.content, '測試消息');
      expect(message.sender, SenderType.user);
      expect(message.type, MessageType.text);
      expect(message.isRead, true); // 用戶發送的消息默認已讀
      expect(message.hasAttachment, false);
      expect(message.needsAttention, false);
    });

    test('should create a ChatMessage with attachments correctly', () {
      final message = ChatMessage(
        content: '測試附件消息',
        sender: SenderType.assistant,
        type: MessageType.image,
        attachmentUrl: 'https://example.com/image.jpg',
      );

      expect(message.content, '測試附件消息');
      expect(message.sender, SenderType.assistant);
      expect(message.type, MessageType.image);
      expect(message.isRead, false); // 助手發送的消息默認未讀
      expect(message.hasAttachment, true);
      expect(message.attachmentUrl, 'https://example.com/image.jpg');
    });

    test('should mark message as read correctly', () {
      final message = ChatMessage(
        content: '測試未讀消息',
        sender: SenderType.assistant,
        needsAttention: true,
      );

      expect(message.isRead, false);
      expect(message.needsAttention, true);

      message.markAsRead();

      expect(message.isRead, true);
      expect(message.needsAttention, false);
    });

    test('should identify message types correctly', () {
      final userMessage = ChatMessage(
        content: '用戶消息',
        sender: SenderType.user,
      );

      final assistantMessage = ChatMessage(
        content: '助手消息',
        sender: SenderType.assistant,
      );

      final systemMessage = ChatMessage(
        content: '系統消息',
        sender: SenderType.system,
      );

      final todoRelatedMessage = ChatMessage(
        content: 'Todo相關消息',
        sender: SenderType.assistant,
        todoId: 123,
      );

      final todoReferenceMessage = ChatMessage(
        content: 'Todo引用消息',
        sender: SenderType.assistant,
        type: MessageType.todoReference,
      );

      expect(userMessage.isUserMessage, true);
      expect(userMessage.isAssistantMessage, false);
      expect(userMessage.isSystemMessage, false);

      expect(assistantMessage.isAssistantMessage, true);
      expect(assistantMessage.isUserMessage, false);

      expect(systemMessage.isSystemMessage, true);

      expect(todoRelatedMessage.isTodoRelated, true);
      expect(todoReferenceMessage.isTodoRelated, true);
      expect(userMessage.isTodoRelated, false);
    });

    test('should display time correctly', () {
      // 注意：這個測試依賴於當前時間，可能需要調整
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day, 14, 30);
      final yesterday = DateTime(now.year, now.month, now.day - 1, 9, 15);
      final lastWeek = DateTime(now.year, now.month, now.day - 7, 18, 0);

      final todayMessage = ChatMessage(
        content: '今天的消息',
        sender: SenderType.user,
      );
      todayMessage.timestamp = today;

      final yesterdayMessage = ChatMessage(
        content: '昨天的消息',
        sender: SenderType.user,
      );
      yesterdayMessage.timestamp = yesterday;

      final oldMessage = ChatMessage(
        content: '較舊的消息',
        sender: SenderType.user,
      );
      oldMessage.timestamp = lastWeek;

      // 測試時間格式（這裡我們主要測試包含的關鍵詞，而不是精確格式）
      expect(todayMessage.timeDisplay.contains('今天'), true);
      expect(yesterdayMessage.timeDisplay.contains('昨天'), true);
      expect(oldMessage.timeDisplay.contains('${lastWeek.year}'), true);
    });

    test('should convert to and from JSON correctly', () {
      final originalMessage = ChatMessage(
        content: '測試 JSON 轉換',
        sender: SenderType.assistant,
        type: MessageType.todoReference,
        todoId: 42,
        attachmentUrl: 'https://example.com/image.jpg',
        needsAttention: true,
      );

      final json = originalMessage.toJson();
      final deserializedMessage = ChatMessage.fromJson(json);

      expect(deserializedMessage.content, originalMessage.content);
      expect(deserializedMessage.sender, originalMessage.sender);
      expect(deserializedMessage.type, originalMessage.type);
      expect(deserializedMessage.todoId, originalMessage.todoId);
      expect(deserializedMessage.attachmentUrl, originalMessage.attachmentUrl);
      expect(
          deserializedMessage.needsAttention, originalMessage.needsAttention);
      expect(deserializedMessage.hasAttachment, originalMessage.hasAttachment);
    });
  });
}
