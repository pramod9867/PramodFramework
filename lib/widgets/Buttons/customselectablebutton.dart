import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:flutter/material.dart';

class CustomSelectableButton extends StatefulWidget {
  final title;
  final double leftPadding;
  final double rightPadding;

  const CustomSelectableButton(
      {Key? key,
      this.title = "Buisiness",
      this.leftPadding = 0,
      this.rightPadding: 0})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomSelectableState();
}

class _CustomSelectableState extends State<CustomSelectableButton> {
  ValueNotifier<bool> isButtonPressed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isButtonPressed,
        builder: (BuildContext context, bool value, Widget? child) {
          return Expanded(
            child:GestureDetector(
              onTap: (){
                isButtonPressed.value =!isButtonPressed.value;
                isButtonPressed.notifyListeners();
              },
              child:  Container(
                decoration: isButtonPressed.value?BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.buttonRed,
                    border: Border.all(width: 1,color: AppColors.buttonRed)
                ):BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                  border: Border.all(width: 1,color: AppColors.lighterGrey)
                ),
                margin: EdgeInsets.only(
                    left: widget.leftPadding, right: widget.rightPadding),
                padding: EdgeInsets.symmetric(vertical: 2.5),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: isButtonPressed.value?CustomTextStyles.regularWhiteMediumFont:CustomTextStyles.regularBlackMediumFont,
                ),
              ),
            ),
          );
        },
      );
  }
}
