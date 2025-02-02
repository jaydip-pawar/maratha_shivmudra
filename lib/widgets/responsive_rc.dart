import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/utils/responsive.dart';

class ResponsiveRC extends StatelessWidget {
  const ResponsiveRC({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Column(spacing: 16, children: children),
      mobileLarge: Row(
        spacing: 16,
        children: List.generate(
          children.length,
          (index) => Expanded(child: children[index]),
        ),
      ),
    );
  }
}
