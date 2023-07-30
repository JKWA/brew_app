import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/temp/temp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
  });

  group('GrindCubit', () {
    blocTest<TempCubit, int>(
      'emits default temperature value when initialized with no previous value',
      build: () => TempCubit(sharedPreferences: sharedPreferences),
      expect: () => [TempCubit.tempDefault],
    );

    blocTest<TempCubit, int>(
      'emits stored temperature value when initialized with a previous value',
      build: () {
        sharedPreferences.setInt(TempCubit.refKey, TempCubit.tempDefault);
        return TempCubit(sharedPreferences: sharedPreferences);
      },
      expect: () => [TempCubit.tempDefault],
    );

    blocTest<TempCubit, int>(
      'emits clamped value when updated with value above upper bound',
      build: () => TempCubit(sharedPreferences: sharedPreferences),
      act: (cubit) => cubit.update(TempCubit.tempHighBound + 10),
      expect: () => [TempCubit.tempDefault, TempCubit.tempHighBound],
    );

    blocTest<TempCubit, int>(
      'emits clamped value when updated with value below lower bound',
      build: () => TempCubit(sharedPreferences: sharedPreferences),
      act: (cubit) => cubit.update(TempCubit.tempLowBound - 10),
      expect: () => [TempCubit.tempDefault, TempCubit.tempLowBound],
    );
  });
}
