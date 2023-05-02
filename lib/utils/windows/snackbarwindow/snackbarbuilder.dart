import 'package:flutter/material.dart';

enum SnackBarPosition { Bottom, Top }

class SnackBarBuilder {
  final Key? key;
  final Widget? snackBar;
  final SnackBarPosition? position;
  final Duration? duration;

  SnackBarBuilder({
    this.key,
    this.snackBar,
    this.position,
    this.duration,
  });
}
