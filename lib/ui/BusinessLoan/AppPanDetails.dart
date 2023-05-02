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

class AppPanDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppPanDetailsState();
}

class _AppPanDetailsState extends State<AppPanDetails> {
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                _getManuallyTitle()
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
            AppConstants.applicantpanDetails,
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Column(
      children: [
        CustomImageBuilder(key: _key,),

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

  _getManuallyTitle() {

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
    child: Column(
    children: [
    Text(
    "OR ENTER DETAILS MANUALLY ",
    style: CustomTextStyles.boldsmallRedFontGotham,


    ),
    ]
    )
    );
  }
}
