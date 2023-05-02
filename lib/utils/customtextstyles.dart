import 'dart:ui';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  //replace with regularMediumFontGotham
  static TextStyle regularMediumFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w100,
  );
  static TextStyle regularWhiteSmallFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.white);

//replace with regularwhitemediumfontgotham
  static TextStyle regularWhiteMediumFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.white);

  static TextStyle regularBlackMediumFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.black);

  static TextStyle regularMediumDarkFont = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.black);
  static TextStyle regularErrorSmallFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.buttonRed);

  //replace with buttonTextStyleGotham ------
  static TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.white);

  static TextStyle buttonTextStyleRed = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.buttonRed);

  static TextStyle regularLargeFonts = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w100,
  );

  static TextStyle regularsmalleFonts = TextStyle(
    fontFamily: 'Gotham',
    fontSize: 12 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w100,
  );
  static TextStyle regularsmalleFontswithUnderline = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.underline,
  );
  static TextStyle regularLightBoxsmalleFonts = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);
  static TextStyle boldMediumFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: (15 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600);

  static TextStyle boldMediumFontPurple = TextStyle(
      fontFamily: 'Poppins',
      fontSize: (15 / 420) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.lightpurple);

  static TextStyle boldMediumFontpink = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (15 / 420) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.pink);

  static TextStyle boldMediumFontPink = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (15 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.pink);
  static TextStyle boldMediumFontGreen = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (15 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.green);

  static TextStyle boldMediumFontYellow = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (15 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.yellow);

  static TextStyle boldMediumFontScalable = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (15 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600);

  static TextStyle boldMedium1Font = TextStyle(
      fontFamily: 'GothamMedium',
      height: 1.4,
      fontSize: 14 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600);

  //replace with boldMediumRedFont Gotham
  static TextStyle boldMediumRedFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonRed);

  static TextStyle boldsmallRedFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonRed);

  static TextStyle boldsmallGreenFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.green);

  static TextStyle boldsmallGreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.lightGrey3);
  static TextStyle boldsmallGreyFontScalable = TextStyle(
      fontFamily: 'Poppins',
      fontSize: (10 / 720) * SizeConfig.screenHeight,
      fontWeight: FontWeight.w600,
      color: AppColors.lightGrey3);

  static TextStyle boldlargerRedFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.buttonRed);

  //replace with boldLargeFontsGotham
  static TextStyle boldLargeFonts = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 18 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle boldLittleLargeFonts = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle boldLargeFonts2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle boldSubtitleLargeFonts = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle regularSmallGreyFont = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);
  static TextStyle regularSmallGreyFont1 = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.light);
  static TextStyle regularMediumGreyFont1 = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.lightGrey3);

  static TextStyle regularMedium2GreyFont1 = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 14 * SizeConfig.textScaleFactor,
      height: 1.5,
      fontWeight: FontWeight.w100,
      color: AppColors.lightGrey3);

//replace regularMediumGreyFontGotham
  static TextStyle regularMediumGreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  static TextStyle regularSmall1GreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  static TextStyle regularMediumLighterGreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.lighterGrey4);

  static TextStyle regularLargeGreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  static TextStyle boldLargerFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  static TextStyle boldVeryLargerFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 26 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );

  //replace by boldVeryLargerFont2Gotham
  static TextStyle boldVeryLargerFont2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle buttonBlackTextStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.black);

  static TextStyle boldMediumrWhiteFont = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

  static TextStyle boldLargerWhiteFont = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 30 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.white);
  static TextStyle boldMediumrBlackFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.black);

  static TextStyle boldVeryLargeWhiteFont = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 24 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

//replace by boldLargeWhiteFontGotham
  static TextStyle boldLargeWhiteFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.white);
  static TextStyle boldsmalleFonts = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 12 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );

  //scalable fonts =>
  // test motoG4 => scaling bloc => 6.4*3.75 => 24 size => Very Large
  //                             => 6.4*3.125 => 20 size => large
//                               => 6.4*2.8125 => 18 size => Medium
//                               => 6.4*2.34375 => 15 size => Small
  //                             => 6.4*2.03125 => 13 size => VerySmall
  static TextStyle VeryLargeBoldLightFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 3.75 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w200,
  );

  static TextStyle VeryLargeBoldBoldFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 4.75 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );

  static TextStyle dvAmountFonts = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 4.00 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );
  static TextStyle BoldTitileFont = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 3.125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );

  static TextStyle LargeBoldLightFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 3.125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w200,
  );
  static TextStyle MediumBoldLightFont = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 2.8125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );

  static TextStyle purpleMenuFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.8125 * SizeConfig.blockSizeVertical,
      fontWeight: FontWeight.w200,
      color: AppColors.lightpurple);
  static TextStyle SmallBoldFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 2.34375 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );
  static TextStyle SmallBoldLightFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 2.34375 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w200,
  );

  static TextStyle VerySmallBoldLightFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 2.03125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w200,
  );

  static TextStyle VerySmallBoldFont = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 2.03125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );

  static TextStyle VerySmallLighGreyFont = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.03125 * SizeConfig.blockSizeVertical,
      fontWeight: FontWeight.w600,
      color: AppColors.lighterGrey);

  static TextStyle VerySmallLightFontWhite = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 2.03125 * SizeConfig.blockSizeVertical,
      fontWeight: FontWeight.w200,
      color: AppColors.white);

// -----------------------------------------------------------------------------------

  //Gotham

  //replace with boldLargeFonts poppins
  static TextStyle boldLargeFontsGotham = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: (SizeConfig.screenWidthNew / 100) * 6,
    fontWeight: FontWeight.w400,
  );

//replace with buttonTextStyle poppins
  static TextStyle buttonTextStyleGotham = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (SizeConfig.screenWidthNew / 100) * 3.8,
      fontWeight: FontWeight.w200,
      color: AppColors.white);

//replace with boldMediumRedFont
  static TextStyle boldMediumRedFontGotham = TextStyle(
      fontFamily: 'Gotham',
      fontSize: (SizeConfig.screenWidthNew / 100) * 3.8,
      fontWeight: FontWeight.w700,
      color: AppColors.buttonRed);

  //replace with regularMediumFont
  static TextStyle regularMediumFontGotham = TextStyle(
    fontFamily: 'Gotham',

    fontWeight: FontWeight.w700,
    // fontFeatures: FontFeature.,
    fontSize: (SizeConfig.screenWidthNew / 100) * 3.4,
    // fontStyle: FontStyle.italic,
  );

  static TextStyle regularMediumFontGothamTextField = TextStyle(
    fontFamily: 'Gotham',

    fontWeight: FontWeight.w700,
    // fontFeatures: FontFeature.,
    fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
    // fontStyle: FontStyle.italic,
  );

  static TextStyle regularMediumFontGothamTextFieldGreyCalendar = TextStyle(
    fontFamily: 'Gotham',
    color: AppColors.lightGrey3,
    fontWeight: FontWeight.w700,
    // fontFeatures: FontFeature.,
    fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
    // fontStyle: FontStyle.italic,
  );

  static TextStyle boldLargerWhiteFontGothamNew = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (SizeConfig.screenWidthNew / 100) * 6,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

// replace with boldLargerWhiteFont
  static TextStyle boldLargerWhiteFontGotham = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (SizeConfig.screenWidthNew / 100) * 10,
      fontWeight: FontWeight.w600,
      color: AppColors.white);

//replace with regularWhiteMediumFont
  static TextStyle regularWhiteMediumFontGotham = TextStyle(
      fontFamily: 'GothamMedium',
      height: 1.35,
      fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
      fontWeight: FontWeight.w100,
      color: AppColors.white);

//replace with boldVeryLargerFont2
  static TextStyle boldVeryLargerFont2Gotham = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: (SizeConfig.screenWidthNew / 100) * 6,
    fontWeight: FontWeight.w600,
  );
//replace with regularMediumGreyFont
  static TextStyle regularMediumGreyFontGotham = TextStyle(
      fontFamily: 'Gotham',
      fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  //replace with regularMediumGreyFont new one with spacing
  static TextStyle regularMediumGreyFontGothamSpacing = TextStyle(
      fontFamily: 'Gotham',
      height: 1.35,
      fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

  static TextStyle regularMediumGreyFontGothamMedium = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: (SizeConfig.screenWidthNew / 100) * 4.2,
    fontWeight: FontWeight.w600,
  );

//replace by regularSmallGreyFont
  static TextStyle regularSmallGreyFontGotham = TextStyle(
      fontFamily: 'Gotham',
      fontSize: (SizeConfig.screenWidthNew / 100) * 3.6,
      fontWeight: FontWeight.w600,
      color: AppColors.light);

//replace by boldsmallRedFont
  static TextStyle boldsmallRedFontGotham = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (SizeConfig.screenWidthNew / 100) * 3.4,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: AppColors.buttonRed);

//replace by dvAmountFontsGotham
  static TextStyle dvAmountFontsGotham = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: (SizeConfig.screenWidthNew / 100) * 7.5,
    fontWeight: FontWeight.w600,
  );
//replace by regularMediumGreyFont1
  static TextStyle regularMediumGreyFont1Gotham = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 15 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.lightGrey3);

  static TextStyle regularMediumGreyFont1GothamHintCalendar =
      TextStyle(fontFamily: 'Gotham', color: AppColors.lightGrey3);

//replace bt boldMediumFont
  static TextStyle boldMediumFontGotham = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: (SizeConfig.screenWidthNew / 100) * 4,
      fontWeight: FontWeight.w600);
//replace bt regularSmallGreyFont1

  static TextStyle regularSmallGreyFont1Gotham = TextStyle(
      fontFamily: 'Gotham',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w100,
      color: AppColors.light);

  static TextStyle boldsmallGreyFontNew = TextStyle(
      fontFamily: 'GothamMedium',
      height: 1.4,
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.lightGrey3);

  static TextStyle MediumBoldLightFontNew = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 2.8125 * SizeConfig.blockSizeVertical,
    fontWeight: FontWeight.w600,
  );
  static TextStyle boldsmallGreyFontGotham = TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 12 * SizeConfig.textScaleFactor,
      fontWeight: FontWeight.w600,
      color: AppColors.lightGrey3);

  static TextStyle boldLargeFontsNew = TextStyle(
    fontFamily: 'GothamMedium',
    height: 1.5,
    fontSize: 18 * SizeConfig.textScaleFactor,
    fontWeight: FontWeight.w600,
  );
}
