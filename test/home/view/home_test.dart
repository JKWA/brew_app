import 'package:brew_app/brew/brew.dart';
import 'package:brew_app/home/view/home.dart';
import 'package:brew_app/power/power.dart';
import 'package:brew_app/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/view_setup.dart';

void main() {
  late Widget Function(Widget) createTestApp;

  setUp(() {
    final setUpValues = setUpTestEnvironment();
    createTestApp = setUpValues.$1;
  });

  testWidgets('BrewPage is shown when it is the child of createTestApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const HomePage(),
      ),
    );

    expect(find.byType(HomePage), findsOneWidget);
  });
  testWidgets('PowerPage is shown when it is the child of createTestApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const PowerPage(title: 'Test PowerPage'),
      ),
    );

    expect(find.byType(PowerPage), findsOneWidget);
  });

  testWidgets('BrewPage is shown when it is the child of createTestApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const BrewPage(title: 'Test BrewPage'),
      ),
    );

    expect(find.byType(BrewPage), findsOneWidget);
  });

  testWidgets('SettingsPage is shown when it is the child of createTestApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const SettingsPage(title: 'Test SettingsPage'),
      ),
    );

    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
