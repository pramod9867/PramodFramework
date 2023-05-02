import 'package:dhanvarsha/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class ButtonStyles {
  static const BoxDecoration redButtonWithCircularBorder = BoxDecoration(
    color: AppColors.buttonRed,
    borderRadius: BorderRadius.all(Radius.circular(50)),
  );

  static const BoxDecoration greyButtonWithCircularBorder = BoxDecoration(
    color: AppColors.light,
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );
}
