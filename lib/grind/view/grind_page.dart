import 'package:brew_app/config/spacing.dart';
import 'package:brew_app/grind/grind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GrindPage extends StatelessWidget {
  const GrindPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final grind = context.watch<GrindCubit>();
    final space = context.read<SpacingConfigModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(space.mediumSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () => grind.update(grind.state - 1),
              child: const Icon(Icons.add),
            ),
            Padding(
              padding: EdgeInsets.all(space.xLargeSpacing),
              child: Text(
                grind.state.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            FloatingActionButton(
              onPressed: () => grind.update(grind.state + 1),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
