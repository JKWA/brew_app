import 'package:brew_app/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempControl extends StatelessWidget {
  const TempControl({super.key});

  @override
  Widget build(BuildContext context) {
    final temp = context.watch<TempCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: temp.toDouble(),
          min: tempLowBound.toDouble(),
          max: tempHighBound.toDouble(),
          label: (temp / 10).toStringAsFixed(1),
          onChanged: (double value) {
            context.read<TempCubit>().update(value.toInt());
          },
        ),
        Text((temp / 10).toStringAsFixed(1))
      ],
    );
  }
}
