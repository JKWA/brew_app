import 'package:brew_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LanguageConfigModel model;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    model = LanguageConfigModel();
  });

  group('changeLanguage', () {
    test('updates the current locale and notify listeners', () async {
      const newLocale = Locale('fr');
      var called = false;

      model
        ..addListener(() {
          called = true;
        })
        ..changeLanguage(newLocale);

      expect(model.currentLocale, newLocale);
      expect(called, isTrue);
    });

    test('does not notify listeners when locale is the same as current',
        () async {
      final currentLocale = model.currentLocale;
      var called = false;

      model
        ..addListener(() {
          called = true;
        })
        ..changeLanguage(currentLocale);

      expect(called, isFalse);
    });
  });
}
