import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrindCubit extends Cubit<int> {
  GrindCubit({required this.sharedPreferences}) : super(grindDefault) {
    _initialize();
    _loadGrind();
  }
  final SharedPreferences sharedPreferences;
  final _updateController = BehaviorSubject<int>();

  static const grindLowerBound = 0;
  static const grindUpperBound = 12;
  static const grindDefault = 8;
  static const refKey = 'grind_level';

  int _clampedGrind(int grind) {
    return grind.clamp(grindLowerBound, grindUpperBound);
  }

  void _initialize() {
    _updateController.stream
        .throttleTime(const Duration(milliseconds: 200))
        .distinct()
        .listen(_updateGrind);
  }

  Future<void> _loadGrind() async {
    final initialGrind = await _getGrind();
    emit(initialGrind);
  }

  Future<int> _getGrind() async {
    final logger = Logger();

    try {
      final grind = sharedPreferences.getInt(refKey) ?? grindDefault;
      return grind.clamp(grindLowerBound, grindUpperBound);
    } catch (e) {
      logger.e('Failed to load grind from SharedPreferences: $e');
      return grindDefault;
    }
  }

  void update(int grind) => _updateController.add(grind);

  Future<void> _updateGrind(int grind) async {
    final valid = _clampedGrind(grind);
    await _saveGrind(valid);
    emit(valid);
  }

  @override
  Future<void> close() {
    _updateController.close();
    return super.close();
  }

  Future<void> _saveGrind(int grind) async {
    final logger = Logger();

    try {
      await sharedPreferences.setInt(refKey, _clampedGrind(grind));
    } catch (e) {
      logger.e('Failed to save grind to SharedPreferences: $e');
    }
  }
}
