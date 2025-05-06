import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/config/router.dart';
import 'package:miki/core/constants/app_constants.dart';
import 'package:miki/ui/theme/app_theme.dart';

void main() {
  // 確保Flutter綁定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 運行應用程式並包裝在ProviderScope中以啟用Riverpod
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 我們的應用程式Widget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 使用Riverpod獲取主題
    final theme = ref.watch(appThemeProvider);

    // 獲取路由器
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
