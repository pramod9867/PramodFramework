import 'package:flutter/cupertino.dart';

class CustomLoader {
  static CustomLoader customloaderbuilder = CustomLoader();

  ValueNotifier<bool> loader = ValueNotifier(false);

  showLoader() {
    loader.value = true;
  }

  hideLoader() {
    loader.value = false;
  }
}
