import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/src/widgets/plain_ink_well.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.isCompulsory = false,
    this.prefixIconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.absorbPointer = false,
    this.validator,
  });

  final String? labelText;
  final bool isCompulsory;
  final IconData? prefixIconData;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool absorbPointer;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;
  String? _errorMessage;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  Widget labelOrNot({required Widget child}) {
    if (widget.labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          compulsoryField(
            child: Text(
              widget.labelText!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.goldLight,
              ),
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      );
    }
    return child;
  }

  Widget compulsoryField({required Widget child}) {
    if (widget.isCompulsory) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.errorColor,
            ),
          ),
        ],
      );
    }
    return child;
  }

  OutlineInputBorder getOutlineInputBorder({
    Color? color,
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: width,
        color: color ??
            (_errorMessage != null
                ? AppColors.errorColor
                : AppColors.darkBorder),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = labelOrNot(
      child: MouseRegion(
        cursor: widget.readOnly
            ? SystemMouseCursors.click
            : SystemMouseCursors.text,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 44,
              child: TextFormField(
                controller: _controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                  if (widget.validator != null) {
                    setState(() {
                      _errorMessage = widget.validator!(value);
                    });
                  }
                  return null;
                },
                readOnly: widget.readOnly,
              ),
            ),
            if (_errorMessage != null && _errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
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

    return textField;
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }
}
