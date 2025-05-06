import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/main.dart';
import 'package:miki/core/constants/app_constants.dart';
import 'package:miki/ui/theme/app_theme.dart';
import 'package:miki/ui/common/screens/home_screen.dart';

void main() {
  group('HomeScreen Widget', () {
    testWidgets('should display app title and welcome message',
        (WidgetTester tester) async {
      // 構建測試小部件樹
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      // 檢查標題是否顯示
      expect(find.text(AppConstants.appName), findsOneWidget);

      // 檢查歡迎訊息是否顯示
      expect(find.text('歡迎使用 ${AppConstants.appName} 應用！'), findsOneWidget);
      expect(find.text('這是一個用Flutter開發的跨平台應用'), findsOneWidget);
    });

    testWidgets('should display action buttons', (WidgetTester tester) async {
      // 構建測試小部件樹
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      // 檢查是否有兩個主要按鈕
      expect(find.text('查看待辦事項'), findsOneWidget);
      expect(find.text('開始聊天'), findsOneWidget);

      // 檢查是否有FAB
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should toggle theme when mode button is pressed',
        (WidgetTester tester) async {
      // 構建測試小部件樹
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      // 初始應該是淺色模式（顯示深色模式按鈕）
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);

      // 點擊深色模式按鈕
      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pump();

      // 現在應該是深色模式（顯示淺色模式按鈕）
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);

      // 再次點擊切換回淺色模式
      await tester.tap(find.byIcon(Icons.light_mode));
      await tester.pump();

      // 應該回到淺色模式
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
    });
  });

  group('MyApp Widget', () {
    testWidgets('should render with correct theme',
        (WidgetTester tester) async {
      // 構建測試小部件樹
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );

      // 檢查是否渲染了 HomeScreen
      expect(find.byType(HomeScreen), findsOneWidget);

      // 檢查是否有除錯標誌（在非生產環境中）
      expect(find.byType(Banner), findsOneWidget);
    });
  });

  testWidgets('HomeScreen 應該正確顯示標題', (WidgetTester tester) async {
    // 準備
    final widget = ProviderScope(
      child: MaterialApp(
        home: HomeScreen(title: 'Miki'),
      ),
    );

    // 執行
    await tester.pumpWidget(widget);

    // 驗證
    expect(find.text('Miki'), findsWidgets);

    // 查找標題元素
    expect(find.byType(AppBar), findsOneWidget);

    // 驗證深色模式切換按鈕存在
    expect(find.byIcon(Icons.light_mode).first, findsAtLeastNWidgets(1));
  });
}
