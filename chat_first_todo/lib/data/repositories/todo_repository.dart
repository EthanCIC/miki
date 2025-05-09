import 'package:miki/data/models/todo.dart';
import 'package:miki/data/services/isar_service.dart';

/// Result 類型定義，用於表示操作結果
class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const Result._({this.data, this.error, required this.isSuccess});

  /// 成功結果
  factory Result.success(T data) => Result._(data: data, isSuccess: true);

  /// 錯誤結果
  factory Result.failure(String error) =>
      Result._(error: error, isSuccess: false);

  /// 映射結果到另一種類型
  Result<R> map<R>(R Function(T data) mapper) {
    if (isSuccess && data != null) {
      return Result.success(mapper(data as T));
    }
    return Result._(error: error, isSuccess: false);
  }
}

/// Todo 儲存庫，提供 Todo 項目管理的業務邏輯
class TodoRepository {
  final IsarService _isarService;

  /// 建構函數，注入 IsarService
  TodoRepository(this._isarService);

  /// 創建新的 Todo 項目
  Future<Result<int>> createTodo({
    required String title,
    String? description,
    TodoPriority priority = TodoPriority.medium,
    DateTime? dueDate,
    bool isImportant = false,
    List<String>? tags,
  }) async {
    try {
      final todo = Todo(
        title: title,
        description: description,
        priority: priority,
        dueDate: dueDate,
        isImportant: isImportant,
        tags: tags,
      );

      final id = await _isarService.createTodo(todo);
      return Result.success(id);
    } catch (e) {
      return Result.failure('創建待辦事項失敗: ${e.toString()}');
    }
  }

  /// 獲取所有 Todo 項目
  Future<Result<List<Todo>>> getAllTodos() async {
    try {
      final todos = await _isarService.getAllTodos();
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取待辦事項失敗: ${e.toString()}');
    }
  }

  /// 根據 ID 獲取指定的 Todo 項目
  Future<Result<Todo?>> getTodoById(int id) async {
    try {
      final todo = await _isarService.getTodoById(id);
      return Result.success(todo);
    } catch (e) {
      return Result.failure('獲取待辦事項詳情失敗: ${e.toString()}');
    }
  }

  /// 更新 Todo 項目
  Future<Result<bool>> updateTodo(Todo todo) async {
    try {
      todo.updatedAt = DateTime.now();
      final success = await _isarService.updateTodo(todo);
      return Result.success(success);
    } catch (e) {
      return Result.failure('更新待辦事項失敗: ${e.toString()}');
    }
  }

  /// 刪除 Todo 項目
  Future<Result<bool>> deleteTodo(int id) async {
    try {
      final success = await _isarService.deleteTodo(id);
      return Result.success(success);
    } catch (e) {
      return Result.failure('刪除待辦事項失敗: ${e.toString()}');
    }
  }

  /// 完成 Todo 項目
  Future<Result<bool>> completeTodo(int id) async {
    try {
      final todoResult = await getTodoById(id);
      if (!todoResult.isSuccess || todoResult.data == null) {
        return Result.failure('找不到待辦事項');
      }

      final todo = todoResult.data!;
      todo.complete();

      return await updateTodo(todo);
    } catch (e) {
      return Result.failure('完成待辦事項失敗: ${e.toString()}');
    }
  }

  /// 獲取待處理的 Todo 項目
  Future<Result<List<Todo>>> getPendingTodos() async {
    try {
      final todos = await _isarService.getPendingTodos();
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取待處理事項失敗: ${e.toString()}');
    }
  }

  /// 獲取今天的 Todo 項目
  Future<Result<List<Todo>>> getTodayTodos() async {
    try {
      final todos = await _isarService.getTodayTodos();
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取今日待辦事項失敗: ${e.toString()}');
    }
  }

  /// 獲取過期的 Todo 項目
  Future<Result<List<Todo>>> getOverdueTodos() async {
    try {
      final todos = await _isarService.getOverdueTodos();
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取逾期待辦事項失敗: ${e.toString()}');
    }
  }

  /// 獲取按優先級排序的 Todo 項目
  Future<Result<List<Todo>>> getTodosByPriority() async {
    try {
      final todos = await _isarService.getTodosByPriority();
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取優先待辦事項失敗: ${e.toString()}');
    }
  }

  /// 根據狀態獲取 Todo 項目
  Future<Result<List<Todo>>> getTodosByStatus(TodoStatus status) async {
    try {
      final todos = await _isarService.getTodosByStatus(status);
      return Result.success(todos);
    } catch (e) {
      return Result.failure('獲取指定狀態待辦事項失敗: ${e.toString()}');
    }
  }

  /// 添加標籤到 Todo 項目
  Future<Result<bool>> addTagToTodo(int id, String tag) async {
    try {
      final todoResult = await getTodoById(id);
      if (!todoResult.isSuccess || todoResult.data == null) {
        return Result.failure('找不到待辦事項');
      }

      final todo = todoResult.data!;
      todo.addTag(tag);

      return await updateTodo(todo);
    } catch (e) {
      return Result.failure('添加標籤失敗: ${e.toString()}');
    }
  }

  /// 從 Todo 項目移除標籤
  Future<Result<bool>> removeTagFromTodo(int id, String tag) async {
    try {
      final todoResult = await getTodoById(id);
      if (!todoResult.isSuccess || todoResult.data == null) {
        return Result.failure('找不到待辦事項');
      }

      final todo = todoResult.data!;
      todo.removeTag(tag);

      return await updateTodo(todo);
    } catch (e) {
      return Result.failure('移除標籤失敗: ${e.toString()}');
    }
  }

  /// 添加註記到 Todo 項目
  Future<Result<bool>> addNoteToTodo(int id, String note) async {
    try {
      final todoResult = await getTodoById(id);
      if (!todoResult.isSuccess || todoResult.data == null) {
        return Result.failure('找不到待辦事項');
      }

      final todo = todoResult.data!;
      todo.addNote(note);

      return await updateTodo(todo);
    } catch (e) {
      return Result.failure('添加註記失敗: ${e.toString()}');
    }
  }

  /// 清空所有 Todo 項目（測試用）
  Future<Result<void>> clearAllTodos() async {
    try {
      await _isarService.clearAll();
      return Result.success(null);
    } catch (e) {
      return Result.failure('清空待辦事項失敗: ${e.toString()}');
    }
  }
}
