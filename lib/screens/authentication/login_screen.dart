import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maratha_shivmudra/utils/colors.dart';
import 'package:maratha_shivmudra/utils/extensions.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final Otpless _otpLess = Otpless();

  @override
  void initState() {
    _otpLess.headlessResponse(onHeadlessResult);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void onHeadlessResult(dynamic result) {
    print('::::::RESULT::${result.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.enter_your_mobile_number,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(
            context.l10n.we_will_sign_you_in_or_create_an_account_automatically,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: .8),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneController,
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
                            return context
                                .l10n.please_enter_a_valid_indian_mobile_number;
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
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 16),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.8),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.black, width: 0.8),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.8),
                          ),
                        ),
                        cursorColor: AppColors.black,
                        style: TextStyle(color: AppColors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final phoneNumber =
                              _phoneController.text.replaceAll(' ', '');

                          Map<String, dynamic> arg = {};
                          arg["phone"] = phoneNumber;
                          arg["countryCode"] = "91";

                          _otpLess.initiatePhoneAuth(onHeadlessResult, arg);
                          log('Valid phone number: $phoneNumber');
                        }
                      },
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.only(top: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(context.l10n.login),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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
