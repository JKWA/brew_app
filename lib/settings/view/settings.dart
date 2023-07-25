import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/language/view/language.dart';
import 'package:brew_app/temp/temp.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Text(
                context.l10n.brew_temp,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const TempControl(),
              const LanguageControl(),
            ],
          ),
        ),
      ),
    );
  }
}
