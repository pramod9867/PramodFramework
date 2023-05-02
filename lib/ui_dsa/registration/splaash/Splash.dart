import 'package:dhanvarsha/bloc_dsa/dropdwonbloc.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/gold/appoint/Appoint.dart';
import 'package:dhanvarsha/ui_dsa/gold/loanrecept/LoanRec.dart';
import 'package:dhanvarsha/ui_dsa/gold/mainvisit/MainVisit.dart';
import 'package:dhanvarsha/ui_dsa/gold/visit/Visit.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/apprej/AppRej.dart';
import 'package:dhanvarsha/ui_dsa/registration/appsub/AppSub.dart';
import 'package:dhanvarsha/ui_dsa/registration/login/Login.dart';
import 'package:dhanvarsha/ui_dsa/registration/regcom/RegCom.dart';
import 'package:dhanvarsha/ui_dsa/registration/reginprog/RegInProg.dart';
import 'package:dhanvarsha/ui_dsa/registration/training/trainingscreen.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({Key? key, required BuildContext context}) : super(key: key);

  @override
  _SpalshState createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  DropDownBloc dd = new DropDownBloc();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgNew,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    alignment: Alignment.center,
                    child: Image.asset(DhanvarshaImages.dhanlogo4),
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome to the",
                          style: CustomTextStyles.boldHeaderLargeFontsNewOne,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "future of",
                              style: CustomTextStyles.boldHeaderLargeFontsNewOne,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              " Loans",
                              style: CustomTextStyles.boldHeaderLargeFontsNewOne2,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          'Become a Dhanvarsha Partner and unlock endless earning!',
                          style: CustomTextStyles.regularMediumGreyFont,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              DhanvarshaImages.sp1,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2,346 Loan Disbursed',
                                  style: CustomTextStyles.boldMediumFont,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              DhanvarshaImages.sp2,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1,908 Happy Agents',
                                  style: CustomTextStyles.boldMediumFont,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      dd.getdropdowndata(context);

                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainVisit(
                                context: context,
                              )),
                        );*/

                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    //builder: (context) => PaymentScreen(
                                    context: context,
                                  )),
                        );*/
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        elevation: 10,
                        child: Container(
                          height: SizeConfig.screenHeight / 14,
                          width: SizeConfig.screenWidth,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.buttonRed,
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18 * SizeConfig.textScaleFactor,
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

            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20, 00, 20, 10),
            //         child: GestureDetector(
            //           onTap: () {
            //             dd.getdropdowndata(context);
            //
            //             /*Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => MainVisit(
            //                     context: context,
            //                   )),
            //             );*/
            //
            //
            //             /* Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => Login(
            //                         //builder: (context) => PaymentScreen(
            //                         context: context,
            //                       )),
            //             );*/
            //           },
            //           child: Container(
            //             height: SizeConfig.screenHeight / 14,
            //             width: SizeConfig.screenWidth,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.rectangle,
            //                 color: Colors.red[600],
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(50))),
            //             child: Center(
            //               child: Text(
            //                 'GET STARTED',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18 * SizeConfig.textScaleFactor,
            //                   fontFamily: 'Poppins',
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20, 00, 20, 10),
            //         child: GestureDetector(
            //           onTap: () {
            //             dd.getdropdowndata(context);
            //
            //             /*Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => MainVisit(
            //                     context: context,
            //                   )),
            //             );*/
            //
            //
            //             /* Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => Login(
            //                         //builder: (context) => PaymentScreen(
            //                         context: context,
            //                       )),
            //             );*/
            //           },
            //           child: Container(
            //             height: SizeConfig.screenHeight / 14,
            //             width: SizeConfig.screenWidth,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.rectangle,
            //                 color: Colors.red[600],
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(50))),
            //             child: Center(
            //               child: Text(
            //                 'GET STARTED',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18 * SizeConfig.textScaleFactor,
            //                   fontFamily: 'Poppins',
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            //           child: Image.asset(
            //             DhanvarshaImages.dhanlogo4,
            //             height: SizeConfig.screenWidth * 0.5,
            //             width: SizeConfig.screenWidth * 0.5,
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            //         child: Text(
            //           'Welcome to the future of Loans',
            //           style: CustomTextStyles.boldwelLargeFonts,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            //         child: Text(
            //           'Become a Dhanvarsha Partner and unlock endless earning!',
            //           style: CustomTextStyles.regularMediumGreyFont,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),

            //       Spacer(),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20, 00, 20, 10),
            //         child: GestureDetector(
            //           onTap: () {
            //             dd.getdropdowndata(context);
            //
            //             /*Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => MainVisit(
            //                     context: context,
            //                   )),
            //             );*/
            //
            //
            //             /* Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => Login(
            //                         //builder: (context) => PaymentScreen(
            //                         context: context,
            //                       )),
            //             );*/
            //           },
            //           child: Container(
            //             height: SizeConfig.screenHeight / 14,
            //             width: SizeConfig.screenWidth,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.rectangle,
            //                 color: Colors.red[600],
            //                 borderRadius:
            //                     BorderRadius.all(Radius.circular(50))),
            //             child: Center(
            //               child: Text(
            //                 'GET STARTED',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18 * SizeConfig.textScaleFactor,
            //                   fontFamily: 'Poppins',
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            DhanvarshaLoader()
          ],
        ),
      ),
    );
  }
}
