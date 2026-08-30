import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class AnimatedButton extends StatefulWidget {
  final Future<void> Function() onTap;
  final String text;

  const AnimatedButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialButton(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: _isLoading
            ? const SizedBox(
                key: ValueKey('loading'),
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: AppColors.white,
                ),
              )
            : Text(
                widget.text,
                key: const ValueKey('button_text'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
      ),
      onTap: () async {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        try {
          await widget.onTap();
        } catch (e) {
          debugPrint('Error in AnimatedButton onTap: $e');
        } finally {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
    );
  }
}
