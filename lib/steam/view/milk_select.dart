import 'package:brew_app/l10n/l10n.dart';
import 'package:brew_app/steam/steam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MilkSelect extends StatelessWidget {
  const MilkSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final selection = <Milk>{context.watch<MilkCubit>().state};

    final l10n = context.l10n;

    ButtonSegment<Milk> getButtonSegment(Milk milk) {
      switch (milk) {
        case Milk.almond:
          return ButtonSegment<Milk>(
            value: Milk.almond,
            label: Text(l10n.milk_almond),
          );
        case Milk.oat:
          return ButtonSegment<Milk>(
            value: Milk.oat,
            label: Text(l10n.milk_oat),
          );
        case Milk.soy:
          return ButtonSegment<Milk>(
            value: Milk.soy,
            label: Text(l10n.milk_soy),
          );
        case Milk.whole:
          return ButtonSegment<Milk>(
            value: Milk.whole,
            label: Text(l10n.milk_whole),
          );
      }
    }

    return SegmentedButton<Milk>(
      segments: Milk.values.map(getButtonSegment).toList(),
      selected: selection,
      onSelectionChanged: (Set<Milk> newSelection) {
        context.read<MilkCubit>().update(newSelection.first);
      },
    );
  }
}
