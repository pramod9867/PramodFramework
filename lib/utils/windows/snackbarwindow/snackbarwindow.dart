import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarbuilder.dart';
import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarwindowbuilder.dart';
import 'package:flutter/material.dart';



class SnackBarWindow extends StatefulWidget {
  final SnackBarWindowBuilder snackBarWindowBuilder;

  SnackBarWindow(
      this.snackBarWindowBuilder, {
        Key? key,
      }) : super(key: key);

  @override
  _SnackBarWindowState createState() => _SnackBarWindowState();
}

class _SnackBarWindowState extends State<SnackBarWindow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.snackBarWindowBuilder.snackbarObservable,
        builder: (context,SnackBarBuilder snackBarBuilder, _) {
          if (snackBarBuilder != null) {
            return Positioned(
                child: Material(
                  type: MaterialType.transparency,
                  child: snackBarBuilder.snackBar,
                ),
                left: 0,
                right: 0,
                top: (snackBarBuilder.position == SnackBarPosition.Top)
                    ? 0
                    : null,
                bottom: (snackBarBuilder.position == SnackBarPosition.Bottom)
                    ? 0
                    : null);
          } else {
            return Container(
              height: 0,
              width: 0,
            );
          }
        });
  }
}
