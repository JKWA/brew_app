import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

enum CoffeeMakerStatus { idle, single, double }

final isIdle = Predicate<CoffeeMakerStatus>(
  (CoffeeMakerStatus status) => status == CoffeeMakerStatus.idle,
);

class BrewCubit extends Cubit<CoffeeMakerStatus> {
  BrewCubit() : super(CoffeeMakerStatus.idle);

  void startSingleShot() {
    emit(CoffeeMakerStatus.single);

    Future.delayed(const Duration(seconds: 3), stopBrewing);
  }

  void startDoubleShot() {
    emit(CoffeeMakerStatus.double);

    Future.delayed(const Duration(seconds: 6), stopBrewing);
  }

  void stopBrewing() {
    emit(CoffeeMakerStatus.idle);
  }
}
