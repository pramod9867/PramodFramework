
import 'dart:io';

import 'package:dhanvarsha/bloc/versionbloc.dart';
import 'package:dhanvarsha/constants/index.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/registration_new/login_number.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton_v1.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:super_tooltip/super_tooltip.dart';

class LoginNewScreen extends StatefulWidget {
  const LoginNewScreen({Key? key}) : super(key: key);

  @override
  _LoginNewScreenState createState() => _LoginNewScreenState();
}

class _LoginNewScreenState extends State<LoginNewScreen> {
  int i = 0;
  VersionBloc? versionBloc;
  @override
  void initState() {


    versionBloc= VersionBloc();
    versionBloc!.checkAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp),
        ),
        isheaderShown: false,
        body: Container(
          child: Container(
            alignment: Alignment.center,
            // color: AppColors.buttonRed,
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical * 25,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          DhanvarshaImages.dhanSetu,
                          height: SizeConfig.blockSizeHorizontal * 35,
                          width: SizeConfig.blockSizeHorizontal * 35,
                          fit: BoxFit.contain,
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(

                          image: DecorationImage(
                              image: AssetImage(_getImage(i)),
                              fit: BoxFit.fill)),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getTitleNew(i)[0],
                                style: CustomTextStyles.boldLargerWhiteFontGotham,
                              ),
                           i!=2?   Text(
                                _getTitleNew(i)[1],
                                style: CustomTextStyles.boldLargerWhiteFontGotham,
                              ):Container(),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _getTitleNew(i)[2],
                                style: CustomTextStyles.regularWhiteMediumFontGotham,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: i < 2
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                i = 2;
                                              });
                                            },
                                            child: Text(
                                              "Skip",
                                              style: CustomTextStyles
                                                  .regularWhiteMediumFontGotham,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              _getDottedContainer(i, 0),
                                              _getDottedContainer(i, 1),
                                              _getDottedContainer(i, 2),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (i >= 2) {
                                              } else {
                                                setState(() {
                                                  i += 1;
                                                });
                                              }
                                            },
                                            child: Container(
                                              child: Image.asset(
                                                DhanvarshaImages.arrowimg,
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : CustomButton_v1(
                                        onButtonPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginNumberNew(),
                                              ));

                                        },
                                        title: "LOGIN",
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        context: context);
  }

  String _getImage(int index) {
    switch (index) {
      case 0:
        return DhanvarshaImages.img3;
      case 1:
        return DhanvarshaImages.img2;
      case 2:
        return DhanvarshaImages.img1;
    }
    return "";
  }

  List<String> _getTitleText(int index) {
    List<String> arrayOfWelcome = [
      "Welcome to",
      "Dhan Setu!",
      "As an empaneled Dhanvarsha\nPartner,get a chance to unlock \nunlimited earning"
    ];

    List<String> easysimpleProcess = [
      "Easy & Simple",
      "Online Process",
      "Track all applications, payments\nand earning through the app"
    ];

    List<String> improveyourearning = [
      "Improve your",
      "earnings, daily!",
      "Become our empaneled partner\nand earn maximum payouts on\nmonthly basis"
    ];

    switch (index) {
      case 0:
        return arrayOfWelcome;
      case 1:
        return easysimpleProcess;
      case 2:
        return improveyourearning;
    }
    return [];
  }





  List<String> _getTitleNew(int index) {
    List<String> arrayOfWelcome = [
      "Built for your",
      "ease",
      "Easy digital onboarding, application, documentation, and loan disbursement process"
    ];

    List<String> easysimpleProcess = [
      "Track Cases",
      "on the go",
      "Get real time status of applications and disbursements"
    ];

    List<String> improveyourearning = [
      "Lucrative Pay-outs",
      "Pay-outs",
      "Track your pay-out on a comprehensive dashboard"
    ];

    switch (index) {
      case 0:
        return arrayOfWelcome;
      case 1:
        return easysimpleProcess;
      case 2:
        return improveyourearning;
    }
    return [];
  }


  _getDottedContainer(int index, int original) {
    return Container(
      height: index == original ? 15 : 7,
      width: index == original ? 15 : 7,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: index == original ? AppColors.white : AppColors.lighterGrey,
          borderRadius: BorderRadius.circular(
            index == original ? 7.5 : 3.5,
          )),
    );
  }
}
