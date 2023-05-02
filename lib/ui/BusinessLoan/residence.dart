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
import 'package:dhanvarsha/widgets/Buttons/CustomBtnBlackborder.dart';
import 'package:dhanvarsha/widgets/Buttons/custbtnwgreyoutline.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/material.dart';

class residence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _residence();
}

class _residence extends State<residence> {
  bool OwnedPressed1=false;
  bool OwnedPressed2=false;
  bool RentedPressed1=false;
  bool RentedPressed2=false;
  bool YesPressed=false;
  bool noPressed=false;

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
                    _getTitleCompoenent("Is Applicant /Co-applicant's current Residence"),
                   _getButtonCompoenent(),
                  _getTitleCompoenent("Is Current Business Place"),
                  _getButtonCompoenentPlace(),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                  child: Divider(),
                  ),
                  _getOwnProComponent()




                ],
              ),

      )
          ],
        ),
      ),
    );
  }

  Widget _getTitleCompoenent(String title) {
    return Container(
      margin: EdgeInsets.only(top: 20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(
            title,
              overflow: TextOverflow.clip,
              style: CustomTextStyles.boldSubtitleLargeFonts,
            maxLines:2
          )),
        ],
      ),
    );
  }

  Widget _getButtonCompoenent() {
    return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: CustomBtnBlackborder(
                      onButtonPressed: () {
                        setState(() {
                           OwnedPressed1=!OwnedPressed1;
                        });
                        print(OwnedPressed1);
                          },
                      title: "Owned",
                      widthScale: 0.45,
                      Pressedflag:OwnedPressed1,
                      boxDecoration: BoxDecorationStyles.outButtonOfBox,
                    ),
                  ),

                  Container(
                    child: CustomBtnBlackborder(
                      onButtonPressed: () {
                        setState(() {
                        RentedPressed1=!RentedPressed1;
                        });
                      },
                      title: "Rented",
                      widthScale: 0.45,
                      Pressedflag:RentedPressed1,
                      boxDecoration: BoxDecorationStyles.outButtonOfBox,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
  Widget _getButtonCompoenentPlace() {
    return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: CustomBtnBlackborder(
                      onButtonPressed: () {
                        setState(() {
                           OwnedPressed2=!OwnedPressed2;
                        });
                          },
                      title: "Owned",
                      widthScale: 0.45,
                      Pressedflag:OwnedPressed2,
                      boxDecoration: BoxDecorationStyles.outButtonOfBox,
                    ),
                  ),

                  Container(

                    child: CustomBtnBlackborder(
                      onButtonPressed: () {
                        setState(() {
                        RentedPressed2=!RentedPressed2;

                        });
                      },
                      title: "Rented",
                      widthScale: 0.45,
                      Pressedflag:RentedPressed2,
                      boxDecoration: BoxDecorationStyles.outButtonOfBox,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _getOwnProComponent() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Text(
              "Does the customer own the property elsewhere? ",
              style: CustomTextStyles.regularSmallGreyFont,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: CustomBtnBlackborder(
                        onButtonPressed: () {
                          setState(() {
                            YesPressed=!YesPressed;
                          });
                        },
                        title: "Yes",
                        widthScale: 0.45,
                        Pressedflag: YesPressed
                        ,
                        boxDecoration: BoxDecorationStyles.outButtonOfBox,
                      ),
                    ),

                    Container(

                      child: CustomBtnBlackborder(
                        onButtonPressed: () {
                          setState(() {
                            noPressed=!noPressed;

                          });
                        },
                        title: "No",
                        widthScale: 0.45,
                        Pressedflag:noPressed,
                        boxDecoration: BoxDecorationStyles.outButtonOfBox,
                      ),
                    )
                  ]
              ),
            )
          ],
        ));
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
    // TODO: implement dispose
    super.dispose();
  }
}
