import 'package:brew_app/brew/brew.dart';
import 'package:brew_app/config/config.dart';
import 'package:brew_app/grind/grind.dart';
import 'package:brew_app/home/home.dart';
import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/steam/steam.dart';
import 'package:brew_app/temp/temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({super.key});

//   final prefs = await SharedPreferences.getInstance();

// final grindCubit = GrindCubit(sharedPreferences: prefs);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SpacingConfigModel>(
                create: (_) => SpacingConfigModel(),
              ),
              ChangeNotifierProvider<LanguageConfigModel>(
                create: (_) => LanguageConfigModel(),
              ),
              BlocProvider<BrewCubit>(
                create: (_) => BrewCubit(),
              ),
              BlocProvider<TempCubit>(
                create: (_) => TempCubit(),
              ),
              BlocProvider<MilkCubit>(
                create: (_) => MilkCubit(),
              ),
              Provider<SharedPreferences>.value(value: snapshot.data!),
              BlocProvider<GrindCubit>(
                create: (context) => GrindCubit(
                  sharedPreferences: context.read<SharedPreferences>(),
                ),
              ),
            ],
            child: Builder(
              builder: (context) {
                return MaterialApp(
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black),
                      titleTextStyle:
                          TextStyle(color: Colors.teal, fontSize: 24),
                      toolbarTextStyle: TextStyle(color: Colors.teal),
                    ),
                    primarySwatch: Colors.teal,
                    brightness: Brightness.light,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  locale: context.watch<LanguageConfigModel>().currentLocale,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const HomePage(),
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        }
        return const Center(child: Text('Error initializing Application'));
      },
    );
  }
}
