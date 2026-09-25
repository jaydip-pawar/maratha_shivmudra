import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/models/member_profile.dart';
import 'package:maratha_shivmudra/src/screens/profile/widgets/profile_content_view.dart';

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
  });
}
