import 'dart:convert';
import 'dart:io';

import 'package:dhanvarsha/bloc/dsaloginbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/dsa_login_request.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/numberverification.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/termconditions/privacy_policy.dart';
import 'package:dhanvarsha/ui/termconditions/terms_coditions.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_crypto/aes_crypto.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs7padding/aes_encryption_helper.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_tooltip/super_tooltip.dart';

class LoginNumberNew extends StatefulWidget {
  const LoginNumberNew({Key? key}) : super(key: key);

  @override
  _LoginNumberNewState createState() => _LoginNumberNewState();
}

class _LoginNumberNewState extends State<LoginNumberNew> implements AppLoading {
  late TextEditingController mobilenumberEditingController;
  var isValidatePressed = false;
  DsaLoginBloc? loginBloc;
  bool isSwitchPressed = false;
  @override
  void initState() {
    mobilenumberEditingController = new TextEditingController();
    // TODO: implement initState
    loginBloc = DsaLoginBloc(this);
    super.initState();
  }

  SuperTooltip? tooltip;
  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      arrowTipDistance: 0.0,
      arrowBaseWidth: 40.0,
      arrowLength: 40.0,
      borderColor: Colors.white,
      borderWidth: 5.0,
      snapsFarAwayVertically: true,
      showCloseButton: ShowCloseButton.inside,
      hasShadow: false,
      touchThrougArea: new Rect.fromLTWH(targetGlobalCenter.dx - 100,
          targetGlobalCenter.dy - 100, 200.0, 160.0),
      touchThroughAreaShape: ClipAreaShape.rectangle,
      content: new Material(
        child: Text(
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
          softWrap: true,
        ),
      ),
    );

    tooltip!.show(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobilenumberEditingController.dispose();
    super.dispose();
  }

  // Future<Null> _cropImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 50,
  //   );
  //
  //   File? croppedFile = await ImageCropper.cropImage(
  //       sourcePath: image!.path,
  //       aspectRatioPresets: Platform.isAndroid
  //           ? [
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio16x9
  //             ]
  //           : [
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio5x3,
  //               CropAspectRatioPreset.ratio5x4,
  //               CropAspectRatioPreset.ratio7x5,
  //               CropAspectRatioPreset.ratio16x9
  //             ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Dhanvarsha',
  //           toolbarColor: Colors.deepOrange,
  //           hideBottomControls: true,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         title: 'Dhanvarsha',
  //       ));
  //   // if (croppedFile != null) {
  //   //   imageFile = croppedFile;
  //   //   setState(() {
  //   //     state = AppState.cropped;
  //   //   });
  //   // }
  // }

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        isBurgerVisble: false,
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight - 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: AppColors.buttonRed,
                  alignment: Alignment.center,
                  child: Image.asset(
                    DhanvarshaImages.icon2,
                    height: SizeConfig.blockSizeVertical * 30,
                    width: SizeConfig.blockSizeHorizontal * 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Mobile Number",
                        style: CustomTextStyles.boldVeryLargerFont2Gotham,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter your 10 digit personal mobile number linked with Aadhaar. Your number is your username",
                        style: CustomTextStyles.regularMediumGreyFontGotham,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: DVTextField(
                    textInputType: TextInputType.number,
                    controller: mobilenumberEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Enter Mobile number",
                    textInpuFormatter: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    hintText: "Enter Mobile No",
                    is91: true,
                    isFlag: true,
                    errorText: "Please enter mobile number",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.mobileNumber,
                    isTitleVisible: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                          child: Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: this.value,
                            focusColor: AppColors.buttonRed,
                            activeColor: AppColors.buttonRed,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
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
                                        decoration: TextDecoration.underline,
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
                                      builder: (context) => PrivacyPolicy(),
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
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: CustomButton(
                    widthScale: 0.90,
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });
                      // String aesHelper= AesHelper.encrypt("1234", "AES 256 ENCRYPTION");
                      //
                      // print(aesHelper);
                      //
                      // String decrypted =AesHelper.decrypt("1234", "yWzPEbpl28H5wtqS4v++nNoZy6mJWndlXn5rlS5WYE+hHTwaK1Yh27nIQyOo05DI");
                      //
                      // print(decrypted);
                
                      // DialogUtils.showInfo(
                      //     context,
                      //     "HI",
                      //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      //     DhanvarshaImages.i);
                
                      if (CustomValidator(mobilenumberEditingController.text)
                          .validate(Validation.mobileNumber)) {
                        if (this.value) {
                          loginDSA();
                        } else {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please accept terms & conditions", context);
                        }
                      } else {
                        // String data = EncryptData.encryptAES("PRAMOD PATIL");
                        // print("DATA IS");
                        // print(data);
                
                        // String decryptedData = EncryptData.decryptAES(
                        //     "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");
                
                        // _cropImage();
                        // print(decryptedData);
                        // String data = EncryptData.encryptAES("PramodPatil");
                        // print("Encrypted Data is");
                        // print(data);
                        // String decryptedData = EncryptData.decryptAES("fl3vVRtWnWbFWmWzwjcFyqSDUGF9gBr81maL0ESgL+6HvtSrqX70PYnHPGLQoZBIPZyY3yRuee+yyvrsu70ylg==");
                        // print("Decrypted Data is");
                        // print(decryptedData);
                      }
                    },
                    title: "CONTINUE",
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  String? encryptedToken;

  loginDSA() async {
    DSALoginDTO dto = DSALoginDTO();
    dto.mobileNumber = mobilenumberEditingController.text;
    String token = DateTime.now().microsecondsSinceEpoch.toString() +
        mobilenumberEditingController.text;

    encryptedToken = await EncryptionUtils.getEncryptedText(token);

    dto.token = await EncryptionUtils.getEncryptedText(token);

    FormData formData = FormData.fromMap(
        {"json": await EncryptionUtils.getEncryptedText(dto.toEncodedJson())});

    loginBloc!.loginDsa(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) async {
    print("IN SUCCESSFUL DATA");
    print(dto.data!);
    DSALoginResponseDTO loginResponseDTO =
        DSALoginResponseDTO.fromJson(jsonDecode(dto.data!));

    print("LOGIN RESPONSE DATA");
    print(loginResponseDTO.id);
    print(loginResponseDTO.isValidLogin!);
    print(jsonEncode(loginResponseDTO.loginBusinessDetailsDTO));
    if (loginResponseDTO.isValidLogin!) {
      SharedPreferenceUtils.sharedPreferenceUtils.addToken(encryptedToken!);
      String? mobileNumber = await EncryptionUtils.getEncryptedText(
          loginResponseDTO.mobileNumber!);
      SharedPreferenceUtils.sharedPreferenceUtils
          .addMobileNumber(mobileNumber!);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberVerification(
              context: context,
              isChangeNumber: false,
              title: "Enter One Time Password",
              description: "Enter 4-digit code received on your mobile number",
              number: loginResponseDTO.mobileNumber!,
              type: 1,
              otp: loginResponseDTO.otp!,
              dsaLoginResponse: loginResponseDTO,
            ),
          ));
    } else {
      SuccessfulResponse.showScaffoldMessage(
          loginResponseDTO.message!, context);
    }

    // TODO: implement isSuccessful
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
