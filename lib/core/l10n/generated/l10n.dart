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

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Middle Name`
  String get middle_name {
    return Intl.message('Middle Name', name: 'middle_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `State`
  String get state {
    return Intl.message('State', name: 'state', desc: '', args: []);
  }

  /// `District`
  String get district {
    return Intl.message('District', name: 'district', desc: '', args: []);
  }

  /// `Sub-District`
  String get sub_district {
    return Intl.message(
      'Sub-District',
      name: 'sub_district',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Pincode`
  String get pincode {
    return Intl.message('Pincode', name: 'pincode', desc: '', args: []);
  }

  /// `Mobile No`
  String get mobile_no {
    return Intl.message('Mobile No', name: 'mobile_no', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Member form`
  String get member_form {
    return Intl.message('Member form', name: 'member_form', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Please enter your first name.`
  String get please_enter_your_first_name {
    return Intl.message(
      'Please enter your first name.',
      name: 'please_enter_your_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name.`
  String get please_enter_your_last_name {
    return Intl.message(
      'Please enter your last name.',
      name: 'please_enter_your_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your date of birth.`
  String get please_enter_your_date_of_birth {
    return Intl.message(
      'Please enter your date of birth.',
      name: 'please_enter_your_date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address.`
  String get please_enter_your_address {
    return Intl.message(
      'Please enter your address.',
      name: 'please_enter_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your city.`
  String get please_enter_your_city {
    return Intl.message(
      'Please enter your city.',
      name: 'please_enter_your_city',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your state.`
  String get please_enter_your_state {
    return Intl.message(
      'Please enter your state.',
      name: 'please_enter_your_state',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your district.`
  String get please_enter_your_district {
    return Intl.message(
      'Please enter your district.',
      name: 'please_enter_your_district',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your sub-district.`
  String get please_enter_your_sub_district {
    return Intl.message(
      'Please enter your sub-district.',
      name: 'please_enter_your_sub_district',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your pincode.`
  String get please_enter_your_pincode {
    return Intl.message(
      'Please enter your pincode.',
      name: 'please_enter_your_pincode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number.`
  String get please_enter_your_mobile_number {
    return Intl.message(
      'Please enter your mobile number.',
      name: 'please_enter_your_mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email.`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email.',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Maratha Shivmudra Pratishthan`
  String get maratha_shivmudra {
    return Intl.message(
      'Maratha Shivmudra Pratishthan',
      name: 'maratha_shivmudra',
      desc: '',
      args: [],
    );
  }

  /// `Thank You for Joining!`
  String get thank_you_for_joining {
    return Intl.message(
      'Thank You for Joining!',
      name: 'thank_you_for_joining',
      desc: '',
      args: [],
    );
  }

  /// `Your membership form has been successfully submitted. We appreciate your support and commitment to our cause.`
  String get joining_message {
    return Intl.message(
      'Your membership form has been successfully submitted. We appreciate your support and commitment to our cause.',
      name: 'joining_message',
      desc: '',
      args: [],
    );
  }

  /// `What do you do for a living?`
  String get what_do_you_do_for_a_living {
    return Intl.message(
      'What do you do for a living?',
      name: 'what_do_you_do_for_a_living',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Employed`
  String get employed {
    return Intl.message('Employed', name: 'employed', desc: '', args: []);
  }

  /// `Business`
  String get business {
    return Intl.message('Business', name: 'business', desc: '', args: []);
  }

  /// `Self-employed`
  String get self_employed {
    return Intl.message(
      'Self-employed',
      name: 'self_employed',
      desc: '',
      args: [],
    );
  }

  /// `Unemployed`
  String get unemployed {
    return Intl.message('Unemployed', name: 'unemployed', desc: '', args: []);
  }

  /// `Retired`
  String get retired {
    return Intl.message('Retired', name: 'retired', desc: '', args: []);
  }

  /// `Homemaker`
  String get homemaker {
    return Intl.message('Homemaker', name: 'homemaker', desc: '', args: []);
  }

  /// `Job-seeker`
  String get job_seeker {
    return Intl.message('Job-seeker', name: 'job_seeker', desc: '', args: []);
  }

  /// `Farmer`
  String get farmer {
    return Intl.message('Farmer', name: 'farmer', desc: '', args: []);
  }

  /// `Select an option to continue`
  String get select_an_option_to_continue {
    return Intl.message(
      'Select an option to continue',
      name: 'select_an_option_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Maharashtra`
  String get maharashtra {
    return Intl.message('Maharashtra', name: 'maharashtra', desc: '', args: []);
  }

  /// `Ahilyanagar`
  String get ahilyanagar {
    return Intl.message('Ahilyanagar', name: 'ahilyanagar', desc: '', args: []);
  }

  /// `Akola`
  String get akola {
    return Intl.message('Akola', name: 'akola', desc: '', args: []);
  }

  /// `Amravati`
  String get amravati {
    return Intl.message('Amravati', name: 'amravati', desc: '', args: []);
  }

  /// `Beed`
  String get beed {
    return Intl.message('Beed', name: 'beed', desc: '', args: []);
  }

  /// `Bhandara`
  String get bhandara {
    return Intl.message('Bhandara', name: 'bhandara', desc: '', args: []);
  }

  /// `Buldhana`
  String get buldhana {
    return Intl.message('Buldhana', name: 'buldhana', desc: '', args: []);
  }

  /// `Chandrapur`
  String get chandrapur {
    return Intl.message('Chandrapur', name: 'chandrapur', desc: '', args: []);
  }

  /// `Chhatrapati Sambhajinagar`
  String get chhatrapati_sambhajinagar {
    return Intl.message(
      'Chhatrapati Sambhajinagar',
      name: 'chhatrapati_sambhajinagar',
      desc: '',
      args: [],
    );
  }

  /// `Dharashiv`
  String get dharashiv {
    return Intl.message('Dharashiv', name: 'dharashiv', desc: '', args: []);
  }

  /// `Dhule`
  String get dhule {
    return Intl.message('Dhule', name: 'dhule', desc: '', args: []);
  }

  /// `Gadchiroli`
  String get gadchiroli {
    return Intl.message('Gadchiroli', name: 'gadchiroli', desc: '', args: []);
  }

  /// `Gondia`
  String get gondia {
    return Intl.message('Gondia', name: 'gondia', desc: '', args: []);
  }

  /// `Hingoli`
  String get hingoli {
    return Intl.message('Hingoli', name: 'hingoli', desc: '', args: []);
  }

  /// `Jalgaon`
  String get jalgaon {
    return Intl.message('Jalgaon', name: 'jalgaon', desc: '', args: []);
  }

  /// `Jalna`
  String get jalna {
    return Intl.message('Jalna', name: 'jalna', desc: '', args: []);
  }

  /// `Kolhapur`
  String get kolhapur {
    return Intl.message('Kolhapur', name: 'kolhapur', desc: '', args: []);
  }

  /// `Latur`
  String get latur {
    return Intl.message('Latur', name: 'latur', desc: '', args: []);
  }

  /// `Mumbai`
  String get mumbai {
    return Intl.message('Mumbai', name: 'mumbai', desc: '', args: []);
  }

  /// `Mumbai Suburban`
  String get mumbai_suburban {
    return Intl.message(
      'Mumbai Suburban',
      name: 'mumbai_suburban',
      desc: '',
      args: [],
    );
  }

  /// `Nagpur`
  String get nagpur {
    return Intl.message('Nagpur', name: 'nagpur', desc: '', args: []);
  }

  /// `Nanded`
  String get nanded {
    return Intl.message('Nanded', name: 'nanded', desc: '', args: []);
  }

  /// `Nandurbar`
  String get nandurbar {
    return Intl.message('Nandurbar', name: 'nandurbar', desc: '', args: []);
  }

  /// `Nashik`
  String get nashik {
    return Intl.message('Nashik', name: 'nashik', desc: '', args: []);
  }

  /// `Palghar`
  String get palghar {
    return Intl.message('Palghar', name: 'palghar', desc: '', args: []);
  }

  /// `Parbhani`
  String get parbhani {
    return Intl.message('Parbhani', name: 'parbhani', desc: '', args: []);
  }

  /// `Pune`
  String get pune {
    return Intl.message('Pune', name: 'pune', desc: '', args: []);
  }

  /// `Raigad`
  String get raigad {
    return Intl.message('Raigad', name: 'raigad', desc: '', args: []);
  }

  /// `Ratnagiri`
  String get ratnagiri {
    return Intl.message('Ratnagiri', name: 'ratnagiri', desc: '', args: []);
  }

  /// `Sangli`
  String get sangli {
    return Intl.message('Sangli', name: 'sangli', desc: '', args: []);
  }

  /// `Satara`
  String get satara {
    return Intl.message('Satara', name: 'satara', desc: '', args: []);
  }

  /// `Sindhudurg`
  String get sindhudurg {
    return Intl.message('Sindhudurg', name: 'sindhudurg', desc: '', args: []);
  }

  /// `Solapur`
  String get solapur {
    return Intl.message('Solapur', name: 'solapur', desc: '', args: []);
  }

  /// `Thane`
  String get thane {
    return Intl.message('Thane', name: 'thane', desc: '', args: []);
  }

  /// `Wardha`
  String get wardha {
    return Intl.message('Wardha', name: 'wardha', desc: '', args: []);
  }

  /// `Washim`
  String get washim {
    return Intl.message('Washim', name: 'washim', desc: '', args: []);
  }

  /// `Yavatmal`
  String get yavatmal {
    return Intl.message('Yavatmal', name: 'yavatmal', desc: '', args: []);
  }

  /// `Akole`
  String get akole {
    return Intl.message('Akole', name: 'akole', desc: '', args: []);
  }

  /// `Jamkhed`
  String get jamkhed {
    return Intl.message('Jamkhed', name: 'jamkhed', desc: '', args: []);
  }

  /// `Karjat`
  String get karjat {
    return Intl.message('Karjat', name: 'karjat', desc: '', args: []);
  }

  /// `Kopargaon`
  String get kopargaon {
    return Intl.message('Kopargaon', name: 'kopargaon', desc: '', args: []);
  }

  /// `Nagar`
  String get nagar {
    return Intl.message('Nagar', name: 'nagar', desc: '', args: []);
  }

  /// `Nevasa`
  String get nevasa {
    return Intl.message('Nevasa', name: 'nevasa', desc: '', args: []);
  }

  /// `Parner`
  String get parner {
    return Intl.message('Parner', name: 'parner', desc: '', args: []);
  }

  /// `Pathardi`
  String get pathardi {
    return Intl.message('Pathardi', name: 'pathardi', desc: '', args: []);
  }

  /// `Rahta`
  String get rahta {
    return Intl.message('Rahta', name: 'rahta', desc: '', args: []);
  }

  /// `Rahuri`
  String get rahuri {
    return Intl.message('Rahuri', name: 'rahuri', desc: '', args: []);
  }

  /// `Sangamner`
  String get sangamner {
    return Intl.message('Sangamner', name: 'sangamner', desc: '', args: []);
  }

  /// `Shevgaon`
  String get shevgaon {
    return Intl.message('Shevgaon', name: 'shevgaon', desc: '', args: []);
  }

  /// `Shrigonda`
  String get shrigonda {
    return Intl.message('Shrigonda', name: 'shrigonda', desc: '', args: []);
  }

  /// `Shrirampur`
  String get shrirampur {
    return Intl.message('Shrirampur', name: 'shrirampur', desc: '', args: []);
  }

  /// `Akot`
  String get akot {
    return Intl.message('Akot', name: 'akot', desc: '', args: []);
  }

  /// `Balapur`
  String get balapur {
    return Intl.message('Balapur', name: 'balapur', desc: '', args: []);
  }

  /// `Barshitakli`
  String get barshitakli {
    return Intl.message('Barshitakli', name: 'barshitakli', desc: '', args: []);
  }

  /// `Murtijapur`
  String get murtijapur {
    return Intl.message('Murtijapur', name: 'murtijapur', desc: '', args: []);
  }

  /// `Patur`
  String get patur {
    return Intl.message('Patur', name: 'patur', desc: '', args: []);
  }

  /// `Telhara`
  String get telhara {
    return Intl.message('Telhara', name: 'telhara', desc: '', args: []);
  }

  /// `Achalpur`
  String get achalpur {
    return Intl.message('Achalpur', name: 'achalpur', desc: '', args: []);
  }

  /// `Anjangaon Surji`
  String get anjangaon_surji {
    return Intl.message(
      'Anjangaon Surji',
      name: 'anjangaon_surji',
      desc: '',
      args: [],
    );
  }

  /// `Bhatkuli`
  String get bhatkuli {
    return Intl.message('Bhatkuli', name: 'bhatkuli', desc: '', args: []);
  }

  /// `Chandur Railway`
  String get chandur_railway {
    return Intl.message(
      'Chandur Railway',
      name: 'chandur_railway',
      desc: '',
      args: [],
    );
  }

  /// `Chandurbazar`
  String get chandurbazar {
    return Intl.message(
      'Chandurbazar',
      name: 'chandurbazar',
      desc: '',
      args: [],
    );
  }

  /// `Chikhaldara`
  String get chikhaldara {
    return Intl.message('Chikhaldara', name: 'chikhaldara', desc: '', args: []);
  }

  /// `Daryapur`
  String get daryapur {
    return Intl.message('Daryapur', name: 'daryapur', desc: '', args: []);
  }

  /// `Dhamangaon Railway`
  String get dhamangaon_railway {
    return Intl.message(
      'Dhamangaon Railway',
      name: 'dhamangaon_railway',
      desc: '',
      args: [],
    );
  }

  /// `Dharni`
  String get dharni {
    return Intl.message('Dharni', name: 'dharni', desc: '', args: []);
  }

  /// `Morshi`
  String get morshi {
    return Intl.message('Morshi', name: 'morshi', desc: '', args: []);
  }

  /// `Nandgaon-Khandeshwar`
  String get nandgaon_khandeshwar {
    return Intl.message(
      'Nandgaon-Khandeshwar',
      name: 'nandgaon_khandeshwar',
      desc: '',
      args: [],
    );
  }

  /// `Tiosa`
  String get tiosa {
    return Intl.message('Tiosa', name: 'tiosa', desc: '', args: []);
  }

  /// `Warud`
  String get warud {
    return Intl.message('Warud', name: 'warud', desc: '', args: []);
  }

  /// `Ambejogai`
  String get ambejogai {
    return Intl.message('Ambejogai', name: 'ambejogai', desc: '', args: []);
  }

  /// `Ashti`
  String get ashti {
    return Intl.message('Ashti', name: 'ashti', desc: '', args: []);
  }

  /// `Dharur`
  String get dharur {
    return Intl.message('Dharur', name: 'dharur', desc: '', args: []);
  }

  /// `Georai`
  String get georai {
    return Intl.message('Georai', name: 'georai', desc: '', args: []);
  }

  /// `Kaij`
  String get kaij {
    return Intl.message('Kaij', name: 'kaij', desc: '', args: []);
  }

  /// `Majalgaon`
  String get majalgaon {
    return Intl.message('Majalgaon', name: 'majalgaon', desc: '', args: []);
  }

  /// `Parli`
  String get parli {
    return Intl.message('Parli', name: 'parli', desc: '', args: []);
  }

  /// `Patoda`
  String get patoda {
    return Intl.message('Patoda', name: 'patoda', desc: '', args: []);
  }

  /// `Shirur (Kasar)`
  String get shirur_kasar {
    return Intl.message(
      'Shirur (Kasar)',
      name: 'shirur_kasar',
      desc: '',
      args: [],
    );
  }

  /// `Wadwani`
  String get wadwani {
    return Intl.message('Wadwani', name: 'wadwani', desc: '', args: []);
  }

  /// `Lakhandur`
  String get lakhandur {
    return Intl.message('Lakhandur', name: 'lakhandur', desc: '', args: []);
  }

  /// `Lakhani`
  String get lakhani {
    return Intl.message('Lakhani', name: 'lakhani', desc: '', args: []);
  }

  /// `Mohadi`
  String get mohadi {
    return Intl.message('Mohadi', name: 'mohadi', desc: '', args: []);
  }

  /// `Pauni`
  String get pauni {
    return Intl.message('Pauni', name: 'pauni', desc: '', args: []);
  }

  /// `Sakoli`
  String get sakoli {
    return Intl.message('Sakoli', name: 'sakoli', desc: '', args: []);
  }

  /// `Tumsar`
  String get tumsar {
    return Intl.message('Tumsar', name: 'tumsar', desc: '', args: []);
  }

  /// `Buldana`
  String get buldana {
    return Intl.message('Buldana', name: 'buldana', desc: '', args: []);
  }

  /// `Chikhli`
  String get chikhli {
    return Intl.message('Chikhli', name: 'chikhli', desc: '', args: []);
  }

  /// `Deolgaon Raja`
  String get deolgaon_raja {
    return Intl.message(
      'Deolgaon Raja',
      name: 'deolgaon_raja',
      desc: '',
      args: [],
    );
  }

  /// `Jalgaon (Jamod)`
  String get jalgaon_jamod {
    return Intl.message(
      'Jalgaon (Jamod)',
      name: 'jalgaon_jamod',
      desc: '',
      args: [],
    );
  }

  /// `Khamgaon`
  String get khamgaon {
    return Intl.message('Khamgaon', name: 'khamgaon', desc: '', args: []);
  }

  /// `Lonar`
  String get lonar {
    return Intl.message('Lonar', name: 'lonar', desc: '', args: []);
  }

  /// `Malkapur`
  String get malkapur {
    return Intl.message('Malkapur', name: 'malkapur', desc: '', args: []);
  }

  /// `Mehkar`
  String get mehkar {
    return Intl.message('Mehkar', name: 'mehkar', desc: '', args: []);
  }

  /// `Motala`
  String get motala {
    return Intl.message('Motala', name: 'motala', desc: '', args: []);
  }

  /// `Nandura`
  String get nandura {
    return Intl.message('Nandura', name: 'nandura', desc: '', args: []);
  }

  /// `Sangrampur`
  String get sangrampur {
    return Intl.message('Sangrampur', name: 'sangrampur', desc: '', args: []);
  }

  /// `Shegaon`
  String get shegaon {
    return Intl.message('Shegaon', name: 'shegaon', desc: '', args: []);
  }

  /// `Sindkhed Raja`
  String get sindkhed_raja {
    return Intl.message(
      'Sindkhed Raja',
      name: 'sindkhed_raja',
      desc: '',
      args: [],
    );
  }

  /// `Ballarpur`
  String get ballarpur {
    return Intl.message('Ballarpur', name: 'ballarpur', desc: '', args: []);
  }

  /// `Bhadravati`
  String get bhadravati {
    return Intl.message('Bhadravati', name: 'bhadravati', desc: '', args: []);
  }

  /// `Brahmapuri`
  String get brahmapuri {
    return Intl.message('Brahmapuri', name: 'brahmapuri', desc: '', args: []);
  }

  /// `Chimur`
  String get chimur {
    return Intl.message('Chimur', name: 'chimur', desc: '', args: []);
  }

  /// `Gondpipri`
  String get gondpipri {
    return Intl.message('Gondpipri', name: 'gondpipri', desc: '', args: []);
  }

  /// `Jiwati`
  String get jiwati {
    return Intl.message('Jiwati', name: 'jiwati', desc: '', args: []);
  }

  /// `Korpana`
  String get korpana {
    return Intl.message('Korpana', name: 'korpana', desc: '', args: []);
  }

  /// `Mul`
  String get mul {
    return Intl.message('Mul', name: 'mul', desc: '', args: []);
  }

  /// `Nagbhid`
  String get nagbhid {
    return Intl.message('Nagbhid', name: 'nagbhid', desc: '', args: []);
  }

  /// `Pombhurna`
  String get pombhurna {
    return Intl.message('Pombhurna', name: 'pombhurna', desc: '', args: []);
  }

  /// `Rajura`
  String get rajura {
    return Intl.message('Rajura', name: 'rajura', desc: '', args: []);
  }

  /// `Sawali`
  String get sawali {
    return Intl.message('Sawali', name: 'sawali', desc: '', args: []);
  }

  /// `Sindewahi`
  String get sindewahi {
    return Intl.message('Sindewahi', name: 'sindewahi', desc: '', args: []);
  }

  /// `Warora`
  String get warora {
    return Intl.message('Warora', name: 'warora', desc: '', args: []);
  }

  /// `Gangapur`
  String get gangapur {
    return Intl.message('Gangapur', name: 'gangapur', desc: '', args: []);
  }

  /// `Kannad`
  String get kannad {
    return Intl.message('Kannad', name: 'kannad', desc: '', args: []);
  }

  /// `Khuldabad`
  String get khuldabad {
    return Intl.message('Khuldabad', name: 'khuldabad', desc: '', args: []);
  }

  /// `Paithan`
  String get paithan {
    return Intl.message('Paithan', name: 'paithan', desc: '', args: []);
  }

  /// `Phulambri`
  String get phulambri {
    return Intl.message('Phulambri', name: 'phulambri', desc: '', args: []);
  }

  /// `Sillod`
  String get sillod {
    return Intl.message('Sillod', name: 'sillod', desc: '', args: []);
  }

  /// `Soegaon`
  String get soegaon {
    return Intl.message('Soegaon', name: 'soegaon', desc: '', args: []);
  }

  /// `Vaijapur`
  String get vaijapur {
    return Intl.message('Vaijapur', name: 'vaijapur', desc: '', args: []);
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
