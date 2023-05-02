import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/otp/OTP.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

typedef assetsFunction = Function();
typedef onVeriftyFunction = Function(String otp);

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();
  ColorBuilder _solidColor = PinListenColorBuilder(Colors.grey, Colors.green);
  DialogUtils.internal();

  factory DialogUtils() => _instance;

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

  static void aadhaarOtpVerificationDialog(
    BuildContext context, {
    required onVeriftyFunction onVerifyPressed,
    required TextEditingController pineditingController,
  }) {
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
                            "Enter The OTP Sent On +91 9867106967",
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

  static void CalculateShopAreaDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                      height: 350,
                      width: SizeConfig.screenWidth * 0.80,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "HOW TO CALCULATE CARPET AREA?",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Inner wall area + floor area",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "= Carpet area.",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                                "Multiply the length and width of each room to get area of room.Add all room areas to get size of shop.",
                                style: CustomTextStyles.regularsmalleFonts,
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                                "Example - Room 1 is 20ft * 30ft = 600 sqft & Room 2 is 10ft *12ft = 120 sqft.",
                                style: CustomTextStyles.regularsmalleFonts,
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                                "Total shop size = 600 + 120 = 720 sqft.",
                                style: CustomTextStyles.regularsmalleFonts,
                                textAlign: TextAlign.center),
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
                      )),
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
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: assetFunction,
                    child: Container(
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * 0.35,
                      width: SizeConfig.screenWidth * 0.65,
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * 0.10,
                            width: SizeConfig.screenHeight * 0.10,
                            child: CircularPercentIndicator(
                              radius: SizeConfig.screenHeight * 0.10,
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
                            "Please Wait",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                          Text(
                            "The Customer loan application is being reward",
                            style: CustomTextStyles.boldMediumFont,
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

  static void showMyDialog(BuildContext context) {
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
                      height: 250,
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
                              "Session Expired",
                              style: CustomTextStyles.boldMediumFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Session has been expired please re-login",
                              style: CustomTextStyles.regularMediumGreyFont,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomButton(
                            onButtonPressed: () {
                              /* NavigationService.navigationService
                                  .navigateTo('\login');*/
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              BasicData.clearData();
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

  static void UploadInsturctionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    width: SizeConfig.screenWidth * 0.80,
                    height: 300,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
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
                            DhanvarshaImages.question,
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "HOW TO UPLOAD DOCUMENTS?",
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
                                    "  Scan documents in good lighting",
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
                                  Text("  Image should not be dark",
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
                                  Text("  Image should not be blurry",
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
                                  Text("  Face should be straight and visible",
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
                                    "  Upload only original documents",
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
                    )),
              ],
            ),
          );
        });
  }

  static void BDUploadInsturctionDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Stack(
              alignment: Alignment(0.6, -0.7),
              children: [
                Container(
                    width: SizeConfig.screenWidth * 0.80,
                    height: 150,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            DhanvarshaImages.question,
                            height: 25,
                            width: 25,
                          ),
                        ),*/
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        /* Container(
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
                                    "  Scan documents in good lighting",
                                    style:
                                    CustomTextStyles.regularSmallGreyFont,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),*/
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "GOT IT",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        /*Container(
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
                                  Text("  Image should not be dark",
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
                                  Text("  Image should not be blurry",
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
                                  Text("  Face should be straight and visible",
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
                                    "  Upload only original documents",
                                    style:
                                    CustomTextStyles.regularSmallGreyFont,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),*/
                        /*Container(
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
                        )*/
                      ],
                    )),
              ],
            ),
          );
        });
  }

  static void POAUploadInsturctionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Stack(
              alignment: Alignment(0.6, -0.6),
              children: [
                Container(
                    width: SizeConfig.screenWidth * 0.80,
                    height: 250,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            DhanvarshaImages.question,
                            height: 25,
                            width: 25,
                          ),
                        ),*/
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(
                            "Kindly upload the correct document.Any discrepancy can lead to rejection of loans",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 0),
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
                                    "  Electricity Bill",
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
                              EdgeInsets.symmetric(horizontal: 18, vertical: 0),
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
                                    "  Water Tax Bill",
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
                              EdgeInsets.symmetric(horizontal: 18, vertical: 0),
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
                                    "  Gas Bill",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "GOT IT",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: AppColors.buttonRed,
                              ),
                            ),
                          ),
                        ),
                        /*Container(
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
                                  Text("  Image should not be dark",
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
                                  Text("  Image should not be blurry",
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
                                  Text("  Face should be straight and visible",
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
                                    "  Upload only original documents",
                                    style:
                                    CustomTextStyles.regularSmallGreyFont,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),*/
                        /*Container(
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
                        )*/
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
