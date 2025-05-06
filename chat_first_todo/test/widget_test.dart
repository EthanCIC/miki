// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/main.dart';
import 'package:miki/core/constants/app_constants.dart';

void main() {
  testWidgets('App should render correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 檢查應用名稱是否正確顯示在AppBar中
    expect(find.text(AppConstants.appName), findsOneWidget);

    // 檢查歡迎訊息是否存在
    expect(find.text('歡迎使用 ${AppConstants.appName} 應用！'), findsOneWidget);

    // 檢查功能按鈕是否存在
    expect(find.text('查看待辦事項'), findsOneWidget);
    expect(find.text('開始聊天'), findsOneWidget);

    // 檢查主題切換按鈕是否存在
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });
}
