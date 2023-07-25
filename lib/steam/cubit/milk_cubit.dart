import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Milk { almond, oat, soy, whole }

String milkToString(Milk milk) {
  return milk.toString().split('.').last;
}

Milk stringToMilk(String string) {
  return Milk.values.firstWhere(
    (milk) => milkToString(milk) == string,
    orElse: () => Milk.whole,
  );
}

Future<Milk> _getMilk() async {
  final logger = Logger();

  try {
    final prefs = await SharedPreferences.getInstance();
    final milkString = prefs.getString('milk_type') ?? 'whole';
    return stringToMilk(milkString);
  } catch (e) {
    logger.e('Failed to load milk type from SharedPreferences: $e');
    return Milk.whole;
  }
}

Future<void> _saveMilk(Milk milk) async {
  final logger = Logger();

  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('milk_type', milkToString(milk));
  } catch (e) {
    logger.e('Failed to save milk type to SharedPreferences: $e');
  }
}

class MilkCubit extends Cubit<Milk> {
  MilkCubit() : super(Milk.whole) {
    _initialize();
    _loadMilk();
  }
  final _updateController = BehaviorSubject<Milk>();

  void _initialize() {
    _updateController.stream
        .throttleTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_updateMilk);
  }

  void update(Milk milk) => _updateController.add(milk);

  Future<void> _updateMilk(Milk milk) async {
    await _saveMilk(milk);
    emit(milk);
  }

  Future<void> _loadMilk() async {
    final initialMilk = await _getMilk();
    emit(initialMilk);
  }

  @override
  Future<void> close() {
    _updateController.close();
    return super.close();
  }
}
