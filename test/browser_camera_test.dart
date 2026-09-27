import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/utils/camera_helper.dart';

void main() {
  group('BrowserCameraHelper Tests', () {
    testWidgets('BrowserCameraHelper.capturePhoto returns null on non-web VM environment', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(BrowserCameraHelper.capturePhoto(context), completion(isNull));
              return const Placeholder();
            },
          ),
        ),
      );
    });
  });
}
