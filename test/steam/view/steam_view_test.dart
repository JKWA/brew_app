import 'package:brew_app/steam/steam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/view_setup.dart';

void main() {
  late Widget Function(Widget) createTestApp;

  setUp(() {
    final setUpValues = setUpTestEnvironment();
    createTestApp = setUpValues.$1;
  });

  testWidgets('SteamPage is shown', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const SteamPage(
          title: 'Steam',
        ),
      ),
    );

    expect(find.byType(SteamPage), findsOneWidget);
  });

  testWidgets('MilkSelect is shown on SteamPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const SteamPage(
          title: 'Steam',
        ),
      ),
    );
    expect(find.byType(MilkSelect), findsOneWidget);
  });
}
