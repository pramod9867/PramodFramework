import 'package:flutter/cupertino.dart';

class CustomLoaderBuilder {
  static CustomLoaderBuilder builder = CustomLoaderBuilder();
  ValueNotifier<bool> isLoaderShow = ValueNotifier(false);
  ValueNotifier<bool> isDiffLoader = ValueNotifier(false);
  ValueNotifier<bool> changeContent = ValueNotifier(false);
  showLoader() {
    isDiffLoader.value = false;
    isLoaderShow.value = true;
    changeContent.value = false;

  }

  hideLoader() {
    isDiffLoader.value = false;
    isLoaderShow.value = false;
    changeContent.value = false;
  }

  showLoaderDiff() {
    isLoaderShow.value = true;
    isDiffLoader.value = true;
    changeContent.value = false;
  }

  hideLoaderDiff() {
    isLoaderShow.value = false;
    isDiffLoader.value = false;
    changeContent.value = false;
  }

  showLoaderUIDiff() {
    isLoaderShow.value = true;
    isDiffLoader.value = true;
    changeContent.value = true;
  }

  hideLoaderUIDiff() {
    isLoaderShow.value = false;
    isDiffLoader.value = false;
    changeContent.value = false;
  }
}
