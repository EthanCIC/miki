import 'package:flutter_test/flutter_test.dart';
import 'package:miki/data/models/todo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Todo Model Tests', () {
    test('Todo model should have required properties and methods', () {
      // 創建示例 Todo 對象
      final todo = Todo(
          title: '測試待辦事項',
          description: '測試描述',
          priority: TodoPriority.high,
          dueDate: DateTime.now(),
          isImportant: true,
          tags: ['標籤1', '標籤2']);

      // 檢查屬性是否正確設置
      expect(todo.title, '測試待辦事項');
      expect(todo.description, '測試描述');
      expect(todo.priority, TodoPriority.high);
      expect(todo.status, TodoStatus.pending);
      expect(todo.isImportant, true);
      expect(todo.tags, contains('標籤1'));
      expect(todo.tags, contains('標籤2'));
      expect(todo.createdAt, isNotNull);
      expect(todo.updatedAt, isNotNull);

      // 測試 Todo 的方法
      todo.complete();
      expect(todo.status, TodoStatus.completed);
      expect(todo.completedAt, isNotNull);

      todo.update(title: '更新的標題');
      expect(todo.title, '更新的標題');

      todo.addTag('新標籤');
      expect(todo.tags, contains('新標籤'));

      todo.removeTag('標籤1');
      expect(todo.tags, isNot(contains('標籤1')));

      todo.addNote('這是一個註記');
      expect(todo.notes, contains('這是一個註記'));

      // 測試輔助方法
      expect(todo.priorityText, '高');
      expect(todo.statusText, '已完成');
      expect(todo.formattedCreatedDate, isNotEmpty);

      // 測試 JSON 轉換
      final json = todo.toJson();
      expect(json['title'], '更新的標題');
      expect(json['status'], TodoStatus.completed.index);

      final newTodo = Todo.fromJson(json);
      expect(newTodo.title, '更新的標題');
      expect(newTodo.status, TodoStatus.completed);
    });

    test('Todo status methods should work correctly', () {
      final todo = Todo(title: '測試狀態');

      // 默認狀態
      expect(todo.status, TodoStatus.pending);
      expect(todo.statusText, '待處理');

      // 設置進行中
      todo.update(status: TodoStatus.inProgress);
      expect(todo.status, TodoStatus.inProgress);
      expect(todo.statusText, '進行中');

      // 設置已完成
      todo.complete();
      expect(todo.status, TodoStatus.completed);
      expect(todo.statusText, '已完成');
      expect(todo.completedAt, isNotNull);

      // 設置已取消
      todo.update(status: TodoStatus.cancelled);
      expect(todo.status, TodoStatus.cancelled);
      expect(todo.statusText, '已取消');
      // 如果狀態從完成變為其他，應該清除完成時間
      expect(todo.completedAt, isNull);
    });

    test('Todo priority methods should work correctly', () {
      final todo = Todo(title: '測試優先級');

      // 默認優先級
      expect(todo.priority, TodoPriority.medium);
      expect(todo.priorityText, '中');

      // 設置低優先級
      todo.update(priority: TodoPriority.low);
      expect(todo.priority, TodoPriority.low);
      expect(todo.priorityText, '低');

      // 設置高優先級
      todo.update(priority: TodoPriority.high);
      expect(todo.priority, TodoPriority.high);
      expect(todo.priorityText, '高');
    });

    test('Todo should correctly handle due dates and overdue status', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final tomorrow = now.add(const Duration(days: 1));

      // 設置過期的待辦事項
      final overdueTodo = Todo(title: '過期待辦事項', dueDate: yesterday);
      expect(overdueTodo.isOverdue, true);
      expect(overdueTodo.formattedDueDate, isNotNull);

      // 設置未過期的待辦事項
      final futureTodo = Todo(title: '未來待辦事項', dueDate: tomorrow);
      expect(futureTodo.isOverdue, false);

      // 沒有截止日期的待辦事項
      final noDueDateTodo = Todo(
        title: '無截止日期待辦事項',
      );
      expect(noDueDateTodo.isOverdue, false);
      expect(noDueDateTodo.formattedDueDate, isNull);

      // 已完成的過期待辦事項不算過期
      overdueTodo.complete();
      expect(overdueTodo.isOverdue, false);
    });
  });
}
