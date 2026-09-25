import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/constants/geo_constants.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/app_searchable_dropdown.dart';
import 'package:maratha_shivmudra/src/widgets/dropdown/geo_address_fields.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testItems = [
    const AppDropdownItem<String>(
      value: 'MH',
      label: '🚩 महाराष्ट्र',
      subtitle: 'सर्व जिल्हे (९९ सभासद)',
      searchKey: 'महाराष्ट्र maharashtra mh',
    ),
    AppDropdownItem<String>.header('--- प्रमुख जिल्हे ---'),
    const AppDropdownItem<String>(
      value: 'Pune',
      label: 'पुणे (Pune)',
      subtitle: '१४ तालुके',
      searchKey: 'पुणे pune',
    ),
    const AppDropdownItem<String>(
      value: 'Satara',
      label: 'सातारा (Satara)',
      subtitle: '११ तालुके',
      searchKey: 'सातारा satara',
    ),
    AppDropdownItem<String>.header('--- सीमावर्ती / इतर ---'),
    const AppDropdownItem<String>(
      value: 'KA-BEL',
      label: '📍 बेळगाव (Belagavi)',
      subtitle: 'कर्नाटक',
      searchKey: 'बेळगाव belagavi karnataka',
    ),
  ];

  testWidgets('AppSearchableDropdown displays selected label and opens/closes on click', (tester) async {
    String? selected = 'MH';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return AppSearchableDropdown<String>(
                    value: selected,
                    items: testItems,
                    labelText: 'जिल्हा',
                    onChanged: (val) {
                      setState(() => selected = val);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Initial state: shows "🚩 महाराष्ट्र"
    expect(find.text('🚩 महाराष्ट्र'), findsOneWidget);

    // Tap to open dropdown menu
    await tester.tap(find.text('🚩 महाराष्ट्र'));
    await tester.pumpAndSettle();

    // The search field should be visible
    expect(find.byType(TextField), findsOneWidget);

    // Headers and options should be visible
    expect(find.text('--- प्रमुख जिल्हे ---'), findsOneWidget);
    expect(find.text('पुणे (Pune)'), findsOneWidget);
    expect(find.text('सातारा (Satara)'), findsOneWidget);

    // Select "पुणे (Pune)"
    await tester.tap(find.text('पुणे (Pune)'));
    await tester.pumpAndSettle();

    // Menu should be closed, selected should now be "पुणे (Pune)"
    expect(find.byType(TextField), findsNothing);
    expect(find.text('पुणे (Pune)'), findsOneWidget);
    expect(selected, equals('Pune'));
  });

  testWidgets('AppSearchableDropdown filters items when typing in search field and clears query', (tester) async {
    String? selected = 'MH';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: AppSearchableDropdown<String>(
                value: selected,
                items: testItems,
                labelText: 'जिल्हा',
                onChanged: (val) => selected = val,
              ),
            ),
          ),
        ),
      ),
    );

    // Open dropdown
    await tester.tap(find.text('🚩 महाराष्ट्र'));
    await tester.pumpAndSettle();

    // Enter search query "satara"
    await tester.enterText(find.byType(TextField), 'satara');
    await tester.pumpAndSettle();

    // "सातारा (Satara)" should be visible, while "पुणे (Pune)" should be filtered out
    expect(find.text('सातारा (Satara)'), findsOneWidget);
    expect(find.text('पुणे (Pune)'), findsNothing);

    // Search query in Marathi "पुणे"
    await tester.enterText(find.byType(TextField), 'पुणे');
    await tester.pumpAndSettle();

    expect(find.text('पुणे (Pune)'), findsOneWidget);
    expect(find.text('सातारा (Satara)'), findsNothing);

    // Tap clear button in search field
    await tester.tap(find.byIcon(Icons.clear_rounded));
    await tester.pumpAndSettle();

    // All options visible again
    expect(find.text('पुणे (Pune)'), findsOneWidget);
    expect(find.text('सातारा (Satara)'), findsOneWidget);

    // Tap outside (on barrier)
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // Overlay is closed
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('AppSearchableDropdown with isRequired: true renders red bold asterisk in sync with CustomTextField', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: AppSearchableDropdown<String>(
                value: null,
                items: [AppDropdownItem(value: '1', label: 'Item 1')],
                labelText: 'जिल्हा',
                isRequired: true,
              ),
            ),
          ),
        ),
      ),
    );

    // Find the RichText widget inside InputDecorator
    final richTextFinder = find.byWidgetPredicate(
      (widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains('जिल्हा') &&
          widget.text.toPlainText().contains('*'),
    );
    expect(richTextFinder, findsOneWidget);

    final richText = tester.widget<RichText>(richTextFinder);
    expect(richText.text.toPlainText(), contains('जिल्हा'));
    expect(richText.text.toPlainText(), contains('*'));

    bool hasRedAsterisk = false;
    richText.text.visitChildren((span) {
      if (span is TextSpan &&
          span.text != null &&
          span.text!.contains('*') &&
          span.style?.color == AppColors.errorColor &&
          span.style?.fontWeight == FontWeight.bold) {
        hasRedAsterisk = true;
        return false;
      }
      return true;
    });
    expect(hasRedAsterisk, isTrue);
  });

  testWidgets('GeoAddressFields fills only Rajya by default, keeping District and Taluka unselected (null)', (tester) async {
    StateInfo? capturedState;
    DistrictInfo? capturedDistrict;
    TalukaInfo? capturedTaluka;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: GeoAddressFields(
                keyPrefix: 'test_geo',
                isMarathi: true,
                onChanged: (state, district, taluka) {
                  capturedState = state;
                  capturedDistrict = district;
                  capturedTaluka = taluka;
                },
              ),
            ),
          ),
        ),
      ),
    );

    // State is defaulted to Maharashtra
    expect(find.text('महाराष्ट्र'), findsOneWidget);

    // District and Taluka dropdowns should be unselected and show 'जिल्हा निवडा...' and 'तालुका निवडा...' placeholder
    expect(find.text('जिल्हा निवडा...'), findsOneWidget);
    expect(find.text('तालुका निवडा...'), findsOneWidget);

    // Verify district dropdown items are available from Maharashtra
    await tester.tap(find.byKey(const ValueKey('test_geo_dist_MH_null')));
    await tester.pumpAndSettle();

    // Select first district (Ahilyanagar)
    final distItem = find.text('अहिल्यानगर');
    expect(distItem, findsOneWidget);
    await tester.tap(distItem);
    await tester.pumpAndSettle();

    // After choosing district, state is MH, district is Ahilyanagar, taluka is still null
    expect(capturedDistrict?.code, equals('AHI'));
    expect(capturedTaluka, isNull);

    // Open Taluka dropdown and select Akole
    await tester.tap(find.byKey(const ValueKey('test_geo_tal_AHI_null')));
    await tester.pumpAndSettle();

    final akoleItem = find.text('अकोले');
    expect(akoleItem, findsOneWidget);
    await tester.tap(akoleItem);
    await tester.pumpAndSettle();

    expect(capturedTaluka?.nameEn, equals('Akole'));

    // Changing state resets district and taluka to null
    await tester.tap(find.byKey(const ValueKey('test_geo_state_MH')));
    await tester.pumpAndSettle();

    final apItem = find.text('आंध्र प्रदेश');
    expect(apItem, findsOneWidget);
    await tester.tap(apItem);
    await tester.pumpAndSettle();

    expect(capturedState?.code, equals('AP'));
    expect(capturedDistrict, isNull);
    expect(capturedTaluka, isNull);
  });

  testWidgets('AppSearchableDropdown inside a Form shows validation error when empty and clears when selected', (tester) async {
    final formKey = GlobalKey<FormState>();
    String? selectedValue;

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
                      value: selectedValue,
                      items: testItems,
                      labelText: 'शिक्षण पात्रता',
                      hintText: 'निवडा...',
                      isRequired: true,
                      validator: (val) => (val == null || val.isEmpty) ? 'कृपया शिक्षण निवडा' : null,
                      onChanged: (val) {
                        setState(() => selectedValue = val);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );

    // Initial state: no error shown
    expect(find.text('कृपया शिक्षण निवडा'), findsNothing);

    // Trigger form validation
    final isValidInitial = formKey.currentState!.validate();
    await tester.pumpAndSettle();

    // Validation must fail and error message must be visible
    expect(isValidInitial, isFalse);
    expect(find.text('कृपया शिक्षण निवडा'), findsOneWidget);

    // Tap dropdown to select an item
    await tester.tap(find.text('निवडा...'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('पुणे (Pune)'));
    await tester.pumpAndSettle();

    // Error message must now be gone and validation must pass
    expect(find.text('कृपया शिक्षण निवडा'), findsNothing);
    final isValidAfter = formKey.currentState!.validate();
    expect(isValidAfter, isTrue);
  });

  testWidgets('GeoAddressFields inside a Form displays validation errors when District and Taluka are unselected', (tester) async {
    final formKey = GlobalKey<FormState>();
    DistrictInfo? selectedDistrict;
    TalukaInfo? selectedTaluka;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: GeoAddressFields(
                keyPrefix: 'form_geo',
                isMarathi: true,
                isRequired: true,
                onChanged: (st, dist, tal) {
                  selectedDistrict = dist;
                  selectedTaluka = tal;
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Initial state: State is MH, District & Taluka unselected, no errors shown yet
    expect(find.text('कृपया जिल्हा निवडा'), findsNothing);
    expect(find.text('कृपया तालुका निवडा'), findsNothing);

    // Run form validation
    final isValidInitial = formKey.currentState!.validate();
    await tester.pumpAndSettle();

    // Both District and Taluka must flag validation errors in Marathi
    expect(isValidInitial, isFalse);
    expect(find.text('कृपया जिल्हा निवडा'), findsOneWidget);
    expect(find.text('कृपया तालुका निवडा'), findsOneWidget);

    // Select District (अहिल्यानगर)
    await tester.tap(find.byKey(const ValueKey('form_geo_dist_MH_null')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('अहिल्यानगर'));
    await tester.pumpAndSettle();

    // District error should be cleared
    expect(find.text('कृपया जिल्हा निवडा'), findsNothing);

    // Form re-validation still fails because Taluka is required
    final isValidSecond = formKey.currentState!.validate();
    await tester.pumpAndSettle();
    expect(isValidSecond, isFalse);
    expect(find.text('कृपया तालुका निवडा'), findsOneWidget);

    // Select Taluka (अकोले)
    await tester.tap(find.byKey(const ValueKey('form_geo_tal_AHI_null')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('अकोले'));
    await tester.pumpAndSettle();

    // Taluka error is also cleared
    expect(find.text('कृपया तालुका निवडा'), findsNothing);

    // Re-validate: everything passes
    final isValidFinal = formKey.currentState!.validate();
    expect(isValidFinal, isTrue);
  });
}
