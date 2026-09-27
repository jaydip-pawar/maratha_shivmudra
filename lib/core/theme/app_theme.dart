import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

abstract class AppTheme {
  /// Dark Theme: Deep Royal Maratha aesthetic
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        fontFamily: AppTypography.fontFamily,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.saffron,
          onPrimary: AppColors.white,
          secondary: AppColors.gold,
          onSecondary: AppColors.black,
          surface: AppColors.darkSurface,
          onSurface: AppColors.textPrimary,
          error: AppColors.errorColor,
          onError: AppColors.white,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.darkBorder, width: 1),
          ),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.darkBgHeroTop,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.darkBorder, width: 1.2),
          ),
        ),
        dividerColor: AppColors.darkBorder,
        iconTheme: const IconThemeData(color: AppColors.goldLight),
      );

  /// Light Theme: Regal Cream, Ivory, and Saffron aesthetic
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: AppTypography.fontFamily,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBg,
        colorScheme: const ColorScheme.light(
          primary: AppColors.saffron,
          onPrimary: AppColors.white,
          secondary: AppColors.goldDark,
          onSecondary: AppColors.white,
          surface: AppColors.lightSurface,
          onSurface: AppColors.textDarkPrimary,
          error: AppColors.errorColor,
          onError: AppColors.white,
        ),
        cardTheme: CardThemeData(
          color: AppColors.lightCard,
          elevation: 2,
          shadowColor: AppColors.black.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.lightCardBorder, width: 1),
          ),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.lightSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.lightCardBorder, width: 1.2),
          ),
        ),
        dividerColor: AppColors.lightDivider,
        iconTheme: const IconThemeData(color: AppColors.saffron),
      );
}
