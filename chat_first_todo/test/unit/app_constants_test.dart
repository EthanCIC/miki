import 'package:flutter_test/flutter_test.dart';
import 'package:miki/core/constants/app_constants.dart';

void main() {
  group('應用程式常數測試', () {
    test('AppConstants 應正確定義應用程式名稱', () {
      // 驗證應用程式名稱不為空且長度合理
      expect(AppConstants.appName, isNotEmpty);
      expect(AppConstants.appName.length, greaterThan(1));
      expect(AppConstants.appName.length, lessThan(50));
    });

    test('AppConstants 應定義有效的應用程式版本', () {
      // 驗證版本格式正確 (例如: 1.0.0)
      final versionRegExp = RegExp(r'^\d+\.\d+\.\d+(\+\d+)?$');
      expect(versionRegExp.hasMatch(AppConstants.appVersion), isTrue);
    });

    test('AppConstants 應定義合理的 API 超時秒數', () {
      // 驗證 API 超時值在合理範圍內
      expect(AppConstants.apiTimeoutSeconds, greaterThan(0));
      expect(AppConstants.apiTimeoutSeconds, lessThanOrEqualTo(60));
    });

    test('ErrorMessages 應定義所有必要的錯誤訊息', () {
      // 驗證錯誤訊息不為空
      expect(ErrorMessages.networkError, isNotEmpty);
      expect(ErrorMessages.serverError, isNotEmpty);
      expect(ErrorMessages.unexpectedError, isNotEmpty);
      expect(ErrorMessages.authError, isNotEmpty);
    });
  });
}
