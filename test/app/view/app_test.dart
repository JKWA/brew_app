import 'package:brew_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders App', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: App()));
      await tester.pumpAndSettle();
      expect(find.byType(App), findsOneWidget);
    });
  });
}
