import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/core/utils/extensions.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;

  InputBorder _inputBorder(Color color, {double width = 1}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
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
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: '1234 5678 90',
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 16,
          letterSpacing: 1.2,
        ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            '+91 ',
            style: TextStyle(
              color: AppColors.goldLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
        enabledBorder: _inputBorder(AppColors.darkBorder),
        focusedBorder: _inputBorder(AppColors.gold, width: 1.5),
        errorBorder: _inputBorder(AppColors.errorColor),
        focusedErrorBorder: _inputBorder(AppColors.errorColor, width: 1.5),
      ),
      cursorColor: AppColors.gold,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
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
