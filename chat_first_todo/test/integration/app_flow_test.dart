import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miki/main.dart';
import 'package:miki/core/constants/app_constants.dart';

// 模擬集成測試
void main() {
  group('App Flow Integration Tests', () {
    testWidgets('Complete app flow test from SplashScreen to HomeScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      
      // 1. 等待 SplashScreen 自身的動畫完成 (如果有動畫控制器驅動的動畫)
      await tester.pumpAndSettle(); 
      
      // 2. 等待 SplashScreen 中的 Future.delayed(2500ms) 完成，這會觸發導航
      // 我們需要 pump 一個略大於 2500ms 的時間，以確保 Future.delayed 回調執行
      await tester.pump(const Duration(milliseconds: 2600));
      
      // 3. 等待導航到 HomeScreen 後的動畫和渲染完成
      await tester.pumpAndSettle();

      // 現在應該在 HomeScreen 了，檢查 HomeScreen 的內容
      expect(find.text('您好，我是'), findsOneWidget, reason: "在 HomeScreen 上找不到 '您好，我是'");
      expect(find.text(AppConstants.appName), findsWidgets, reason: "在 HomeScreen 上找不到 AppName");
      expect(find.text('您的智能個人助理，隨時為您提供幫助'), findsOneWidget, reason: "在 HomeScreen 上找不到助理描述");

      // 檢查主題切換按鈕（允許 light_mode 或 dark_mode 其中之一存在）
      final hasLightModeInitial = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      final hasDarkModeInitial = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
      expect(hasLightModeInitial || hasDarkModeInitial, true, reason: "HomeScreen 初始主題圖示未找到");

      // 測試主題切換
      if (hasDarkModeInitial) {
        await tester.tap(find.byIcon(Icons.dark_mode));
      } else {
        await tester.tap(find.byIcon(Icons.light_mode));
      }
      await tester.pumpAndSettle();

      // 確認主題已切換
      final hasLightModeAfterTap = find.byIcon(Icons.light_mode).evaluate().isNotEmpty;
      final hasDarkModeAfterTap = find.byIcon(Icons.dark_mode).evaluate().isNotEmpty;
      if (hasDarkModeInitial) {
        expect(hasLightModeAfterTap, true, reason: "點擊深色模式後應顯示淺色模式圖示");
      } else {
        expect(hasDarkModeAfterTap, true, reason: "點擊淺色模式後應顯示深色模式圖示");
      }

      // 檢查功能卡片存在
      expect(find.text('任務管理'), findsOneWidget, reason: "HomeScreen 找不到 '任務管理' 卡片");
      expect(find.text('智能對話'), findsOneWidget, reason: "HomeScreen 找不到 '智能對話' 卡片");

      // 測試 FAB 按鈕
      expect(find.byType(FloatingActionButton), findsOneWidget, reason: "HomeScreen 找不到 FAB");
      expect(find.byIcon(Icons.add), findsOneWidget, reason: "HomeScreen 找不到 FAB 圖示");
    });
  });
}

// 注意：隨著我們實現更多功能，這個集成測試將擴展以包括：
// 1. 導航到待辦事項頁面並添加/編輯/刪除待辦事項
// 2. 導航到聊天頁面並發送/接收消息
// 3. 測試待辦事項和聊天之間的互動
// 4. 測試數據持久化（例如使用 Isar 數據庫）
// 5. 測試離線和在線模式
