import 'package:dhanvarsha/bloc_dsa/otpservicebloc.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/terms/Terms.dart';
import 'package:dhanvarsha/ui_dsa/registration/terms/privacy_policy.dart';
import 'package:dhanvarsha/ui_dsa/registration/terms/terms_coditions.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/mock_handler/data.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required BuildContext context}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameEditingController = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isValidatePressed = false;
  OTPServiceBloc otp1 = new OTPServiceBloc();

  String phoneNumber = '';
  bool validnumber = true;
  Color buttoncolor = AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgNew,
          body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.bgNew, AppColors.bgNew],
              )),
              padding: EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          DhanvarshaImages.dhanlogo4,
                          height: 50,
                          width: 100,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Center(
                          child: Image.asset(
                            DhanvarshaImages.log,
                            height: 120,
                            width: 120,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Enter Mobile Number",
                              style: CustomTextStyles.bold24LargeFonts,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Enter your 10-digit personal mobile number linked with Aadhaar. Your number is your username.',
                              style: CustomTextStyles.regularMediumGreyFont,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: validnumber
                                        ? BoxDecorationStyles
                                            .outTextFieldBoxDecoration
                                        : BoxDecorationStyles
                                            .outTextFieldBoxErrorDecoration,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          DhanvarshaImages.flag,
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '+91 | ',
                                            style: CustomTextStyles
                                                .regularMediumFont,
                                        ),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: TextFormField(
                                            onChanged: (text) {
                                              print("on Change Text Called");
                                              setState(() {
                                                phoneNumber = text;
                                              });

                                              if (phoneNumber.length == 10) {
                                                setState(() {
                                                  validnumber = true;
                                                  buttoncolor =
                                                      AppColors.buttonRed;
                                                  buttontextcolor =
                                                      Colors.white;
                                                });
                                              } else {
                                                buttoncolor =
                                                    Colors.grey.shade300;
                                                buttontextcolor =
                                                    Colors.grey.shade600;
                                              }

                                              print("on Change $phoneNumber");
                                            },
                                            initialValue: phoneNumber,
                                            maxLines: 1,
                                            keyboardType: TextInputType.number,
                                            style: CustomTextStyles
                                                .regularMediumFont,
                                            cursorColor: AppColors.black,
                                            decoration: InputDecoration(
                                              // isDense: true,// this will remove the default content padding
                                              hintText: "Enter mobile no.",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 3),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (!validnumber)
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 0),
                                          child: Text(
                                            'Enter your 10 digit Mobile No registered with Dhanvarsha.',
                                            style: TextStyle(
                                                color: AppColors.buttonRed),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'By continuing, you agree to our ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'GothamMedium',
                                          fontSize: 12),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndConditions(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Terms of Use',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'GothamMedium',
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Text(
                                      ' and',
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Gotham',
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PrivacyPolicy(),
                                          fullscreenDialog: true),
                                    );
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      height: 1.25,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                                                    fontFamily: 'GothamMedium',
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () async {
                      if (phoneNumber.length == 10) {
                        setState(() {
                          validnumber = true;
                        });
                      } else {
                        setState(() {
                          validnumber = false;
                        });
                      }
                      // var a = 'hello';
                      // print(a);
                      // var b =await EncryptionUtils.getEncryptedText(a.toString());
                      // print('this is b $b');
                      // var c = await EncryptionUtils.decryptString(b.toString());
                      // print(c);
                      if (validnumber) {
                        otp1.getOtp(phoneNumber, context);
                      } else {}

                      // print('isopt'+otp1.isOtp.toString());
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OTP(
                      //           context: context,
                      //         )),
                      //   );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        elevation: 10,
                        child: Container(
                          height: SizeConfig.screenHeight / 14,
                          width: SizeConfig.screenWidth,
                          // margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: buttoncolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                color: buttontextcolor,
                                fontSize: 18 * SizeConfig.textScaleFactor,
                                fontFamily: 'GothamMedium',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CustomButton(
                  //   onButtonPressed: () {},
                  //   title: "SUBMIT",
                  // ),
                ],
              ),
            ),
          ),
          // SingleChildScrollView(
          //   child: Container(
          //     decoration: new BoxDecoration(
          //         gradient: new LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [AppColors.gra1, AppColors.gra2],
          //     )),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               /*GestureDetector(
          //                 child: Image.asset(
          //                   DhanvarshaImages.bck,
          //                   height: 20,
          //                   width: 20,
          //                 ),
          //                 onTap: () {
          //                   Navigator.pop(context);
          //                 },
          //               ),*/
          //               Padding(
          //                 padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          //                 child: Image.asset(
          //                   DhanvarshaImages.dhanvarshalogo,
          //                   width: SizeConfig.screenWidth / 2.5,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          //           child: Center(
          //             child: Image.asset(
          //               DhanvarshaImages.log,
          //             ),
          //           ),
          //         ),
          //
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(20, 50, 0, 10),
          //           child: Text(
          //             'Enter Mobile Number',
          //             style: CustomTextStyles.bold24LargeFonts,
          //           ),
          //         ),
          //
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(20, 0, 30, 10),
          //           child: Text(
          //             'Enter your 10-digit personal mobile number linked with Aadhaar. Your number is your username.',
          //             style: CustomTextStyles.regularMediumGreyFont,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         // Container(
          //         //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //         //   child: DVTextField(
          //         //     controller: nameEditingController,
          //         //     outTextFieldDecoration:
          //         //         BoxDecorationStyles.outTextFieldBoxDecoration,
          //         //     inputDecoration:
          //         //         InputDecorationStyles.inputDecorationTextField,
          //         //     title: "Mobile Number",
          //         //     hintText: "+91",
          //         //     errorText: "Type Your Query Here",
          //         //     maxLine: 1,
          //         //     ktype: TextInputType.number,
          //         //     isValidatePressed: isValidatePressed,
          //         //   ),
          //         // ),
          //         Container(
          //           width: double.infinity,
          //           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //           child: Container(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 10, vertical: 10),
          //                   decoration: validnumber
          //                       ? BoxDecorationStyles.outTextFieldBoxDecoration
          //                       : BoxDecorationStyles
          //                           .outTextFieldBoxErrorDecoration,
          //                   child: Row(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Image.asset(
          //                         DhanvarshaImages.flag,
          //                         height: 30,
          //                         width: 30,
          //                       ),
          //                       SizedBox(width: 10),
          //                       Text(
          //                         '+91 | ',
          //                         style: TextStyle(fontSize: 17),
          //                       ),
          //                       SizedBox(width: 20),
          //                       Expanded(
          //                         child: TextFormField(
          //                           onChanged: (text) {
          //                             print("on Change Text Called");
          //                             setState(() {
          //                               phoneNumber = text;
          //                             });
          //
          //                             if (phoneNumber.length == 10) {
          //                               setState(() {
          //                                 validnumber = true;
          //                                 buttoncolor = Colors.red;
          //                                 buttontextcolor = Colors.white;
          //                               });
          //                             } else {
          //                               buttoncolor = Colors.grey.shade300;
          //                               buttontextcolor = Colors.grey.shade600;
          //                             }
          //
          //                             print("on Change $phoneNumber");
          //                           },
          //                           initialValue: phoneNumber,
          //                           maxLines: 1,
          //                           keyboardType: TextInputType.number,
          //                           style: CustomTextStyles.regularMediumFont,
          //                           cursorColor: AppColors.black,
          //                           decoration: InputDecoration(
          //                             // isDense: true,// this will remove the default content padding
          //                             hintText: "Enter mobile no.",
          //                             hintStyle: TextStyle(color: Colors.grey),
          //                             contentPadding: EdgeInsets.symmetric(
          //                                 horizontal: 0, vertical: 3),
          //                             border: InputBorder.none,
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 (!validnumber)
          //                     ? Padding(
          //                         padding:
          //                             const EdgeInsets.fromLTRB(0, 5, 0, 0),
          //                         child: Text(
          //                           'invalid mobile number',
          //                           style: TextStyle(color: Colors.red),
          //                         ),
          //                       )
          //                     : Container(),
          //               ],
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           height: SizeConfig.screenHeight / 10,
          //         ),

          //         SizedBox(
          //           height: 20,
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(20, 00, 20, 0),
          //           child: GestureDetector(
          //             onTap: () async {
          //               if (phoneNumber.length == 10) {
          //                 setState(() {
          //                   validnumber = true;
          //                 });
          //               } else {
          //                 setState(() {
          //                   validnumber = false;
          //                 });
          //               }
          //               // var a = 'hello';
          //               // print(a);
          //               // var b =await EncryptionUtils.getEncryptedText(a.toString());
          //               // print('this is b $b');
          //               // var c = await EncryptionUtils.decryptString(b.toString());
          //               // print(c);
          //               if (validnumber) {
          //                 otp1.getOtp(phoneNumber, context);
          //               } else {}
          //
          //               // print('isopt'+otp1.isOtp.toString());
          //               //   Navigator.push(
          //               //     context,
          //               //     MaterialPageRoute(
          //               //         builder: (context) => OTP(
          //               //           context: context,
          //               //         )),
          //               //   );
          //             },
          //             child: Container(
          //               height: SizeConfig.screenHeight / 14,
          //               width: SizeConfig.screenWidth,
          //               margin: EdgeInsets.symmetric(vertical: 10),
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.rectangle,
          //                   color: buttoncolor,
          //                   borderRadius:
          //                       BorderRadius.all(Radius.circular(50))),
          //               child: Center(
          //                 child: Text(
          //                   'CONTINUE',
          //                   style: TextStyle(
          //                     color: buttontextcolor,
          //                     fontSize: 18 * SizeConfig.textScaleFactor,
          //                     fontFamily: 'Poppins',
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         // Container(
          //         //   child: CustomButton(
          //         //     onButtonPressed: () {
          //         //       Navigator.push(
          //         //         context,
          //         //         MaterialPageRoute(builder: (context) => OTP(context: context,)),
          //         //       );
          //         //     },
          //         //     title: "CONTINUE",
          //         //     boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
          DhanvarshaLoader(),
        ],
      )),
    );
  }
}
