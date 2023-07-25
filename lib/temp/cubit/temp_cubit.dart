import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const tempLowBound = 900;
const tempHighBound = 960;
const tempDefault = 930;

int validTemp(int temp) {
  if (temp > tempHighBound) {
    return tempHighBound;
  }
  if (temp < tempLowBound) {
    return tempLowBound;
  }
  return temp;
}

Future<int> _getTemp() async {
  final logger = Logger();

  try {
    final prefs = await SharedPreferences.getInstance();
    return validTemp(prefs.getInt('temp_celsius') ?? tempDefault);
  } catch (e) {
    logger.e('Failed to load temperature from SharedPreferences: $e');
    return tempDefault;
  }
}

Future<void> _saveTemp(int temp) async {
  final valid = validTemp(temp);
  final logger = Logger();

  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('temp_celsius', valid);
  } catch (e) {
    logger.e('Failed to save temperature to SharedPreferences: $e');
  }
}

class TempCubit extends Cubit<int> {
  TempCubit() : super(tempDefault) {
    _initialize();
    _loadTemp();
  }
  final _updateController = BehaviorSubject<int>();

  void _initialize() {
    _updateController.stream
        .throttleTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_updateTemp);
  }

  void update(int temp) => _updateController.add(temp);

  Future<void> _updateTemp(int temp) async {
    final valid = validTemp(temp);
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
