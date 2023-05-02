import 'package:dhanvarsha/bloc_dsa/confirmotpbloc.dart';
import 'package:dhanvarsha/bloc_dsa/otpservicebloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/terms/privacy_policy.dart';
import 'package:dhanvarsha/ui_dsa/registration/terms/terms_coditions.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key, required BuildContext context}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  GlobalKey key = GlobalKey();
  TextEditingController nameEditingController = new TextEditingController();
  late TextEditingController pinEditingController =
      TextEditingController(text: BasicData.otp);
  var isValidatePressed = false;
  ConfirmOTPBloc confirmotp = new ConfirmOTPBloc();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String otp = BasicData.otp;
  OTPServiceBloc otp1 = new OTPServiceBloc();
  ValueNotifier<bool>? isVerified;
  //String phone = '';

  // getOTPinfo() async {
  //   final SharedPreferences prefs = await _prefs;
  //   phone = prefs.getString('phone')!;
  //   otp = prefs.getString('otp')!;
  //   print('from shared pred phone $phone');
  //   print('from shared pred otp $otp');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVerified = ValueNotifier(!pinEditingController.text.isEmpty);
    pinEditingController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    if (!pinEditingController.text.isEmpty) {
      print("Here");
      isVerified?.value = true;
      isVerified?.notifyListeners();
    } else {
      print("Here 1");
      isVerified?.value = false;
      isVerified?.notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinEditingController.removeListener(_printLatestValue);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.bgNew, AppColors.bgNew],
                )),
                constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
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
                          padding: EdgeInsets.symmetric(vertical: 35),
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
                                'Enter One Time \nPassword',
                                style: CustomTextStyles.bold24LargeFonts,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: RichText(
                                text: new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text:
                                            'Enter 4-digit code received on your mobile number',
                                        style: CustomTextStyles
                                            .regularMediumGreyFont),
                                    new TextSpan(
                                      text: ' +91 ${BasicData.phone}',
                                      style: CustomTextStyles.boldMediumFont,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: PinInputTextField(
                                controller: pinEditingController,
                                key: key,
                                onSubmit: (text) {},
                                pinLength: 4,
                                autoFocus: false,
                                decoration: BoxLooseDecoration(
                                  radius: Radius.circular(5),
                                  strokeColorBuilder: PinListenColorBuilder(
                                      Colors.black, Colors.grey),
                                  bgColorBuilder: PinListenColorBuilder(
                                      Colors.white, Colors.white),
                                  strokeWidth: 1,
                                  gapSpace: 10,
                                  obscureStyle: ObscureStyle(
                                    isTextObscure: false,
                                  ),
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
                                            fontFamily: 'Poppins',
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
                                              fontFamily: 'Poppins',
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
                                            fontFamily: 'Poppins',
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicy(),
                                            fullscreenDialog: true),
                                      );
                                    },
                                    child: Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         child: Text(
                            //           'Enter 4-digit code received on your mobile number',
                            //           style: CustomTextStyles
                            //               .regularMediumGreyFont,
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       child: Text(
                            //         '+91 ${BasicData.phone}',
                            //         style:
                            //             CustomTextStyles.regularMediumGreyFont,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   margin: EdgeInsets.symmetric(vertical: 20),
                            //   child: Container(
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Container(
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: 5, horizontal: 5),
                            //           decoration: validnumber
                            //               ? BoxDecorationStyles
                            //               .outTextFieldBoxDecoration
                            //               : BoxDecorationStyles
                            //               .outTextFieldBoxErrorDecoration,
                            //           child: Row(
                            //             crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //             children: [
                            //               Image.asset(
                            //                 DhanvarshaImages.flag,
                            //                 height: 30,
                            //                 width: 30,
                            //               ),
                            //               SizedBox(width: 10),
                            //               Text(
                            //                 '+91 | ',
                            //                 style: TextStyle(fontSize: 17),
                            //               ),
                            //               SizedBox(width: 20),
                            //               Expanded(
                            //                 child: TextFormField(
                            //                   onChanged: (text) {
                            //                     print("on Change Text Called");
                            //                     setState(() {
                            //                       phoneNumber = text;
                            //                     });
                            //
                            //                     if (phoneNumber.length == 10) {
                            //                       setState(() {
                            //                         validnumber = true;
                            //                         buttoncolor = Colors.red;
                            //                         buttontextcolor =
                            //                             Colors.white;
                            //                       });
                            //                     } else {
                            //                       buttoncolor =
                            //                           Colors.grey.shade300;
                            //                       buttontextcolor =
                            //                           Colors.grey.shade600;
                            //                     }
                            //
                            //                     print("on Change $phoneNumber");
                            //                   },
                            //                   initialValue: phoneNumber,
                            //                   maxLines: 1,
                            //                   keyboardType: TextInputType.number,
                            //                   style: CustomTextStyles
                            //                       .regularMediumFont,
                            //                   cursorColor: AppColors.black,
                            //                   decoration: InputDecoration(
                            //                     // isDense: true,// this will remove the default content padding
                            //                     hintText: "Enter mobile no.",
                            //                     hintStyle:
                            //                     TextStyle(color: Colors.grey),
                            //                     contentPadding:
                            //                     EdgeInsets.symmetric(
                            //                         horizontal: 0,
                            //                         vertical: 3),
                            //                     border: InputBorder.none,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         (!validnumber)
                            //             ? Padding(
                            //           padding: const EdgeInsets.fromLTRB(
                            //               0, 5, 0, 0),
                            //           child: Text(
                            //             'invalid mobile number',
                            //             style: TextStyle(color: Colors.red),
                            //           ),
                            //         )
                            //             : Container(),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 5),
                            //   child: Column(
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Text(
                            //             'By continuing, you agree to our ',
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontFamily: 'Poppins',
                            //                 fontSize: 12),
                            //           ),
                            //           GestureDetector(
                            //             onTap: () {
                            //               Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       TermsAndConditions(),
                            //                 ),
                            //               );
                            //             },
                            //             child: Text(
                            //               'Terms of Use',
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontFamily: 'Poppins',
                            //                   decoration:
                            //                   TextDecoration.underline,
                            //                   fontWeight: FontWeight.w600,
                            //                   fontSize: 12),
                            //             ),
                            //           ),
                            //           Text(
                            //             ' and',
                            //             maxLines: 2,
                            //             style: TextStyle(
                            //                 color: Colors.black,
                            //                 fontFamily: 'Poppins',
                            //                 fontSize: 12),
                            //           ),
                            //         ],
                            //       ),
                            //       GestureDetector(
                            //         onTap: () {
                            //           Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => PrivacyPolicy(),
                            //                 fullscreenDialog: true),
                            //           );
                            //         },
                            //         child: Text(
                            //           'Privacy Policy',
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               decoration: TextDecoration.underline,
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 12),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        await otp1.getOtp(BasicData.phone, context,
                            isNavigate: false);
                        setState(() {
                          pinEditingController.text = BasicData.otp;
                        });
                      },
                      child: Center(
                          child: Text(
                        'RESEND CODE',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16 * SizeConfig.textScaleFactor,
                            fontWeight: FontWeight.w400,
                            color: AppColors.buttonRed),
                      )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         child: Image.asset(
                    //           DhanvarshaImages.bck,
                    //           height: 20,
                    //           width: 20,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Center(
                    //           child: Image.asset(
                    //             DhanvarshaImages.dhanvarshalogo,
                    //             width: SizeConfig.screenWidth / 2.5,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    //   child: Center(
                    //     child: Image.asset(
                    //       DhanvarshaImages.otp,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    //   child: Text(
                    //     'Enter One Time \nPassword',
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontSize: 22 * SizeConfig.textScaleFactor,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //   child: Text(
                    //     'Enter 4-digit code received on your mobile number',
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //   child: Text(
                    //     '+91 ' + BasicData.phone,
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pop(
                    //       context,
                    //     );
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //     child: Text(
                    //       'CHANGE NUMBER',
                    //       style: TextStyle(
                    //           fontFamily: 'Poppins',
                    //           fontSize: 14 * SizeConfig.textScaleFactor,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.red[600]),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: PinInputTextField(
                    //     controller: pinEditingController,
                    //     key: key,
                    //     onSubmit: (text) {},
                    //     pinLength: 4,
                    //     autoFocus: false,
                    //     decoration: BoxLooseDecoration(
                    //       radius: Radius.circular(5),
                    //       strokeColorBuilder:
                    //           PinListenColorBuilder(Colors.black, Colors.grey),
                    //       bgColorBuilder:
                    //           PinListenColorBuilder(Colors.white, Colors.white),
                    //       strokeWidth: 1,
                    //       gapSpace: 10,
                    //       obscureStyle: ObscureStyle(
                    //         isTextObscure: false,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Image.asset(
                    //       DhanvarshaImages.tick2,
                    //       height: 20,
                    //       width: 20,
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Container(
                    //       width: SizeConfig.screenWidth / 1.2,
                    //       child: Text(
                    //         'I declare that I have obtained the requisite authorizations from '
                    //         'the applicant and all the co-applicant (if any)'
                    //         'to pull their bureau reports for assessment of their'
                    //         'loan application and for processing the KYCs provided ',
                    //         style: TextStyle(
                    //           fontFamily: 'Poppins',
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // GestureDetector(
                    //   onTap: () async {
                    //     await otp1.getOtp(BasicData.phone, context,
                    //         isNavigate: false);
                    //     setState(() {
                    //       pinEditingController.text = BasicData.otp;
                    //     });
                    //   },
                    //   child: Center(
                    //       child: Text(
                    //     'RESEND CODE',
                    //     style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 16 * SizeConfig.textScaleFactor,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.red[600]),
                    //   )),
                    // ),
                    ValueListenableBuilder(
                        valueListenable: isVerified!,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          if (value) {
                            return GestureDetector(
                              onTap: () {
                                if (!pinEditingController.text.isEmpty) {
                                  BasicData.otp = pinEditingController.text;
                                  confirmotp.confirmOTP(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Please Enter Valid OTP")));
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Registration(
                                //             context: context,
                                //           )),
                                // );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Material(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                                  elevation: 10,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        height: SizeConfig.screenHeight / 14,
                                        width: SizeConfig.screenWidth,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: isVerified!.value
                                                ? AppColors.bgreen
                                                : AppColors.buttonRed,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Center(
                                            child: Text(
                                          'VERIFIED',
                                          style: TextStyle(
                                              fontFamily: 'GothamMedium',
                                              fontSize:
                                                  20 * SizeConfig.textScaleFactor,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                if (!pinEditingController.text.isEmpty) {
                                  BasicData.otp = pinEditingController.text;
                                  confirmotp.confirmOTP(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Please Enter Valid OTP")));
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Registration(
                                //             context: context,
                                //           )),
                                // );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  elevation: 10,
                                  child: Container(
                                    child: Container(
                                      height: SizeConfig.screenHeight / 14,
                                      width: SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: AppColors.buttonRedWithOpacity,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: Center(
                                          child: Text(
                                        'CONTINUE',
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            fontSize:
                                                20 * SizeConfig.textScaleFactor,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            DhanvarshaLoader(),
          ],
        ),
      ),
    );
  }
}
