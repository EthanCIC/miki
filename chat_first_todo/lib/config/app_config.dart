import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 應用環境類型
enum Environment {
  dev,
  staging,
  production,
}

/// 全局應用程序配置
class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableAnalytics;
  final Map<String, bool> featureFlags;

  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableAnalytics,
    required this.featureFlags,
  });

  // 根據環境獲取配置
  factory AppConfig.fromEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        return const AppConfig(
          environment: Environment.dev,
          apiBaseUrl: 'http://localhost:8000', // 本地開發 API
          enableAnalytics: false, // 開發環境禁用分析
          featureFlags: {
            'enableMultiLanguage': true,
            'enableNotifications': true,
            'enableSync': true,
            'enableChat': true,
          },
        );
      case Environment.staging:
        return const AppConfig(
          environment: Environment.staging,
          apiBaseUrl: 'https://api-staging.chatfirsttodo.com',
          enableAnalytics: true,
          featureFlags: {
            'enableMultiLanguage': true,
            'enableNotifications': true,
            'enableSync': true,
            'enableChat': true,
          },
        );
      case Environment.production:
        return const AppConfig(
          environment: Environment.production,
          apiBaseUrl: 'https://api.chatfirsttodo.com',
          enableAnalytics: true,
          featureFlags: {
            'enableMultiLanguage': true,
            'enableNotifications': true,
            'enableSync': true,
            'enableChat': true,
          },
        );
    }
  }

  // 是否為開發環境
  bool get isDevelopment => environment == Environment.dev;

  // 是否為生產環境
  bool get isProduction => environment == Environment.production;

  // 檢查特色標誌是否啟用
  bool isFeatureEnabled(String featureKey) {
    return featureFlags[featureKey] ?? false;
  }

  // 僅在調試模式下輸出到控制台
  void debugLog(String message) {
    if (isDevelopment || kDebugMode) {
      debugPrint('📝 [AppConfig]: $message');
    }
  }
}

// 創建全局 AppConfig 提供者
final appConfigProvider = Provider<AppConfig>((ref) {
  // 預設使用開發環境配置
  return AppConfig.fromEnvironment(Environment.dev);
});

// 產生特色標誌提供者
final featureProvider = Provider.family<bool, String>((ref, featureKey) {
  final config = ref.watch(appConfigProvider);
  return config.isFeatureEnabled(featureKey);
});
