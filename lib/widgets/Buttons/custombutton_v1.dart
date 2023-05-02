import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class CustomButton_v1 extends StatefulWidget {
  final String title;
  final VoidCallback onButtonPressed;
  final double widthScale;
  final BoxDecoration boxDecoration;
  final bool isRightArrow;

  CustomButton_v1(
      {Key? key,
        this.title = "Sample",
        this.widthScale = 1,
        required this.onButtonPressed,
        this.boxDecoration = ButtonStyles.redButtonWithCircularBorder, this.isRightArrow=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton_v1> {
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return GestureDetector(
        onTap: widget.onButtonPressed,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            elevation: 10,

            child: Container(
              height: (SizeConfig.screenHeight/100) *7.5,
              width: widget.widthScale * SizeConfig.screenWidth,
              decoration: widget.boxDecoration,
              child: Center(
                child: Text(
                  widget.title,
                  style: CustomTextStyles.buttonTextStyleGotham,
                ),
              ),
            ),
          ),
        ));
  }
}
