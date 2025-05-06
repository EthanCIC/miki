import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

/// 應用程式主題顏色
class AppColors {
  // 品牌主色 - iOS 風格的藍色調
  static const Color primary = Color(0xFF007AFF); // iOS 藍色
  static const Color primaryContainer = Color(0xFF0A84FF); // iOS 淺藍色

  // 輔助色 - iOS 風格
  static const Color secondary = Color(0xFF5AC8FA); // iOS 淺藍
  static const Color secondaryContainer = Color(0xFF34AADC); // iOS 中藍

  // 強調色 - iOS 風格的綠色
  static const Color accent = Color(0xFF30D158); // iOS 綠色

  // 深色主題背景色 - iOS 風格
  static const Color darkBackground = Color(0xFF000000); // 純黑色
  static const Color darkSurface = Color(0xFF1C1C1E); // 卡片背景
  static const Color darkCardColor = Color(0xFF2C2C2E); // 卡片顏色

  // 淺色主題背景色 - iOS 風格
  static const Color lightBackground = Color(0xFFF2F2F7); // iOS 淺灰背景
  static const Color lightSurface = Colors.white;
  static const Color lightCardColor = Colors.white;

  // 狀態色 - iOS 風格
  static const Color error = Color(0xFFFF3B30); // iOS 紅色
  static const Color success = Color(0xFF30D158); // iOS 綠色
  static const Color warning = Color(0xFFFFCC00); // iOS 黃色
  static const Color info = Color(0xFF64D2FF); // iOS 信息藍

  // 文字色 - iOS 風格
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E93);
  static const Color darkTextTertiary = Color(0xFF636366);

  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF8E8E93);
  static const Color lightTextTertiary = Color(0xFFC7C7CC);

  // 分隔線顏色
  static const Color darkDivider = Color(0xFF38383A);
  static const Color lightDivider = Color(0xFFD1D1D6);

  // iOS 漸層色
  static const List<Color> gradientColors = [
    Color(0xFF34AADC),
    Color(0xFF007AFF),
  ];
}

/// 應用程式文字樣式 - iOS 風格
class AppTextStyles {
  // 標題樣式 - iOS 風格
  static TextStyle largeTitle(bool isDark) => TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: 0.37,
        fontFamily: '.SF Pro Display', // iOS 系統字體
      );

  static TextStyle title1(bool isDark) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: 0.36,
        fontFamily: '.SF Pro Display',
      );

  static TextStyle title2(bool isDark) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: 0.35,
        fontFamily: '.SF Pro Display',
      );

  static TextStyle title3(bool isDark) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: 0.38,
        fontFamily: '.SF Pro Display',
      );

  // 內文樣式 - iOS 風格
  static TextStyle body(bool isDark) => TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.normal,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: -0.41,
        fontFamily: '.SF Pro Text',
      );

  static TextStyle callout(bool isDark) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: -0.32,
        fontFamily: '.SF Pro Text',
      );

  static TextStyle subheadline(bool isDark) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        letterSpacing: -0.24,
        fontFamily: '.SF Pro Text',
      );

  static TextStyle footnote(bool isDark) => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color:
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        letterSpacing: -0.08,
        fontFamily: '.SF Pro Text',
      );

  static TextStyle caption1(bool isDark) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color:
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        letterSpacing: 0,
        fontFamily: '.SF Pro Text',
      );

  static TextStyle caption2(bool isDark) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color:
            isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
        letterSpacing: 0.07,
        fontFamily: '.SF Pro Text',
      );
}

/// 應用程式邊距和間距 - iOS 風格
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

/// 應用程式圓角 - iOS 風格
class AppRadius {
  static const double small = 6.0;
  static const double medium = 10.0;
  static const double large = 14.0;
  static const double xl = 20.0;
}

/// 應用程式陰影 - iOS 風格（較淡）
class AppShadows {
  static List<BoxShadow> small(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.18)
              : Colors.black.withOpacity(0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> medium(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.2)
              : Colors.black.withOpacity(0.07),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> large(bool isDark) => [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.2)
              : Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
}

/// 獲取應用程式主題
ThemeData getAppTheme(bool isDark) {
  return isDark ? _darkTheme : _lightTheme;
}

/// 淺色主題 - iOS 風格
final _lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.lightSurface,
    background: AppColors.lightBackground,
    error: AppColors.error,
  ),
  // iOS 風格字體
  fontFamily: '.SF Pro Text',
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardColor: AppColors.lightCardColor,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    clipBehavior: Clip.antiAlias,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    foregroundColor: AppColors.lightTextPrimary,
    elevation: 0,
    centerTitle: true,
    shadowColor: Colors.transparent,
    titleTextStyle: AppTextStyles.title1(false),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      elevation: 0,
      minimumSize: const Size(44, 44),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFE5E5EA),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    hintStyle: TextStyle(color: AppColors.lightTextSecondary),
  ),
  dividerColor: AppColors.lightDivider,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.lightTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.lightSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.large),
    ),
  ),
);

/// 深色主題 - iOS 風格
final _darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.darkSurface,
    background: AppColors.darkBackground,
    error: AppColors.error,
  ),
  // iOS 風格字體
  fontFamily: '.SF Pro Text',
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkCardColor,
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    clipBehavior: Clip.antiAlias,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkTextPrimary,
    elevation: 0,
    centerTitle: true,
    shadowColor: Colors.transparent,
    titleTextStyle: AppTextStyles.title1(true),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      elevation: 0,
      minimumSize: const Size(44, 44),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCardColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    hintStyle: TextStyle(color: AppColors.darkTextSecondary),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.darkTextSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
    ),
  ),
  dividerColor: AppColors.darkDivider,
  dialogTheme: DialogTheme(
    backgroundColor: AppColors.darkSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.large),
    ),
  ),
);

/// 主題提供者 (使用 Riverpod)
final themeProvider = StateProvider<bool>((ref) => true); // 預設為深色主題

/// 最終主題提供者
final appThemeProvider = Provider<ThemeData>((ref) {
  final isDarkMode = ref.watch(themeProvider);
  return getAppTheme(isDarkMode);
});
