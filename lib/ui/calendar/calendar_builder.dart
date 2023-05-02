import 'package:flutter/cupertino.dart';

class CalendarBuilder {
  static CalendarBuilder builder = CalendarBuilder();
  ValueNotifier<List<int>> notifier = ValueNotifier([-1, -1]);
  ValueNotifier<int> years = ValueNotifier(2021);

  selectFirstMonth(int index) {
    if (notifier.value[0] == -1 || notifier.value[0] != index) {
      notifier.value[0] = index;
    } else if (notifier.value[0] == index) {
      notifier.value[0] = -1;
    }
    notifier.notifyListeners();
    print(notifier.value);
  }

  incrementYear() {
    years.value = years.value + 1;
    years.notifyListeners();
  }

  decrementYear() {
    years.value = years.value - 1;
    years.notifyListeners();
  }

  selectSecondMonth(int index) {
    if (notifier.value[1] == -1 ||
        notifier.value[1] != index && notifier.value[0] < index) {
      notifier.value[1] = index;
    } else if (notifier.value[1] == index) {
      notifier.value[1] = -1;
    }
    notifier.notifyListeners();
    print(notifier.value);
  }
}
