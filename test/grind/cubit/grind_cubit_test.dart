import 'package:bloc_test/bloc_test.dart';
import 'package:brew_app/grind/cubit/grind_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
  });

  group('GrindCubit', () {
    blocTest<GrindCubit, int>(
      'emits default grind value when initialized with no previous value',
      build: () => GrindCubit(sharedPreferences: sharedPreferences),
      expect: () => [GrindCubit.grindDefault],
    );

    blocTest<GrindCubit, int>(
      'emits stored grind value when initialized with a previous value',
      build: () {
        sharedPreferences.setInt(GrindCubit.refKey, GrindCubit.grindDefault);
        return GrindCubit(sharedPreferences: sharedPreferences);
      },
      expect: () => [GrindCubit.grindDefault],
    );

    blocTest<GrindCubit, int>(
      'emits clamped value when updated with value above upper bound',
      build: () => GrindCubit(sharedPreferences: sharedPreferences),
      act: (cubit) => cubit.update(GrindCubit.grindUpperBound + 1),
      expect: () => [GrindCubit.grindDefault, GrindCubit.grindUpperBound],
    );

    blocTest<GrindCubit, int>(
      'emits clamped value when updated with value below lower bound',
      build: () => GrindCubit(sharedPreferences: sharedPreferences),
      act: (cubit) => cubit.update(GrindCubit.grindLowerBound - 1),
      expect: () => [GrindCubit.grindDefault, GrindCubit.grindLowerBound],
    );
  });
}
