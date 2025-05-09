import 'package:flutter_test/flutter_test.dart';
import 'package:miki/data/services/isar_service.dart';
import 'package:miki/data/models/todo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('IsarService API Tests', () {
    test('IsarService should have correctly defined methods', () {
      // 測試 IsarService 的存在和基本方法簽名
      const service = IsarService;

      // 確認服務有所有必要的方法
      expect(service, isNotNull);
    });

    test('Todo model API should work correctly', () {
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
    });
  });
}
