import 'package:flutter/material.dart';

class PlainInkWell extends StatelessWidget {
  const PlainInkWell({super.key, this.child, this.onTap});

  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
