import 'package:flutter/material.dart';

abstract class AppColors {
  // Base Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF41B692);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF1F5F9);
  static const Color greyMedium = Color(0xFFCBD5E1);
  static const Color greyDark = Color(0xFF334155);

  // Legacy colors for backwards compatibility
  static const Color primaryColor = Color(0xFFFF6F00);
  static const Color errorColor = Color(0xFFF41033);
  static const Color borderColor = Color(0x33FFB300);
  static const Color sectionColor = Color(0xFF1B202D);
  static const Color fieldTextColor = Color(0xFFF8FAFC);

  // Royal Maratha Palette
  static const Color saffron = Color(0xFFFF6F00); // भगवा
  static const Color saffronDark = Color(0xFFD84315);
  static const Color saffronLight = Color(0xFFFF8F00);
  static const Color saffronAccent = Color(0xFFFF5722);

  static const Color gold = Color(0xFFFFD700); // सुवर्ण
  static const Color goldLight = Color(0xFFFFE082);
  static const Color goldDark = Color(0xFFC69214);
  static const Color goldAccentLight = Color(0xFFFFD54F);

  static const Color maroon = Color(0xFF2D0C13);
  static const Color maroonDark = Color(0xFF1A070B);
  static const Color maroonDeep = Color(0xFF240A0F);
  static const Color maroonMid = Color(0xFF18080C);
  static const Color maroonLowest = Color(0xFF120508);
  static const Color ctaMaroonDark = Color(0xFF28080E);
  static const Color ctaMaroonLight = Color(0xFF45100B);
  static const Color deepMaroonBg = Color(0xFF0E070A);

  // ID Card Gradient Colors
  static const Color cardDarkGradientStart = Color(0xFF200A0A);
  static const Color cardDarkGradientMid = Color(0xFF140808);
  static const Color cardDarkGradientEnd = Color(0xFF0F0505);

  // Light Theme Palette (Regal Cream & Ivory)
  static const Color lightBg = Color(0xFFFAF7F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF3ECE0);
  static const Color lightParchment1 = Color(0xFFFFFDF8);
  static const Color lightParchment2 = Color(0xFFFAF4E8);
  static const Color lightParchment3 = Color(0xFFF5EBD8);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE2D6C2);
  static const Color lightBorder = Color(0x33B45309);
  static const Color lightNavBg = Color(0xF8FAF7F2);
  static const Color lightFooterBg = Color(0xFFEDE4D4);
  static const Color lightDivider = Color(0xFFE5DDD0);

  // Dark Theme Background & Surfaces
  static const Color darkBg = Color(0xFF0D0F15);
  static const Color darkBgHeroTop = Color(0xFF1B070A);
  static const Color darkBgHeroMid = Color(0xFF0F1117);
  static const Color darkBgHeroBottom = Color(0xFF0B0D13);
  static const Color darkSurface = Color(0xFF151922);
  static const Color cardDark = Color(0xFF1B202D);
  static const Color cardDarkElevated = Color(0xFF222938);
  static const Color footerBg = Color(0xFF090B0F);
  static const Color darkBorder = Color(0x33FFB300);

  // Text Colors (Dark Theme)
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textGold = Color(0xFFFFD54F);
  static const Color textLight = Color(0xFFF1F5F9);
  static const Color textCrimson = Color(0xFFFF4444);

  // Text Colors (Light Theme)
  static const Color textDarkPrimary = Color(0xFF1C1917);
  static const Color textDarkSecondary = Color(0xFF44403C);
  static const Color textDarkMuted = Color(0xFF78716C);
  static const Color textDarkGold = Color(0xFFB45309);

  // Warm Amber & Coral Accents
  static const Color orangeLight = Color(0xFFFFB74D);
  static const Color orangeCoral = Color(0xFFFF7043);

  // Pillar & Metric Accents
  static const Color healthRed = Color(0xFFEF4444);
  static const Color educationBlue = Color(0xFF3B82F6);
  static const Color historyAmber = Color(0xFFF59E0B);
  static const Color entrepreneurshipGreen = Color(0xFF10B981);
  static const Color reliefPurple = Color(0xFF8B5CF6);
  static const Color coralOrange = Color(0xFFFB923C);
  static const Color mintGreen = Color(0xFF34D399);
  static const Color locationBlue = Color(0xFF60A5FA);
  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color skyBlue = Color(0xFF0EA5E9);

  // Border & Glow Accents
  static const Color goldBorderSubtle = Color(0x33FFD700);
  static const Color goldBorderMedium = Color(0x55FFB300);
  static const Color goldBorderLight = Color(0x33B45309);
  static const Color goldMetallic = Color(0xFFB8860B);
  static const Color goldShadow = Color(0xFFC69214);
  static const Color maroonCard = Color(0xFF6B1200);

  // Status & Feedback Colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorAccent = Color(0xFFFF5252);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF69F0AE);
  static const Color blueAccent = Color(0xFF448AFF);
  static const Color orange = Color(0xFFFF9800);
  static const Color orangeDark = Color(0xFFE65100);
  static const Color orangeAccent = Color(0xFFFFAB40);
  static const Color greenLight = Color(0xFFE8F5E9);
  static const Color greenAccent = Color(0xFF69F0AE);
  static const Color greenDark = Color(0xFF2E7D32);
  static const Color lightGreenAccent = Color(0xFFB9F6CA);
  static const Color redAccent = Color(0xFFFF5252);
  static const Color redDark = Color(0xFFC62828);
  static const Color amber = Color(0xFFFFC107);
  static const Color amberAccent = Color(0xFFFFD740);
  static const Color amberDark = Color(0xFFFF6F00);
  static const Color pink = Color(0xFFE91E63);
  static const Color pinkAccent = Color(0xFFFF4081);
  static const Color pinkDark = Color(0xFF880E4F);
  static const Color purpleAccent = Color(0xFFE040FB);
  static const Color cyanAccent = Color(0xFF18FFFF);
  static const Color lightBlueAccent = Color(0xFF40C4FF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);
  static const Color grey600 = Color(0xFF757575);

  // Admin Card & Surface
  static const Color adminMaroonDark1 = Color(0xFF2E0F0F);
  static const Color adminMaroonDark2 = Color(0xFF1B0808);
  static const Color adminMaroonDark3 = Color(0xFF120505);

  // Surface & Keyboard Specific
  static const Color dialogBgDark = Color(0xFF160B0B);
  static const Color keyboardKeyDark = Color(0xFF180C0C);
  static const Color keyboardKeyDark2 = Color(0xFF261414);
  static const Color keyboardKeyDark3 = Color(0xFF1E1111);
  static const Color keyboardKeySwar = Color(0xFF281813);
  static const Color keyboardKeyAction = Color(0xFF351A14);

  // Toast Gradient Pairs
  static const Color toastSuccessGradStart = Color(0xF012281D);
  static const Color toastSuccessGradEnd = Color(0xF00C1B13);
  static const Color toastErrorGradStart = Color(0xF02E1015);
  static const Color toastErrorGradEnd = Color(0xF01C080C);
  static const Color toastWarningGradStart = Color(0xF02A1C0A);
  static const Color toastWarningGradEnd = Color(0xF01A1005);
  static const Color toastInfoGradStart = Color(0xF029140C);
  static const Color toastInfoGradEnd = Color(0xF0180B07);

  // Adaptive Helpers based on brightness
  static Color adaptiveBg(bool isDark) => isDark ? darkBg : lightBg;
  static Color adaptiveSurface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color adaptiveCard(bool isDark) => isDark ? cardDark : lightCard;
  static Color adaptiveBorder(bool isDark) => isDark ? darkBorder : lightCardBorder;
  static Color adaptiveTextPrimary(bool isDark) => isDark ? textPrimary : textDarkPrimary;
  static Color adaptiveTextSecondary(bool isDark) => isDark ? textSecondary : textDarkSecondary;
  static Color adaptiveTextMuted(bool isDark) => isDark ? textMuted : textDarkMuted;
  static Color adaptiveNavBg(bool isDark) => isDark ? darkBg.withValues(alpha: 0.95) : lightNavBg;
}
