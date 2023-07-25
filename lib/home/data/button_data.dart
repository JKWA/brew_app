import 'package:brew_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

export 'button_data.dart';

List<(String, IconData)> getMainButtonData(BuildContext context) {
  return [
    (context.l10n.main_button_A, Icons.power_settings_new),
    (context.l10n.main_button_B, Icons.workspaces),
    (context.l10n.main_button_C, Icons.coffee),
    (context.l10n.main_button_D, Icons.waves),
    (context.l10n.main_button_E, Icons.settings),
  ];
}
