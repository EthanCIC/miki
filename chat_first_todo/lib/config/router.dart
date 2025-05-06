import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 導入頁面
import 'package:miki/features/chat/presentation/pages/chat_page.dart';
import 'package:miki/features/todo/presentation/pages/todo_list_page.dart';
import 'package:miki/ui/common/screens/home_screen.dart';
import 'package:miki/ui/common/screens/splash_screen.dart';
import 'package:miki/ui/common/screens/error_screen.dart';

/// 路由名稱常量
class AppRoutes {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String chat = 'chat';
  static const String todoList = 'todo-list';

  // 路徑
  static const String splashPath = '/splash';
  static const String homePath = '/';
  static const String chatPath = '/chat';
  static const String todoListPath = '/todos';
}

/// 路由提供者
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splashPath,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splashPath,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.homePath,
        name: AppRoutes.home,
        builder: (context, state) => const HomeScreen(title: 'Miki'),
      ),
      GoRoute(
        path: AppRoutes.chatPath,
        name: AppRoutes.chat,
        builder: (context, state) => const ChatPage(),
      ),
      GoRoute(
        path: AppRoutes.todoListPath,
        name: AppRoutes.todoList,
        builder: (context, state) => const TodoListPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
});

/// 路由擴展
extension GoRouterExtension on BuildContext {
  /// 獲取 GoRouter 實例
  GoRouter get router => GoRouter.of(this);

  /// 導航到指定路由
  void goNamed(String name,
      {Map<String, String> params = const {},
      Map<String, dynamic> queryParams = const {}}) {
    router.goNamed(
      name,
      pathParameters: params,
      queryParameters: queryParams,
    );
  }
}
