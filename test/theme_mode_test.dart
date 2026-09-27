import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/theme/app_theme.dart';
import 'package:maratha_shivmudra/core/theme/theme_service.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

void main() {
  setUp(() {
    ThemeService.instance.setThemeMode(ThemeMode.system);
  });

  group('ThemeService Tests', () {
    test('Default mode should be ThemeMode.system', () {
      expect(ThemeService.instance.currentMode, equals(ThemeMode.system));
      expect(appThemeModeNotifier.value, equals(ThemeMode.system));
    });

    test('setThemeMode updates mode correctly', () {
      ThemeService.instance.setThemeMode(ThemeMode.light);
      expect(ThemeService.instance.currentMode, equals(ThemeMode.light));

      ThemeService.instance.setThemeMode(ThemeMode.dark);
      expect(ThemeService.instance.currentMode, equals(ThemeMode.dark));

      ThemeService.instance.setThemeMode(ThemeMode.system);
      expect(ThemeService.instance.currentMode, equals(ThemeMode.system));
    });

    test('cycleThemeMode cycles through system -> light -> dark -> system', () {
      expect(ThemeService.instance.currentMode, equals(ThemeMode.system));

      ThemeService.instance.cycleThemeMode();
      expect(ThemeService.instance.currentMode, equals(ThemeMode.light));

      ThemeService.instance.cycleThemeMode();
      expect(ThemeService.instance.currentMode, equals(ThemeMode.dark));

      ThemeService.instance.cycleThemeMode();
      expect(ThemeService.instance.currentMode, equals(ThemeMode.system));
    });

    test('Labels and icons map appropriately for each ThemeMode', () {
      expect(ThemeService.instance.getIcon(ThemeMode.system), Icons.brightness_auto_rounded);
      expect(ThemeService.instance.getIcon(ThemeMode.light), Icons.light_mode_rounded);
      expect(ThemeService.instance.getIcon(ThemeMode.dark), Icons.dark_mode_rounded);

      expect(ThemeService.instance.getLabel(ThemeMode.system, isMarathi: true), contains('ऑटो'));
      expect(ThemeService.instance.getLabel(ThemeMode.light, isMarathi: true), contains('लाईट'));
      expect(ThemeService.instance.getLabel(ThemeMode.dark, isMarathi: true), contains('डार्क'));
    });
  });

  group('AppTheme Theme Configurations', () {
    test('Dark theme brightness is dark and uses dark canvas', () {
      final dark = AppTheme.darkTheme;
      expect(dark.brightness, equals(Brightness.dark));
      expect(dark.scaffoldBackgroundColor, equals(AppColors.darkBg));
      expect(dark.colorScheme.primary, equals(AppColors.saffron));
    });

    test('Light theme brightness is light and uses light canvas', () {
      final light = AppTheme.lightTheme;
      expect(light.brightness, equals(Brightness.light));
      expect(light.scaffoldBackgroundColor, equals(AppColors.lightBg));
      expect(light.colorScheme.primary, equals(AppColors.saffron));
    });
  });
}
