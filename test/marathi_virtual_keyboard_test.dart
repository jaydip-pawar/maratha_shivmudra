import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/utils/responsive.dart';
import 'package:maratha_shivmudra/src/widgets/keyboard/marathi_virtual_keyboard.dart';
import 'package:maratha_shivmudra/src/widgets/textfields/text_field.dart';

void main() {
  group('MarathiVirtualKeyboard Streamlined On-Screen Tests', () {
    testWidgets(
      'No header/cross icon, no numbers in initial view, swar in row 1, empty signs shown initially',
      (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 600,
                width: 500,
                child: MarathiVirtualKeyboard(controller: controller),
              ),
            ),
          ),
        );

        // Verify NO header / cross / drag chip
        expect(find.text('हलवा (Drag)'), findsNothing);
        expect(find.byIcon(Icons.close_rounded), findsNothing);

        // Verify NO numbers in initial view
        expect(find.text('१'), findsNothing);
        expect(find.text('०'), findsNothing);

        // Verify Swar (a, aa, aai...) in first row
        expect(find.text('अ'), findsOneWidget);
        expect(find.text('आ'), findsOneWidget);
        expect(find.text('ऋ'), findsOneWidget);

        // Verify signs row is present with empty signs (◌ा, ◌ि...)
        expect(find.text('\u25CCा'), findsOneWidget);
        expect(find.text('\u25CCि'), findsOneWidget);

        // Verify Vyanjan exist
        expect(find.text('क'), findsOneWidget);
        expect(find.text('म'), findsOneWidget);

        // Verify Comma and Dot in bottom row
        expect(find.text(','), findsOneWidget);
        expect(find.text('.'), findsOneWidget);

        // Verify Complete has tick mark sign only (no text 'पूर्ण')
        expect(find.byIcon(Icons.check_rounded), findsOneWidget);
        expect(find.text('पूर्ण'), findsNothing);

        // Verify Backspace has sign only (no text 'मागे')
        expect(find.byIcon(Icons.backspace_outlined), findsOneWidget);
        expect(find.text('⌫ मागे'), findsNothing);
      },
    );

    testWidgets(
      'Signs row replaces empty sign with active character without changing height',
      (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 600,
                width: 500,
                child: MarathiVirtualKeyboard(controller: controller),
              ),
            ),
          ),
        );

        // Initially signs row shows empty signs (◌ा)
        expect(find.text('\u25CCा'), findsOneWidget);
        final initialKeyboardSize = tester.getSize(
          find.byType(MarathiVirtualKeyboard),
        );

        // Tap 'क'
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('क'));

        // Empty sign replaced with 'का', 'कि', 'की' etc.
        expect(find.text('का'), findsOneWidget);
        expect(find.text('कि'), findsOneWidget);
        expect(find.text('की'), findsOneWidget);

        // Verify height remains constant (no height increase / jump)
        final postClickKeyboardSize = tester.getSize(
          find.byType(MarathiVirtualKeyboard),
        );
        expect(
          postClickKeyboardSize.height,
          equals(initialKeyboardSize.height),
        );

        // Tap 'का'
        await tester.tap(find.text('का'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('का'));

        // Tap 'की' to replace matra
        await tester.tap(find.text('की'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('की'));
      },
    );

    testWidgets(
      '?123 mode shows ONLY Marathi numbers and special chars, switches back',
      (WidgetTester tester) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                height: 600,
                width: 500,
                child: MarathiVirtualKeyboard(controller: controller),
              ),
            ),
          ),
        );

        // Tap ?123
        await tester.tap(find.text('?123'));
        await tester.pumpAndSettle();

        // Verify ONLY Marathi numbers in special chars view
        expect(find.text('१'), findsOneWidget);
        expect(find.text('२'), findsOneWidget);
        expect(find.text('०'), findsOneWidget);
        expect(find.text('1'), findsNothing); // No English numbers

        // Verify symbols
        expect(find.text('₹'), findsOneWidget);
        expect(find.text('@'), findsOneWidget);
        expect(find.text('मराठी'), findsOneWidget);

        // Tap Marathi number '१'
        await tester.tap(find.text('१'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('१'));

        // Tap 'मराठी' to switch back
        await tester.tap(find.text('मराठी'));
        await tester.pumpAndSettle();

        expect(find.text('क'), findsOneWidget);
        expect(find.text('?123'), findsOneWidget);
      },
    );

    testWidgets('Backspace on 2nd last row deletes character', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'भारत');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 500,
              child: MarathiVirtualKeyboard(controller: controller),
            ),
          ),
        ),
      );

      final backspace = find.byIcon(Icons.backspace_outlined);
      await tester.tap(backspace);
      await tester.pumpAndSettle();

      expect(controller.text, equals('भार'));
    });

    testWidgets('Supports physical computer keyboard typing', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 600,
              width: 500,
              child: MarathiVirtualKeyboard(controller: controller),
            ),
          ),
        ),
      );

      // Send Devanagari character from physical keyboard
      await tester.sendKeyEvent(LogicalKeyboardKey.keyK, character: 'क');
      await tester.pumpAndSettle();
      expect(controller.text, equals('क'));

      // Send Space from physical keyboard
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();
      expect(controller.text, equals('क '));

      // Send Backspace from physical keyboard
      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pumpAndSettle();
      expect(controller.text, equals('क'));
    });

    testWidgets(
      'TextField remains focused when virtual keyboard is opened and operated',
      (WidgetTester tester) async {
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      TextField(controller: controller, focusNode: focusNode),
                      ElevatedButton(
                        onPressed: () {
                          MarathiVirtualKeyboard.show(
                            context,
                            controller: controller,
                            focusNode: focusNode,
                          );
                        },
                        child: const Text('Open Keyboard'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // Open keyboard
        await tester.tap(find.text('Open Keyboard'));
        await tester.pumpAndSettle();

        // Verify keyboard is open in overlay
        expect(MarathiVirtualKeyboard.isOpen, isTrue);
        expect(find.byType(MarathiVirtualKeyboard), findsOneWidget);

        // Verify target text field IS focused!
        expect(focusNode.hasFocus, isTrue);

        // Tap 'क' on virtual keyboard
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();

        // Verify text updated and focus is STILL kept on text field
        expect(controller.text, equals('क'));
        expect(focusNode.hasFocus, isTrue);

        // Tap tick mark (check_rounded) to close
        await tester.tap(find.byIcon(Icons.check_rounded));
        await tester.pumpAndSettle();

        // Verify keyboard is dismissed
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        expect(find.byType(MarathiVirtualKeyboard), findsNothing);
      },
    );

    testWidgets(
      'Consecutive virtual keystrokes append characters without selecting or replacing them',
      (WidgetTester tester) async {
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      TextField(controller: controller, focusNode: focusNode),
                      ElevatedButton(
                        onPressed: () {
                          MarathiVirtualKeyboard.show(
                            context,
                            controller: controller,
                            focusNode: focusNode,
                          );
                        },
                        child: const Text('Open Keyboard'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Keyboard'));
        await tester.pumpAndSettle();

        // Type 'क'
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('क'));
        expect(controller.selection.isCollapsed, isTrue);

        // Simulate browser focus auto-selecting the existing text
        controller.selection = const TextSelection(
          baseOffset: 0,
          extentOffset: 1,
        );
        await tester.pumpAndSettle();

        // Type 'ख' - should NEVER replace 'क' even if browser selected it!
        await tester.tap(find.text('ख'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('कख'));
        expect(controller.selection.isCollapsed, isTrue);

        // Type 'ग'
        await tester.tap(find.text('ग'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('कखग'));
        expect(controller.selection.isCollapsed, isTrue);

        // Type 'घ'
        await tester.tap(find.text('घ'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('कखगघ'));
        expect(controller.selection.isCollapsed, isTrue);

        MarathiVirtualKeyboard.dismiss();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Clicking inside empty space of keyboard does not lose focus or select text',
      (WidgetTester tester) async {
        final controller = TextEditingController(text: 'मराठी');
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      TextField(controller: controller, focusNode: focusNode),
                      ElevatedButton(
                        onPressed: () {
                          MarathiVirtualKeyboard.show(
                            context,
                            controller: controller,
                            focusNode: focusNode,
                          );
                        },
                        child: const Text('Open Keyboard'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open Keyboard'));
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);

        // Tap on empty space / padding inside keyboard container
        final keyboardFinder = find.byType(MarathiVirtualKeyboard);
        final keyboardTopLeft = tester.getTopLeft(keyboardFinder);
        // Offset by 4 pixels inside container padding (empty area with no key)
        await tester.tapAt(keyboardTopLeft + const Offset(4, 4));
        await tester.pumpAndSettle();

        // Verify text field STILL has focus
        expect(focusNode.hasFocus, isTrue);
        // Verify selection is strictly collapsed at the end (not selecting all characters)
        expect(controller.selection.isCollapsed, isTrue);
        expect(controller.selection.start, equals(5));

        // Now tap a key and verify it appends instead of replacing
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('मराठीक'));

        MarathiVirtualKeyboard.dismiss();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'In desktop and tablet view (width >= 700), show does not scroll the page',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final controller = TextEditingController();
        final focusNode = FocusNode();
        final scrollController = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: Builder(
                  builder: (context) {
                    return Column(
                      children: [
                        Container(height: 100, color: Colors.blue),
                        TextField(controller: controller, focusNode: focusNode),
                        Container(height: 1200, color: Colors.green),
                        ElevatedButton(
                          onPressed: () {
                            MarathiVirtualKeyboard.show(
                              context,
                              controller: controller,
                              focusNode: focusNode,
                            );
                          },
                          child: const Text('Open Keyboard'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );

        expect(scrollController.offset, equals(0.0));

        // Show keyboard in desktop view
        final openBtn = find.text('Open Keyboard');
        await tester.ensureVisible(openBtn);
        await tester.tap(openBtn);
        await tester.pumpAndSettle();

        // Ensure that show() itself did not force-scroll to field (scroll offset remains unchanged)
        final offsetBeforeKeyboard = scrollController.offset;
        await tester.pump(const Duration(milliseconds: 300));
        expect(scrollController.offset, equals(offsetBeforeKeyboard));

        MarathiVirtualKeyboard.dismiss();
        await tester.pumpAndSettle();
      },
    );
  });

  group('Device soft keyboard suppression & field tap restoration tests', () {
    tearDown(() {
      Responsive.debugOverrideHasSoftKeyboard = null;
      MarathiVirtualKeyboard.dismiss();
    });

    testWidgets('Device determination: hasSoftKeyboard returns true on mobile/tablet', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Text('hasSoft: ${Responsive.hasSoftKeyboard(context)}');
              },
            ),
          ),
        ),
      );
      expect(find.text('hasSoft: true'), findsOneWidget);
    });

    testWidgets(
      'Clicking keyboard icon on soft keyboard device suppresses device keyboard (TextInputType.none) and opens MarathiVirtualKeyboard',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController(text: 'जय');
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Initially before clicking icon, keyboardType is TextInputType.text
        var formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.text));

        // Click suffix keyboard icon
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();

        // Verify keyboardType is now TextInputType.none (device soft keyboard suppressed!)
        formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.none));

        // Verify MarathiVirtualKeyboard is open and field is focused
        expect(MarathiVirtualKeyboard.isOpen, isTrue);
        expect(focusNode.hasFocus, isTrue);
        expect(controller.selection.baseOffset, equals(2));
      },
    );

    testWidgets(
      'Clicking inside textfield dismisses MarathiVirtualKeyboard and restores device keyboard (TextInputType.text)',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController(text: 'मराठा');
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard via suffix icon
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        var formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.none));

        // Now click inside the textfield
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Verify Marathi virtual keyboard is dismissed
        expect(MarathiVirtualKeyboard.isOpen, isFalse);

        // Verify keyboardType is restored to normal TextInputType.text for mobile keyboard
        formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.text));
      },
    );

    testWidgets(
      'Dismissing MarathiVirtualKeyboard resets suppressDeviceKeyboard',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        var formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.none));

        // Dismiss keyboard programmatically or via barrier
        MarathiVirtualKeyboard.dismiss();
        await tester.pumpAndSettle();

        // Keyboard type is automatically restored to TextInputType.text
        formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.text));
      },
    );

    testWidgets(
      'On desktop (hasSoftKeyboard == false), keyboardType remains TextInputType.text when keyboard icon is clicked',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Click suffix keyboard icon on desktop
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();

        // Desktop doesn't suppress physical keyboard, leaves TextInputType.text
        final formField = tester.widget<TextField>(find.byType(TextField));
        expect(formField.keyboardType, equals(TextInputType.text));
        expect(MarathiVirtualKeyboard.isOpen, isTrue);
      },
    );

    testWidgets(
      'Typing keys on virtual keyboard maintains TextInputType.none and readOnly without popping system keyboard',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        var textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, equals(TextInputType.none));
        expect(textField.readOnly, isFalse);

        // Type 'क' on virtual keyboard
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('क'));

        // Verify keyboardType remains TextInputType.none and field is editable
        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, equals(TextInputType.none));
        expect(textField.readOnly, isFalse);

        // Type matra 'ा'
        await tester.tap(find.text('का'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('का'));

        // Verify still suppressed
        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, equals(TextInputType.none));
        expect(textField.readOnly, isFalse);

        // Type another char
        await tester.tap(find.text('म'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('काम'));

        // Still suppressed!
        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, equals(TextInputType.none));
        expect(textField.readOnly, isFalse);

        // Backspace
        await tester.tap(find.byIcon(Icons.backspace_outlined));
        await tester.pumpAndSettle();
        expect(controller.text, equals('का'));

        // Still suppressed!
        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, equals(TextInputType.none));
        expect(textField.readOnly, isFalse);
      },
    );

    testWidgets(
      'Repeatedly clicking inside text field dismisses virtual keyboard and keeps system keyboard active (readOnly: false)',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController(text: 'भारत');
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Click inside text field
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Virtual keyboard closed, editable text field ready for system keyboard
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        var textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.readOnly, isFalse);
        expect(textField.keyboardType, equals(TextInputType.text));

        // Click inside text field AGAIN (repeated press)
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Remains in system keyboard editable mode!
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.readOnly, isFalse);
        expect(textField.keyboardType, equals(TextInputType.text));
      },
    );

    testWidgets(
      'Typing Latin letters on physical keyboard transliterates to Marathi',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Type 'j', 'a', 'y' on physical keyboard
        await tester.sendKeyEvent(LogicalKeyboardKey.keyJ, character: 'j');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyY, character: 'y');
        await tester.pumpAndSettle();

        expect(controller.text, equals('जय'));
      },
    );

    testWidgets(
      'Virtual keyboard backspace deletes character at middle cursor position without moving to end',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController(text: 'भारत');
        // Place cursor after 'भा' (index 2)
        controller.selection = const TextSelection.collapsed(offset: 2);
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Tap keyboard icon to open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Cursor should still be at index 2 (not reset to 4 by opening keyboard)
        expect(controller.selection.start, equals(2));

        // Tap backspace on virtual keyboard (should delete 'ा' at index 1)
        final backspaceFinder = find.byIcon(Icons.backspace_outlined);
        expect(backspaceFinder, findsOneWidget);
        await tester.tap(backspaceFinder);
        await tester.pumpAndSettle();

        // Text should now be 'भरत' and cursor at index 1
        expect(controller.text, equals('भरत'));
        expect(controller.selection.start, equals(1));
        expect(controller.selection.end, equals(1));

        // Tap backspace again (should delete 'भ' at index 0)
        await tester.tap(backspaceFinder);
        await tester.pumpAndSettle();
        expect(controller.text, equals('रत'));
        expect(controller.selection.start, equals(0));
        expect(controller.selection.end, equals(0));
      },
    );

    testWidgets(
      'Typing full phrase in English with space transliterates both words cleanly',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();

        // Type 'p', 'a', 'w', 'a', 'a', 'r'
        await tester.sendKeyEvent(LogicalKeyboardKey.keyP, character: 'p');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyW, character: 'w');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyR, character: 'r');
        await tester.pumpAndSettle();

        expect(controller.text, equals('पवार'));

        // Send space
        await tester.sendKeyEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();
        expect(controller.text, equals('पवार '));

        // Type second word 'j', 'a', 'y'
        await tester.sendKeyEvent(LogicalKeyboardKey.keyJ, character: 'j');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyA, character: 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.keyY, character: 'y');
        await tester.pumpAndSettle();

        expect(controller.text, equals('पवार जय'));
      },
    );

    testWidgets(
      'Virtual keyboard backspace deletes selected text range without moving cursor to end',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController(text: 'जयदिप पवार');
        // Select ' पवार' (range 5..10)
        controller.selection =
            const TextSelection(baseOffset: 5, extentOffset: 10);
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();

        // Tap backspace on virtual keyboard
        final backspaceFinder = find.byIcon(Icons.backspace_outlined);
        await tester.tap(backspaceFinder);
        await tester.pumpAndSettle();

        // Range deleted, only 'जयदिप' remains with cursor at index 5
        expect(controller.text, equals('जयदिप'));
        expect(controller.selection.start, equals(5));
        expect(controller.selection.end, equals(5));
      },
    );

    testWidgets(
      'Click outside triggers underlying button immediately without '
      'requiring double tap',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController();
        final focusNode = FocusNode();
        bool buttonClicked = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    focusNode: focusNode,
                    suffixIconData: Icons.keyboard_alt_outlined,
                    onSuffixTap: () {
                      MarathiVirtualKeyboard.show(
                        tester.element(find.byType(CustomTextField)),
                        controller: controller,
                        focusNode: focusNode,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      buttonClicked = true;
                    },
                    child: const Text('Submit Form'),
                  ),
                ],
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Click outside on the 'Submit Form' button with a SINGLE tap
        await tester.tap(find.text('Submit Form'));
        await tester.pumpAndSettle();

        // Virtual keyboard dismissed AND button executed in single tap!
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        expect(buttonClicked, isTrue);
      },
    );

    testWidgets(
      'Typing English directly in Marathi field transliterates to Marathi',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
              ),
            ),
          ),
        );

        // Enter English letters directly into the text field
        await tester.enterText(find.byType(TextField), 'jaydip');
        await tester.pumpAndSettle();

        // Field automatically converts English to Marathi!
        expect(controller.text, equals('जयदिप'));

        // Enter another word
        await tester.enterText(find.byType(TextField), 'pawaar');
        await tester.pumpAndSettle();
        expect(controller.text, equals('पवार'));
      },
    );

    test(
      'Sequential single character typing in MarathiPhoneticInputFormatter converts each letter',
      () {
        final formatter = MarathiPhoneticInputFormatter();
        var val = const TextEditingValue(text: '');

        // 1. Type 'j'
        val = formatter.formatEditUpdate(
          val,
          const TextEditingValue(
            text: 'j',
            selection: TextSelection.collapsed(offset: 1),
          ),
        );
        expect(val.text, equals('ज'));

        // 2. Type 'a' -> 'ja' (in Indic phonetics, inherent vowel preserves base consonant 'ज')
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}a',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('ज'));

        // 3. Type 'y' -> 'jay'
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}y',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जय'));

        // 4. Type 'd' -> 'jayd'
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}d',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जयद'));

        // 5. Type 'i' -> 'jaydi'
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}i',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जयदि'));

        // 6. Type 'p' -> 'jaydip'
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}p',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जयदिप'));

        // 7. Space
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text} ',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जयदिप '));

        // 8. Next word 's'
        val = formatter.formatEditUpdate(
          val,
          TextEditingValue(
            text: '${val.text}s',
            selection: TextSelection.collapsed(offset: val.text.length + 1),
          ),
        );
        expect(val.text, equals('जयदिप स'));
      },
    );

    testWidgets(
      'Clicking inside focused text field dismisses virtual keyboard and summons system keyboard',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        final log = <MethodCall>[];
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.textInput,
          (call) async {
            log.add(call);
            return null;
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // 1. Click suffix icon to open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // 2. Click directly inside the textfield
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Virtual keyboard dismissed and system keyboard show invoked
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        expect(
          log.any((call) => call.method == 'TextInput.show'),
          isTrue,
        );

        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.textInput,
          null,
        );
      },
    );

    testWidgets(
      'Typing on virtual keyboard keeps text selection collapsed without marking all text',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = false;
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    focusNode: focusNode,
                    suffixIconData: Icons.keyboard_alt_outlined,
                    onSuffixTap: () {
                      MarathiVirtualKeyboard.show(
                        tester.element(find.byType(CustomTextField)),
                        controller: controller,
                        focusNode: focusNode,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Tap 'क'
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('क'));
        expect(controller.selection.isCollapsed, isTrue);
        expect(controller.selection.baseOffset, equals(1));

        // Tap 'ा' (matra)
        await tester.tap(find.text('का'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('का'));
        expect(controller.selection.isCollapsed, isTrue);
        expect(controller.selection.baseOffset, equals(2));

        // Tap 'ल'
        await tester.tap(find.text('ल'));
        await tester.pumpAndSettle();
        expect(controller.text, equals('काल'));
        expect(controller.selection.isCollapsed, isTrue);
        expect(controller.selection.baseOffset, equals(3));
      },
    );

    testWidgets(
      'Mobile view reduces keyboard height and spacing',
      (tester) async {
        final controller = TextEditingController();

        // Render in mobile width (360 x 640)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(360, 640)),
              child: Scaffold(
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: MarathiVirtualKeyboard(controller: controller),
                ),
              ),
            ),
          ),
        );

        final keyboardSize = tester.getSize(
          find.byType(MarathiVirtualKeyboard),
        );

        // Mobile keyboard height is compact (< 280 px)
        expect(keyboardSize.height, lessThan(280));

        // Individual key button container height on mobile is 32 (not 38)
        final keyButton = find.ancestor(
          of: find.text('क'),
          matching: find.byType(Container),
        ).first;
        final keySize = tester.getSize(keyButton);
        expect(keySize.height, equals(32));
      },
    );

    testWidgets(
      'Back gesture dismisses virtual keyboard instead of popping page',
      (tester) async {
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => CustomTextField(
                  controller: controller,
                  focusNode: focusNode,
                  suffixIconData: Icons.keyboard_alt_outlined,
                  onSuffixTap: () {
                    MarathiVirtualKeyboard.show(
                      context,
                      controller: controller,
                      focusNode: focusNode,
                    );
                  },
                ),
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);

        // Simulate back gesture (Android back button or swipe)
        final handled = await tester.binding.handlePopRoute();
        expect(handled, isTrue);
        await tester.pumpAndSettle();

        // Virtual keyboard is closed, but the page is STILL OPEN!
        expect(MarathiVirtualKeyboard.isOpen, isFalse);
        expect(find.byType(CustomTextField), findsOneWidget);
      },
    );

    testWidgets(
      'Virtual keyboard key taps invoke light haptic feedback',
      (tester) async {
        final controller = TextEditingController();
        final hapticCalls = <MethodCall>[];

        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (call) async {
            if (call.method == 'HapticFeedback.vibrate') {
              hapticCalls.add(call);
            }
            return null;
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MarathiVirtualKeyboard(
                controller: controller,
              ),
            ),
          ),
        );

        // Tap a character key ('क')
        await tester.tap(find.text('क'));
        await tester.pumpAndSettle();

        // Verify haptic feedback was called
        expect(hapticCalls.isNotEmpty, isTrue);
        expect(
          hapticCalls.first.arguments,
          equals('HapticFeedbackType.lightImpact'),
        );
      },
    );

    testWidgets(
      'Clicking inside same textfield which opened virtual keyboard closes it and manually summons system keyboard',
      (tester) async {
        Responsive.debugOverrideHasSoftKeyboard = true;
        final controller = TextEditingController(text: 'जय');
        final focusNode = FocusNode();
        final textInputCalls = <MethodCall>[];

        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.textInput,
          (call) async {
            textInputCalls.add(call);
            return null;
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                suffixIconData: Icons.keyboard_alt_outlined,
                onSuffixTap: () {
                  MarathiVirtualKeyboard.show(
                    tester.element(find.byType(CustomTextField)),
                    controller: controller,
                    focusNode: focusNode,
                  );
                },
              ),
            ),
          ),
        );

        // Open virtual keyboard
        await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
        await tester.pumpAndSettle();
        expect(MarathiVirtualKeyboard.isOpen, isTrue);
        textInputCalls.clear();

        // Now tap inside the same text field
        await tester.tap(find.byType(TextField));
        await tester.pumpAndSettle();

        // Virtual keyboard is dismissed
        expect(MarathiVirtualKeyboard.isOpen, isFalse);

        // System keyboard was manually requested via TextInput.show
        final hasShowCall = textInputCalls.any((c) => c.method == 'TextInput.show');
        expect(hasShowCall, isTrue);

        // KeyboardType is restored to standard text
        final field = tester.widget<TextField>(find.byType(TextField));
        expect(field.keyboardType, equals(TextInputType.text));
      },
    );
  });
}
