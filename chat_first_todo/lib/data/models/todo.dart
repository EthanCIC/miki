import 'package:isar/isar.dart';

part 'todo.g.dart';

/// Todo 項目優先級
enum TodoPriority { low, medium, high }

/// Todo 項目狀態
enum TodoStatus { pending, inProgress, completed, cancelled }

/// Todo 項目模型
@collection
class Todo {
  /// 唯一識別符，由 Isar 自動生成
  Id id = Isar.autoIncrement;

  /// 待辦事項標題
  late String title;

  /// 待辦事項描述
  String? description;

  /// 待辦事項優先級
  @enumerated
  late TodoPriority priority;

  /// 待辦事項狀態
  @enumerated
  late TodoStatus status;

  /// 截止日期
  DateTime? dueDate;

  /// 創建日期
  late DateTime createdAt;

  /// 最後更新日期
  late DateTime updatedAt;

  /// 完成日期
  DateTime? completedAt;

  /// 是否標記為重要
  late bool isImportant;

  /// 待辦事項標籤
  List<String>? tags;

  /// 待辦事項附註
  List<String>? notes;

  /// 創建新的 Todo 項目
  Todo({
    required this.title,
    this.description,
    this.priority = TodoPriority.medium,
    this.status = TodoStatus.pending,
    this.dueDate,
    this.isImportant = false,
    this.tags,
    this.notes,
  }) {
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  /// 完成待辦事項
  void complete() {
    status = TodoStatus.completed;
    completedAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  /// 更新待辦事項
  void update({
    String? title,
    String? description,
    TodoPriority? priority,
    TodoStatus? status,
    DateTime? dueDate,
    bool? isImportant,
    List<String>? tags,
    List<String>? notes,
  }) {
    if (title != null) this.title = title;
    if (description != null) this.description = description;
    if (priority != null) this.priority = priority;
    if (status != null) {
      this.status = status;
      if (status == TodoStatus.completed) {
        completedAt = DateTime.now();
      } else {
        completedAt = null;
      }
    }
    if (dueDate != null) this.dueDate = dueDate;
    if (isImportant != null) this.isImportant = isImportant;
    if (tags != null) this.tags = tags;
    if (notes != null) this.notes = notes;

    updatedAt = DateTime.now();
  }

  /// 添加標籤
  void addTag(String tag) {
    tags ??= [];
    if (!tags!.contains(tag)) {
      tags!.add(tag);
      updatedAt = DateTime.now();
    }
  }

  /// 移除標籤
  void removeTag(String tag) {
    if (tags != null && tags!.contains(tag)) {
      tags!.remove(tag);
      updatedAt = DateTime.now();
    }
  }

  /// 添加附註
  void addNote(String note) {
    notes ??= [];
    notes!.add(note);
    updatedAt = DateTime.now();
  }

  /// 獲取優先級顯示文字
  String get priorityText {
    switch (priority) {
      case TodoPriority.low:
        return '低';
      case TodoPriority.medium:
        return '中';
      case TodoPriority.high:
        return '高';
    }
  }

  /// 獲取狀態顯示文字
  String get statusText {
    switch (status) {
      case TodoStatus.pending:
        return '待處理';
      case TodoStatus.inProgress:
        return '進行中';
      case TodoStatus.completed:
        return '已完成';
      case TodoStatus.cancelled:
        return '已取消';
    }
  }

  /// 獲取格式化的創建日期
  String get formattedCreatedDate {
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }

  /// 獲取格式化的截止日期
  String? get formattedDueDate {
    if (dueDate == null) return null;
    return '${dueDate!.year}/${dueDate!.month}/${dueDate!.day}';
  }

  /// 檢查是否到期
  bool get isOverdue {
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && status != TodoStatus.completed;
  }

  /// 轉換為 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.index,
      'status': status.index,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isImportant': isImportant,
      'tags': tags,
      'notes': notes,
    };
  }

  /// 從 JSON 創建
  factory Todo.fromJson(Map<String, dynamic> json) {
    var todo = Todo(
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: TodoPriority.values[(json['priority'] as int?) ?? 1],
      status: TodoStatus.values[(json['status'] as int?) ?? 0],
      isImportant: (json['isImportant'] as bool?) ?? false,
    );

    todo.id = (json['id'] as int?) ?? Isar.autoIncrement;

    if (json['dueDate'] != null) {
      todo.dueDate = DateTime.parse(json['dueDate'] as String);
    }

    todo.createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : DateTime.now();

    todo.updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'] as String)
        : DateTime.now();

    if (json['completedAt'] != null) {
      todo.completedAt = DateTime.parse(json['completedAt'] as String);
    }

    if (json['tags'] != null) {
      todo.tags = List<String>.from(json['tags'] as Iterable<dynamic>);
    }

    if (json['notes'] != null) {
      todo.notes = List<String>.from(json['notes'] as Iterable<dynamic>);
    }

    return todo;
  }
}
