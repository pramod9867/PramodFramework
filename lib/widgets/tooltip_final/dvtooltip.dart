import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Container(
      child: Tooltip(
        key: key,
        preferBelow: true,
        margin: EdgeInsets.fromLTRB(50, 0, 10, 0),
        padding: EdgeInsets.fromLTRB(15, 10, 5, 10),
        excludeFromSemantics: false,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(10.0)),
        textStyle: CustomTextStyles.regularMediumFont,
        message: message,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTap(key),
          child: child,
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
