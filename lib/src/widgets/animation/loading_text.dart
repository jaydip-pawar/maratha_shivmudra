import 'package:flutter/material.dart';

class AnimatedLoadingText extends StatefulWidget {
  const AnimatedLoadingText({super.key, required this.text});

  final String text;

  @override
  State<AnimatedLoadingText> createState() => _AnimatedLoadingTextState();
}

class _AnimatedLoadingTextState extends State<AnimatedLoadingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          '${widget.text}${'.' * (DateTime.now().second % 3 + 1)}',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        );
      },
    );
  }
}
