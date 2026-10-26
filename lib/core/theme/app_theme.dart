import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static const String fontPlayfair = 'Playfair Display';
  static const String fontCormorant = 'Cormorant Garamond';
  static const String fontInter = 'Inter';

  static ThemeData get luxuryTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontInter,
      fontFamilyFallback: const [
        'Noto Sans Telugu',
        'Gautami',
        'system-ui',
        '-apple-system',
        'BlinkMacSystemFont',
        'Segoe UI',
        'Roboto',
        'Helvetica Neue',
        'Arial',
        'sans-serif',
      ],
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        onPrimary: Color(0xFF0A0F1D),
        onSecondary: Color(0xFF0A0F1D),
        onSurface: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontPlayfair,
          fontSize: 64,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: 0.5,
          height: 1.05,
        ),
        displayMedium: TextStyle(
          fontFamily: fontPlayfair,
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: 0.3,
          height: 1.15,
        ),
        displaySmall: TextStyle(
          fontFamily: fontPlayfair,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: 0.2,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontPlayfair,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontPlayfair,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: fontCormorant,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: fontInter,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontInter,
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: AppColors.textSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontInter,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontFamily: fontInter,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          color: AppColors.textPrimary,
        ),
        labelSmall: TextStyle(
          fontFamily: fontInter,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 3.0,
          color: AppColors.gold,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.4)),
        radius: const Radius.circular(8),
        thickness: WidgetStateProperty.all(6),
      ),
    );
  }
}
