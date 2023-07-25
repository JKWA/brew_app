// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/brew/brew.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrewCubit', () {
    test('initial state should be idle', () {
      expect(BrewCubit().state, CoffeeMakerStatus.idle);
    });

    blocTest<BrewCubit, CoffeeMakerStatus>(
      'emits [CoffeeMakerStatus.single, CoffeeMakerStatus.idle] when startSingleShot is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.startSingleShot(),
      expect: () => [CoffeeMakerStatus.single, CoffeeMakerStatus.idle],
      wait: const Duration(
        seconds: 4,
      ), // Adjust the wait duration to account for delay in the cubit
    );

    blocTest<BrewCubit, CoffeeMakerStatus>(
      'emits [CoffeeMakerStatus.double, CoffeeMakerStatus.idle] when startDoubleShot is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.startDoubleShot(),
      expect: () => [CoffeeMakerStatus.double, CoffeeMakerStatus.idle],
      wait: const Duration(
        seconds: 7,
      ), // Adjust the wait duration to account for delay in the cubit
    );

    blocTest<BrewCubit, CoffeeMakerStatus>(
      'emits [CoffeeMakerStatus.idle] when stopBrewing is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.stopBrewing(),
      expect: () => [CoffeeMakerStatus.idle],
    );
  });
}
