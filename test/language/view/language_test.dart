import 'package:brew_app/config/config.dart';
import 'package:brew_app/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/view_setup.dart';

void main() {
  late Widget Function(Widget) createTestApp;
  late LanguageConfigModel languageConfigModel;

  setUp(() {
    final setUpValues = setUpTestEnvironment();
    createTestApp = setUpValues.$1;
    languageConfigModel = setUpValues.$3; // assignment here
  });

  testWidgets('LanguageControl is shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const LanguageControl(),
      ),
    );
    expect(find.byType(LanguageControl), findsOneWidget);
  });

  testWidgets('LanguageControl has correct initial value',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const LanguageControl(),
      ),
    );

    final dropdownButtonFinder = find.byWidgetPredicate(
      (Widget widget) => widget is DropdownButton<Locale>,
      description: 'DropdownButton<Locale>',
    );

    final dropdownButton =
        tester.firstWidget<DropdownButton<Locale>>(dropdownButtonFinder);

    expect(dropdownButton.value, equals(languageConfigModel.currentLocale));
  });
}
