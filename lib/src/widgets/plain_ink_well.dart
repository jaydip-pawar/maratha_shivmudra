import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

class PlainInkWell extends StatelessWidget {
  const PlainInkWell({super.key, this.child, this.onTap});

  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
