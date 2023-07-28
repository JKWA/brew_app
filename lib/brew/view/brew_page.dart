import 'package:brew_app/brew/brew.dart';
import 'package:brew_app/config/spacing.dart';
import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/temp/temp.dart';
import 'package:brew_app/utility/predicate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocBuilder<BrewCubit, BrewStatus>(
            builder: (context, brewStatus) {
              return match<CoffeeMakerStatus, Widget>(
                () => const BrewButtons(),
                () => const BrewInfoWidget(),
              )(isIdle)(brewStatus.status);
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
    final temp = context.watch<TempCubit>().state;

    return BlocBuilder<BrewCubit, BrewStatus>(
      builder: (context, brewStatus) {
        late String message;
        final space = context.read<SpacingConfigModel>();

        switch (brewStatus.status) {
          case CoffeeMakerStatus.idle:
            message = l10n.brew_idle_message;
          case CoffeeMakerStatus.double:
            message = l10n.brew_double_message;

          case CoffeeMakerStatus.single:
            message = l10n.brew_single_message;
        }
        return SizedBox(
          width: space.measure,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: brewStatus.progress,
                semanticsLabel: 'Brew time progress',
              ),
              Padding(
                padding: EdgeInsets.only(top: space.largeSpacing),
                child: Text(
                  '$message ${temp / 10} celsius',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
