import 'dart:io';

import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/model/request/offeracceptrejectdto.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/bussinessloan/repaymentdetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/ui/registration_new/splash.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/keyboardbuilder.dart';
import 'package:dhanvarsha/utils/system_padding/system_padding.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

typedef assetsFunction = Function();
typedef onVeriftyFunction = Function(String otp);

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();
  ColorBuilder _solidColor = PinListenColorBuilder(Colors.grey, Colors.green);
  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showBusinessLoanPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    //onTap: assetFunction,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: AppColors.white),
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * 0.37,
                      width: SizeConfig.screenWidth * 0.65,
                      // color: AppColors.white,
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * 0.10,
                            width: SizeConfig.screenHeight * 0.10,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "APPLICATION SUBMITTED SUCCESSFULLY\n",
                                style: CustomTextStyles.boldMediumFont,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "The customer's loan application is being reviewed.",
                                style: CustomTextStyles.regularsmalleFonts,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            title: "CLOSE",
                            widthScale: 0.5,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showCompleteApplicationPopupForBusinessPAN(
      BuildContext context, assetsFunction assetFunction) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: assetFunction,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: AppColors.white),
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * 0.35,
                      width: SizeConfig.screenWidth * 0.65,
                      // color: AppColors.white,
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * 0.10,
                            width: SizeConfig.screenHeight * 0.10,
                            child: CircularPercentIndicator(
                              radius: SizeConfig.screenHeight * 0.08,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 8.0,
                              percent: 0.4,
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: AppColors.lighterGrey,
                              progressColor: AppColors.buttonRed,
                            ),
                          ),
                          Text(
                            "PLEASE WAIT",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                          Column(
                            children: [
                              Text(
                                "We are fetching customer's GST details",
                                style: CustomTextStyles.boldsmalleFonts,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              Navigator.pop(context);
                            },
                            title: "Close",
                            widthScale: 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showImagePickerDialog(BuildContext context,
      {required assetsFunction onImagePressed,
      required assetsFunction onGalleryPressed}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            content: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onImagePressed();
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            DhanvarshaImages.camerabutton,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Camera",
                          style: CustomTextStyles.regularMediumFont,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onGalleryPressed();
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            DhanvarshaImages.gallerybutton,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Gallery",
                          style: CustomTextStyles.regularMediumFont,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static void aadhaarOtpVerificationDialog(BuildContext context,
      {required onVeriftyFunction onVerifyPressed,
      required TextEditingController pineditingController,
      String mobileNumber = "9867106967"}) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                      height: SizeConfig.screenHeight * 0.40,
                      width: SizeConfig.screenWidth * 0.80,
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Verify Aadhaar Card",
                            style: CustomTextStyles.regularLargeFonts,
                          ),
                          Text(
                            "Enter The OTP Sent On +91 ${mobileNumber}",
                            style: CustomTextStyles.regularSmallGreyFont,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: PinInputTextField(
                              controller: pineditingController,
                              onSubmit: onVerifyPressed,
                              pinLength: 6,
                              autoFocus: true,
                              decoration: BoxLooseDecoration(
                                radius: Radius.zero,
                                strokeColorBuilder: PinListenColorBuilder(
                                    AppColors.black, AppColors.lightGrey3),
                                bgColorBuilder: PinListenColorBuilder(
                                    Colors.white, Colors.white),
                                strokeWidth: 1,
                                gapSpace: 5,
                                obscureStyle: ObscureStyle(
                                  isTextObscure: true,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Resend In 30 Sec",
                            style: CustomTextStyles.regularSmallGreyFont,
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              onVerifyPressed(pineditingController.text);
                            },
                            widthScale: 0.6,
                            title: "Verify",
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  static void showCompleteApplicationPopup(
      BuildContext context, assetsFunction assetFunction) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: assetFunction,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: AppColors.white),
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * 0.35,
                      width: SizeConfig.screenWidth * 0.65,
                      // color: AppColors.white,
                      margin: EdgeInsets.symmetric(vertical: 25),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * 0.10,
                            width: SizeConfig.screenHeight * 0.10,
                            child: CircularPercentIndicator(
                              radius: SizeConfig.screenHeight * 0.08,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 8.0,
                              percent: 0.4,
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: AppColors.lighterGrey,
                              progressColor: AppColors.buttonRed,
                            ),
                          ),
                          Text(
                            "PLEASE WAIT",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                          Column(
                            children: [
                              Text(
                                "The customer's loan",
                                style: CustomTextStyles.boldsmalleFonts,
                              ),
                              Text(
                                " application is being reviewed",
                                style: CustomTextStyles.boldsmalleFonts,
                              )
                            ],
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              assetFunction();
                              Navigator.of(context).pop();
                            },
                            title: "CLOSE",
                            widthScale: 0.5,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void showKycDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * 0.50,
                      width: SizeConfig.screenWidth * 0.80,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 10),
                          //   child: Image.asset(DhanvarshaImages.i),
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "WHAT IS O-KYC?",
                              style: CustomTextStyles.boldMediumFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              AppConstants.okycdesc,
                              style: CustomTextStyles.regularSmallGreyFont,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  // static void customerlreadyExist(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return Material(
  //         type: MaterialType.transparency,
  //         child: Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               Container(
  //                 alignment: Alignment.center,
  //                 height: SizeConfig.blockSizeVertical * 55,
  //                 width: SizeConfig.screenWidth * 0.85,
  //                 margin: EdgeInsets.symmetric(vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.white,
  //                   border: Border.all(
  //                     width: 1,
  //                   ),
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(7),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Image.asset(
  //                       DhanvarshaImages.boyexc,
  //                       height: SizeConfig.blockSizeVertical * 20,
  //                       width: SizeConfig.blockSizeHorizontal * 50,
  //                     ),
  //                     Text(
  //                       "CUSTOMER ALREADY EXIST",
  //                       style: CustomTextStyles.boldLargeFonts,
  //                     ),
  //                     Container(
  //                       margin: EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         "This customer already has an Active Personal Loan Offer that expires in 9 days.",
  //                         style: CustomTextStyles.regularsmalleFonts,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                     CustomButton(
  //                       onButtonPressed: () {
  //                         SuccessfulResponse.showScaffoldMessage(
  //                             "Coming Soon !", context);
  //                       },
  //                       title: "VIEW APPLICATION",
  //                       widthScale: 0.5,
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static void loanAlreadyExist(BuildContext context, {int? count}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 65,
                  width: SizeConfig.screenWidth * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.personalloan,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        "CUSTOMER HAS AN ACTIVE ${count == 1 ? "PERSONAL LOAN" : "BUSINESS LOAN"}",
                        style: CustomTextStyles.boldLargeFonts,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(),
                      ),
                      CustomButton(
                        onButtonPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        title: "OK",
                        widthScale: 0.5,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void clientcreatedExist(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 60,
                  width: SizeConfig.screenWidth * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.boyexc,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        "CUSTOMER ALREADY EXIST",
                        style: CustomTextStyles.boldLargeFonts,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Days you can contact this lead for loan offer.",
                          style: CustomTextStyles.regularsmalleFonts,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.lighterGrey)),
                            child: Text(
                              "5",
                              style: CustomTextStyles.boldLargeFonts,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.lighterGrey)),
                            child: Text(
                              "1",
                              style: CustomTextStyles.boldLargeFonts,
                            ),
                          )
                        ],
                      ),
                      CustomButton(
                        onButtonPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        title: "CREATE NEW",
                        widthScale: 0.5,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void customernotCreatedV1(BuildContext context, {String name = ""}) {
    showDialog(
      context: context,
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: false,
            context: context,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(minWidth: 280.0, minHeight: 435.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        DhanvarshaImages.boycross,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Column(
                        children: [
                          Text(
                            "CUSTOMER CANNOT BE\n CREATED",
                            style: CustomTextStyles.boldLargeFonts,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(
                              "A customer with name ${name} has already applied for a Loan and application is in progress.",
                              style: CustomTextStyles.regularsmalleFonts,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      CustomButton(
                        onButtonPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        title: "OK",
                        widthScale: 0.5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void customernotCreated(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 60,
                  width: SizeConfig.screenWidth * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.boycross,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Column(
                        children: [
                          Text(
                            "CUSTOMER CANNOT BE\n CREATED",
                            style: CustomTextStyles.boldLargeFonts,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "A customer with name Pramod Patil has already applied for a Loan and application is in progress",
                              style: CustomTextStyles.regularsmalleFonts,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      CustomButton(
                        onButtonPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        title: "VIEW APPLICATION",
                        widthScale: 0.5,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void successfulappdialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 60,
                  width: SizeConfig.screenWidth * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.appAccepted,
                        height: SizeConfig.blockSizeVertical * 20,
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Column(
                        children: [
                          Text(
                            "APPLICATION SUBMITTED SUCCESSFULLY",
                            style: CustomTextStyles.boldLargeFonts,
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text(
                              "The customer's loan application is being reviewed",
                              style: CustomTextStyles.regularsmalleFonts,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      CustomButton(
                        onButtonPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        title: "CLOSE",
                        widthScale: 0.5,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void rejectOffer(
      BuildContext context, OfferBloc offerBloc, int refPLId,
      {type = "PL"}) {
    showDialog(
      context: context,
      builder: (_) {
        return Container(
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: false,
            context: context,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(minWidth: 280.0, minHeight: 50.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          DhanvarshaImages.rejecticon,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "Are YOU SURE YOU WANT TO REJECT THIS OFFER?",
                          style: CustomTextStyles.boldMediumFont,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          OfferAcceptRejectDTO offerAcceptRejectDTO =
                              OfferAcceptRejectDTO();
                          offerAcceptRejectDTO.refPlId = refPLId;
                          offerAcceptRejectDTO.softOfferStatus = 0;

                          print(offerAcceptRejectDTO.toEncodedJson());
                          FormData formData = FormData.fromMap({
                            'json': await EncryptionUtils.getEncryptedText(
                                offerAcceptRejectDTO.toEncodedJson()),
                          });

                          if (type == "PL") {
                            offerBloc!.offerAccepted(formData, type: 0);
                            Navigator.pop(context);
                          } else {
                            offerBloc!.offerAcceptedStatusBL(formData, type: 0);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Yes, Reject",
                            style: CustomTextStyles.boldMediumRedFont,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "No",
                            style: CustomTextStyles.boldMediumRedFont,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void existfromapplications(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, minHeight: 180.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   margin: EdgeInsets.symmetric(vertical: 10),
                              //   child: Image.asset(
                              //     DhanvarshaImages.i,
                              //     height: 25,
                              //     width: 25,
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Do you want to exit from current process?",
                                  style: CustomTextStyles.boldMediumFont,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Exit from an app");

                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Yes",
                                    style: CustomTextStyles.boldMediumRedFont,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "No",
                                    style: CustomTextStyles.boldMediumRedFont,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });

    //
    //
    //
    // showDialog(
    //     context: context,
    //     builder: (_) {
    //       return Material(
    //         type: MaterialType.transparency,
    //         child: Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Stack(
    //             alignment: Alignment.center,
    //             children: [
    //               Container(
    //                   alignment: Alignment.center,
    //                   height: SizeConfig.screenHeight * 0.33,
    //                   width: SizeConfig.screenWidth * 0.70,
    //                   margin: EdgeInsets.symmetric(vertical: 10),
    //                   decoration: BoxDecoration(
    //                       color: AppColors.white,
    //                       border: Border.all(
    //                         width: 1,
    //                       ),
    //                       borderRadius: BorderRadius.all(Radius.circular(7))),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Container(
    //                         margin: EdgeInsets.symmetric(vertical: 10),
    //                         child: Image.asset(
    //                           DhanvarshaImages.i,
    //                           height: 25,
    //                           width: 25,
    //                         ),
    //                       ),
    //                       Container(
    //                         padding: EdgeInsets.symmetric(horizontal: 15),
    //                         margin: EdgeInsets.symmetric(vertical: 10),
    //                         child: Text(
    //                           "Do you want to exit from current process?",
    //                           style: CustomTextStyles.boldMediumFont,
    //                           textAlign: TextAlign.center,
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           Navigator.of(context)
    //                               .popUntil((route) => route.isFirst);
    //                         },
    //                         child: Container(
    //                           margin: EdgeInsets.symmetric(vertical: 10),
    //                           child: Text(
    //                             "Yes",
    //                             style: CustomTextStyles.boldMediumRedFont,
    //                           ),
    //                         ),
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           Navigator.of(context).pop();
    //                         },
    //                         child: Container(
    //                           margin: EdgeInsets.symmetric(vertical: 10),
    //                           child: Text(
    //                             "No",
    //                             style: CustomTextStyles.boldMediumRedFont,
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   )),
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }

  static void offerrejectedOffer(
      BuildContext context, assetsFunction onDonePressed) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 220,
                      width: SizeConfig.screenWidth * 0.70,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 10),
                          //   child: Image.asset(
                          //     DhanvarshaImages.i,
                          //     height: 25,
                          //     width: 25,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "OFFER REJECTED",
                              style: CustomTextStyles.boldMediumFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "This offer has been rejected by you",
                              style: CustomTextStyles.regularMediumGreyFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomButton(
                            onButtonPressed: onDonePressed,
                            title: "DONE",
                            widthScale: 0.5,
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  static void offerrejectedByLoan1(BuildContext context,
      {String message = "Issue from server", String days = "24"}) {
    List<String> splittedDays = days.split("");

    print(splittedDays);
    print(splittedDays);
    showDialog(
        context: context,
        builder: (_) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, minHeight: 200.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Image.asset(
                              DhanvarshaImages.Group,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "CUSTOMER REJECTED\n RECENTLY",
                              style: CustomTextStyles.boldMediumFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              message,
                              style: CustomTextStyles.regularMediumGreyFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.lighterGrey4,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    splittedDays.length == 2
                                        ? splittedDays[0]
                                        : "0",
                                    style: CustomTextStyles.boldLargeFonts,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.lighterGrey4,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    splittedDays.length == 2
                                        ? splittedDays[1]
                                        : splittedDays[0],
                                    style: CustomTextStyles.boldLargeFonts,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 25),
                                child: Text(
                                  "OK",
                                  style: CustomTextStyles.boldMediumRedFont,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  static void offerrejectedByLoan(BuildContext context,
      {String message = "Issue from server"}) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 45,
                    width: SizeConfig.screenWidth * 0.70,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            DhanvarshaImages.i,
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "APPLICATION REJECTED",
                            style: CustomTextStyles.boldMediumFont,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            message,
                            style: CustomTextStyles.regularMediumGreyFont,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CustomButton(
                          onButtonPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          title: "CLOSE",
                          widthScale: 0.5,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showMyDialog(
      {String title = "Session Expired",
      String message = "Session has been expired please re-login"}) {
    showDialog(
        barrierDismissible: false,
        context:
            NavigationService.navigationService.navigatorKey.currentContext!,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: 220,
                      width: SizeConfig.screenWidth * 0.70,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 10),
                          //   child: Image.asset(
                          //     DhanvarshaImages.i,
                          //     height: 25,
                          //     width: 25,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Session Expired",
                              style: CustomTextStyles.boldMediumFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              message,
                              style: CustomTextStyles.regularMediumGreyFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              NavigationService.navigationService
                                  .navigateTo('\login');
                            },
                            title: "OK",
                            widthScale: 0.5,
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  static void cbStatusReject({String url = ""}) {
    showDialog(
        barrierDismissible: false,
        context:
            NavigationService.navigationService.navigatorKey.currentContext!,
        builder: (_) {
          return WillPopScope(
            child: Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 220,
                        width: SizeConfig.screenWidth * 0.70,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset(
                                DhanvarshaImages.i,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Version Update",
                                style: CustomTextStyles.boldMediumFont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "To use this app, download the latest version",
                                style: CustomTextStyles.regularMediumGreyFont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            CustomButton(
                              onButtonPressed: () async {
                                // NavigationService.navigationService
                                //     .navigateTo('\login');
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  SuccessfulResponse.showScaffoldMessage(
                                      "Invalid url",
                                      NavigationService.navigationService
                                          .navigatorKey.currentContext!);
                                }
                              },
                              title: "UPDATE",
                              widthScale: 0.5,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            onWillPop: () async => false,
          );
        });
  }

  static void versionUpdateDialog({String url = ""}) {
    showDialog(
        barrierDismissible: false,
        context:
            NavigationService.navigationService.navigatorKey.currentContext!,
        builder: (_) {
          return WillPopScope(
            child: Material(
              type: MaterialType.transparency,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 220,
                        width: SizeConfig.screenWidth * 0.70,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset(
                                DhanvarshaImages.i,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Version Update",
                                style: CustomTextStyles.boldMediumFont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "To use this app, download the latest version",
                                style: CustomTextStyles.regularMediumGreyFont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            CustomButton(
                              onButtonPressed: () async {
                                // NavigationService.navigationService
                                //     .navigateTo('\login');
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  SuccessfulResponse.showScaffoldMessage(
                                      "Invalid url",
                                      NavigationService.navigationService
                                          .navigatorKey.currentContext!);
                                }
                              },
                              title: "UPDATE",
                              widthScale: 0.5,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            onWillPop: () async => false,
          );
        });
  }

  static void UploadInsturctionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 280.0, minHeight: 275.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      // type: MaterialType.transparency,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 10),
                            //   child: Image.asset(
                            //     DhanvarshaImages.i,
                            //     height: 25,
                            //     width: 25,
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "INSTRUCTION FOR UPLOAD",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                      Text(
                                        "  Make sure you capture in good lighting.",
                                        style:
                                            CustomTextStyles.regularSmallGreyFont,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                      Text("  Image should not be dark.",
                                          style: CustomTextStyles
                                              .regularSmallGreyFont),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                      Text("  Image should not be blurry.",
                                          style: CustomTextStyles
                                              .regularSmallGreyFont),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                      Text("  Face should be legit and visible.",
                                          style: CustomTextStyles
                                              .regularSmallGreyFont),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //Center Column contents horizontally,
                                children: [
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: ,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 8,
                                      ),
                                      Text(
                                        "  Upload only original images.",
                                        style:
                                            CustomTextStyles.regularSmallGreyFont,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                children: [
                                  CustomButton(
                                    onButtonPressed: () {
                                      Navigator.pop(context);
                                    },
                                    widthScale: 0.6,
                                    title: "CLOSE",
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  static void showInfo(BuildContext context, String urlPath, {type = "pdf"}) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, maxHeight: 400.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              constraints: BoxConstraints(minHeight: 280),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1,
                                color: AppColors.lighterGrey,
                              )),
                              height: 250,
                              width: 380,
                              child: type == "pdf"
                                  ? Uri.parse(urlPath).isAbsolute
                                      ? PDF().fromUrl(
                                          urlPath,
                                          placeholder: (double progress) =>
                                              Center(
                                                  child: Container(
                                            child: CircularProgressIndicator(),
                                          )),
                                          errorWidget: (dynamic error) =>
                                              Center(
                                                  child:
                                                      Text(error.toString())),
                                        )
                                      : PDF().fromPath(
                                          urlPath,
                                        )
                                  : Uri.parse(urlPath).isAbsolute
                                      ? Image.network(
                                          urlPath,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                            // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                          },
                                        )
                                      : Image.file(File(urlPath))),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: CustomButton(
                              onButtonPressed: () {
                                Navigator.of(context).pop();
                              },
                              title: "CLOSE",
                              widthScale: 0.35,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  // static void showLogOutDialog(){
  //   return   //   showDialog(
  //   //       context: context,
  //   //       builder: (_) {
  //   //         return Padding(
  //   //           padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //   //           child: MediaQuery.removeViewInsets(
  //   //               removeLeft: true,
  //   //               removeTop: true,
  //   //               removeRight: true,
  //   //               removeBottom: true,
  //   //               context: context,
  //   //               child: Align(
  //   //                 alignment: Alignment.bottomCenter,
  //   //                 child: ConstrainedBox(
  //   //                   constraints:
  //   //                       const BoxConstraints(minWidth: 280.0, minHeight: 200.0),
  //   //                   child: Material(
  //   //                     elevation: 2.0,
  //   //                     borderRadius: BorderRadius.circular(20.0),
  //   //                     child: Column(
  //   //                       crossAxisAlignment: CrossAxisAlignment.center,
  //   //                       mainAxisAlignment: MainAxisAlignment.end,
  //   //                       mainAxisSize: MainAxisSize.min,
  //   //                       children: [
  //   //                         Container(
  //   //                           margin: EdgeInsets.symmetric(vertical: 10),
  //   //                           child: Image.asset(
  //   //                             image,
  //   //                             height: 35,
  //   //                             width: 35,
  //   //                           ),
  //   //                         ),
  //   //                         Container(
  //   //                           margin: EdgeInsets.symmetric(vertical: 10),
  //   //                           child: Text(
  //   //                             title,
  //   //                             style: CustomTextStyles.boldLargerFont,
  //   //                             textAlign: TextAlign.center,
  //   //                           ),
  //   //                         ),
  //   //                         Container(
  //   //                           margin: EdgeInsets.symmetric(vertical: 10),
  //   //                           child: Text(
  //   //                             infotext,
  //   //                             style: CustomTextStyles.regularSmallGreyFont,
  //   //                             textAlign: TextAlign.center,
  //   //                           ),
  //   //                         ),
  //   //                       ],
  //   //                     ),
  //   //                   ),
  //   //                 ),
  //   //               )),
  //   //         );
  //   //       });
  // }
  static void clientIdDialog(
      BuildContext context, String id, VoidCallback onOkPressed) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return WillPopScope(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MediaQuery.removeViewInsets(
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  context: context,
                  child: Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: 280.0, minHeight: 200.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Image.asset(
                                DhanvarshaImages.person,
                                height: 25,
                                width: 25,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Customer ID No",
                                  style: CustomTextStyles.boldLargeFonts,
                                )),
                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 10),
                            //   child: Text(
                            //     "Your client id is",
                            //     style: CustomTextStyles.regularMediumFont,
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                id,
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: CustomButton(
                                onButtonPressed: onOkPressed,
                                title: "OKAY",
                                widthScale: 0.35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            onWillPop: () async => false,
          );
        });
  }

  static void rejectFinalOfferReason(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, minHeight: 200.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(
                                  DhanvarshaImages.i,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              Text(
                                "REJECT OFFER",
                                style: CustomTextStyles.boldMedium1Font,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  static void rejectWithReason(
      BuildContext context, OfferBloc offerBloc, int RefId,
      {type = "PL"}) {
    var reasonController = TextEditingController(text: "");
    var reasonDescriptionController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SystemPadding(
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: MediaQuery.removeViewInsets(
                    removeLeft: true,
                    removeTop: true,
                    removeRight: true,
                    removeBottom: false,
                    context: context,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            minWidth: 280.0, minHeight: 300.0),
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Image.asset(
                                      DhanvarshaImages.rejecticon,
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 0),
                                    child: Text(
                                      "REJECT OFFER",
                                      style: CustomTextStyles.boldMedium1Font,
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       vertical: 10, horizontal: 10),
                                  //   child: DVTextField(
                                  //     controller: reasonController,
                                  //     outTextFieldDecoration:
                                  //         BoxDecorationStyles
                                  //             .outButtonOfBoxGreyCorner,
                                  //     inputDecoration: InputDecorationStyles
                                  //         .inputDecorationTextField,
                                  //     title: "Reject Reason",
                                  //     textInpuFormatter: [
                                  //       UpperCaseTextFormatter(),
                                  //     ],
                                  //     hintText: "Please enter reason",
                                  //     errorText: "Please enter reason",
                                  //     maxLine: 1,
                                  //     isValidatePressed: false,
                                  //     isTitleVisible: false,
                                  //   ),
                                  // ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: DVTextField(
                                      controller: reasonDescriptionController,
                                      outTextFieldDecoration:
                                          BoxDecorationStyles
                                              .outButtonOfBoxGreyCorner1,
                                      inputDecoration: InputDecorationStyles
                                          .inputDecorationTextField,
                                      title: "Pan",
                                      textInpuFormatter: [
                                        UpperCaseTextFormatter(),
                                      ],
                                      hintText: "Please enter reason",
                                      errorText:
                                          "Please enter reason description",
                                      maxLine: 5,
                                      isValidatePressed: false,
                                      isTitleVisible: false,
                                    ),
                                  ),

                                  // CustomButton(
                                  //   onButtonPressed: () async {
                                  //
                                  //   },
                                  //   title: "SUBMIT",
                                  //   widthScale: 0.5,
                                  // ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (reasonDescriptionController.text !=
                                          "") {
                                        OfferAcceptRejectDTO
                                            offerAcceptRejectDTO =
                                            OfferAcceptRejectDTO();
                                        offerAcceptRejectDTO.refPlId = RefId;
                                        offerAcceptRejectDTO.softOfferStatus =
                                            0;
                                        offerAcceptRejectDTO.RejectDescription =
                                            reasonDescriptionController.text;
                                        offerAcceptRejectDTO.RejectReason =
                                            reasonController.text;

                                        print(offerAcceptRejectDTO
                                            .toEncodedJson());
                                        FormData formData = FormData.fromMap({
                                          'json': await EncryptionUtils
                                              .getEncryptedText(
                                                  offerAcceptRejectDTO
                                                      .toEncodedJson()),
                                        });

                                        if (type == "PL") {
                                          offerBloc!
                                              .offerAccepted(formData, type: 1);
                                          Navigator.of(context).pop();
                                        } else {
                                          offerBloc!.offerAcceptedStatusBL(
                                              formData,
                                              type: 1);
                                          Navigator.of(context).pop();
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please enter all details");
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "SUBMIT",
                                        style:
                                            CustomTextStyles.boldMediumRedFont,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "CLOSE",
                                        style:
                                            CustomTextStyles.boldMediumRedFont,
                                      ),
                                    ),
                                  )
                                  // CustomButton(
                                  //   onButtonPressed: () async {
                                  //     Navigator.of(context).pop();
                                  //   },
                                  //   boxDecoration: BoxDecorationStyles.outButtonOfBoxRed,
                                  //   title: "CLOSE",
                                  //   widthScale: 0.5,
                                  // )

                                  // GestureDetector(
                                  //
                                  //   child: Container(
                                  //     margin:
                                  //         EdgeInsets.symmetric(vertical: 10),
                                  //     child: Text(
                                  //       "SUBMIT",
                                  //       style:
                                  //           CustomTextStyles.buttonTextStyleRed,
                                  //     ),
                                  //   ),
                                  // ),

                                  // Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  //   child: Text(
                                  //     "Are YOU SURE YOU WANT TO REJECT THIS OFFER?",
                                  //     style: CustomTextStyles.boldMediumFont,
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 10),
                                  //   child: Text(
                                  //     "Yes, Reject",
                                  //     style: CustomTextStyles.boldMediumRedFont,
                                  //   ),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 10),
                                  //   child: Text(
                                  //     "No",
                                  //     style: CustomTextStyles.boldMediumRedFont,
                                  //   ),
                                  // )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          );
        });
  }

  static void rejectFinalOfferNew(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MediaQuery.removeViewInsets(
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  context: context,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: 280.0, minHeight: 200.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Image.asset(
                                    DhanvarshaImages.rejecticon,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "OFFER REJECTED",
                                    style: CustomTextStyles.boldLargeFonts,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "This offer has been rejected by you",
                                    style: CustomTextStyles.regularMediumFont,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "OK",
                                      style: CustomTextStyles.boldMediumRedFont,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(vertical: 10),
                                //   child: Text(
                                //     "No",
                                //     style: CustomTextStyles.boldMediumRedFont,
                                //   ),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  static void changeCurrentAddress(
      BuildContext context, VoidCallback onAddAddressPressed) {
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MediaQuery.removeViewInsets(
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  context: context,
                  child: Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: 280.0, minHeight: 200.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Image.asset(
                                    DhanvarshaImages.i,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    "Current Address is Not Same As\n Aadhaar Address",
                                    style: CustomTextStyles.boldMediumFont,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                CustomButton(
                                  onButtonPressed: onAddAddressPressed,
                                  title: "ADD ADDRESS",
                                  widthScale: 0.5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  static void rejectFinalOffer(BuildContext context, OfferBloc offerBloc,
      {type = "PL"}) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, minHeight: 200.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(
                                  DhanvarshaImages.i,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(
                                  "Are YOU SURE YOU WANT TO REJECT THIS OFFER?",
                                  style: CustomTextStyles.boldMediumFont,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (true) {
                                    OfferAcceptRejectDTO offerAcceptRejectDTO =
                                        OfferAcceptRejectDTO();
                                    offerAcceptRejectDTO.refPlId = 1;
                                    offerAcceptRejectDTO.softOfferStatus = 1;
                                    offerAcceptRejectDTO.RejectDescription = "";
                                    offerAcceptRejectDTO.RejectReason = "";

                                    print(offerAcceptRejectDTO.toEncodedJson());
                                    FormData formData = FormData.fromMap({
                                      'json': await EncryptionUtils
                                          .getEncryptedText(offerAcceptRejectDTO
                                              .toEncodedJson()),
                                    });

                                    if (type == "PL") {
                                      offerBloc!.offerAccepted(formData);
                                    } else {
                                      offerBloc!.offerAcceptedStatusBL(formData,
                                          type: 1);
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please enter all details");
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Yes, Reject",
                                    style: CustomTextStyles.boldMediumRedFont,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "No",
                                    style: CustomTextStyles.boldMediumRedFont,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  static void previousDataLogOut(BuildContext context, String image) {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: MediaQuery.removeViewInsets(
                  removeLeft: true,
                  removeTop: true,
                  removeRight: true,
                  removeBottom: true,
                  context: context,
                  child: Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: 280.0, minHeight: 150.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 15),
                            //   child: Image.asset(
                            //     DhanvarshaImages.i,
                            //     height: 25,
                            //     width: 25,
                            //   ),
                            // ),
                            // Container(
                            //     margin: EdgeInsets.symmetric(vertical: 5),
                            //     child: Text(
                            //       "Data Removed",
                            //       style: CustomTextStyles.boldLargeFonts,
                            //     )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                "Please note that the data will be erased if you go back",
                                style: CustomTextStyles.boldLittleLargeFonts,
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // CustomButton(onButtonPressed: (){},title: "OK",widthScale: 0.25,),
                            GestureDetector(
                              onTap: () async {
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 2;
                                });
                                // SharedPreferenceUtils.sharedPreferenceUtils
                                //     .clearAllData();
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => SplashScreen()),
                                //         (Route<dynamic> route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "OK",
                                  style: CustomTextStyles.boldMediumRedFont,
                                ),
                              ),
                            ),

                            // CustomButton(onButtonPressed: (){},title: "CLOSE",widthScale: 0.25,),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "CANCEL",
                                  style: CustomTextStyles.boldMediumRedFont,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
        });
  }

  static void showLogOut(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MediaQuery.removeViewInsets(
                removeLeft: true,
                removeTop: true,
                removeRight: true,
                removeBottom: true,
                context: context,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 280.0, minHeight: 200.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 15),
                          //   child: Image.asset(
                          //     DhanvarshaImages.i,
                          //     height: 25,
                          //     width: 25,
                          //   ),
                          // ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "LOGOUT",
                                style: CustomTextStyles.boldLargeFonts,
                              )),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Are you sure you want to logout?",
                              style: CustomTextStyles.regularMediumFont,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferenceUtils.sharedPreferenceUtils
                                  .clearAllData();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "YES, LOGOUT",
                                style: CustomTextStyles.regularMediumFont,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "CLOSE",
                                style: CustomTextStyles.regularMediumFont,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
