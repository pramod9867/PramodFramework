import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:flutter/material.dart';

class BoxDecorationStyles {
  static BoxDecoration outTextFieldBoxDecoration = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.gra2),
      color: AppColors.gra2,
      borderRadius: BorderRadius.all(Radius.circular(10)));


  static BoxDecoration outTextFieldBoxDecorationWithBlack = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.black),
      color: AppColors.gra2,
      borderRadius: BorderRadius.all(Radius.circular(10)));

  static BoxDecoration outTextFieldBoxErrorDecoration = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.buttonRed),
      color: AppColors.gra2,

      borderRadius: BorderRadius.all(Radius.circular(10)));

  static BoxDecoration outButtonOfBox = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.white),
      color: AppColors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)));

  static BoxDecoration outButtonOfBoxOnlyBorderRed = BoxDecoration(
    color: AppColors.buttonRed,
      border: Border.all(width: 1, color: AppColors.buttonRed),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  static BoxDecoration outButtonOfBoxGreyBackground = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.lighBox),
      color: AppColors.lighBox,
      borderRadius: BorderRadius.all(Radius.circular(5)));

  static BoxDecoration outButtonOfBoxRed = BoxDecoration(
      border: Border.all(width: 1, color: AppColors.buttonRed),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: AppColors.buttonRed);

  static  BoxDecoration outButtonOfRedBox = BoxDecoration(
      border: Border.all(width: 1,color: AppColors.buttonRed),
      borderRadius: BorderRadius.all(Radius.circular(5))
  );

}
