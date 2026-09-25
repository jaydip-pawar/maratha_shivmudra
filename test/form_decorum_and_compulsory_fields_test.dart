import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/src/screens/member_form/bloc/form_bloc.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';
import 'package:maratha_shivmudra/src/widgets/keyboard/marathi_virtual_keyboard.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

class FakeSecureStorage implements SecureStorage {
  @override
  Future<void> clear() async {}

  @override
  Future<void> delete({required String key}) async {}

  @override
  Future<String> getMobileNumber() async => '9876543210';

  @override
  Future<bool> isFormSubmitted() async => true;

  @override
  Future<bool> isUserLoggedIn() async => true;

  @override
  Future<String> read({required String key}) async => '';

  @override
  Future<void> setFormSubmitted(bool value) async {}

  @override
  Future<void> setLoginFlag(bool value) async {}

  @override
  Future<void> setMobileNumber(String mobileNumber) async {}

  @override
  Future<void> write({required String key, required String value}) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    if (!getIt.isRegistered<SecureStorage>()) {
      getIt.registerSingleton<SecureStorage>(FakeSecureStorage());
    }
  });

  group('Form Decorum & Compulsory Fields Tests', () {
    test('MemberFormBloc validate() requires Middle Name (English & Marathi)', () {
      final bloc = MemberFormBloc();

      // Set standard required fields without middle name
      bloc.firstNameController.text = 'Jaydip';
      bloc.lastNameController.text = 'Pawar';
      bloc.firstNameMrController.text = 'जयदीप';
      bloc.lastNameMrController.text = 'पवार';
      bloc.dateOfBirthController.text = '1995-05-15';
      bloc.addressController.text = 'Sadashiv Peth';
      bloc.addressMrController.text = 'सदाशिव पेठ';
      bloc.selectedDistrict.value = const DistrictInfo(
        code: 'SATARA',
        nameEn: 'Satara',
        nameMr: 'सातारा',
        talukas: [],
      );
      bloc.selectedTaluka.value = const TalukaInfo(nameEn: 'Koregaon', nameMr: 'कोरेगाव');
      bloc.pincodeController.text = '415501';
      bloc.living = 'स्वतंत्र घर';
      bloc.mobileNoController.text = '9876543210';

      // Middle name is empty: validate() MUST return false
      expect(bloc.validate(), isFalse);

      // Add English middle name only: still false because Marathi middle name is compulsory
      bloc.middleNameController.text = 'Sanjay';
      expect(bloc.validate(), isFalse);

      // Add Marathi middle name: validate() MUST now pass
      bloc.middleNameMrController.text = 'संजय';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('Custom living and profession values persist correctly in MemberProfile', () {
      final data = {
        'full_name_en': 'Jaydip Sanjay Pawar',
        'full_name_mr': 'जयदीप संजय पवार',
        'first_name': 'Jaydip',
        'middle_name': 'Sanjay',
        'last_name': 'Pawar',
        'first_name_mr': 'जयदीप',
        'middle_name_mr': 'संजय',
        'last_name_mr': 'पवार',
        'phone': '8691955046',
        'living': 'मामांच्या घरी (Relative Home)',
        'profession': 'सॉफ्टवेअर आर्किटेक्ट (Software Architect)',
        'education_level': 'इतर',
        'education_other': 'B.Tech in Artificial Intelligence',
        'education': 'B.Tech in Artificial Intelligence',
        'unemployed_education': 'M.Sc Data Science',
      };

      final profile = MemberProfile.fromFirestore('8691955046', data);

      expect(profile.living, equals('मामांच्या घरी (Relative Home)'));
      expect(profile.profession, equals('सॉफ्टवेअर आर्किटेक्ट (Software Architect)'));
      expect(profile.educationOther, equals('B.Tech in Artificial Intelligence'));
      expect(profile.unemployedEducation, equals('M.Sc Data Science'));
      expect(profile.middleName, equals('Sanjay'));
      expect(profile.middleNameMr, equals('संजय'));
    });

    test('MemberFormBloc defaults to state selected (MH) and null district/taluka', () {
      final bloc = MemberFormBloc();

      expect(bloc.selectedState.value.code, equals('MH'));
      expect(bloc.selectedDistrict.value, isNull);
      expect(bloc.selectedTaluka.value, isNull);

      bloc.close();
    });

    test('MemberFormBloc strictly validates Name characters (no spaces, numbers or special chars)', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // Space in English first name -> invalid
      bloc.firstNameController.text = 'Jay dip';
      expect(bloc.validate(), isFalse);

      // Number in English middle name -> invalid
      bloc.firstNameController.text = 'Jaydip';
      bloc.middleNameController.text = 'Sanjay1';
      expect(bloc.validate(), isFalse);

      // Special character in English last name -> invalid
      bloc.middleNameController.text = 'Sanjay';
      bloc.lastNameController.text = 'Pawar!';
      expect(bloc.validate(), isFalse);

      bloc.lastNameController.text = 'Pawar';
      expect(bloc.validate(), isTrue);

      // English letters or digits inside Marathi name -> invalid
      bloc.firstNameMrController.text = 'जयदीप1';
      expect(bloc.validate(), isFalse);

      // Devanagari digits inside Marathi name -> invalid
      bloc.firstNameMrController.text = 'जयदीप१२३';
      expect(bloc.validate(), isFalse);

      bloc.firstNameMrController.text = 'Jayदीप';
      expect(bloc.validate(), isFalse);

      bloc.firstNameMrController.text = 'जयदीप';
      expect(bloc.validate(), isTrue);

      bloc.middleNameMrController.text = 'संजय४५६';
      expect(bloc.validate(), isFalse);
      bloc.middleNameMrController.text = 'संजय';
      expect(bloc.validate(), isTrue);

      bloc.lastNameMrController.text = 'पवार७८९';
      expect(bloc.validate(), isFalse);
      bloc.lastNameMrController.text = 'पवार';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberFormBloc strictly validates Pincode (must be exactly 6 digits)', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // 5 digits
      bloc.pincodeController.text = '41550';
      expect(bloc.validate(), isFalse);

      // 7 digits
      bloc.pincodeController.text = '4155012';
      expect(bloc.validate(), isFalse);

      // Characters
      bloc.pincodeController.text = '41550A';
      expect(bloc.validate(), isFalse);

      // Exactly 6 digits
      bloc.pincodeController.text = '415501';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberFormBloc validates Village / Locality mutual presence & character constraints', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // Both empty -> valid (neither is required if omitted)
      bloc.villageController.text = '';
      bloc.villageMrController.text = '';
      expect(bloc.validate(), isTrue);

      // English provided, Marathi empty -> invalid (mutual requirement)
      bloc.villageController.text = 'Rahimatpur';
      bloc.villageMrController.text = '';
      expect(bloc.validate(), isFalse);

      // Marathi provided, English empty -> invalid
      bloc.villageController.text = '';
      bloc.villageMrController.text = 'रहिमतपूर';
      expect(bloc.validate(), isFalse);

      // Both provided with valid characters -> valid
      bloc.villageController.text = 'Rahimatpur';
      bloc.villageMrController.text = 'रहिमतपूर';
      expect(bloc.validate(), isTrue);

      // Numbers in village -> invalid
      bloc.villageController.text = 'Rahimatpur 123';
      expect(bloc.validate(), isFalse);

      bloc.villageController.text = 'Rahimatpur';
      bloc.villageMrController.text = 'रहिमतपूर १२३';
      expect(bloc.validate(), isFalse);

      bloc.villageMrController.text = 'रहिमतपूर123';
      expect(bloc.validate(), isFalse);

      bloc.villageMrController.text = 'रहिमतपूर';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberFormBloc strictly validates Mobile Number (must be exactly 10 digits)', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // 9 digits
      bloc.mobileNoController.text = '987654321';
      expect(bloc.validate(), isFalse);

      // 11 digits
      bloc.mobileNoController.text = '98765432100';
      expect(bloc.validate(), isFalse);

      // Exactly 10 digits
      bloc.mobileNoController.text = '9876543210';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberFormBloc validates Email address regex when entered', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // Empty email is permitted
      bloc.emailController.text = '';
      expect(bloc.validate(), isTrue);

      // Invalid format -> invalid
      bloc.emailController.text = 'invalid_email';
      expect(bloc.validate(), isFalse);

      bloc.emailController.text = 'invalid@email';
      expect(bloc.validate(), isFalse);

      // Valid email -> valid
      bloc.emailController.text = 'test.member@shivmudra.org';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberFormBloc validates compulsory Occupation subfields', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      // 1. Employed (नोकरी)
      bloc.living = 'नोकरी';
      expect(bloc.validate(), isFalse); // Job details missing
      bloc.jobDesignationController.text = 'Manager';
      expect(bloc.validate(), isFalse); // Company missing
      bloc.jobCompanyController.text = 'Shivmudra Trust';
      expect(bloc.validate(), isTrue);

      // 2. Business (व्यवसाय)
      bloc.living = 'व्यवसाय';
      expect(bloc.validate(), isFalse); // Business type missing
      bloc.businessTypeController.text = 'Retail';
      expect(bloc.validate(), isTrue);

      // 3. Self-employed (स्वयंरोजगार) requires at least 1 of: designation, company, or business type
      bloc.living = 'स्वयंरोजगार';
      bloc.jobDesignationController.text = '';
      bloc.jobCompanyController.text = '';
      bloc.businessTypeController.text = '';
      expect(bloc.validate(), isFalse); // All 3 empty -> invalid

      // Filling only designation -> valid
      bloc.jobDesignationController.text = 'Freelancer';
      expect(bloc.validate(), isTrue);

      // Filling only company -> valid
      bloc.jobDesignationController.text = '';
      bloc.jobCompanyController.text = 'Self-Owned Startup';
      expect(bloc.validate(), isTrue);

      // Filling only business type -> valid
      bloc.jobCompanyController.text = '';
      bloc.businessTypeController.text = 'Retail Consulting';
      expect(bloc.validate(), isTrue);

      // 4. Student (विद्यार्थी) requires qualification
      bloc.living = 'विद्यार्थी';
      expect(bloc.validate(), isFalse);
      bloc.selectedEducation.value = 'Graduate (B.A/B.Com/B.Sc/B.E/etc.)';
      expect(bloc.validate(), isTrue);

      // 5. Farmer (शेती) requires crop
      bloc.living = 'शेती';
      expect(bloc.validate(), isFalse);
      bloc.cropsList.value = ['ऊस (Sugarcane)'];
      expect(bloc.validate(), isTrue);

      // 6. Unemployed (बेरोजगार) requires education and sector, while skills is optional
      bloc.living = 'बेरोजगार';
      bloc.unemployedEducation.value = null;
      bloc.unemployedPreferredSectorController.text = '';
      bloc.unemployedSkillsController.text = '';
      expect(bloc.validate(), isFalse);

      bloc.unemployedEducation.value = 'पदवी (Graduate)';
      expect(bloc.validate(), isFalse);

      bloc.unemployedPreferredSectorController.text = 'आयटी (IT)';
      // Skills is optional, so validate() MUST now be true even with empty skills:
      expect(bloc.validate(), isTrue);

      // And remains true when skills are provided:
      bloc.unemployedSkillsController.text = 'MS-CIT, Typing';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('CapitalizeFirstLetterFormatter capitalizes the first character correctly', () {
      final formatter = CapitalizeFirstLetterFormatter();

      const oldVal = TextEditingValue.empty;
      const newVal = TextEditingValue(
        text: 'jaydip',
        selection: TextSelection.collapsed(offset: 6),
      );

      final result = formatter.formatEditUpdate(oldVal, newVal);
      expect(result.text, equals('Jaydip'));
      expect(result.selection.baseOffset, equals(6));
    });

    testWidgets('CustomTextField renders hintText and wraps long labels without overflow', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                child: CustomTextField(
                  labelText: 'व्यवसायाचे स्वरूप / प्रकार खूप मोठे शीर्षक जे रॅप व्हायला हवे',
                  hintText: 'उदा. किरकोळ विक्री, आयटी',
                  isCompulsory: true,
                  controller: controller,
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.textContaining('व्यवसायाचे स्वरूप'), findsOneWidget);
      expect(find.textContaining('*'), findsOneWidget);
      expect(find.text('उदा. किरकोळ विक्री, आयटी'), findsOneWidget);
    });

    testWidgets('Privacy trust badge renders lock icon inline with Text.rich and WidgetSpan', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 250,
                child: Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.lock_outline_rounded,
                            size: 14,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'आपली माहिती मराठा शिवमुद्रा प्रतिष्ठानकडे सुरक्षित राहील.',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      expect(find.textContaining('आपली माहिती'), findsOneWidget);
    });

    test('MemberFormBloc validate() requires Address in both English and Marathi', () {
      final bloc = MemberFormBloc();
      _fillValidBasic(bloc);

      expect(bloc.validate(), isTrue);

      bloc.addressMrController.text = '';
      expect(bloc.validate(), isFalse);

      bloc.addressMrController.text = 'सदाशिव पेठ';
      bloc.addressController.text = '';
      expect(bloc.validate(), isFalse);

      bloc.addressController.text = 'Sadashiv Peth';
      expect(bloc.validate(), isTrue);

      bloc.close();
    });

    test('MemberProfile correctly parses and serializes address_mr', () {
      final data = {
        'full_name_en': 'Jaydip Pawar',
        'address': 'Sadashiv Peth, Pune',
        'address_mr': 'सदाशिव पेठ, पुणे',
      };

      final profile = MemberProfile.fromFirestore('1234567890', data);
      expect(profile.address, equals('Sadashiv Peth, Pune'));
      expect(profile.addressMr, equals('सदाशिव पेठ, पुणे'));

      final map = profile.toFirestore();
      expect(map['address_mr'], equals('सदाशिव पेठ, पुणे'));
    });

    testWidgets('MarathiVirtualKeyboard respects inputFormatters filtering digits', (tester) async {
      final controller = TextEditingController();
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarathiVirtualKeyboard(
              controller: controller,
              focusNode: focusNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\u0900-\u0963\u0971-\u097F\u200C\u200D]')),
              ],
            ),
          ),
        ),
      );

      // Verify that digit toggle (?123) is not rendered when digits are disallowed by inputFormatters
      expect(find.text('?123'), findsNothing);

      controller.dispose();
      focusNode.dispose();
    });

    testWidgets('AppSearchableDropdown inside a Form flags validation error for student education and unemployed qualification when left empty', (tester) async {
      final formKey = GlobalKey<FormState>();
      String? studentEdu;
      String? unempEdu;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      AppSearchableDropdown<String>(
                        key: ValueKey('test_student_edu_${studentEdu ?? ""}'),
                        value: studentEdu,
                        labelText: 'सर्वोच्च शिक्षण निवडा',
                        hintText: 'शिक्षण निवडा...',
                        isRequired: true,
                        validator: (val) => (val == null || val.trim().isEmpty) ? 'कृपया सर्वोच्च शिक्षण निवडा' : null,
                        items: const [
                          AppDropdownItem(value: '10th', label: '१०वी (10th)'),
                          AppDropdownItem(value: 'Graduate', label: 'पदवी (Graduate)'),
                        ],
                        onChanged: (val) => setState(() => studentEdu = val),
                      ),
                      AppSearchableDropdown<String>(
                        key: ValueKey('test_unemp_edu_${unempEdu ?? ""}'),
                        value: unempEdu,
                        labelText: 'सर्वोच्च शिक्षण पात्रता',
                        hintText: 'पात्रता निवडा...',
                        isRequired: true,
                        validator: (val) => (val == null || val.trim().isEmpty) ? 'कृपया सर्वोच्च शिक्षण पात्रता निवडा' : null,
                        items: const [
                          AppDropdownItem(value: 'ITI', label: 'आयटीआय (ITI)'),
                          AppDropdownItem(value: 'Diploma', label: 'पदविका (Diploma)'),
                        ],
                        onChanged: (val) => setState(() => unempEdu = val),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      // Initially no errors shown
      expect(find.text('कृपया सर्वोच्च शिक्षण निवडा'), findsNothing);
      expect(find.text('कृपया सर्वोच्च शिक्षण पात्रता निवडा'), findsNothing);

      // Trigger form validation
      final isValid = formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Both dropdowns must flag their respective errors
      expect(isValid, isFalse);
      expect(find.text('कृपया सर्वोच्च शिक्षण निवडा'), findsOneWidget);
      expect(find.text('कृपया सर्वोच्च शिक्षण पात्रता निवडा'), findsOneWidget);

      // Select student education
      await tester.tap(find.text('शिक्षण निवडा...'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('पदवी (Graduate)'));
      await tester.pumpAndSettle();

      // Student error is cleared
      expect(find.text('कृपया सर्वोच्च शिक्षण निवडा'), findsNothing);
      expect(find.text('कृपया सर्वोच्च शिक्षण पात्रता निवडा'), findsOneWidget);

      // Select unemployed qualification
      await tester.tap(find.text('पात्रता निवडा...'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('आयटीआय (ITI)'));
      await tester.pumpAndSettle();

      // Unemployed error is cleared
      expect(find.text('कृपया सर्वोच्च शिक्षण पात्रता निवडा'), findsNothing);

      // Form validation passes
      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('CustomTextField validation error disappears immediately when user types data', (tester) async {
      final formKey = GlobalKey<FormState>();
      final nameController = TextEditingController();
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextField(
                labelText: 'पूर्ण नाव',
                controller: nameController,
                focusNode: focusNode,
                isCompulsory: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'कृपया पूर्ण नाव प्रविष्ट करा';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Initially no error is displayed
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsNothing);

      // Form submit button clicked (validation throws)
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Error must now be displayed
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsOneWidget);

      // User starts typing in the field
      await tester.enterText(find.byType(TextFormField), 'J');
      await tester.pump();

      // Validation error MUST disappear immediately upon typing!
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsNothing);

      // User continues typing
      await tester.enterText(find.byType(TextFormField), 'Jaydip Pawar');
      await tester.pump();
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsNothing);

      // If user deletes all text and leaves field (blur)
      await tester.enterText(find.byType(TextFormField), '');
      focusNode.unfocus();
      await tester.pump();

      // Error reappears when emptied and blurred
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsOneWidget);

      // User types again
      await tester.enterText(find.byType(TextFormField), 'Jaydip');
      await tester.pump();

      // Error disappears again immediately!
      expect(find.text('कृपया पूर्ण नाव प्रविष्ट करा'), findsNothing);
    });

    testWidgets('CustomTextField validation error disappears immediately when data is set programmatically (DatePicker / Keyboard)', (tester) async {
      final formKey = GlobalKey<FormState>();
      final dobController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextField(
                labelText: 'जन्मतारीख',
                controller: dobController,
                isCompulsory: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'कृपया जन्मतारीख प्रविष्ट करा';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Submit pressed on empty DOB
      formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(find.text('कृपया जन्मतारीख प्रविष्ट करा'), findsOneWidget);

      // DatePicker sets controller text programmatically
      dobController.text = '1995-05-15';
      await tester.pump();

      // Error MUST disappear immediately!
      expect(find.text('कृपया जन्मतारीख प्रविष्ट करा'), findsNothing);
    });

    testWidgets('Self-employed section validation clears immediately when typing in any of the 3 fields', (tester) async {
      final formBloc = MemberFormBloc();
      final formKey = formBloc.formKey;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'पद / हुद्दा',
                    controller: formBloc.jobDesignationController,
                    validator: (val) {
                      final hasAny = formBloc.jobDesignationController.text.trim().isNotEmpty ||
                          formBloc.jobCompanyController.text.trim().isNotEmpty ||
                          formBloc.businessTypeController.text.trim().isNotEmpty;
                      if (!hasAny) {
                        return 'पद, कंपनी किंवा व्यवसाय यांपैकी किमान १ माहिती आवश्यक आहे';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    labelText: 'कंपनी नाव',
                    controller: formBloc.jobCompanyController,
                  ),
                  CustomTextField(
                    labelText: 'व्यवसाय प्रकार',
                    controller: formBloc.businessTypeController,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Submit pressed when all 3 fields empty
      formKey.currentState!.validate();
      await tester.pumpAndSettle();
      expect(find.text('पद, कंपनी किंवा व्यवसाय यांपैकी किमान १ माहिती आवश्यक आहे'), findsOneWidget);

      // User types in company field
      formBloc.jobCompanyController.text = 'Shivaji Enterprises';
      await tester.pump();

      // Validation error on designation MUST clear immediately!
      expect(find.text('पद, कंपनी किंवा व्यवसाय यांपैकी किमान १ माहिती आवश्यक आहे'), findsNothing);

      formBloc.close();
    });
  });
}

void _fillValidBasic(MemberFormBloc bloc) {
  bloc.firstNameController.text = 'Jaydip';
  bloc.middleNameController.text = 'Sanjay';
  bloc.lastNameController.text = 'Pawar';
  bloc.firstNameMrController.text = 'जयदीप';
  bloc.middleNameMrController.text = 'संजय';
  bloc.lastNameMrController.text = 'पवार';
  bloc.dateOfBirthController.text = '1995-05-15';
  bloc.addressController.text = 'Sadashiv Peth';
  bloc.addressMrController.text = 'सदाशिव पेठ';
  bloc.selectedDistrict.value = const DistrictInfo(
    code: 'SATARA',
    nameEn: 'Satara',
    nameMr: 'सातारा',
    talukas: [],
  );
  bloc.selectedTaluka.value = const TalukaInfo(nameEn: 'Koregaon', nameMr: 'कोरेगाव');
  bloc.pincodeController.text = '415501';
  bloc.living = 'इतर';
  bloc.mobileNoController.text = '9876543210';
}
