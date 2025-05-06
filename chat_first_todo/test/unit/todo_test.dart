import 'package:flutter_test/flutter_test.dart';
import 'package:miki/data/models/todo.dart';

void main() {
  group('Todo Model', () {
    test('should create a Todo with correct default values', () {
      final todo = Todo(title: '測試待辦事項');

      expect(todo.title, '測試待辦事項');
      expect(todo.priority, TodoPriority.medium);
      expect(todo.status, TodoStatus.pending);
      expect(todo.isImportant, false);
      expect(todo.completedAt, null);
    });

    test('should mark a todo as complete', () {
      final todo = Todo(title: '測試待辦事項');
      todo.complete();

      expect(todo.status, TodoStatus.completed);
      expect(todo.completedAt, isNotNull);
    });

    test('should update todo properties correctly', () {
      final todo = Todo(title: '測試待辦事項');
      final date = DateTime(2023, 5, 1);

      todo.update(
        title: '更新標題',
        description: '描述信息',
        priority: TodoPriority.high,
        status: TodoStatus.inProgress,
        dueDate: date,
        isImportant: true,
      );

      expect(todo.title, '更新標題');
      expect(todo.description, '描述信息');
      expect(todo.priority, TodoPriority.high);
      expect(todo.status, TodoStatus.inProgress);
      expect(todo.dueDate, date);
      expect(todo.isImportant, true);
    });

    test('should add and remove tags correctly', () {
      final todo = Todo(title: '測試待辦事項');

      todo.addTag('重要');
      expect(todo.tags, contains('重要'));

      todo.addTag('工作');
      expect(todo.tags, contains('工作'));
      expect(todo.tags?.length, 2);

      todo.removeTag('重要');
      expect(todo.tags, isNot(contains('重要')));
      expect(todo.tags?.length, 1);
    });

    test('should add notes correctly', () {
      final todo = Todo(title: '測試待辦事項');

      todo.addNote('第一條筆記');
      expect(todo.notes, contains('第一條筆記'));

      todo.addNote('第二條筆記');
      expect(todo.notes?.length, 2);
    });

    test('should correctly identify overdue todos', () {
      final pastDueDate = DateTime.now().subtract(const Duration(days: 1));
      final futureDueDate = DateTime.now().add(const Duration(days: 1));

      final overdueTodo = Todo(
        title: '逾期待辦事項',
        dueDate: pastDueDate,
      );

      final upcomingTodo = Todo(
        title: '未來待辦事項',
        dueDate: futureDueDate,
      );

      final completedOverdueTodo = Todo(
        title: '已完成的逾期待辦事項',
        dueDate: pastDueDate,
        status: TodoStatus.completed,
      );

      expect(overdueTodo.isOverdue, true);
      expect(upcomingTodo.isOverdue, false);
      expect(completedOverdueTodo.isOverdue, false);
    });

    test('should convert to and from JSON correctly', () {
      final originalTodo = Todo(
        title: '測試 JSON 轉換',
        description: '測試描述',
        priority: TodoPriority.high,
        isImportant: true,
        dueDate: DateTime(2023, 12, 31),
      );

      originalTodo.addTag('測試');
      originalTodo.addNote('測試筆記');

      final json = originalTodo.toJson();
      final deserializedTodo = Todo.fromJson(json);

      expect(deserializedTodo.title, originalTodo.title);
      expect(deserializedTodo.description, originalTodo.description);
      expect(deserializedTodo.priority, originalTodo.priority);
      expect(deserializedTodo.isImportant, originalTodo.isImportant);
      expect(deserializedTodo.dueDate?.day, originalTodo.dueDate?.day);
      expect(deserializedTodo.tags?[0], originalTodo.tags?[0]);
      expect(deserializedTodo.notes?[0], originalTodo.notes?[0]);
    });
  });
}
