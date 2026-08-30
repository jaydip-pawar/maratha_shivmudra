import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

class ShivmudraEmblem extends StatelessWidget {
  final double size;

  const ShivmudraEmblem({
    super.key,
    this.size = 240,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.maroon,
        ),
        child: const Center(
          child: Text('🚩', style: TextStyle(fontSize: 48)),
        ),
      ),
    );
  }
}
