import 'package:brew_app/config/config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpacingConfigModel', () {
    late SpacingConfigModel spacingConfigModel;

    setUp(() {
      spacingConfigModel = SpacingConfigModel();
    });

    test('returns correct default spacings', () {
      expect(spacingConfigModel.smallSpacing, 4);
      expect(spacingConfigModel.mediumSpacing, 8);
      expect(spacingConfigModel.largeSpacing, 16);
    });

    test('updates medium spacing correctly', () {
      spacingConfigModel.updateMediumSpacing(10);

      expect(spacingConfigModel.smallSpacing, 5);
      expect(spacingConfigModel.mediumSpacing, 10);
      expect(spacingConfigModel.largeSpacing, 20);
    });

    test('notifies listeners when updating medium spacing', () {
      var notified = false;
      spacingConfigModel
        ..addListener(() => notified = true)
        ..updateMediumSpacing(10);

      expect(notified, true);
    });
  });
}
