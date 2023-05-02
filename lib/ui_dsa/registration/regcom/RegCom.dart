import 'package:dhanvarsha/bloc_dsa/dropdwonbloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/ui_dsa/gold/appoint/Appoint.dart';
import 'package:dhanvarsha/ui_dsa/gold/loanrecept/LoanRec.dart';
import 'package:dhanvarsha/ui_dsa/gold/mainvisit/MainVisit.dart';
import 'package:dhanvarsha/ui_dsa/gold/visit/Visit.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/login/Login.dart';
import 'package:dhanvarsha/ui_dsa/registration/training/trainingscreen.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

import 'package:url_launcher/url_launcher.dart';

class RegCom extends StatefulWidget {
  const RegCom({Key? key, required BuildContext context}) : super(key: key);

  @override
  _RegComState createState() => _RegComState();
}

class _RegComState extends State<RegCom> {
  DropDownBloc dd = new DropDownBloc();
  launchURL() {
    print("Launch URL");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginNewScreen()),
        (Route<dynamic> route) => false);
    // const url =
    //     'https://play.google.com/store/apps/details?id=com.dhanvarsha.cpapp';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    DhanvarshaImages.regbck,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*GestureDetector(
                                child: Image.asset(
                                  DhanvarshaImages.bck,
                                  height: 20,
                                  width: 20,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),*/
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Image.asset(
                            DhanvarshaImages.dhanvarshalogo,
                            width: SizeConfig.screenWidth / 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Center(
                                child: Image.asset(
                                  DhanvarshaImages.regcom,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Registration Completed",
                                      style: TextStyle(
                                        fontSize:
                                            18 * SizeConfig.textScaleFactor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 0),
                                    child: Text(
                                      "Congratulations!",
                                      style: TextStyle(
                                        fontSize:
                                            14 * SizeConfig.textScaleFactor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 0, 40, 0),
                                    child: Text(
                                      "You are now a Dhanvarsha Partner.",
                                      style: TextStyle(
                                        fontSize:
                                            14 * SizeConfig.textScaleFactor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                            //   child: Text(
                            //     "Login App",
                            //     style: TextStyle(
                            //         fontSize: 16 * SizeConfig.textScaleFactor,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            //   child: Text(
                            //     "To get started.Login to Dhan Setu",
                            //     style: TextStyle(
                            //       fontSize: 14 * SizeConfig.textScaleFactor,
                            //     ),
                            //   ),
                            // ),
                            /*Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                "Please contact your onboarding agent.In case you do not receive the refund in 3 days.",
                                style: TextStyle(
                                  fontSize:
                                  14 * SizeConfig.textScaleFactor,

                                ),
                              ),
                            ),*/
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: GestureDetector(
                                  onTap: launchURL,
                                  /*onTap: () {
                                      //dd.getdropdowndata(context);

                                      */ /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegInProg(
                                              context: context,
                                            )),
                                      );*/ /*
                                    },*/
                                  child: Container(
                                    height: SizeConfig.screenHeight / 14,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: SizeConfig.screenWidth / 2,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: AppColors.buttonRed,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              18 * SizeConfig.textScaleFactor,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Your Business Card",
                  style: TextStyle(
                    fontSize: 18 * SizeConfig.textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(DhanvarshaImages.buscard),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                        child: Image.asset(
                          DhanvarshaImages.busscardname,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: Text(
                          "EMPANELLED AGENT",
                          style: TextStyle(
                              fontSize: 16 * SizeConfig.textScaleFactor,
                              color: AppColors.buttonRed),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          BasicData.fName + " " + BasicData.lName,
                          style: TextStyle(
                              fontSize: 18 * SizeConfig.textScaleFactor,
                              color: AppColors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "+91 "+BasicData.moninName,
                          style: TextStyle(
                              fontSize: 18 * SizeConfig.textScaleFactor,
                              color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Partner Center",
                  style: TextStyle(
                    fontSize: 18 * SizeConfig.textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        //onTap: _launchURL,
                        onTap: () {
                          Share.share(
                              'To Become a Dhanvarsha Partner, download the Dhan Setu App from the link https://bit.ly/3cjvdtw');
                        },

                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image.asset(
                                  DhanvarshaImages.Invite,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invite Friends',
                                      style: CustomTextStyles.boldMediumFont,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                DhanvarshaImages.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrainingScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image.asset(
                                  DhanvarshaImages.train,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Training Center',
                                      style: CustomTextStyles.boldMediumFont,
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      'Check videos for guidance',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                        fontSize:
                                            13 * SizeConfig.textScaleFactor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                DhanvarshaImages.left,
                              ),

                              /*Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.red.shade100,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Rs 1,000",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Poppins',
                                      fontSize: 14 * SizeConfig.textScaleFactor,
                                    ),
                                  ),
                                )
                            ),*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
