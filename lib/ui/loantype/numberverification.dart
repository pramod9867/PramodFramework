import 'dart:async';
import 'dart:convert';

import 'package:dhanvarsha/bloc/dsaloginbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/dsa_login_request.dart';
import 'package:dhanvarsha/model/request/otprequestdto.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/model/response/otpresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration/reg/Rejistration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class NumberVerification extends StatefulWidget {
  final String title;
  final String description;
  final String number;
  final bool isChangeNumber;
  final int type;
  final String otp;
  final DSALoginResponseDTO? dsaLoginResponse;

  const NumberVerification(
      {Key? key,
      required BuildContext context,
      this.title = "To Accept Loan Offer",
      this.description =
          "Enter the code we have sent to the customer via SMS to mobile number.",
      this.number = "+91 8879809963.",
      this.isChangeNumber = false,
      this.type = 0,
      this.otp = "",
      this.dsaLoginResponse})
      : super(key: key);

  @override
  _NumberVerificationState createState() => _NumberVerificationState();
}

class _NumberVerificationState extends State<NumberVerification>
    implements AppLoading {
  GlobalKey key = GlobalKey();
  var isValidatePressed = false;
  DsaLoginBloc? loginBloc;
  TextEditingController? pinEditingController;
  Timer? _timer;
  ValueNotifier<int> isOtpSend = ValueNotifier(60);
  int _start = 10;

  bool value = true;
  @override
  void initState() {
    pinEditingController = TextEditingController(); // TODO: implement initState
    pinEditingController!.text = widget.otp;
    startTimer();
    loginBloc = DsaLoginBloc(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseView(
        isdhavarshalogovisible: false,
        type: false,
        context: context,
        body: SingleChildScrollView(
          child: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      height: SizeConfig.screenHeight - 45 - SizeConfig.verticalviewinsects,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(DhanvarshaImages.otp,
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenWidth * 0.35),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              widget.title,
              style: CustomTextStyles.boldVeryLargerFont2Gotham,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.description,
                style: CustomTextStyles.regularMediumGreyFontGotham,
              ),
              SizedBox(
                height: 10,
              ),
              Text("+91 " + widget.number,
                  style: CustomTextStyles.regularMediumGreyFontGothamMedium),
              widget.isChangeNumber
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'CHANGE NUMBER',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonRed),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: PinInputTextField(
              key: key,
            
              controller: pinEditingController,
              onSubmit: (text) {},
              pinLength: 4,
              autoFocus: false,
              decoration: BoxLooseDecoration(
                radius: Radius.circular(5),
                strokeColorBuilder:
                    PinListenColorBuilder(Colors.black, Colors.grey),
                bgColorBuilder:
                    PinListenColorBuilder(Colors.white, Colors.white),
                strokeWidth: 1,
                gapSpace: 10,
                obscureStyle: ObscureStyle(
                  isTextObscure: false,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: isOtpSend,
              builder: (BuildContext context, int hasError, child) {
                if (isOtpSend.value == 0) {
                  return GestureDetector(
                    onTap: () {
                      loginDSA();
                    },
                    child: Center(
                      child: Text('RESEND CODE',
                          style: CustomTextStyles.regularMediumGreyFontGotham),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Text('OTP will sent in ${isOtpSend.value} seconds',
                          style: CustomTextStyles.regularMediumGreyFontGotham),
                    ),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       SizedBox(
          //         height: 20,
          //         width: 20,
          //         child: Container(
          //
          //           child: Checkbox(
          //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //             value: this.value,
          //             focusColor: AppColors.buttonRed,
          //             activeColor: AppColors.buttonRed,
          //             onChanged: (bool? value) {
          //               setState(() {
          //                 this.value = value!;
          //               });
          //             },
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child:Container(
          //           margin: EdgeInsets.symmetric(horizontal: 10),
          //           child:  Text(
          //             AppConstants.consonantMessage,
          //             style: CustomTextStyles.regularSmallGreyFont,
          //             textAlign: TextAlign.left,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          GestureDetector(
            onTap: () {
              print(jsonEncode(widget.dsaLoginResponse));
              if (widget.type == 0) {
                if (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoanFlowSuccessful(),
                    ),
                  );
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please check declaration", context);
                }
              } else {
                if (pinEditingController!.text.length == 4) {
                  if (value) {
                    verifyOTP();
                  } else {
                    SuccessfulResponse.showScaffoldMessage(
                        "Please check declaration", context);
                  }
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please enter a valid OTP", context);
                }
              }
              ;
            },
            child: Container(
              height: SizeConfig.screenHeight / 15,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: AppColors.buttonRed,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                  child: Text(
                'CONTINUE',
                style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  loginDSA() async {
    DSALoginDTO dto = DSALoginDTO();
    dto.mobileNumber = widget.number;

    FormData formData = FormData.fromMap(
        {"json": await EncryptionUtils.getEncryptedText(dto.toEncodedJson())});

    await loginBloc!.loginDsa(formData, isSuccesfulCalled: false);
    startTimer();
  }

  void startTimer() {
    if (isOtpSend.value == 0) {
      isOtpSend.value = 60;
    }

    print(_timer);

    _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => {
              if (isOtpSend.value == 0)
                {
                  _timer!.cancel(),
                }
              else
                {
                  isOtpSend.value = isOtpSend.value - 1,
                }
            });
  }

  verifyOTP() async {
    OTPRequestDTO otpRequestDTO = OTPRequestDTO();
    otpRequestDTO.mobileNumber = widget.number;
    otpRequestDTO.oTP = pinEditingController!.text;

    FormData formData = FormData.fromMap({
      "json":
          await EncryptionUtils.getEncryptedText(otpRequestDTO.toEncodedJson()),
    });

    loginBloc!.verifyOTP(formData);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pinEditingController!.dispose();
    super.dispose();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    OtpResponseDTO otpResponseDTO =
        OtpResponseDTO.fromJson(jsonDecode(dto.data!));

    if (otpResponseDTO.isValidOTP!) {
      print("Save Login Response IS");

      print(jsonEncode(widget.dsaLoginResponse));
      print(widget.dsaLoginResponse);
      SharedPreferenceUtils.sharedPreferenceUtils
          .setLogindata(jsonEncode(widget.dsaLoginResponse!));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DVDashboard(context: context)),
          (Route<dynamic> route) =>false);
    } else {
      SuccessfulResponse.showScaffoldMessage(otpResponseDTO.message!, context);
    }
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
