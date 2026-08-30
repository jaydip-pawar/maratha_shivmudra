import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key, required this.onDone});

  final Future<bool> Function(String) onDone;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField>
  with SingleTickerProviderStateMixin {
  final int _otpLength = 6;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  late final FocusNode _keyboardFocusNode;

  String _currentOtp = '';
  bool _isReadOnly = false;
  bool _isSuccess = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _otpLength,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(_otpLength, (index) => FocusNode());
    _keyboardFocusNode = FocusNode();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shakeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween<double>(begin: 8, end: 0), weight: 1),
    ]).animate(_animationController);

    for (int i = 0; i < _otpLength; i++) {
      _focusNodes[i].addListener(() {
        if (!mounted) return;
        if (_focusNodes[i].hasFocus && _controllers[i].text.isNotEmpty) {
          _moveToNextBox(i);
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _animationController.dispose();
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  Future<void> _updateOtp() async {
    _currentOtp = _controllers.map((controller) => controller.text).join();

    if (_currentOtp.length != _otpLength) return;

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _isReadOnly = true;
    });

    final isSuccess = await widget.onDone(_currentOtp);

    if (!mounted) return;

    setState(() {
      _isSuccess = isSuccess;
      _hasError = !isSuccess;

      FocusManager.instance.primaryFocus?.unfocus();

      if (isSuccess) {
        _isReadOnly = true;
      }
    });

    if (!isSuccess) {
      await _animationController.forward();
      _animationController.reset();
      setState(() {
        _isReadOnly = false;
        for (var controller in _controllers) {
          controller.clear();
        }
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      });
    }
  }

  void _moveToNextBox(int index) {
    if (index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  void _moveToPreviousBox(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_otpLength, (index) {
              return Focus(
                focusNode: index == 0 ? _keyboardFocusNode : null,
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace) {
                    if (_controllers[index].text.isEmpty) {
                      _moveToPreviousBox(index);
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: SizedBox(
                  width: constraints.maxWidth < 400
                      ? (constraints.maxWidth - 50) / 6
                      : 48,
                  height: 52,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    readOnly: _isReadOnly,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    cursorColor: AppColors.gold,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontSize: constraints.maxWidth < 400 ? 16 : 20,
                      fontWeight: FontWeight.bold,
                      color: _isSuccess
                          ? AppColors.green
                          : _hasError
                              ? AppColors.errorColor
                              : AppColors.goldLight,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: _isSuccess
                              ? AppColors.green
                              : _hasError
                                  ? AppColors.errorColor
                                  : AppColors.darkBorder,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: _isSuccess
                              ? AppColors.green
                              : _hasError
                                  ? AppColors.errorColor
                                  : AppColors.gold,
                          width: 1.5,
                        ),
                      ),
                      filled: true,
                      fillColor: _isSuccess
                          ? AppColors.green.withValues(alpha: 0.15)
                          : _hasError
                              ? AppColors.errorColor.withValues(alpha: 0.15)
                              : AppColors.darkSurface,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _moveToNextBox(index);
                      }
                      _updateOtp();
                    },
                    onTap: () {
                      if (_controllers
                          .sublist(0, index)
                          .any((controller) => controller.text.isEmpty)) {
                        FocusScope.of(context).requestFocus(
                          _focusNodes[_controllers.indexWhere(
                            (controller) => controller.text.isEmpty,
                          )],
                        );
                      }
                    },
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
