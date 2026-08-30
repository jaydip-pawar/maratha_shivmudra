import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

abstract class AppTypography {
  static const String fontFamily = 'NotoSerifDevanagari';

  // Hero Section
  static TextStyle orgName(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 26 : 42,
        fontWeight: FontWeight.w900,
        color: AppColors.goldLight,
        letterSpacing: 0.5,
        height: 1.2,
      );

  static TextStyle heroTagline(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 18 : 26,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
        height: 1.3,
      );

  static TextStyle heroSubtitle(bool isMobile) => TextStyle(
        fontSize: isMobile ? 14 : 16,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  static TextStyle shlokaBadge(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 11 : 13,
        fontWeight: FontWeight.w600,
        color: AppColors.goldLight,
      );

  // Section Headers
  static TextStyle sectionTitle(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 22 : 32,
        fontWeight: FontWeight.bold,
        color: AppColors.goldLight,
      );

  static TextStyle sectionSubtitle(bool isMobile) => TextStyle(
        fontSize: isMobile ? 13 : 15,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  // Sacred Pledge (संघटनेची प्रतिज्ञा)
  static TextStyle pledgeHeading(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 22 : 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textCrimson,
        letterSpacing: 0.5,
        shadows: const [
          Shadow(
            color: AppColors.black,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      );

  static TextStyle pledgeSubheading(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 13 : 15,
        color: AppColors.textSecondary,
      );

  static TextStyle pledgeInvocation(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.w600,
        color: AppColors.goldLight,
        height: 1.65,
        letterSpacing: 0.2,
      );

  static TextStyle pledgeBody(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
        height: 1.65,
        letterSpacing: 0.2,
      );

  static TextStyle pledgeSlogans(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 14 : 17,
        fontWeight: FontWeight.bold,
        color: AppColors.goldLight,
        letterSpacing: 0.5,
      );

  // Cards & Pillars
  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle cardBody = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle cardTag = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // Statistics
  static TextStyle statValue(bool isMobile, Color color) => TextStyle(
        fontSize: isMobile ? 22 : 28,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: 0.5,
      );

  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // Events
  static const TextStyle eventTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.35,
  );

  static const TextStyle eventDate = TextStyle(
    fontSize: 12,
    color: AppColors.goldLight,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle eventLocation = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle eventBody = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
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

  // Navigation & Footer
  static TextStyle navBrand(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 15 : 18,
        fontWeight: FontWeight.bold,
        color: AppColors.goldLight,
        letterSpacing: 0.5,
      );

  static TextStyle navTagline(bool isMobile) => TextStyle(
        fontFamily: fontFamily,
        fontSize: isMobile ? 10 : 11,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      );

  static TextStyle navLink({required bool isHovered, bool isHighlight = false}) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: isHighlight || isHovered ? FontWeight.w600 : FontWeight.w500,
        color: isHighlight
            ? AppColors.saffronLight
            : (isHovered ? AppColors.goldLight : AppColors.textPrimary),
      );

  static const TextStyle footerHeading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle footerBody = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle footerTribute = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: AppColors.gold,
  );

  static const TextStyle footerCopyright = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.white,
  );
}

abstract class AppGradients {
  static const LinearGradient heroBackground = LinearGradient(
    colors: [
      AppColors.darkBgHeroTop,
      AppColors.darkBgHeroMid,
      AppColors.darkBgHeroBottom,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroTextGradient = LinearGradient(
    colors: [
      Color(0xFFFFB74D),
      Color(0xFFFF7043),
      Color(0xFFFFD54F),
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

  static const LinearGradient ctaBackground = LinearGradient(
    colors: [
      AppColors.ctaMaroonDark,
      AppColors.ctaMaroonLight,
      AppColors.ctaMaroonDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient impactBackground = LinearGradient(
    colors: [
      AppColors.maroonMid,
      AppColors.darkBgHeroMid,
      AppColors.maroonMid,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient goldDivider = LinearGradient(
    colors: [
      Colors.transparent,
      AppColors.gold,
      Colors.transparent,
    ],
  );

  static LinearGradient badgeGradient = LinearGradient(
    colors: [
      AppColors.saffronDark.withValues(alpha: 0.4),
      AppColors.goldDark.withValues(alpha: 0.3),
    ],
  );
}
