import 'package:brew_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageControl extends StatelessWidget {
  const LanguageControl({super.key});

  @override
  Widget build(BuildContext context) {
    final supportedLocales = context
            .findAncestorWidgetOfExactType<MaterialApp>()
            ?.supportedLocales
            .toSet()
            .toList() ??
        [];

    return Material(
      child: DropdownButton<Locale>(
        value: context.watch<LanguageConfigModel>().currentLocale,
        items: supportedLocales.map((Locale locale) {
          return DropdownMenuItem<Locale>(
            value: locale,
            child: Text(locale.languageCode.toUpperCase()),
          );
        }).toList(),
        onChanged: (Locale? selectedLocale) {
          if (selectedLocale != null) {
            context.read<LanguageConfigModel>().changeLanguage(selectedLocale);
          }
        },
      ),
    );
  }
}
