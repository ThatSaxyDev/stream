import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final calculationsControllerProvider =
    StateNotifierProvider<CalculationsController, int>((ref) {
  return CalculationsController();
});

//! the calculations controller class extending state notifier
class CalculationsController extends StateNotifier<int> {
  CalculationsController() : super(0);

  Timer? timerFromOutside;

  //! add numbers
  void addNumbers({
    required int firstNumber,
    required int secondNumber,
  }) {
    //! add numbers
    int sum = firstNumber + secondNumber;

    //! update state with sum
    state = sum;
  }

  void startCounting() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timerFromOutside = timer;
      state = state + 1;
    });
  }

  void stopCountAndReset() {
    timerFromOutside!.cancel();
    state = 0;
  }
}
