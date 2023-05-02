import 'dart:convert';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String title;
  final DSALoginResponseDTO? loginResponseDTO;

  ProfileScreen({Key? key, this.title = "My Profile", this.loginResponseDTO})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "",
      type: false,
      context: context,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: SizeConfig.screenWidth,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getProfileCard(),
              // _getBuisinessDetailsCard(),
              // _getBankDetailsCard()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProfileCard() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "My Profile",
              style: CustomTextStyles.boldVeryLargerFont,
            ),
          ),
          _getDVCard(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Business Details",
              style: CustomTextStyles.boldLargeFonts,
            ),
          ),
          _getBusinessDetails(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Bank Details",
              style: CustomTextStyles.boldLargeFonts,
            ),
          ),
          _getBankDetails()
        ],
      ),
    );
  }

  Widget _getBusinessDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Business Name",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBusinessDetailsDTO!.businessName!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Business Type",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBusinessDetailsDTO!.businessType!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Size Of Shop",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBusinessDetailsDTO!.sizeOfShop!+" Sq. Ft",
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monthly Income",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  "Rs "+this
                      .loginResponseDTO!
                      .loginBusinessDetailsDTO!
                      .monthlyIncome!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getBankDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account Number",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBankDetailsDTO!.accountNumber!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bank Name",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBankDetailsDTO!.bankName!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "IFSC CODE",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBankDetailsDTO!.iFSCCode!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: CustomTextStyles.regularMediumFont,
                ),
                Text(
                  this.loginResponseDTO!.loginBankDetailsDTO!.name!,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getDVCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Your Business Card",
              style: CustomTextStyles.boldLargeFonts,
            ),
          ),
          Container(
              width: SizeConfig.screenWidth - 30,
              height: 200,
              margin: EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(DhanvarshaImages.dvnewcard),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      DhanvarshaImages.dhansetuNewCard,
                      height: 40,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EMPANELLED AGENT",
                          style: CustomTextStyles.boldlargerRedFont,
                        ),
                        Text(
                          this.loginResponseDTO!.name!,
                          style: CustomTextStyles.boldLargerWhiteFont,
                        ),
                        Text(
                        "+91"+" "+this.loginResponseDTO!.mobileNumber!,
                          style: CustomTextStyles.boldLargerWhiteFont,
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
  //
  // getDashboardData() async {
  //   String data =
  //       await SharedPreferenceUtils.sharedPreferenceUtils.getLoginData();
  //
  //   loginResponseDTO = DSALoginResponseDTO.fromJson(jsonDecode(data));
  //
  //   // print("Dashboard Data is..");
  //   // print(jsonEncode(loginResponseDTO));
  //
  //   // _getDashboarddata();
  // }

  Widget _getBuisinessDetailsCard() {
    return Expanded(
        flex: 10,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "BUISINESS DETAILS",
                  style: CustomTextStyles.SmallBoldFont,
                ),
              ),
              Expanded(
                  child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Buisiness Name",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "XYZ",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Buisiness Type",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "Private",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Size Of Shop",
                              style: CustomTextStyles.VerySmallBoldLightFont,
                            ),
                            Text(
                              "1000 Sq.Ft",
                              style: CustomTextStyles.VerySmallBoldFont,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monthly Income",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "Rs . 40,000",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  Widget _getBankDetailsCard() {
    return Expanded(
        flex: 10,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "BANK DETAILS",
                  style: CustomTextStyles.SmallBoldFont,
                ),
              ),
              Expanded(
                  child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Number",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "123456789",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bank Name",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "ICICI Bank",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IFSC Code",
                              style: CustomTextStyles.VerySmallBoldLightFont,
                            ),
                            Text(
                              "ICIC000593",
                              style: CustomTextStyles.VerySmallBoldFont,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: CustomTextStyles.VerySmallBoldLightFont,
                          ),
                          Text(
                            "Prakash Vishwanathan",
                            style: CustomTextStyles.VerySmallBoldFont,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
