import 'package:brew_app/brew/brew.dart';
import 'package:brew_app/config/spacing.dart';
import 'package:brew_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class BrewPage extends StatelessWidget {
  const BrewPage({required this.title, super.key});

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
        child: Align(
          alignment: Alignment.topCenter,
          child: BlocBuilder<BrewCubit, CoffeeMakerStatus>(
            builder: (context, status) {
              return isIdle(status).match(
                () => const BrewInfoWidget(),
                () => const BrewButtons(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BrewButtons extends StatelessWidget {
  const BrewButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final space = context.read<SpacingConfigModel>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(space.mediumSpacing),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              context.read<BrewCubit>().startSingleShot();
            },
            child: Text(l10n.brew_single_button),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(space.mediumSpacing),
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              context.read<BrewCubit>().startDoubleShot();
            },
            child: Text(l10n.brew_double_button),
          ),
        ),
      ],
    );
  }
}

class BrewInfoWidget extends StatelessWidget {
  const BrewInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<BrewCubit, CoffeeMakerStatus>(
      builder: (context, status) {
        late String message;
        switch (status) {
          case CoffeeMakerStatus.idle:
            message = l10n.brew_idle_message;
          case CoffeeMakerStatus.double:
            message = l10n.brew_double_message;

          case CoffeeMakerStatus.single:
            message = l10n.brew_single_message;
        }
        return Text(
          message,
          style: Theme.of(context).textTheme.headlineSmall,
        );
      },
    );
  }
}
