import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/src/screens/profile/widgets/profile_content_view.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

void main() {
  final incompleteProfile = MemberProfile.fromFirestore('8691955046', {
    'phone': '8691955046',
    'first_name': 'Shivaji',
    'last_name': 'Bhosale',
    'full_name_en': 'Shivaji Bhosale',
    'full_name_mr': 'शिवाजी भोसले',
    'gender': 'Male',
    'living': 'स्वतंत्र घर / स्वतःचे घर (Own House)',
    'district': 'Satara',
    'district_en': 'Satara',
    'sub_district': 'Jawali',
    'village': 'Mahabaleshwar',
    'pincode': '412806',
    'address': 'Historic Wada',
    'profession': 'शेती (Farmer)',
    'crops_produced': ['ऊस', 'सोयाबीन'],
    'blood_group': 'O+',
    'emergency_contact_name': 'Bhosale',
    'emergency_contact_phone': '9876543210',
    'member_id': 'MH-SAT-JAW-0001',
    'is_card_issued': true,
  });

  final complete100Profile = MemberProfile.fromFirestore('8691955046', {
    'full_name_en': 'Jaydip Pawar',
    'full_name_mr': 'जयदीप पवार',
    'first_name': 'Jaydip',
    'last_name': 'Pawar',
    'phone': '8691955046',
    'district_mr': 'सातारा',
    'district_en': 'Satara',
    'district': 'Satara',
    'sub_district': 'कोरेगाव',
    'village': 'कोरेगाव',
    'pincode': '415501',
    'address': 'सदाशिव पेठ, कोरेगाव',
    'date_of_birth': '1995-05-15',
    'gender': 'पुरुष (Male)',
    'living': 'स्वतंत्र घर (Own House)',
    'photo_base64': 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
    'blood_group': 'O+',
    'emergency_contact_name': 'संजय पवार',
    'emergency_contact_phone': '9876543210',
    'is_native_address_same': true,
    'is_politically_active': true,
    'political_party': 'शिवसेना',
    'political_role': 'युवा समन्वयक',
    'is_associated_with_ngo': true,
    'ngo_name': 'शिवमुद्रा प्रतिष्ठान',
    'ngo_role': 'सचिव',
    'is_organ_donor_pledged': true,
    'has_organ_donation_answered': true,
    'profession': 'शेती (Farmer)',
    'crops_produced': ['सोयाबीन', 'ऊस', 'हळद'],
    'member_id': 'MH-SAT-KOR-0001',
    'is_card_issued': true,
  });

  group('ProfileContentView Multi-View Responsiveness & Constraint Safety', () {
    testWidgets('Renders successfully on Desktop view with bounded height (No empty state)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 700,
                height: 750,
                child: ProfileContentView(
                  initialProfile: incompleteProfile,
                  isCompact: false,
                  isFixedHeader: true,
                  showCloseButton: true,
                  onClose: () {},
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that profile identity header is rendered (Not empty!)
      expect(find.text('8691955046'), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);
      // Verify sections exist
      expect(find.byType(ProfileContentView), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('Renders successfully on Mobile view with compact constraints',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 390,
              height: 844,
              child: ProfileContentView(
                initialProfile: incompleteProfile,
                isCompact: true,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('8691955046'), findsAtLeastNWidgets(1));
      expect(find.byType(ProfileContentView), findsOneWidget);
    });

    testWidgets('Renders safely without assertion crash when placed inside unbounded scrollable',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // Testing unbounded height parent (e.g. outer SingleChildScrollView)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: ProfileContentView(
                initialProfile: incompleteProfile,
                isCompact: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // No crash/assertion throw, content renders
      expect(find.text('8691955046'), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('Profile status card is VISIBLE when profile is incomplete (<100%)',
        (WidgetTester tester) async {
      expect(incompleteProfile.isProfileComplete, isFalse);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 700,
              height: 800,
              child: ProfileContentView(
                initialProfile: incompleteProfile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Progress meter card should be visible
      expect(
        find.byWidgetPredicate(
          (w) => w is Text && (w.data?.contains('प्रोफाइल पूर्णता') == true || w.data?.contains('Profile Completion') == true),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Profile status card is HIDDEN when profile reaches 100% complete',
        (WidgetTester tester) async {
      expect(complete100Profile.isProfileComplete, isTrue);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 700,
              height: 800,
              child: ProfileContentView(
                initialProfile: complete100Profile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Progress meter card should NOT be shown
      expect(
        find.byWidgetPredicate(
          (w) => w is Text && (w.data?.contains('प्रोफाइल पूर्णता') == true || w.data?.contains('Profile Completion') == true),
        ),
        findsNothing,
      );
    });

    testWidgets('Native place district displays "-" and NOT "पुणे" when native district is empty',
        (WidgetTester tester) async {
      final profileNoNative = MemberProfile(
        phone: '8691955046',
        isNativeAddressSameAsCurrent: false,
        nativeDistrict: '',
        nativeDistrictMr: '',
        nativeState: '',
        nativeTaluka: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 700,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profileNoNative,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the row for Native District / मूळ जिल्हा
      expect(find.text('मूळ जिल्हा'), findsOneWidget);
      // It should display '-' and definitely NOT 'पुणे'
      expect(find.text('पुणे'), findsNothing);
    });

    testWidgets('Native place edit mode dropdown shows hint and does not select default district',
        (WidgetTester tester) async {
      final profileNoNative = MemberProfile(
        phone: '8691955046',
        isNativeAddressSameAsCurrent: false,
        nativeDistrict: '',
        nativeDistrictMr: '',
        nativeState: '',
        nativeTaluka: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 700,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profileNoNative,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the "संपादित करा" button for Section 3 (native_address)
      final editButtons = find.text('संपादित करा');
      // Section 1: personal (0), Section 2: residence (1), Section 3: native (2)
      expect(editButtons, findsAtLeastNWidgets(3));
      await tester.ensureVisible(editButtons.at(2));
      await tester.tap(editButtons.at(2));
      await tester.pumpAndSettle();

      // Verify "संपादित करा" turned into "संपादन सुरू आहे"
      expect(find.text('संपादन सुरू आहे'), findsOneWidget);

      // Verify that 'पुणे' is NOT selected in any dropdown or text in Section 3
      expect(find.text('पुणे'), findsNothing);

      // Verify hintText is displayed
      expect(find.text('जिल्हा निवडा...'), findsOneWidget);
    });

    testWidgets('Current address edit mode shows both English and Marathi fields for village and full address', (WidgetTester tester) async {
      final profile = MemberProfile(
        phone: '8691955046',
        village: 'Pune',
        villageMr: 'पुणे',
        address: 'MG Road, Camp',
        addressMr: 'एमजी रोड, कॅम्प',
        pincode: '411001',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "संपादित करा" for Section 2 (current_address)
      final editButtons = find.text('संपादित करा');
      expect(editButtons, findsAtLeastNWidgets(2));
      await tester.ensureVisible(editButtons.at(1));
      await tester.tap(editButtons.at(1));
      await tester.pumpAndSettle();

      // Verify English and Marathi labels are present
      expect(find.text('गाव / शहर / परिसर (English)'), findsOneWidget);
      expect(find.text('गाव / शहर / परिसर (मराठी)'), findsOneWidget);
      expect(find.text('पत्ता (English) *'), findsOneWidget);
      expect(find.text('पत्ता (मराठी) *'), findsOneWidget);

      // Verify values are populated
      expect(find.text('Pune'), findsOneWidget);
      expect(find.text('पुणे'), findsOneWidget);
      expect(find.text('MG Road, Camp'), findsOneWidget);
      expect(find.text('एमजी रोड, कॅम्प'), findsOneWidget);
    });

    testWidgets(
        'Personal info edit mode has both English and Marathi name fields with phonetic transliteration and validation',
        (WidgetTester tester) async {
      final profile = MemberProfile(
        firstName: 'Rahul',
        firstNameMr: 'राहुल',
        middleName: 'Sanjay',
        middleNameMr: 'संजय',
        lastName: 'Patil',
        lastNameMr: 'पाटील',
        gender: 'male',
        phone: '9876543210',
        roleType: 'member',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "संपादित करा" for Section 1 (personal)
      final editButtons = find.text('संपादित करा');
      expect(editButtons, findsAtLeastNWidgets(1));
      await tester.ensureVisible(editButtons.first);
      await tester.tap(editButtons.first);
      await tester.pumpAndSettle();

      // Verify name fields are present with correct labels
      expect(find.text('पहिले नाव (English) *'), findsOneWidget);
      expect(find.text('पहिले नाव (मराठी) *'), findsOneWidget);
      expect(find.text('मधले नाव (English) *'), findsOneWidget);
      expect(find.text('मधले नाव (मराठी) *'), findsOneWidget);
      expect(find.text('आडनाव (English) *'), findsOneWidget);
      expect(find.text('आडनाव (मराठी) *'), findsOneWidget);

      // Verify populated values
      expect(find.text('Rahul'), findsOneWidget);
      expect(find.text('राहुल'), findsOneWidget);

      // Find the Marathi first name field and enter text phonetically
      final marathiFirstNameFinder = find.widgetWithText(CustomTextField, 'पहिले नाव (मराठी) *');
      expect(marathiFirstNameFinder, findsOneWidget);

      // Enter English characters into Marathi field to test phonetic transliteration
      final textFormField = find.descendant(of: marathiFirstNameFinder, matching: find.byType(TextFormField));
      await tester.enterText(textFormField, 'amit');
      await tester.pumpAndSettle();

      // Should be transliterated to Marathi "अमित" and NOT allow English letters "amit"
      expect(find.text('amit'), findsNothing);
      expect(find.text('अमित'), findsOneWidget);
    });

    testWidgets(
        'Native place (mul patta) edit mode marks all fields as compulsory when different from current address',
        (WidgetTester tester) async {
      final profile = MemberProfile(
        phone: '8691955046',
        firstName: 'Rahul',
        lastName: 'Patil',
        gender: 'male',
        district: 'Satara',
        subDistrict: 'Jawali',
        address: 'Wada',
        pincode: '412806',
        isNativeAddressSameAsCurrent: false,
        nativeState: '',
        nativeDistrict: '',
        nativeTaluka: '',
        nativeVillage: '',
        nativeVillageMr: '',
        nativeAddress: '',
        nativeAddressMr: '',
        nativePincode: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('mr'),
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "संपादित करा" for Section 3 (native_address)
      final editButtons = find.text('संपादित करा');
      expect(editButtons, findsAtLeastNWidgets(3));
      await tester.ensureVisible(editButtons.at(2));
      await tester.tap(editButtons.at(2));
      await tester.pumpAndSettle();

      // Verify compulsory fields display asterisk (*) and optional full address does not
      expect(find.text('मूळ राज्य *'), findsOneWidget);
      expect(find.text('मूळ जिल्हा *'), findsOneWidget);
      expect(find.text('मूळ तालुका / शहर *'), findsOneWidget);
      expect(find.text('मूळ गाव / वाडी (English) *'), findsOneWidget);
      expect(find.text('मूळ गाव / वाडी (मराठी) *'), findsOneWidget);
      expect(find.text('पिनकोड (६ अंक) *'), findsOneWidget);
      expect(find.text('मूळ संपूर्ण पत्ता (English)'), findsOneWidget);
      expect(find.text('मूळ संपूर्ण पत्ता (मराठी)'), findsOneWidget);

      // Tap "जतन करा" to trigger section validation with empty fields
      final saveButton = find.text('जतन करा');
      expect(saveButton, findsOneWidget);
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pump();

      // Verify that validation error message is shown (e.g. state required)
      expect(find.text('कृपया मूळ राज्य निवडा'), findsOneWidget);
    });

    testWidgets('Section 6 Political & NGO edit mode requires subfields on Yes and clears them on No', (tester) async {
      final profile = MemberProfile.fromFirestore('8691955046', {
        'phone': '8691955046',
        'first_name': 'Jaydip',
        'last_name': 'Pawar',
        'is_politically_active': true,
        'political_party': 'शिवसेना',
        'political_role': 'पदाधिकारी',
        'is_associated_with_ngo': true,
        'ngo_name': 'मराठा क्रांती मोर्चा',
        'ngo_role': 'कार्यकर्ता',
      });

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('mr'),
          home: Scaffold(
            body: SizedBox(
              width: 800,
              height: 1200,
              child: ProfileContentView(
                initialProfile: profile,
                isCompact: false,
                isFixedHeader: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "संपादित करा" for Section 6 (social)
      final editButtons = find.text('संपादित करा');
      // Section 6 edit button
      await tester.ensureVisible(editButtons.at(5));
      await tester.tap(editButtons.at(5));
      await tester.pumpAndSettle();

      // Verify compulsory subfields exist when Yes is selected (cleanLabel + red asterisk)
      expect(find.text('राजकीय पक्ष / संघटना नाव'), findsOneWidget);
      expect(find.text('सध्याचे पद / जबाबदारी'), findsOneWidget);
      expect(find.text('सामाजिक संस्थेचे नाव'), findsOneWidget);
      expect(find.text('संस्थेतील पद / कार्य'), findsOneWidget);
      expect(find.text('*'), findsAtLeastNWidgets(4));

      // Verify the text fields are populated with existing data
      expect(find.text('शिवसेना'), findsOneWidget);
      expect(find.text('पदाधिकारी'), findsOneWidget);

      // Now click "नाही (No)" on Political Active
      final noChips = find.text('नाही (No)');
      await tester.tap(noChips.first);
      await tester.pumpAndSettle();

      // Verify political subfields are now hidden
      expect(find.text('राजकीय पक्ष / संघटना नाव'), findsNothing);
      expect(find.text('सध्याचे पद / जबाबदारी'), findsNothing);

      // Click "होय (Yes)" again on Political Active
      final yesChips = find.text('होय (Yes)');
      await tester.tap(yesChips.first);
      await tester.pumpAndSettle();

      // Subfields reappear and must be CLEARED (empty text), not retaining old text
      expect(find.text('शिवसेना'), findsNothing);
      expect(find.text('पदाधिकारी'), findsNothing);
    });
  });
}
