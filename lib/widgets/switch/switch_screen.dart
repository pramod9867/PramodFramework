import 'package:dhanvarsha/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

typedef onSwitchPressed = Function(bool isValue);
class SwitchScreen extends StatefulWidget {
  final onSwitchPressed onswitchPressed;

  const SwitchScreen({Key? key,required this.onswitchPressed}) : super(key: key);
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State<SwitchScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterSwitch(
            width: 55,
            height: 35,
            activeColor: AppColors.buttonRed,
            value: isSwitched,
            onToggle: (value) {
              setState(() {
                isSwitched = value;

              });
              print(value);

            },
          ),
        ]);
  }
}
