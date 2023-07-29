import 'package:brew_app/config/spacing.dart';
import 'package:brew_app/steam/steam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SteamPage extends StatelessWidget {
  const SteamPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final space = context.read<SpacingConfigModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(space.mediumSpacing),
        child: const Align(
          alignment: Alignment.topCenter,
          child: MilkSelect(),
        ),
      ),
    );
  }
}
