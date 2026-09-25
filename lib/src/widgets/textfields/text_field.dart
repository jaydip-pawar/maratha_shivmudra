import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/utils/bilingual_helper.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/responsive.dart';
import 'package:maratha_shivmudra/src/widgets/keyboard/marathi_virtual_keyboard.dart';
import 'package:maratha_shivmudra/src/widgets/plain_ink_well.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.isCompulsory = false,
    this.prefixIconData,
    this.suffixIconData,
    this.onSuffixTap,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.absorbPointer = false,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.enableMarathiTransliteration,
    this.hintText,
    this.onChanged,
  });

  final String? labelText;
  final String? hintText;
  final bool isCompulsory;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool absorbPointer;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool? enableMarathiTransliteration;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

/// Formatter that automatically capitalizes the first character of text.
class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final text = newValue.text;
    final capitalized =
        text[0].toUpperCase() + (text.length > 1 ? text.substring(1) : '');
    return newValue.copyWith(
      text: capitalized,
      selection: newValue.selection,
    );
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  late final MarathiPhoneticInputFormatter _phoneticFormatter =
      MarathiPhoneticInputFormatter();
  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  String? _errorMessage;
  bool _suppressDeviceKeyboard = false;
  bool _hadValidationError = false;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChanged);
    _effectiveFocusNode.addListener(_onFocusChange);
    MarathiVirtualKeyboard.isOpenNotifier.addListener(_onKeyboardOpenChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _controller).removeListener(_handleTextChanged);
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_handleTextChanged);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)
          ?.removeListener(_onFocusChange);
      _effectiveFocusNode.addListener(_onFocusChange);
    }
  }

  void _handleTextChanged() {
    if (_errorMessage != null) {
      if (_controller.text.trim().isNotEmpty) {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      } else if (widget.validator != null) {
        final err = widget.validator!(_controller.text);
        if (err == null && mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      }
    }
  }

  void _onFocusChange() {
    // If virtual keyboard is open, never reset device keyboard suppression!
    if (MarathiVirtualKeyboard.isOpen) return;

    if (!_effectiveFocusNode.hasFocus) {
      if (_hadValidationError && _controller.text.trim().isEmpty) {
        final effectiveValidator = widget.validator ??
            (widget.isCompulsory
                ? (val) {
                    if (val == null || val.trim().isEmpty) {
                      final cleanLabel =
                          widget.labelText?.replaceAll('*', '').trim();
                      if (cleanLabel != null && cleanLabel.isNotEmpty) {
                        return '$cleanLabel आवश्यक आहे';
                      }
                      return 'हे फील्ड आवश्यक आहे';
                    }
                    return null;
                  }
                : null);
        if (effectiveValidator != null) {
          final err = effectiveValidator(_controller.text);
          if (err != null && err != _errorMessage) {
            if (mounted) {
              setState(() {
                _errorMessage = err;
              });
            }
          }
        }
      }

      if (_suppressDeviceKeyboard) {
        if (mounted) {
          setState(() {
            _suppressDeviceKeyboard = false;
          });
        }
      }
    }
  }

  void _onKeyboardOpenChanged() {
    if (!MarathiVirtualKeyboard.isOpenNotifier.value &&
        _suppressDeviceKeyboard) {
      if (mounted) {
        setState(() {
          _suppressDeviceKeyboard = false;
        });
      }
    }
  }

  void _handleSuffixTap() {
    if (MarathiVirtualKeyboard.isOpen) {
      MarathiVirtualKeyboard.dismiss();
      return;
    }
    final bool isSoftDevice = Responsive.hasSoftKeyboard(context);
    final currentSel = _controller.selection;
    final targetSelection = (currentSel.start >= 0 &&
            currentSel.start <= _controller.text.length)
        ? currentSel
        : TextSelection.collapsed(offset: _controller.text.length);

    if (isSoftDevice) {
      setState(() {
        _suppressDeviceKeyboard = true;
      });
      if (!kIsWeb) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (!_effectiveFocusNode.hasFocus) {
          _effectiveFocusNode.requestFocus();
        }
        _controller.selection = targetSelection;
        if (!kIsWeb) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
        widget.onSuffixTap?.call();
      });
    } else {
      if (!_effectiveFocusNode.hasFocus) {
        _effectiveFocusNode.requestFocus();
      }
      _controller.selection = targetSelection;
      widget.onSuffixTap?.call();
    }
  }

  void _handleTextFieldTap() {
    final bool wasVirtualActive = MarathiVirtualKeyboard.isOpen ||
        MarathiVirtualKeyboard.wasRecentlyDismissed ||
        _suppressDeviceKeyboard;

    if (MarathiVirtualKeyboard.isOpen) {
      MarathiVirtualKeyboard.dismiss();
    }
    _suppressDeviceKeyboard = false;
    if (mounted) setState(() {});

    final currentSel = _controller.selection;

    if (wasVirtualActive) {
      // Virtual keyboard was open: manually trigger the system keyboard!
      // Unfocus so Flutter tears down TextInputType.none connection,
      // then on next frame re-focus with standard TextInputType & show IME.
      _effectiveFocusNode.unfocus();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _effectiveFocusNode.requestFocus();
        if (currentSel.start >= 0 &&
            currentSel.end <= _controller.text.length) {
          _controller.selection = currentSel;
        }
        SystemChannels.textInput.invokeMethod('TextInput.show');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (!_effectiveFocusNode.hasFocus) {
          _effectiveFocusNode.requestFocus();
        }
        if (Responsive.hasSoftKeyboard(context)) {
          SystemChannels.textInput.invokeMethod('TextInput.show');
        }
      });
    }
    widget.onTap?.call();
  }

  Widget labelOrNot({required Widget child}) {
    final label = widget.labelText;
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.goldLight,
              ),
              children: [
                if (widget.isCompulsory)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.errorColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      );
    }
    return child;
  }

  OutlineInputBorder getOutlineInputBorder({Color? color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: width,
        color:
            color ??
            (_errorMessage != null
                ? AppColors.errorColor
                : AppColors.darkBorder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSoftDevice = Responsive.hasSoftKeyboard(context);
    final isVirtualActive = isSoftDevice &&
        (_suppressDeviceKeyboard || MarathiVirtualKeyboard.isOpen);
    final bool effectiveMarathiTransliteration =
        widget.enableMarathiTransliteration ??
        (widget.suffixIconData == Icons.keyboard_alt_outlined);

    final List<TextInputFormatter> effectiveFormatters = [
      if (effectiveMarathiTransliteration)
        _phoneticFormatter,
      ...?widget.inputFormatters,
    ];

    Widget textField = labelOrNot(
      child: MouseRegion(
        cursor: widget.readOnly
            ? SystemMouseCursors.click
            : SystemMouseCursors.text,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 44,
              child: TextFormField(
                controller: _controller,
                focusNode: _effectiveFocusNode,
                readOnly: widget.readOnly,
                showCursor: !widget.readOnly,
                textCapitalization: widget.textCapitalization,
                keyboardType: isVirtualActive
                    ? TextInputType.none
                    : (widget.keyboardType ?? TextInputType.text),
                inputFormatters: effectiveFormatters.isNotEmpty
                    ? effectiveFormatters
                    : null,
                onTap: _handleTextFieldTap,
                onChanged: (val) {
                  _handleTextChanged();
                  widget.onChanged?.call(val);
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: getOutlineInputBorder(),
                  focusedBorder: getOutlineInputBorder(
                    color: AppColors.gold,
                    width: 1.5,
                  ),
                  enabledBorder: getOutlineInputBorder(),
                  errorBorder: getOutlineInputBorder(
                    color: AppColors.errorColor,
                  ),
                  focusedErrorBorder: getOutlineInputBorder(
                    color: AppColors.errorColor,
                    width: 1.5,
                  ),
                  prefixIcon: widget.prefixIconData != null
                      ? Icon(
                          widget.prefixIconData,
                          size: 18,
                          color: AppColors.goldLight,
                        )
                      : null,
                  suffixIcon: widget.suffixIconData != null
                      ? (widget.onSuffixTap != null
                            ? InkWell(
                                canRequestFocus: false,
                                onTap: _handleSuffixTap,
                                borderRadius: BorderRadius.circular(20),
                                child: Icon(
                                  widget.suffixIconData,
                                  size: 20,
                                  color: AppColors.goldLight.withValues(
                                    alpha: 0.9,
                                  ),
                                ),
                              )
                            : Icon(
                                widget.suffixIconData,
                                size: 20,
                                color: AppColors.goldLight.withValues(
                                  alpha: 0.7,
                                ),
                              ))
                      : null,
                ),
                cursorHeight: 18,
                cursorColor: AppColors.gold,
                cursorWidth: 1.5,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
                validator: (value) {
                  final effectiveValidator = widget.validator ??
                      (widget.isCompulsory
                          ? (val) {
                              if (val == null || val.trim().isEmpty) {
                                final cleanLabel =
                                    widget.labelText?.replaceAll('*', '').trim();
                                if (cleanLabel != null && cleanLabel.isNotEmpty) {
                                  return '$cleanLabel आवश्यक आहे';
                                }
                                return 'हे फील्ड आवश्यक आहे';
                              }
                              return null;
                            }
                          : null);
                  if (effectiveValidator != null) {
                    final err = effectiveValidator(value);
                    _hadValidationError = err != null;
                    setState(() {
                      _errorMessage = err;
                    });
                  }
                  return null;
                },
              ),
            ),
            if (_errorMessage != null && _errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _errorMessage ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.errorColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.absorbPointer) {
      textField = PlainInkWell(
        onTap: widget.onTap,
        child: AbsorbPointer(child: textField),
      );
    }

    return PopScope(
      canPop: !MarathiVirtualKeyboard.isOpen,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && MarathiVirtualKeyboard.isOpen) {
          MarathiVirtualKeyboard.dismiss();
        }
      },
      child: TapRegion(
        groupId: MarathiVirtualKeyboard,
        child: textField,
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _effectiveFocusNode.removeListener(_onFocusChange);
    MarathiVirtualKeyboard.isOpenNotifier
        .removeListener(_onKeyboardOpenChanged);
    if (widget.controller == null) _controller.dispose();
    _internalFocusNode?.dispose();
    super.dispose();
  }
}

/// Real-time phonetic transliteration formatter for Marathi text fields.
/// Automatically transliterates Latin letters (a-z, A-Z) to Marathi
/// (Devanagari) using BilingualHelper while passing Devanagari characters
/// through untouched.
class MarathiPhoneticInputFormatter extends TextInputFormatter {
  MarathiPhoneticInputFormatter();

  String _latinBuffer = '';
  int _lastWordStart = -1;

  void reset() {
    _latinBuffer = '';
    _lastWordStart = -1;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      reset();
      return newValue;
    }

    if (newValue.text == oldValue.text) {
      return newValue;
    }

    // If no Latin letters in new value, reset buffer and pass through
    if (!RegExp('[a-zA-Z]').hasMatch(newValue.text)) {
      reset();
      return newValue;
    }

    final lengthDiff = newValue.text.length - oldValue.text.length;

    // Check if this is truly a single character typed into oldValue
    final isSingleCharAddition = lengthDiff == 1 &&
        newValue.selection.baseOffset > 0 &&
        newValue.selection.baseOffset <= newValue.text.length &&
        oldValue.text ==
            (newValue.text.substring(0, newValue.selection.baseOffset - 1) +
                newValue.text.substring(newValue.selection.baseOffset));

    // Case 1: Single character typed (addition of 1 char)
    if (isSingleCharAddition) {
      final cursorPos = newValue.selection.baseOffset;
      final newChar = newValue.text[cursorPos - 1];

      // If not a Latin letter (e.g. space, punctuation, number, Marathi char)
      if (!RegExp(r'^[a-zA-Z]$').hasMatch(newChar)) {
        reset();
        return newValue;
      }

      // Latin letter typed
      if (_lastWordStart < 0 || _lastWordStart > cursorPos - 1) {
        int idx = cursorPos - 2;
        while (idx >= 0 && oldValue.text[idx] != ' ') {
          idx--;
        }
        _lastWordStart = idx + 1;
        _latinBuffer = '';
      }

      _latinBuffer += newChar.toLowerCase();
      final mrWord = BilingualHelper.transliterateToMarathi(_latinBuffer);

      final before = _lastWordStart <= oldValue.text.length
          ? oldValue.text.substring(0, _lastWordStart)
          : '';
      final oldCursor = oldValue.selection.baseOffset;
      final after = oldCursor >= 0 && oldCursor <= oldValue.text.length
          ? oldValue.text.substring(oldCursor)
          : '';

      final newText = before + mrWord + after;
      final newCursor = (before + mrWord).length;

      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newCursor),
      );
    }

    // Check if this is truly a single character deleted from oldValue
    final isSingleCharDeletion = lengthDiff == -1 &&
        oldValue.selection.baseOffset > 0 &&
        oldValue.selection.baseOffset <= oldValue.text.length &&
        newValue.text ==
            (oldValue.text.substring(0, oldValue.selection.baseOffset - 1) +
                oldValue.text.substring(oldValue.selection.baseOffset));

    // Case 2: Single backspace
    if (isSingleCharDeletion) {
      if (_latinBuffer.isNotEmpty) {
        _latinBuffer = _latinBuffer.substring(0, _latinBuffer.length - 1);
        if (_latinBuffer.isNotEmpty && _lastWordStart >= 0) {
          final mrWord = BilingualHelper.transliterateToMarathi(_latinBuffer);
          final before = oldValue.text.substring(
            0,
            _lastWordStart.clamp(0, oldValue.text.length),
          );
          final cursorInOld = oldValue.selection.baseOffset;
          final after = cursorInOld >= 0 && cursorInOld <= oldValue.text.length
              ? oldValue.text.substring(cursorInOld)
              : '';
          final newText = before + mrWord + after;
          final newCursor = (before + mrWord).length;
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newCursor),
          );
        }
      }
      reset();
      return newValue;
    }

    // Case 3: Bulk paste, selection replacement, or multi-char changes
    reset();
    final converted = BilingualHelper.transliterateToMarathi(newValue.text);
    final offsetDelta = converted.length - newValue.text.length;
    final newOffset = (newValue.selection.baseOffset + offsetDelta)
        .clamp(0, converted.length);
    return TextEditingValue(
      text: converted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
