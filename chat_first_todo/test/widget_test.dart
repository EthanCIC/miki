// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/ui/common/screens/home_screen.dart';
import 'package:miki/core/constants/app_constants.dart';

void main() {
  testWidgets('首頁標題與功能卡片應正確顯示', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(title: AppConstants.appName),
        ),
      ),
    );

    // 檢查標題區塊
    expect(find.text('您好，我是'), findsOneWidget);
    expect(find.text(AppConstants.appName), findsWidgets); // 允許多個
    expect(find.text('您的智能個人助理，隨時為您提供幫助'), findsOneWidget);

    // 檢查功能卡片
    expect(find.text('任務管理'), findsOneWidget);
    expect(find.text('我可以幫您管理日程和待辦事項'), findsOneWidget);
    expect(find.text('智能對話'), findsOneWidget);
    expect(find.text('與我聊天，我可以記錄並創建任務'), findsOneWidget);

    // 檢查主題切換按鈕（允許 light_mode 或 dark_mode 其中之一存在）
    final hasLightMode = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
    final hasDarkMode = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
    expect(hasLightMode || hasDarkMode, true);

    // 檢查新增任務的 FAB
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
