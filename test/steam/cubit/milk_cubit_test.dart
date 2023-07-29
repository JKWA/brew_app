import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/steam/cubit/milk_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MilkCubit milkCubit;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    milkCubit = MilkCubit(sharedPreferences: mockSharedPreferences);
  });

  tearDown(() {
    milkCubit.close();
  });

  group('GrindCubit', () {
    blocTest<MilkCubit, Milk>(
      'emits [] when nothing is added',
      build: () => milkCubit,
      expect: () => <Milk>[],
    );

    blocTest<MilkCubit, Milk>(
      'emits default when initialized with no value',
      build: () {
        SharedPreferences.setMockInitialValues({});
        return MilkCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <Milk>[MilkCubit.defaultMilk],
    );

    const selectedMilk = Milk.almond;

    blocTest<MilkCubit, Milk>(
      'emits same value when initialized with value',
      build: () {
        when(mockSharedPreferences.getString(MilkCubit.refKey))
            .thenReturn(milkToString(selectedMilk));

        SharedPreferences.setMockInitialValues(
          {MilkCubit.refKey: selectedMilk},
        );

        return MilkCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <Milk>[selectedMilk],
    );

    blocTest<MilkCubit, Milk>(
      'emits default value when initialized with bad value',
      build: () {
        when(mockSharedPreferences.getString(MilkCubit.refKey))
            .thenReturn('bad_value');

        SharedPreferences.setMockInitialValues(
          {MilkCubit.refKey: 'bad_value'},
        );

        return MilkCubit(sharedPreferences: mockSharedPreferences);
      },
      expect: () => <Milk>[MilkCubit.defaultMilk],
    );
  });
}
