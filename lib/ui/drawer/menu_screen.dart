import 'dart:convert';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/profile/faqscreen.dart';
import 'package:dhanvarsha/ui/profile/gethelp.dart';
import 'package:dhanvarsha/ui/profile/profilescreen.dart';
import 'package:dhanvarsha/ui/profile/trainingscreen.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        isheaderShown: false, body: _getMobileBody(), context: context);
  }

  Widget _getMobileBody() {
    return Container(
      height: SizeConfig.screenHeight - SizeConfig.verticalviewinsects,
      child: Stack(
        children: [_getBG(), _getMenue()],
      ),
    );
  }

  Widget _getBG() {
    return Container(
      height: SizeConfig.screenHeight -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom -
          50,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(DhanvarshaImages.bgNew), fit: BoxFit.cover)),
    );
  }

  Widget _getMenue() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      DhanvarshaImages.right,
                      color: AppColors.white,
                      height: 15,
                      width: 15,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Settings",
                    style: CustomTextStyles.boldLargerWhiteFont,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            color: AppColors.white),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Personal Settings",
                                  style: CustomTextStyles.regularLargeFonts,
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  String data = await SharedPreferenceUtils
                                      .sharedPreferenceUtils
                                      .getLoginData();

                                  DSALoginResponseDTO loginResponseDTO =
                                      DSALoginResponseDTO.fromJson(
                                          jsonDecode(data));


                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                        loginResponseDTO: loginResponseDTO,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.contactNew,
                                          height: 35,
                                          width: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "My Profile",
                                            style: CustomTextStyles
                                                .boldLargeFonts2,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: Image.asset(
                                        DhanvarshaImages.left,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Share.share(
                                      'download the Dhan Setu App from the link https://bit.ly/3cjvdtw',
                                      subject:
                                      'To Become a Dhanvarsha Partner,');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.shareNew,
                                          height: 35,
                                          width: 35,
                                        ),
                                    Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Invite Friends",
                                                  style: CustomTextStyles
                                                      .boldLargeFonts2,
                                                ),
                                                // Text(
                                                //   "0 Friends referred",
                                                //   style: CustomTextStyles
                                                //       .regularSmallGreyFont,
                                                // ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                    Container(
                                      child: Image.asset(
                                        DhanvarshaImages.left,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: AppColors.buttondisabled,
                        height: 10,
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(color: AppColors.white),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Self Help Videos",
                                  style: CustomTextStyles.regularLargeFonts,
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TrainingScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                  Row(
                                        children: [
                                          Image.asset(
                                            DhanvarshaImages.refreshNew,
                                            height: 35,
                                            width: 35,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Training Center",
                                                    style: CustomTextStyles
                                                        .boldLargeFonts2,
                                                  ),
                                                  Text(
                                                    "0 Videos Watched",
                                                    style: CustomTextStyles
                                                        .regularSmallGreyFont,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    Container(
                                      child: Image.asset(
                                        DhanvarshaImages.left,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: AppColors.buttondisabled,
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(color: AppColors.white),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Support",
                                  style: CustomTextStyles.regularLargeFonts,
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GetHelp(),
                                    ),
                                  );
                                  // SuccessfulResponse.showScaffoldMessage(
                                  //     "Coming Soon !", context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.questNew,
                                          height: 35,
                                          width: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            "Need Help?",
                                            style: CustomTextStyles
                                                .boldLargeFonts2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Image.asset(
                                        DhanvarshaImages.left,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Divider(),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  // SuccessfulResponse.showScaffoldMessage(
                                  //     "Coming Soon !", context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FAQScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.notepadNew,
                                          height: 35,
                                          width: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "FAQs",
                                                style: CustomTextStyles
                                                    .boldLargeFonts2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Image.asset(
                                        DhanvarshaImages.left,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: AppColors.buttondisabled,
                        height: 10,
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(color: AppColors.white),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                // child: Text(
                                //   "Self Help Videos",
                                //   style: CustomTextStyles.regularLargeFonts,
                                // ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogUtils.showLogOut(
                                      context, DhanvarshaImages.otp);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.logoutNew,
                                          height: 35,
                                          width: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "LOG OUT",
                                                  style: CustomTextStyles
                                                      .boldMediumRedFont,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // Container(
                                    //   child: Image.asset(
                                    //     DhanvarshaImages.left,
                                    //     height: 20,
                                    //     width: 20,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHorizontalPaddingDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(),
    );
  }

  Widget _getProfileRow(
      {String title = "",
      String image = DhanvarshaImages.shareNew,
      String description = "",
      int index = 0}) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
            return;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
            return;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingScreen(),
              ),
            );
            return;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FAQScreen(),
              ),
            );
            return;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GetHelp(),
              ),
            );
            return;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  Image.asset(
                    image,
                    height: 30,
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          title,
                          style: CustomTextStyles.MediumBoldLightFont,
                        ),
                      ),
                      description != ""
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                description,
                                style: CustomTextStyles.boldsmallGreyFont,
                              ),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              DhanvarshaImages.left,
              color: AppColors.buttonRed,
              height: 25,
              width: 25,
            )
          ],
        ),
      ),
    );
  }
}
