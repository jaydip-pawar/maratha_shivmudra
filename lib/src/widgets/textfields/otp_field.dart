import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  const OtpField({super.key, required this.onDone});

  final Future<bool> Function(String) onDone;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField>
    with SingleTickerProviderStateMixin {
  final int _otpLength = 4;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  String _currentOtp = '';
  bool _isReadOnly = false;
  bool _isSuccess = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(_otpLength, (index) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (index) => FocusNode());

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
        if (_focusNodes[i].hasFocus && _controllers[i].text.isNotEmpty) {
          _moveToNextBox(i);
        }
        setState(() {}); // Update visual states dynamically
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
    super.dispose();
  }

  Future<void> _updateOtp() async {
    _currentOtp = _controllers.map((controller) => controller.text).join();
    if (_currentOtp.length == _otpLength) {
      setState(() {
        _isReadOnly = true;
      });

      // Simulating async verification
      final isSuccess = await widget.onDone(_currentOtp);

      setState(() {
        _isSuccess = isSuccess;
        _isError = !_isSuccess;
        if (!_isSuccess) {
          _animationController.forward().then((_) {
            Future.delayed(const Duration(milliseconds: 300), _clearOtp);
          });
        } else {
          _isReadOnly = true;
        }
      });
    }
  }

  void _clearOtp() {
    for (var controller in _controllers) {
      controller.clear();
    }
    setState(() {
      _isReadOnly = false;
      _isSuccess = false;
      _isError = false;
    });
    _animationController.reset();
    FocusScope.of(context).requestFocus(_focusNodes[0]);
  }

  void _moveToNextBox(int index) {
    if (_controllers[index].text.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double fieldWidth = constraints.maxWidth / _otpLength - 6;
      return KeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            for (int i = 0; i < _otpLength; i++) {
              if (_focusNodes[i].hasFocus && _controllers[i].text.isEmpty) {
                if (i > 0) {
                  _controllers[i - 1].clear();
                  FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                }
                break;
              }
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: List.generate(_otpLength, (index) {
            return AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_isError ? _shakeAnimation.value : 0, 0),
                  child: child,
                );
              },
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width < 700
                    ? fieldWidth <= 50
                        ? fieldWidth
                        : 50
                    : 50,
                height: MediaQuery.sizeOf(context).width < 700
                    ? fieldWidth <= 50
                        ? fieldWidth
                        : 50
                    : 50,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  readOnly: _isReadOnly,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: constraints.maxWidth < 400 ? 16 : 22,
                    fontWeight: FontWeight.bold,
                    color: _isSuccess
                        ? Colors.green.shade900
                        : _isError
                            ? Colors.red.shade900
                            : Colors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _isSuccess
                            ? Colors.green
                            : _isError
                                ? Colors.red
                                : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: _isSuccess
                            ? Colors.green
                            : _isError
                                ? Colors.red
                                : Colors.black87,
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: _isSuccess
                        ? Colors.green.withValues(alpha: 0.2)
                        : _isError
                            ? Colors.red.withValues(alpha: 0.2)
                            : Colors.white,
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
                            (controller) => controller.text.isEmpty)],
                      );
                    }
                  },
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
