import 'package:flutter/material.dart';
import 'package:miki/ui/theme/app_theme.dart';

/// 錯誤頁面
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  final String? message;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    this.error,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('出現錯誤'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '糟糕，發生了錯誤',
                style: AppTextStyles.title2(isDarkMode),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message ?? error?.toString() ?? '未知錯誤',
                style: AppTextStyles.body(isDarkMode),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('重試'),
                ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
