import 'package:brew_app/power/power.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/view_setup.dart';

void main() {
  late Widget Function(Widget) createTestApp;

  setUp(() {
    final setUpValues = setUpTestEnvironment();
    createTestApp = setUpValues.$1;
  });

  testWidgets('PowerPage is shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const PowerPage(
          title: 'TEST',
        ),
      ),
    );

    expect(find.byType(PowerPage), findsOneWidget);
  });
}
