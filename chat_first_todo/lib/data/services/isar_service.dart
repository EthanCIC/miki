import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:miki/data/models/todo.dart';
import 'package:miki/data/services/database_migration_service.dart';
import 'package:flutter/foundation.dart';

/// Isar 數據庫服務，用於處理 Todo 項目的 CRUD 操作
class IsarService {
  /// 數據庫實例
  late Future<Isar> db;

  /// 建構函數，初始化數據庫連接
  IsarService() {
    db = openDB();
  }

  /// 打開數據庫連接
  Future<Isar> openDB() async {
    try {
      // 使用遷移服務來打開數據庫，確保模式兼容性
      return await DatabaseMigrationService.migrateDatabase();
    } catch (e) {
      debugPrint('打開數據庫時發生錯誤: $e');
      rethrow;
    }
  }

  /// 創建新的 Todo 項目
  Future<int> createTodo(Todo todo) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        return isar.todos.put(todo); // 返回 ID
      });
    } catch (e) {
      debugPrint('創建待辦事項時發生錯誤: $e');
      rethrow;
    }
  }

  /// 獲取所有 Todo 項目
  Future<List<Todo>> getAllTodos() async {
    try {
      final isar = await db;
      return isar.todos.where().findAll();
    } catch (e) {
      debugPrint('獲取待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 根據 ID 獲取指定的 Todo 項目
  Future<Todo?> getTodoById(int id) async {
    try {
      final isar = await db;
      return isar.todos.get(id);
    } catch (e) {
      debugPrint('獲取待辦事項詳情時發生錯誤: $e');
      return null;
    }
  }

  /// 更新 Todo 項目
  Future<bool> updateTodo(Todo todo) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        final id = await isar.todos.put(todo);
        return id > 0; // 返回是否成功
      });
    } catch (e) {
      debugPrint('更新待辦事項時發生錯誤: $e');
      return false;
    }
  }

  /// 刪除 Todo 項目
  Future<bool> deleteTodo(int id) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        return isar.todos.delete(id); // 返回是否成功
      });
    } catch (e) {
      debugPrint('刪除待辦事項時發生錯誤: $e');
      return false;
    }
  }

  /// 批量添加 Todo 項目
  Future<List<int>> bulkCreateTodos(List<Todo> todos) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        return isar.todos.putAll(todos); // 返回 ID 列表
      });
    } catch (e) {
      debugPrint('批量創建待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 批量更新 Todo 項目
  Future<List<int>> bulkUpdateTodos(List<Todo> todos) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        return isar.todos.putAll(todos); // 返回 ID 列表
      });
    } catch (e) {
      debugPrint('批量更新待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 批量刪除 Todo 項目
  Future<int> bulkDeleteTodos(List<int> ids) async {
    try {
      final isar = await db;
      return isar.writeTxn(() async {
        int count = 0;
        for (var id in ids) {
          if (await isar.todos.delete(id)) {
            count++;
          }
        }
        return count; // 返回成功刪除的數量
      });
    } catch (e) {
      debugPrint('批量刪除待辦事項時發生錯誤: $e');
      return 0;
    }
  }

  /// 根據狀態獲取 Todo 項目
  Future<List<Todo>> getTodosByStatus(TodoStatus status) async {
    try {
      final isar = await db;
      return isar.todos.filter().statusEqualTo(status).findAll();
    } catch (e) {
      debugPrint('獲取指定狀態待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 獲取所有待辦項目（未完成和未取消）
  Future<List<Todo>> getPendingTodos() async {
    try {
      final isar = await db;
      return isar.todos
          .filter()
          .not()
          .statusEqualTo(TodoStatus.completed)
          .not()
          .statusEqualTo(TodoStatus.cancelled)
          .findAll();
    } catch (e) {
      debugPrint('獲取待處理事項時發生錯誤: $e');
      return [];
    }
  }

  /// 獲取已逾期的 Todo 項目
  Future<List<Todo>> getOverdueTodos() async {
    try {
      final isar = await db;
      final now = DateTime.now();
      return isar.todos
          .filter()
          .not()
          .statusEqualTo(TodoStatus.completed)
          .not()
          .statusEqualTo(TodoStatus.cancelled)
          .dueDateLessThan(now)
          .findAll();
    } catch (e) {
      debugPrint('獲取逾期待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 獲取今天到期的 Todo 項目
  Future<List<Todo>> getTodayTodos() async {
    try {
      final isar = await db;
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));

      return isar.todos
          .filter()
          .not()
          .statusEqualTo(TodoStatus.completed)
          .not()
          .statusEqualTo(TodoStatus.cancelled)
          .dueDateGreaterThan(today.subtract(const Duration(seconds: 1)))
          .dueDateLessThan(tomorrow)
          .findAll();
    } catch (e) {
      debugPrint('獲取今日待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 獲取按優先級排序的 Todo 項目
  Future<List<Todo>> getTodosByPriority() async {
    try {
      final isar = await db;
      return isar.todos
          .filter()
          .not()
          .statusEqualTo(TodoStatus.completed)
          .not()
          .statusEqualTo(TodoStatus.cancelled)
          .sortByPriority()
          .thenByDueDate()
          .findAll();
    } catch (e) {
      debugPrint('獲取優先待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 根據標籤獲取 Todo 項目
  Future<List<Todo>> getTodosByTag(String tag) async {
    try {
      final isar = await db;
      // Isar 不直接支持 List<String> 的包含查詢，所以我們需要獲取所有項目然後過濾
      final todos = await isar.todos.where().findAll();
      return todos.where((todo) => todo.tags?.contains(tag) ?? false).toList();
    } catch (e) {
      debugPrint('獲取帶有指定標籤的待辦事項時發生錯誤: $e');
      return [];
    }
  }

  /// 清空所有 Todo 項目（測試用）
  Future<void> clearAll() async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.todos.clear();
      });
    } catch (e) {
      debugPrint('清空所有待辦事項時發生錯誤: $e');
    }
  }

  /// 檢查數據庫是否需要遷移
  Future<bool> needsMigration() async {
    return DatabaseMigrationService.needsMigration();
  }

  /// 獲取當前數據庫版本
  Future<int> getDatabaseVersion() async {
    return DatabaseMigrationService.getDatabaseVersion();
  }

  /// 獲取遷移歷史記錄
  Future<List<Map<String, dynamic>>> getMigrationHistory() async {
    return DatabaseMigrationService.getMigrationHistory();
  }

  /// 重建數據庫（測試用）
  Future<void> rebuildDatabase() async {
    await DatabaseMigrationService.resetDatabase();
    db = openDB(); // 重新打開數據庫
  }
}
