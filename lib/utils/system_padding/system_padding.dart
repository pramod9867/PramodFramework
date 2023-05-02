import 'package:flutter/material.dart';

class SystemPadding extends StatelessWidget {
  final Widget child;

  SystemPadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    print("SYSTEM PADDING");
    print(mediaQuery.viewInsets);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets/2,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}