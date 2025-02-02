import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.isCompulsory = false,
    this.prefixIconData,
  });

  final String? labelText;
  final bool isCompulsory;
  final IconData? prefixIconData;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Widget labelOrNot({required Widget child}) {
    if (widget.labelText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          compulsoryField(
              child: Text(
            widget.labelText!,
            style: TextStyle(fontSize: 16, color: AppColors.fieldTextColor),
          )),
          child,
        ],
      );
    }
    return child;
  }

  Widget compulsoryField({required Widget child}) {
    if (widget.isCompulsory) {
      return Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Text(
            '*',
            style: TextStyle(fontSize: 16, color: AppColors.errorColor),
          ),
        ],
      );
    }
    return child;
  }

  OutlineInputBorder getOutlineInputBorder({bool isError = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      gapPadding: 0,
      borderSide: BorderSide(
        width: .8,
        color: isError ? AppColors.errorColor : AppColors.borderColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return labelOrNot(
      child: SizedBox(
        height: 40,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(8, 20, 30, 10),
            border: getOutlineInputBorder(),
            focusedBorder: getOutlineInputBorder(),
            enabledBorder: getOutlineInputBorder(),
            errorBorder: getOutlineInputBorder(isError: true),
            focusedErrorBorder: getOutlineInputBorder(isError: true),
            prefixIcon: widget.prefixIconData != null
                ? Icon(
                    widget.prefixIconData,
                    size: 18,
                  )
                : null,
          ),
          cursorHeight: 17,
          cursorColor: AppColors.fieldTextColor,
          cursorWidth: 1,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.fieldTextColor,
          ),
        ),
      ),
    );
  }
}
