import 'package:brew_app/brew/brew.dart';
import 'package:brew_app/config/config.dart';
import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/steam/steam.dart';
import 'package:brew_app/temp/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

(
  MultiProvider Function(Widget child),
  SpacingConfigModel,
  LanguageConfigModel,
  BrewCubit,
  TempCubit
) setUpTestEnvironment() {
  final brewCubit = BrewCubit()
    ..emit(const BrewStatus(status: CoffeeMakerStatus.idle));
  final tempCubit = TempCubit()..emit(930);
  final milkCubit = MilkCubit()..emit(Milk.whole);

  final spacingConfigModel = SpacingConfigModel();
  final languageConfigModel = LanguageConfigModel();

  MultiProvider createTestApp(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpacingConfigModel>.value(
          value: spacingConfigModel,
        ),
        ChangeNotifierProvider<LanguageConfigModel>.value(
          value: languageConfigModel,
        ),
        BlocProvider<BrewCubit>.value(
          value: brewCubit,
        ),
        BlocProvider<TempCubit>.value(
          value: tempCubit,
        ),
        BlocProvider<MilkCubit>.value(
          value: milkCubit,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    );
  }

  return (
    createTestApp,
    spacingConfigModel,
    languageConfigModel,
    brewCubit,
    tempCubit,
  );
}
