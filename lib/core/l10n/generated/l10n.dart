// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your mobile number.`
  String get enter_your_mobile_number {
    return Intl.message(
      'Enter your mobile number.',
      name: 'enter_your_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `We'll sign you in or create an account automatically.`
  String get we_will_sign_you_in_or_create_an_account_automatically {
    return Intl.message(
      'We\'ll sign you in or create an account automatically.',
      name: 'we_will_sign_you_in_or_create_an_account_automatically',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Continue`
  String get continue_text {
    return Intl.message('Continue', name: 'continue_text', desc: '', args: []);
  }

  /// `Please enter a phone number`
  String get please_enter_a_phone_number {
    return Intl.message(
      'Please enter a phone number',
      name: 'please_enter_a_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 10 digits`
  String get phone_number_must_be_10_digits {
    return Intl.message(
      'Phone number must be 10 digits',
      name: 'phone_number_must_be_10_digits',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid Indian mobile number`
  String get please_enter_a_valid_indian_mobile_number {
    return Intl.message(
      'Please enter a valid Indian mobile number',
      name: 'please_enter_a_valid_indian_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account`
  String get verify_your_account {
    return Intl.message(
      'Verify your account',
      name: 'verify_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to your phone`
  String get enter_the_verification_code_sent_to_your_phone {
    return Intl.message(
      'Enter the verification code sent to your phone',
      name: 'enter_the_verification_code_sent_to_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `Haven't received the code?`
  String get havent_received_the_code {
    return Intl.message(
      'Haven\'t received the code?',
      name: 'havent_received_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Send again`
  String get send_again {
    return Intl.message('Send again', name: 'send_again', desc: '', args: []);
  }

  /// `Account verified!`
  String get account_verified {
    return Intl.message(
      'Account verified!',
      name: 'account_verified',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Maratha Shivmudra`
  String get welcome {
    return Intl.message(
      'Welcome to Maratha Shivmudra',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Go to dashboard`
  String get go_to_dashboard {
    return Intl.message(
      'Go to dashboard',
      name: 'go_to_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later!`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong. Please try again later!',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for verification`
  String get waiting_for_verification {
    return Intl.message(
      'Waiting for verification',
      name: 'waiting_for_verification',
      desc: '',
      args: [],
    );
  }

  /// `Fill the Member Form`
  String get fill_the_member_form {
    return Intl.message(
      'Fill the Member Form',
      name: 'fill_the_member_form',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'mr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
