import 'package:isar/isar.dart';

part 'chat_message.g.dart';

/// 消息類型
enum MessageType { text, image, system, todoReference }

/// 消息發送者類型
enum SenderType { user, assistant, system }

/// 聊天消息模型
@collection
class ChatMessage {
  /// 唯一識別符，由 Isar 自動生成
  Id id = Isar.autoIncrement;

  /// 消息內容
  late String content;

  /// 消息類型
  @enumerated
  late MessageType type;

  /// 發送者類型
  @enumerated
  late SenderType sender;

  /// 發送時間
  late DateTime timestamp;

  /// 是否已讀
  late bool isRead;

  /// 關聯的 Todo ID (如果適用)
  int? todoId;

  /// 是否包含附件
  late bool hasAttachment;

  /// 附件 URL (如果有)
  String? attachmentUrl;

  /// 消息是否需要關注
  late bool needsAttention;

  /// 創建新的聊天消息
  ChatMessage({
    required this.content,
    required this.sender,
    this.type = MessageType.text,
    this.todoId,
    this.attachmentUrl,
    this.needsAttention = false,
  }) {
    timestamp = DateTime.now();
    isRead = sender == SenderType.user; // 用戶發送的消息默認標記為已讀
    hasAttachment = attachmentUrl != null;
  }

  /// 標記為已讀
  void markAsRead() {
    isRead = true;
    needsAttention = false;
  }

  /// 檢查消息是否是 Todo 相關
  bool get isTodoRelated => todoId != null || type == MessageType.todoReference;

  /// 檢查消息是否是系統消息
  bool get isSystemMessage => sender == SenderType.system;

  /// 檢查消息是否是用戶發送的
  bool get isUserMessage => sender == SenderType.user;

  /// 檢查消息是否是助手發送的
  bool get isAssistantMessage => sender == SenderType.assistant;

  /// 獲取消息發送時間的顯示文字（今天/昨天/日期）
  String get timeDisplay {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDate == today) {
      return '今天 ${_formatTime(timestamp)}';
    } else if (messageDate == yesterday) {
      return '昨天 ${_formatTime(timestamp)}';
    } else {
      return '${timestamp.year}/${timestamp.month}/${timestamp.day} ${_formatTime(timestamp)}';
    }
  }

  /// 格式化時間為 HH:MM 格式
  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  /// 轉換為 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type.index,
      'sender': sender.index,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'todoId': todoId,
      'hasAttachment': hasAttachment,
      'attachmentUrl': attachmentUrl,
      'needsAttention': needsAttention,
    };
  }

  /// 從 JSON 創建
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    var message = ChatMessage(
      content: json['content'],
      sender: SenderType.values[json['sender'] ?? 0],
      type: MessageType.values[json['type'] ?? 0],
      todoId: json['todoId'],
      attachmentUrl: json['attachmentUrl'],
      needsAttention: json['needsAttention'] ?? false,
    );

    message.id = json['id'] ?? Isar.autoIncrement;
    message.isRead = json['isRead'] ?? false;
    message.hasAttachment = json['hasAttachment'] ?? false;

    if (json['timestamp'] != null) {
      message.timestamp = DateTime.parse(json['timestamp']);
    }

    return message;
  }
}
