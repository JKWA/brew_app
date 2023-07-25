import 'package:flutter/foundation.dart';

class SpacingConfigModel extends ChangeNotifier {
  double _mediumSpacing = 8;

  double get smallSpacing => _mediumSpacing * 0.5;
  double get mediumSpacing => _mediumSpacing;
  double get largeSpacing => _mediumSpacing * 2;

  void updateMediumSpacing(double newSpacing) {
    _mediumSpacing = newSpacing;
    notifyListeners();
  }
}
