import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

abstract class AppTypography {
  static const String fontFamily = 'NotoSerifDevanagari';

  // Hero Section
  static TextStyle orgName(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 26 : 42,
        fontWeight: FontWeight.w900,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
        letterSpacing: 0.5,
        height: 1.2,
      );

  static TextStyle heroTagline(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 18 : 26,
        fontWeight: FontWeight.w800,
        color: isDark ? AppColors.white : AppColors.textDarkPrimary,
        height: 1.3,
      );

  static TextStyle heroSubtitle(bool isMobile, {bool isDark = true}) => TextStyle(
        fontSize: isMobile ? 14 : 16,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        height: 1.6,
      );

  static TextStyle shlokaBadge(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 11 : 13,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
      );

  // Section Headers
  static TextStyle sectionTitle(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 22 : 32,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
      );

  static TextStyle sectionSubtitle(bool isMobile, {bool isDark = true}) => TextStyle(
        fontSize: isMobile ? 13 : 15,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        height: 1.5,
      );

  // Sacred Pledge (संघटनेची प्रतिज्ञा)
  static TextStyle pledgeHeading(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 22 : 28,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textCrimson : AppColors.saffronDark,
        letterSpacing: 0.5,
        shadows: isDark
            ? const [
                Shadow(
                  color: AppColors.black,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ]
            : null,
      );

  static TextStyle pledgeSubheading(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 13 : 15,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
      );

  static TextStyle pledgeInvocation(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
        height: 1.65,
        letterSpacing: 0.2,
      );

  static TextStyle pledgeBody(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textLight : AppColors.textDarkPrimary,
        height: 1.65,
        letterSpacing: 0.2,
      );

  static TextStyle pledgeSlogans(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 17,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
        letterSpacing: 0.5,
      );

  // Cards & Pillars
  static TextStyle cardTitle({bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textPrimary : AppColors.textDarkPrimary,
        height: 1.3,
      );

  static TextStyle cardBody({bool isDark = true}) => TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        height: 1.6,
      );

  static TextStyle cardTag({bool isDark = true}) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkMuted,
      );

  // Statistics
  static TextStyle statValue(bool isMobile, Color color) => TextStyle(
        fontSize: isMobile ? 22 : 28,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: 0.5,
      );

  static TextStyle statLabel({bool isDark = true}) => TextStyle(
        fontSize: 12,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  // Events
  static TextStyle eventTitle({bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textPrimary : AppColors.textDarkPrimary,
        height: 1.35,
      );

  static TextStyle eventDate({bool isDark = true}) => TextStyle(
        fontSize: 12,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
        fontWeight: FontWeight.w600,
      );

  static TextStyle eventLocation({bool isDark = true}) => TextStyle(
        fontSize: 12,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
      );

  static TextStyle eventBody({bool isDark = true}) => TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        height: 1.55,
      );

  // Call to Action
  static TextStyle ctaTitle(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 24 : 36,
        fontWeight: FontWeight.bold,
        color: AppColors.goldLight,
        height: 1.25,
      );

  static TextStyle ctaSubtitle(bool isMobile) => TextStyle(
        fontSize: isMobile ? 14 : 16,
        color: AppColors.textLight,
        height: 1.6,
      );

  static TextStyle navBrand(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 15 : 18,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.goldLight : AppColors.saffronDark,
        letterSpacing: 0.5,
      );

  static TextStyle navTagline(bool isMobile, {bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 10 : 11,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkMuted,
        fontWeight: FontWeight.w500,
      );

  static TextStyle navLink({
    required bool isHovered,
    bool isHighlight = false,
    bool isDark = true,
  }) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: isHighlight || isHovered ? FontWeight.w600 : FontWeight.w500,
        color: isHighlight
            ? AppColors.saffronLight
            : (isHovered
                ? (isDark ? AppColors.goldLight : AppColors.saffronDark)
                : (isDark ? AppColors.textPrimary : AppColors.textDarkPrimary)),
      );

  static TextStyle footerHeading({bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDark ? AppColors.textPrimary : AppColors.saffronDark,
      );

  static TextStyle footerBody({bool isDark = true}) => TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.textSecondary : AppColors.textDarkSecondary,
        height: 1.6,
      );

  static TextStyle footerTribute({bool isDark = true}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: isDark ? AppColors.gold : AppColors.goldDark,
      );

  static TextStyle footerCopyright({bool isDark = true}) => TextStyle(
        fontSize: 12,
        color: isDark ? AppColors.textMuted : AppColors.textDarkMuted,
      );

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.white,
  );
}

abstract class AppGradients {
  static const LinearGradient idCardBackground = LinearGradient(
    colors: [
      AppColors.cardDarkGradientStart,
      AppColors.cardDarkGradientMid,
      AppColors.cardDarkGradientEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroBackground = LinearGradient(
    colors: [
      AppColors.darkBgHeroTop,
      AppColors.darkBgHeroMid,
      AppColors.darkBgHeroBottom,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroBackgroundLight = LinearGradient(
    colors: [
      AppColors.lightSurfaceElevated,
      AppColors.lightBg,
      AppColors.lightSurface,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient heroBackgroundAdaptive(bool isDark) =>
      isDark ? heroBackground : heroBackgroundLight;

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [
      AppColors.orangeLight,
      AppColors.orangeCoral,
      AppColors.goldAccentLight,
    ],
  );

  static const LinearGradient pledgeCardGradient = LinearGradient(
    colors: [
      AppColors.maroonDeep,
      AppColors.maroonMid,
      AppColors.maroonLowest,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pledgeCardGradientLight = LinearGradient(
    colors: [
      AppColors.lightParchment1,
      AppColors.lightParchment2,
      AppColors.lightParchment3,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient pledgeCardGradientAdaptive(bool isDark) =>
      isDark ? pledgeCardGradient : pledgeCardGradientLight;

  static const LinearGradient ctaBackground = LinearGradient(
    colors: [
      AppColors.ctaMaroonDark,
      AppColors.ctaMaroonLight,
      AppColors.ctaMaroonDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient ctaBackgroundLight = LinearGradient(
    colors: [
      AppColors.maroonDeep,
      AppColors.saffronDark,
      AppColors.maroonDeep,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient ctaBackgroundAdaptive(bool isDark) =>
      isDark ? ctaBackground : ctaBackgroundLight;

  static const LinearGradient impactBackground = LinearGradient(
    colors: [
      AppColors.maroonMid,
      AppColors.darkBgHeroMid,
      AppColors.maroonMid,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient impactBackgroundLight = LinearGradient(
    colors: [
      AppColors.lightSurfaceElevated,
      AppColors.lightBg,
      AppColors.lightSurfaceElevated,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient impactBackgroundAdaptive(bool isDark) =>
      isDark ? impactBackground : impactBackgroundLight;

  static const LinearGradient goldDivider = LinearGradient(
    colors: [
      AppColors.transparent,
      AppColors.gold,
      AppColors.transparent,
    ],
  );

  static LinearGradient badgeGradient = LinearGradient(
    colors: [
      AppColors.saffronDark.withValues(alpha: 0.4),
      AppColors.goldDark.withValues(alpha: 0.3),
    ],
  );
}
