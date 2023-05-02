import 'package:dhanvarsha/bloc_dsa/dropdwonbloc.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/gold/appoint/Appoint.dart';
import 'package:dhanvarsha/ui_dsa/gold/loanrecept/LoanRec.dart';
import 'package:dhanvarsha/ui_dsa/gold/mainvisit/MainVisit.dart';
import 'package:dhanvarsha/ui_dsa/gold/visit/Visit.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/login/Login.dart';
import 'package:dhanvarsha/ui_dsa/registration/reg/Rejistration.dart';
import 'package:dhanvarsha/ui_dsa/registration/training/trainingscreen.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class RegInProg extends StatefulWidget {
  const RegInProg({Key? key, required BuildContext context}) : super(key: key);

  @override
  _RegInProgState createState() => _RegInProgState();
}

class _RegInProgState extends State<RegInProg> {
  DropDownBloc dd = new DropDownBloc();
  _launchURL() async {
    const url = 'https://dhanvarsha.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
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
                      height: 200,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  DhanvarshaImages.inprog,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Registration In Progress",
                                      style: TextStyle(
                                          fontSize:
                                              18 * SizeConfig.textScaleFactor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'GothamMedium'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        "Add your bank account details",
                                        style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize:
                                                13 * SizeConfig.textScaleFactor,
                                            color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: GestureDetector(
                              onTap: () {
                                //dd.getdropdowndata(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Registration(
                                            context: context,
                                          )),
                                );
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegInProg(
                                        context: context,
                                      )),
                                );*/
                              },
                              child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                elevation: 10,
                                child: Container(
                                  height: SizeConfig.screenHeight / 14,
                                  width: SizeConfig.screenWidth / 2,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.red[600],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Center(
                                    child: Text(
                                      'ADD DETAILS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            18 * SizeConfig.textScaleFactor,
                                        fontFamily: 'GothamMedium',
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
                "Partner Center",
                style: TextStyle(
                    fontFamily: 'GothamMedium',
                  fontSize: 18 * SizeConfig.textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    GestureDetector(
                      //onTap: _launchURL,
                      onTap: () {
                        Share.share(
                            'To Become a Dhanvarsha Partner, download the Dhan Setu App from the link https://bit.ly/3cjvdtw');
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              DhanvarshaImages.left,
                            ),
                            // Container(
                            //     decoration: BoxDecoration(
                            //         shape: BoxShape.rectangle,
                            //         color: Colors.red.shade100,
                            //         borderRadius:
                            //         BorderRadius.all(Radius.circular(50))),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Text("Rs 1,000",
                            //         style: TextStyle(
                            //           color: Colors.red,
                            //           fontFamily: 'Poppins',
                            //           fontSize: 14 * SizeConfig.textScaleFactor,
                            //         ),
                            //       ),
                            //     )
                            // ),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
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
                                  ),
                                  Text(
                                    'Check videos for guidance',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gotham',
                                      fontSize: 13 * SizeConfig.textScaleFactor,
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
    );
  }
}
