import 'package:flutter/material.dart';

/// Global reactive notifier for the application ThemeMode (default: ThemeMode.system / Auto)
final ValueNotifier<ThemeMode> appThemeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.system);

class ThemeService {
  ThemeService._();
  static final ThemeService instance = ThemeService._();

  ThemeMode get currentMode => appThemeModeNotifier.value;

  void setThemeMode(ThemeMode mode) {
    if (appThemeModeNotifier.value != mode) {
      appThemeModeNotifier.value = mode;
    }
  }

  void cycleThemeMode() {
    switch (appThemeModeNotifier.value) {
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
    }
  }

  bool isDarkMode(BuildContext context) {
    final mode = appThemeModeNotifier.value;
    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  IconData getIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }

  String getLabel(ThemeMode mode, {bool isMarathi = true}) {
    switch (mode) {
      case ThemeMode.system:
        return isMarathi ? 'ऑटो (Auto)' : 'Auto (System)';
      case ThemeMode.light:
        return isMarathi ? 'लाईट (Light)' : 'Light';
      case ThemeMode.dark:
        return isMarathi ? 'डार्क (Dark)' : 'Dark';
    }
  }
}
