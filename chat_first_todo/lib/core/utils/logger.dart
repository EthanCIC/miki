import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 應用程式日誌工具類
class AppLogger {
  late final Logger _logger;

  /// 建構日誌記錄器
  AppLogger() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // 顯示的呼叫堆疊層級數
        errorMethodCount: 8, // 錯誤時顯示的呼叫堆疊層級數
        lineLength: 120, // 每行最大長度
        colors: true, // 彩色輸出
        printEmojis: true, // 輸出表情符號
        printTime: true, // 輸出時間
      ),
      level: kDebugMode ? Level.verbose : Level.info, // 調試模式下輸出更詳細的日誌
    );
  }

  /// 記錄詳細的開發信息
  void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }

  /// 記錄偵錯信息
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// 記錄一般信息
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// 記錄警告信息
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 記錄錯誤信息
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 記錄嚴重錯誤信息
  void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

/// 全局日誌記錄器提供者
final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger();
});
