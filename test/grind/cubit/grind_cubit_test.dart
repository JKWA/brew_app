import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/grind/cubit/grind_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late GrindCubit grindCubit;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    grindCubit = GrindCubit(sharedPreferences: mockSharedPreferences);
  });

  tearDown(() {
    grindCubit.close();
  });

  group('GrindCubit', () {
    blocTest<GrindCubit, int>(
      'emits [] when nothing is added',
      build: () => grindCubit,
      expect: () => <int>[],
    );

    blocTest<GrindCubit, int>(
      'emits default when initialized with no value',
      build: () {
        SharedPreferences.setMockInitialValues({});
        return GrindCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <int>[GrindCubit.grindDefault],
    );

    blocTest<GrindCubit, int>(
      'emits same value when initialized with value',
      build: () {
        when(mockSharedPreferences.getInt(GrindCubit.refKey))
            .thenReturn(GrindCubit.grindLowerBound);
        SharedPreferences.setMockInitialValues(
          {GrindCubit.refKey: GrindCubit.grindLowerBound},
        );

        return GrindCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <int>[GrindCubit.grindLowerBound],
    );

    blocTest<GrindCubit, int>(
      'emits lower bound value when initialized with below lower bound',
      build: () {
        when(mockSharedPreferences.getInt(GrindCubit.refKey))
            .thenReturn(GrindCubit.grindLowerBound);
        SharedPreferences.setMockInitialValues(
          {GrindCubit.refKey: GrindCubit.grindLowerBound - 1},
        );

        return GrindCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <int>[GrindCubit.grindLowerBound],
    );

    blocTest<GrindCubit, int>(
      'emits upper bound value when initialized with above upper bound',
      build: () {
        when(mockSharedPreferences.getInt(GrindCubit.refKey))
            .thenReturn(GrindCubit.grindUpperBound);
        SharedPreferences.setMockInitialValues(
          {GrindCubit.refKey: GrindCubit.grindUpperBound + 1},
        );

        return GrindCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <int>[GrindCubit.grindUpperBound],
    );

    blocTest<GrindCubit, int>(
      'emits updated value when updated with new value',
      build: () => grindCubit,
      act: (cubit) => cubit.update(5),
      expect: () => <int>[5],
    );

    blocTest<GrindCubit, int>(
      'emits clamped value when updated with value below lower bound',
      build: () => grindCubit,
      act: (cubit) => cubit.update(GrindCubit.grindLowerBound - 1),
      expect: () => <int>[GrindCubit.grindLowerBound],
    );

    blocTest<GrindCubit, int>(
      'emits clamped value when updated with value above upper bound',
      build: () => grindCubit,
      act: (cubit) => cubit.update(GrindCubit.grindUpperBound + 1),
      expect: () => <int>[GrindCubit.grindUpperBound],
    );

    blocTest<GrindCubit, int>(
      'emits default value when SharedPreferences throws an exception',
      build: () {
        when(mockSharedPreferences.getInt(GrindCubit.refKey))
            .thenThrow(Exception());
        return GrindCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <int>[8],
    );
  });
}
