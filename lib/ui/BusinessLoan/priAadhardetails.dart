import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/aadharcompletedetails.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custbtnwgreyoutline.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/material.dart';

class priAadhardetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _priAadhardetailsState();
}

class _priAadhardetailsState extends State<priAadhardetails> {
  TextEditingController pinEditingController = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  GlobalKey<CustomImageBuilderState> _backKey = GlobalKey();


  bool isNoPressed=true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
              child: Column(
                children: [
                  _getTitleCompoenent(),
                  _getButtonCompoenent()
                ],
              ),

      )
          ],
        ),
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
            AppConstants.applicantAadhaarDetails,
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getButtonCompoenent() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Text(
              "Is The Customer's Aadhaar Card link to their register mobile number . +91 9867106967?",
              style: CustomTextStyles.regularSmallGreyFont,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  custbtnwgreyoutline(
                    onButtonPressed: () {
                      InheritedWrapperState wrapper = InheritedWrapper.of(context);
                      wrapper.incrementCounter();
                    },
                    title: "Yes",
                    widthScale: 0.4,
                    boxDecoration:BoxDecorationStyles.outButtonOfBox,
                  ),
                  custbtnwgreyoutline(
                    onButtonPressed: () {
                    },
                    title: "No",
                    boxDecoration: BoxDecorationStyles.outButtonOfBox,
                    widthScale: 0.4,
                  ),
                  ]
              ),
            )
          ],
        ));
  }

  Widget _getTitleCompoenentNEW() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Customer Aadhaar Details",
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Row(
      children: [
        CustomImageBuilder(
          key: _key,
          image: DhanvarshaImages.aadhar,
        ),
       Container(
         margin: EdgeInsets.symmetric(horizontal: 10),
         child:  CustomImageBuilder(
           key: _backKey,
           value: "Back View",
           image: DhanvarshaImages.aadharcard,
         ),
       )
      ],
    );
  }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CustomButton(
            onButtonPressed: () {
              InheritedWrapperState wrapper = InheritedWrapper.of(context);
              wrapper.incrementCounter();
            },
            title: "Continue",
            boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
          ),
          Text(
            "I DON'T HAVE AADHAAR CARD",
            style: CustomTextStyles.boldsmallRedFontGotham,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    pinEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
