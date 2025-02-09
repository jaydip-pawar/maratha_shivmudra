import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/src/widgets/buttons/material_button.dart';

class AnimatedButton extends StatefulWidget {
  final Future<void> Function() onTap;
  final String text;

  const AnimatedButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
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
            ? SizedBox(
                key: ValueKey('loading'),
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                key: ValueKey('button_text'),
                widget.text,
              ),
      ),
      onTap: () async {
        if (_isLoading) return;
        setState(() {
          _isLoading = true;
        });
        await widget.onTap();
        setState(() {
          _isLoading = false;
        });
      },
    );
  }
}
