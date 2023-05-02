import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoldLoanStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoldLoanStatusState();
}

class _GoldLoanStatusState extends State<GoldLoanStatus> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        title: "Gold Loan Status",
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _getTitleCompoenent(),
                _getDhanVarshaCard(),
                _getBuisinessDetails(),
                _getGoldDetails(),
                _getAppointmentDetails(),
                Text(
                  "SHARE WITH CUSTOMER",
                  style: CustomTextStyles.boldlargerRedFont,
                ),
                Divider(),
                _getButtonCompoenets()
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getTitleCompoenent() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pramod Sirasikar",
            style: CustomTextStyles.boldLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getDhanVarshaCard() {
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.25,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 40,
              child: Container(
                width: double.infinity,
                color: AppColors.lighBox,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status : ",
                          style: CustomTextStyles.boldMediumFont,
                        ),
                        Text(
                          "Application",
                          style: CustomTextStyles.boldMediumFont,
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Date :",
                            style: CustomTextStyles.regularMediumFont,
                          ),
                          Text(
                            " 5 July 2021",
                            style: CustomTextStyles.regularMediumGreyFont1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Last Updated :",
                            style: CustomTextStyles.regularMediumFont,
                          ),
                          Text(
                            " 10 July 2021",
                            style: CustomTextStyles.regularMediumGreyFont1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Expires In :",
                            style: CustomTextStyles.regularMediumFont,
                          ),
                          Text(
                            " 4 Days ",
                            style: CustomTextStyles.regularMediumGreyFont1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGoldDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Gold Details",
              style: CustomTextStyles.regularLargeGreyFont,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Gold Carrot",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "24K",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Net Weight",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "24,000",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getBuisinessDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Loan Details",
              style: CustomTextStyles.regularLargeGreyFont,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Loan Amount",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Rs . 10,000",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Employment Type",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Self Employed",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Mobile Number",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "+91 9867106967",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("PIN", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "560006",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("DOB", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "April 9, 1992",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getAppointmentDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Appointment Details",
              style: CustomTextStyles.regularLargeGreyFont,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: SizeConfig.screenHeight * 0.2,
            width: SizeConfig.screenHeight - 30,
            decoration: BoxDecorationStyles.outButtonOfBox,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Airoli Beach",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                          Text(
                            "Plot No 1, Mataji Nirmalabhai Marg, Belapur CBD,Mumbai -400037",
                            style: CustomTextStyles.regularMediumGreyFont1,
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "4.8 KM",
                          style: CustomTextStyles.boldLargeFonts,
                        ),
                        // Image.asset(
                        //   DhanvarshaImages.i,
                        //   height: 25,
                        //   width: 25,
                        // ),
                        Text(
                          "Directions",
                          style: CustomTextStyles.boldsmallRedFontGotham,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getButtonCompoenets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            "For Smooth and prompt loan disbursal process upload customer's documents",
            style: CustomTextStyles.regularMediumGreyFont1,
          ),
        ),
        CustomButton(onButtonPressed: () {},title: "Continue",)
      ],
    );
  }
}
