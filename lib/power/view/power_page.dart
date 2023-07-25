import 'package:brew_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PowerPage extends StatelessWidget {
  const PowerPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          context.l10n.goodby_message,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
