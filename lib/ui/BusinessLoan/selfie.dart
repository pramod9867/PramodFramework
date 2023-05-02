import 'dart:io';
import 'dart:async';
import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/material.dart';

class selfie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _selfie();
}

class _selfie extends State<selfie> {
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleCompoenent(),
                _getHoirzontalImageUpload(),

              ],
            ),
          ),
          _getContinueButton()
        ],
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.applicantuploadphot,
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Column(
      children: [
        CustomImageBuilder(key: _key,image: DhanvarshaImages.pinNew,
          value: "Profile Picture",
        ),
      ],
    );
  }

  Widget _getContinueButton() {
    return

      Container(
        child: CustomButton(
          onButtonPressed: () {
            InheritedWrapperState wrapper = InheritedWrapper.of(context);
            wrapper.incrementCounter();
          },
          title: "Continue",
          boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
        ),


      );

  }



}
