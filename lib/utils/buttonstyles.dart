import 'package:dhanvarsha/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonStyles{
  static const BoxDecoration redButtonWithCircularBorder= BoxDecoration(
    color: AppColors.buttonRed,
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  static const BoxDecoration redButtonWithCircularBorderWithOpacity= BoxDecoration(
    color: AppColors.buttonRedOpacity,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
  static const BoxDecoration greyButtonWithCircularBorder= BoxDecoration(

    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
}