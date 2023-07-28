import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:brew_app/utility/predicate.dart';
import 'package:equatable/equatable.dart';

enum CoffeeMakerStatus { idle, single, double }

Predicate<CoffeeMakerStatus> isIdle =
    (status) => status == CoffeeMakerStatus.idle;

class BrewStatus extends Equatable {
  const BrewStatus({required this.status, this.progress = 0.0});

  final CoffeeMakerStatus status;
  final double progress;

  @override
  List<Object> get props => [status, progress];
}

class BrewCubit extends Cubit<BrewStatus> {
  BrewCubit() : super(const BrewStatus(status: CoffeeMakerStatus.idle));

  Timer? _timer;

  void startSingleShot() {
    _startBrewing(CoffeeMakerStatus.single, 10);
  }

  void startDoubleShot() {
    _startBrewing(CoffeeMakerStatus.double, 20);
  }

  void _startBrewing(CoffeeMakerStatus status, int totalSeconds) {
    var remainingSeconds = totalSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      remainingSeconds--;
      if (remainingSeconds < 0) {
        timer.cancel();
        stopBrewing();
      } else {
        final progress = double.parse(
          (1.0 - (remainingSeconds / totalSeconds)).toStringAsFixed(2),
        );
        emit(BrewStatus(status: status, progress: progress));
      }
    });
  }

  void stopBrewing() {
    _timer?.cancel();
    emit(const BrewStatus(status: CoffeeMakerStatus.idle));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
