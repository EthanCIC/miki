import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/ui/theme/app_theme.dart';

/// 待辦事項列表頁面
class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  // 模擬的待辦事項數據
  final List<TodoItem> _todoItems = [
    TodoItem(
      id: '1',
      title: '完成 GoRouter 設置',
      description: '實現應用程式的路由系統',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      isCompleted: false,
      priority: TodoPriority.high,
    ),
    TodoItem(
      id: '2',
      title: '設計聊天界面',
      description: '創建聊天頁面的 UI',
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      isCompleted: true,
      priority: TodoPriority.medium,
    ),
    TodoItem(
      id: '3',
      title: '實現本地存儲',
      description: '使用 Isar 數據庫設置本地存儲',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      isCompleted: false,
      priority: TodoPriority.high,
    ),
    TodoItem(
      id: '4',
      title: '添加深色模式支持',
      description: '實現應用程式的深色模式',
      dueDate: DateTime.now().add(const Duration(hours: 6)),
      isCompleted: true,
      priority: TodoPriority.low,
    ),
    TodoItem(
      id: '5',
      title: '編寫單元測試',
      description: '為核心功能編寫單元測試',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      isCompleted: false,
      priority: TodoPriority.medium,
    ),
  ];

  void _toggleTodoStatus(String id) {
    setState(() {
      final index = _todoItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        _todoItems[index] = _todoItems[index].copyWith(
          isCompleted: !_todoItems[index].isCompleted,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // 將待辦事項按日期分組
    final Map<String, List<TodoItem>> groupedTodos = {};

    // 逾期
    final overdue = _todoItems
        .where((item) =>
            !item.isCompleted && item.dueDate.isBefore(DateTime.now()))
        .toList();
    if (overdue.isNotEmpty) {
      groupedTodos['已逾期'] = overdue;
    }

    // 今天
    final today = _todoItems
        .where((item) => !item.isCompleted && _isToday(item.dueDate))
        .toList();
    if (today.isNotEmpty) {
      groupedTodos['今天'] = today;
    }

    // 即將到來
    final upcoming = _todoItems
        .where((item) =>
            !item.isCompleted &&
            item.dueDate.isAfter(DateTime.now()) &&
            !_isToday(item.dueDate))
        .toList();
    if (upcoming.isNotEmpty) {
      groupedTodos['即將到來'] = upcoming;
    }

    // 已完成
    final completed = _todoItems.where((item) => item.isCompleted).toList();
    if (completed.isNotEmpty) {
      groupedTodos['已完成'] = completed;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('待辦事項'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 實現過濾功能
            },
            tooltip: '過濾',
          ),
        ],
      ),
      body: groupedTodos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 64,
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '沒有待辦事項',
                    style: AppTextStyles.title2(isDarkMode),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '在聊天中與 Miki 對話來創建新的待辦事項',
                    style: AppTextStyles.body(isDarkMode).copyWith(
                      color: isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: groupedTodos.length,
              itemBuilder: (context, index) {
                final groupTitle = groupedTodos.keys.elementAt(index);
                final items = groupedTodos[groupTitle]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Row(
                        children: [
                          Text(
                            groupTitle,
                            style: AppTextStyles.title3(isDarkMode).copyWith(
                              color: _getGroupColor(groupTitle, isDarkMode),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            '(${items.length})',
                            style: AppTextStyles.body(isDarkMode).copyWith(
                              color: isDarkMode
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ..._buildTodoItems(items, isDarkMode),
                    if (index < groupedTodos.length - 1)
                      const Divider(height: AppSpacing.xl),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 添加新的待辦事項
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add),
        tooltip: '新增待辦事項',
      ),
    );
  }

  List<Widget> _buildTodoItems(List<TodoItem> items, bool isDarkMode) {
    return items.map((item) {
      return Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        elevation: isDarkMode ? 2 : 1,
        child: InkWell(
          onTap: () {
            // TODO: 顯示詳細信息
          },
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 完成狀態按鈕
                InkWell(
                  onTap: () => _toggleTodoStatus(item.id),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.isCompleted
                          ? AppColors.success
                          : Colors.transparent,
                      border: Border.all(
                        color: item.isCompleted
                            ? AppColors.success
                            : _getPriorityColor(item.priority, isDarkMode),
                        width: 2,
                      ),
                    ),
                    child: item.isCompleted
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                // 內容
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (item.priority == TodoPriority.high)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '重要',
                                style:
                                    AppTextStyles.caption1(isDarkMode).copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              item.title,
                              style: AppTextStyles.body(isDarkMode).copyWith(
                                fontWeight: FontWeight.w500,
                                decoration: item.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: item.isCompleted
                                    ? (isDarkMode
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary)
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (item.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: AppTextStyles.subheadline(isDarkMode).copyWith(
                            color: isDarkMode
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                            decoration: item.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: _getDueDateColor(item.dueDate, isDarkMode),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDueDate(item.dueDate),
                            style: AppTextStyles.caption1(isDarkMode).copyWith(
                              color: _getDueDateColor(item.dueDate, isDarkMode),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    if (_isToday(date)) {
      final hours = date.hour.toString().padLeft(2, '0');
      final minutes = date.minute.toString().padLeft(2, '0');
      return '今天 $hours:$minutes';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return '明天';
    } else if (date.year == now.year) {
      return '${date.month}/${date.day}';
    } else {
      return '${date.year}/${date.month}/${date.day}';
    }
  }

  Color _getGroupColor(String group, bool isDarkMode) {
    switch (group) {
      case '已逾期':
        return AppColors.error;
      case '今天':
        return AppColors.primary;
      case '即將到來':
        return AppColors.accent;
      case '已完成':
        return isDarkMode
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;
      default:
        return isDarkMode
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;
    }
  }

  Color _getPriorityColor(TodoPriority priority, bool isDarkMode) {
    switch (priority) {
      case TodoPriority.high:
        return AppColors.error;
      case TodoPriority.medium:
        return AppColors.warning;
      case TodoPriority.low:
        return AppColors.secondary;
    }
  }

  Color _getDueDateColor(DateTime dueDate, bool isDarkMode) {
    if (dueDate.isBefore(DateTime.now())) {
      return AppColors.error;
    } else if (_isToday(dueDate)) {
      return AppColors.warning;
    } else {
      return isDarkMode
          ? AppColors.darkTextSecondary
          : AppColors.lightTextSecondary;
    }
  }
}

/// 待辦事項優先級
enum TodoPriority {
  high,
  medium,
  low,
}

/// 待辦事項模型
class TodoItem {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final TodoPriority priority;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
    required this.priority,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    TodoPriority? priority,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }
}
