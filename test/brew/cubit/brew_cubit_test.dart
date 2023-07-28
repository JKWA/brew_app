// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/brew/brew.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BrewCubit', () {
    test('initial state should be idle', () {
      expect(BrewCubit().state.status, CoffeeMakerStatus.idle);
    });

    blocTest<BrewCubit, BrewStatus>(
      'emits progress status from 0.1 to 1.0 then idle when startSingleShot is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.startSingleShot(),
      expect: () => [
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.1),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.2),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.3),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.4),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.5),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.6),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.7),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.8),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 0.9),
        const BrewStatus(status: CoffeeMakerStatus.single, progress: 1),
        const BrewStatus(status: CoffeeMakerStatus.idle),
      ],
      wait: const Duration(
        seconds: 11,
      ),
    );

    blocTest<BrewCubit, BrewStatus>(
      'emits progress status from 0.1 to 0.25 over 5 seconds when startDoubleShot is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.startDoubleShot(),
      expect: () => [
        const BrewStatus(status: CoffeeMakerStatus.double, progress: 0.05),
        const BrewStatus(status: CoffeeMakerStatus.double, progress: 0.1),
        const BrewStatus(status: CoffeeMakerStatus.double, progress: 0.15),
        const BrewStatus(status: CoffeeMakerStatus.double, progress: 0.2),
        const BrewStatus(status: CoffeeMakerStatus.double, progress: 0.25),
      ],
      wait: const Duration(
        seconds: 5,
      ),
    );

    blocTest<BrewCubit, BrewStatus>(
      'emits [CoffeeMakerStatus.idle] when stopBrewing is called',
      build: BrewCubit.new,
      act: (cubit) => cubit.stopBrewing(),
      expect: () => [
        const BrewStatus(status: CoffeeMakerStatus.idle),
      ],
    );
  });
}
