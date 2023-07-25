import 'package:brew_app/brew/brew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/view_setup.dart';

void main() {
  late BrewCubit brewCubit;
  late Widget Function(Widget) createTestApp;

  setUp(() {
    final setUpValues = setUpTestEnvironment();
    createTestApp = setUpValues.$1;
    brewCubit = setUpValues.$4;
  });

  testWidgets('BrewPage is shown when it is the child of createTestApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const BrewPage(
          title: 'Brew',
        ),
      ),
    );

    expect(find.byType(BrewPage), findsOneWidget);
  });

  testWidgets('BrewButtons are shown when BrewCubit state is idle',
      (WidgetTester tester) async {
    brewCubit.emit(CoffeeMakerStatus.idle);

    await tester.pumpWidget(
      createTestApp(
        const BrewPage(
          title: 'Brew',
        ),
      ),
    );
    expect(find.byType(BrewButtons), findsOneWidget);
    expect(find.byType(BrewInfoWidget), findsNothing);
  });

  testWidgets('BrewInfoWidget is shown when BrewCubit state is single',
      (WidgetTester tester) async {
    brewCubit.emit(CoffeeMakerStatus.single);
    await tester.pumpWidget(
      createTestApp(
        const BrewPage(
          title: 'Brew',
        ),
      ),
    );
    expect(find.byType(BrewButtons), findsNothing);
    expect(find.byType(BrewInfoWidget), findsOneWidget);
  });

  testWidgets('BrewInfoWidget is shown when BrewCubit state is double',
      (WidgetTester tester) async {
    brewCubit.emit(CoffeeMakerStatus.double);
    await tester.pumpWidget(
      createTestApp(
        const BrewPage(
          title: 'Brew',
        ),
      ),
    );
    expect(find.byType(BrewButtons), findsNothing);
    expect(find.byType(BrewInfoWidget), findsOneWidget);
  });
}
