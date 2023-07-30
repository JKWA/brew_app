import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempCubit extends Cubit<int> {
  TempCubit({required this.sharedPreferences}) : super(tempDefault) {
    _initialize();
    _loadTemp();
  }
  static const tempLowBound = 900;
  static const tempHighBound = 960;
  static const tempDefault = 930;
  static const refKey = 'temp_celsius';

  final SharedPreferences sharedPreferences;
  final _updateController = BehaviorSubject<int>();

  int _clampedGrind(int grind) {
    return grind.clamp(tempLowBound, tempHighBound);
  }

  Future<int> _getTemp() async {
    final logger = Logger();

    try {
      return _clampedGrind(sharedPreferences.getInt(refKey) ?? tempDefault);
    } catch (e) {
      logger.e('Failed to load temperature from SharedPreferences: $e');
      return tempDefault;
    }
  }

  Future<void> _saveTemp(int temp) async {
    final valid = _clampedGrind(temp);
    final logger = Logger();

    try {
      await sharedPreferences.setInt(refKey, valid);
    } catch (e) {
      logger.e('Failed to save temperature to SharedPreferences: $e');
    }
  }

  void _initialize() {
    _updateController.stream
        .throttleTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_updateTemp);
  }

  void update(int temp) => _updateController.add(temp);

  Future<void> _updateTemp(int temp) async {
    final valid = _clampedGrind(temp);
    await _saveTemp(valid);
    emit(valid);
  }

  Future<void> _loadTemp() async {
    final initialTemp = await _getTemp();
    emit(initialTemp);
  }

  @override
  Future<void> close() {
    _updateController.close();
    return super.close();
  }
}
