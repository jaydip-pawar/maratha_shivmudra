import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/src/widgets/feedback/app_floating_toast.dart';

void main() {
  testWidgets('AppFloatingToast renders in root overlay and is visible above dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: true,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Modal Dialog'),
                        content: ElevatedButton(
                          onPressed: () {
                            AppFloatingToast.showSuccess(
                              dialogContext,
                              'माहिती यशस्वीरित्या जतन झाली!',
                              title: 'यशस्वी',
                            );
                          },
                          child: const Text('Save Info'),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Open Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // 1. Open Dialog
    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Modal Dialog'), findsOneWidget);

    // 2. Click Save Info inside Dialog to trigger AppFloatingToast
    await tester.tap(find.text('Save Info'));
    await tester.pump(); // Start animation
    await tester.pump(const Duration(milliseconds: 400)); // Complete entry animation

    // 3. Verify AppFloatingToast is rendered and visible on screen
    expect(find.text('माहिती यशस्वीरित्या जतन झाली!'), findsOneWidget);
    expect(find.text('यशस्वी'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);

    // 4. Tap close button on toast to dismiss
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('माहिती यशस्वीरित्या जतन झाली!'), findsNothing);
  });

  testWidgets('AppFloatingToast auto dismisses after duration',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  AppFloatingToast.showInfo(
                    context,
                    'Auto dismiss test',
                    duration: const Duration(seconds: 1),
                  );
                },
                child: const Text('Show Info'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Info'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Auto dismiss test'), findsOneWidget);

    // Advance time past 1 second duration
    await tester.pump(const Duration(seconds: 1, milliseconds: 100));
    await tester.pumpAndSettle();

    expect(find.text('Auto dismiss test'), findsNothing);
  });

  testWidgets('AppFloatingToast showError renders error style',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  AppFloatingToast.showError(
                    context,
                    'कृपया सर्व आवश्यक माहिती भरा.',
                    title: 'त्रुटी',
                  );
                },
                child: const Text('Show Error'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Error'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('कृपया सर्व आवश्यक माहिती भरा.'), findsOneWidget);
    expect(find.text('त्रुटी'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);

    // Swipe up to dismiss
    await tester.drag(find.text('कृपया सर्व आवश्यक माहिती भरा.'), const Offset(0, -50));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('कृपया सर्व आवश्यक माहिती भरा.'), findsNothing);
  });

  testWidgets(
      'AppFloatingToast does NOT block gestures, taps or scrolling on main UI',
      (WidgetTester tester) async {
    int buttonTaps = 0;
    final scrollController = ScrollController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () => buttonTaps++,
                child: const Text('Main UI Button'),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 50,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('Item $index'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Show AppFloatingToast
    final context = tester.element(find.text('Main UI Button'));
    AppFloatingToast.showSuccess(context, 'Saved successfully');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify toast is visible
    expect(find.text('Saved successfully'), findsOneWidget);

    // 1. Tap main UI button while toast is active - MUST NOT BE BLOCKED
    await tester.tap(find.text('Main UI Button'));
    await tester.pump();
    expect(buttonTaps, 1);

    // 2. Scroll main UI ListView while toast is active - MUST NOT BE INTERRUPTED
    expect(scrollController.offset, 0.0);
    await tester.drag(find.text('Item 5'), const Offset(0, -200));
    await tester.pump();
    expect(scrollController.offset, greaterThan(100));
  });
}
