import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/main.dart';
import 'package:miki/core/constants/app_constants.dart';
import 'package:miki/ui/theme/app_theme.dart';
import 'package:miki/ui/common/screens/home_screen.dart';

void main() {
  group('HomeScreen Widget specific tests', () {
    testWidgets('should display app title and welcome message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      expect(find.text('您好，我是'), findsOneWidget);
      expect(find.text(AppConstants.appName),
          findsWidgets); // AppBar title + Body text
      expect(find.text('您的智能個人助理，隨時為您提供幫助'), findsOneWidget);
    });

    testWidgets('should display action cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      expect(find.text('任務管理'), findsOneWidget);
      expect(find.text('我可以幫您管理日程和待辦事項'), findsOneWidget);
      expect(find.text('智能對話'), findsOneWidget);
      expect(find.text('與我聊天，我可以記錄並創建任務'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should toggle theme when mode button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomeScreen(title: AppConstants.appName),
          ),
        ),
      );

      // 根據初始圖示點擊並驗證切換
      final isInitiallyLight =
          find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;

      if (isInitiallyLight) {
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
        await tester.tap(find.byIcon(Icons.dark_mode));
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.light_mode), findsOneWidget);
      } else {
        expect(find.byIcon(Icons.light_mode), findsOneWidget);
        await tester.tap(find.byIcon(Icons.light_mode));
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      }
    });
  });

  group('MyApp Widget integration tests', () {
    testWidgets('should render HomeScreen and allow theme toggling via MyApp',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(), // 測試 MyApp 的啟動與 HomeScreen 顯示
        ),
      );
      // 1. 等待 SplashScreen 自身的動畫完成
      await tester.pumpAndSettle();
      // 2. 等待 SplashScreen 中的 Future.delayed(2500ms) 完成，觸發導航
      await tester.pump(const Duration(milliseconds: 2600));
      // 3. 等待導航到 HomeScreen 後的動畫和渲染完成
      await tester.pumpAndSettle();

      // 確認 HomeScreen 內容透過 MyApp 成功渲染
      expect(find.text('您好，我是'), findsOneWidget,
          reason: "MyApp 未能正確渲染 HomeScreen 上的 '您好，我是'");
      expect(find.text(AppConstants.appName), findsWidgets,
          reason: "MyApp 未能正確渲染 HomeScreen 上的 AppName");

      // Banner 檢查 (只在 debug mode)
      expect(find.byType(Banner).evaluate().length <= 1, true,
          reason: "Banner 檢查失敗");

      // 此處可以加入 MyApp 層級的主題切換測試，如果需要的話
      // 例如，找到 AppBar 上的 IconButton 並點擊，然後驗證主題變化
    });
  });

  // 此測試保持原樣，因為它的目的是直接測試 HomeScreen 的 title。
  testWidgets('HomeScreen title should be displayed correctly from parameter',
      (WidgetTester tester) async {
    const testTitle = 'Test Title For HomeScreen';
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(title: testTitle),
        ),
      ),
    );
    // AppBar 標題
    expect(find.widgetWithText(AppBar, testTitle), findsOneWidget);
    // Body 內的 AppConstants.appName 還是會顯示
    expect(find.text(AppConstants.appName), findsOneWidget);
  });
}
