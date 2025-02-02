import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, required this.controller});

  final TextEditingController controller;

  InputBorder _inputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: 0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.digitsOnly,
        _PhoneNumberFormatter(),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.l10n.please_enter_a_phone_number;
        }
        final cleanNumber = value.replaceAll(' ', '');
        if (cleanNumber.length != 10) {
          return context.l10n.phone_number_must_be_10_digits;
        }
        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleanNumber)) {
          return context.l10n.please_enter_a_valid_indian_mobile_number;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: '1234 5678 90',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '+91 ',
            style: TextStyle(color: AppColors.black, fontSize: 16),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        enabledBorder: _inputBorder(AppColors.borderColor),
        focusedBorder: _inputBorder(AppColors.black),
        errorBorder: _inputBorder(AppColors.errorColor),
        focusedErrorBorder: _inputBorder(AppColors.errorColor),
      ),
      cursorColor: AppColors.black,
      style: TextStyle(color: AppColors.black),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final text = newValue.text.replaceAll(' ', '');
    if (text.length > 10) {
      return oldValue;
    }

    final sb = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      sb.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        sb.write(' ');
      }
    }

    return TextEditingValue(
      text: sb.toString(),
      selection: TextSelection.collapsed(offset: sb.length),
    );
  }
}
