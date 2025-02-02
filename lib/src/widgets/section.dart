import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/responsive.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    this.child,
    this.spacing,
    this.children,
  })  : assert(!(child != null && children != null),
            'You can provide either a child or children, but not both.'),
        assert(!(spacing != null && children == null),
            'Spacing must be null if children is not provided.'),
        assert(!(child == null && children == null),
            'You must provide either a child or children.');

  final Widget? child;
  final double? spacing;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.sectionColor,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(maxWidth: 800),
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 16.0 : 24.0),
      child: child != null
          ? child!
          : Column(
              spacing: spacing ?? 0,
              children: children!,
            ),
    );
  }
}
