import 'package:dhanvarsha/bloc_dsa/dropdwonbloc.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui_dsa/gold/appoint/Appoint.dart';
import 'package:dhanvarsha/ui_dsa/gold/loanrecept/LoanRec.dart';
import 'package:dhanvarsha/ui_dsa/gold/mainvisit/MainVisit.dart';
import 'package:dhanvarsha/ui_dsa/gold/visit/Visit.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/login/Login.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRej extends StatefulWidget {
  const AppRej({Key? key, required BuildContext context}) : super(key: key);

  @override
  _AppRejState createState() => _AppRejState();
}

class _AppRejState extends State<AppRej> {
  DropDownBloc dd = new DropDownBloc();
  launchMailto() async {


    final Uri params = Uri(
      scheme: 'mailto',
      path: 'customerqueries@dfltech.co',
      query: 'subject=DhanVarsha B2B App', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      SuccessfulResponse.showScaffoldMessage("Not able to open", context);
      throw 'Could not launch $url';
    }
    // final mailtoLink = Mailto(
    //   to: ['customerqueries@dfltech.co'],
    //   subject:"",
    //   body: '',
    // );
    // // Convert the Mailto instance into a string.
    // // Use either Dart's string interpolation
    // // or the toString() method.
    // await launch('$mailtoLink');
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
                      height: SizeConfig.screenHeight/1.7,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Center(
                              child: Image.asset(
                                DhanvarshaImages.reji,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Application Rejected",
                                  style: TextStyle(
                                    fontSize:
                                    18 * SizeConfig.textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'We are sorry to inform you that your application to be a ',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: const <TextSpan>[
                                        TextSpan(text: 'Dhanvarsha Partner ', style: TextStyle(fontWeight: FontWeight.bold)),
                                        TextSpan(text: 'is rejected as one or more criteria is not fulfilled'),
                                      ],
                                    ),
                                  ),

                                )
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                          //   child: Text(
                          //     "Refund Initiated",
                          //     style: TextStyle(
                          //       fontSize:
                          //       16 * SizeConfig.textScaleFactor,
                          //       fontWeight: FontWeight.bold
                          //
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          //   child:
                          //   RichText(
                          //     text: TextSpan(
                          //       text: 'A refund of ',
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //       ),
                          //       children: const <TextSpan>[
                          //         TextSpan(text: 'Rs.5,109 ', style: TextStyle(fontWeight: FontWeight.bold)),
                          //         TextSpan(text: 'has been already initiated and you will receive the refund within '),
                          //         TextSpan(text: '3 working days.', style: TextStyle(fontWeight: FontWeight.bold)),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          //   child:
                          //   RichText(
                          //     text: TextSpan(
                          //       text: 'Please contact your onboarding agent,in case you do not receive the refund in ',
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //       ),
                          //       children: const <TextSpan>[
                          //         TextSpan(text: '3 days.', style: TextStyle(fontWeight: FontWeight.bold)),
                          //       ],
                          //     ),
                          //   ),
                          //
                          //
                          //
                          //
                          //   /*Text(
                          //     "Please contact your onboarding agent,in case you do not receive the refund in 3 days.",
                          //     style: TextStyle(
                          //       fontSize:
                          //       14 * SizeConfig.textScaleFactor,
                          //
                          //     ),
                          //   ),*/
                          // ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  //dd.getdropdowndata(context);
                                  launchMailto();
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegInProg(
                                          context: context,
                                        )),
                                  );*/
                                },
                                child: Container(
                                  height: SizeConfig.screenHeight / 14,
                                  width: SizeConfig.screenWidth / 2,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.red[600],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                                  child: Center(
                                    child: Text(
                                      'WRITE TO US',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18 * SizeConfig.textScaleFactor,
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


          ],
        ),
      ),
    );
  }
}
