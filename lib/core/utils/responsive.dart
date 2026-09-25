import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.mobileLarge,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 700;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 500 &&
      MediaQuery.sizeOf(context).width < 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 700 &&
      MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  @visibleForTesting
  static bool? debugOverrideHasSoftKeyboard;

  /// Returns whether the device supports or uses an on-screen/software keyboard (mobile or tablet).
  static bool hasSoftKeyboard(BuildContext context) {
    if (debugOverrideHasSoftKeyboard != null) {
      return debugOverrideHasSoftKeyboard!;
    }
    final isMobilePlatform = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
    final isMobileOrTablet = isMobile(context) || isTablet(context);
    return isMobilePlatform || isMobileOrTablet;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.width >= 1024 && desktop != null) {
      return desktop!;
    } else if (size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (size.width >= 500 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
