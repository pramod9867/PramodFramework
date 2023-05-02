import 'dart:async';
import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarbuilder.dart';
import 'package:flutter/material.dart';


class SnackBarWindowBuilder {
  static final SnackBarWindowBuilder defaultMenuWindow =
  SnackBarWindowBuilder();
  Timer? _timer;

  ValueNotifier<SnackBarBuilder> snackbarObservable = ValueNotifier(null!);

  show(SnackBarBuilder snackBar) {
    snackbarObservable.value = snackBar;
    if(_timer != null && _timer!.isActive!){
      _timer!.cancel();
    };
    if(snackBar.duration != null){
      _timer = Timer(snackBar.duration!, (){
        dismissAll();
      });
    }
  }

  dismissAll() {
    snackbarObservable.value = null!;
  }
}
