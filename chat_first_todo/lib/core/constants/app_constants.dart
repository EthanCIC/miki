/// 應用程式常量
class AppConstants {
  // 應用相關
  static const String appName = 'Miki';
  static const String appVersion = '1.0.0';

  // API 相關
  static const int apiTimeoutSeconds = 30;
  static const String apiVersionPath = '/api/v1';

  // 儲存相關
  static const String localDbName = 'miki.db';
  static const String preferencePrefix = 'miki_';

  // 功能相關
  static const int maxTodoItems = 100;
  static const int maxTodoTitleLength = 100;
  static const int maxChatMessageLength = 500;

  // 動畫相關
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration standardAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}

/// 共享偏好設置鍵常量
class PreferenceKeys {
  static const String isDarkMode = 'is_dark_mode';
  static const String userProfile = 'user_profile';
  static const String lastSyncTime = 'last_sync_time';
  static const String notificationEnabled = 'notification_enabled';
  static const String tutorialCompleted = 'tutorial_completed';
}

/// 錯誤訊息常量
class ErrorMessages {
  static const String networkError = '網絡連接錯誤，請檢查您的網絡';
  static const String serverError = '伺服器錯誤，請稍後再試';
  static const String timeoutError = '請求超時，請稍後再試';
  static const String authenticationError = '身份驗證失敗，請重新登入';
  static const String validationError = '數據驗證失敗，請檢查輸入';
  static const String generalError = '發生錯誤，請稍後再試';
}

/// 提示訊息常量
class SuccessMessages {
  static const String todoCreated = '待辦事項已創建';
  static const String todoUpdated = '待辦事項已更新';
  static const String todoDeleted = '待辦事項已刪除';
  static const String settingsSaved = '設置已保存';
  static const String actionCompleted = '操作已完成';
}
