import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/l10n/generated/l10n.dart';
import 'package:maratha_shivmudra/core/utils/responsive.dart';

extension BuildContextExtensions on BuildContext {
  S get l10n => S.of(this);

  bool get isMobile => Responsive.isMobile(this);

  bool get isMobileLarge => Responsive.isMobileLarge(this);

  bool get isTablet => Responsive.isTablet(this);

  bool get isDesktop => Responsive.isDesktop(this);
}

extension SizeBoxExtension on num {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());
}
