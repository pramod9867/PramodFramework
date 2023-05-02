import 'dart:async';
import 'dart:convert';

import 'package:dhanvarsha/bloc/clientverify.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/clientverifydto.dart';
import 'package:dhanvarsha/model/request/verifyotp.dart';
import 'package:dhanvarsha/model/response/verifyotpresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/loantype/selectloantype.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration/reg/Rejistration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class NumberVerification extends StatefulWidget {
  final int count;
  final String mobileNumber;
  final String otp;
  final int clientID;
  final int loanID;
  final bool isChangeNumber;
  final int refId;
  final String statusFlag;
  final String name;
  const NumberVerification(
      {Key? key,
      required BuildContext context,
      this.count = -1,
      this.mobileNumber = "",
      this.otp = "",
      this.refId = 0,
      this.clientID = 0,
      this.loanID = 0,
      this.isChangeNumber = true,
      this.name = "",
      this.statusFlag = ""})
      : super(key: key);

  @override
  _NumberVerificationState createState() => _NumberVerificationState();
}

class _NumberVerificationState extends State<NumberVerification>
    implements AppLoading {
  GlobalKey key = GlobalKey();
  var isValidatePressed = false;
  Timer? _timer;
  late ClientVerifyBloc clientVerifyBloc;
  PLFetchBloc? plFetchBloc;
  ValueNotifier<int> isOtpSend = ValueNotifier(60);
  late TextEditingController pinEditingController;

  bool value = false;
  @override
  void initState() {
    // TODO: implement initState
    pinEditingController = TextEditingController(text: widget.otp);
    clientVerifyBloc = ClientVerifyBloc.appLoading(this);
    plFetchBloc = PLFetchBloc.appLoading(this);
    BlocProvider.setBloc<PLFetchBloc>(plFetchBloc);
    startTimer();
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
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight -
              45 -
              MediaQuery.of(context).viewInsets.top -
              MediaQuery.of(context).viewInsets.bottom -
              20),
      // height: SizeConfig.screenHeight - 45 - SizeConfig.verticalviewinsects,
      margin: EdgeInsets.symmetric(horizontal: 10),
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
              "Enter Customer's One Time Password",
              style: CustomTextStyles.boldLargeFontsGotham,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Enter 4 digit code we have sent you via SMS to the customer's mobile number",
              //   style: CustomTextStyles.regularMediumGreyFont,
              // ),

              RichText(
                text: TextSpan(
                    text:
                        "Enter 4 digit code we have sent you via SMS to the customer's mobile number ",
                    style: CustomTextStyles.regularMediumGreyFontGotham,
                    children: <TextSpan>[
                      TextSpan(
                        text: "+91 " + widget.mobileNumber,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18 * SizeConfig.textScaleFactor,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black
                        ),
                      ),
                    ]),
              ),
              // Text("+91 " + widget.mobileNumber,
              //     style: CustomTextStyles.boldLargeFonts),
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
                              color: Colors.red[600]),
                        ),
                      ),
                    )
                  : Container()
            ],
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: PinInputTextField(
              key: key,
              controller: pinEditingController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onSubmit: (text) async {
                if (text.length == 4) {
                  if (value) {
                    await authentiCateOTP();
                  } else {
                    SuccessfulResponse.showScaffoldMessage(
                        "Please check declaration", context);
                  }
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please filled 4 digit otp", context);
                }
              },
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
                      verifyClient();
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
                      child: Text('RESEND CODE IN ${isOtpSend.value} SECONDS',
                          style: CustomTextStyles.regularMediumGreyFontGotham),
                    ),
                  );
                }
              }),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Container(
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      AppConstants.consonantMessage,
                      style: CustomTextStyles.regularSmallGreyFontGotham,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              if (widget.count == -1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoanFlowSuccessful(),
                  ),
                );
              } else {
                if (pinEditingController.text.length == 4) {
                  if (value) {
                    await authentiCateOTP();
                  } else {
                    SuccessfulResponse.showScaffoldMessage(
                        "Please check declaration", context);
                  }
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please enter valid otp", context);
                }
              }
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
                'VERIFY OTP',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }

  verifyClient() async {
    ClientVerifyDTO clientVerifyDTO = ClientVerifyDTO();
    clientVerifyDTO.pincode = CustomerOnBoarding.Pincode;
    clientVerifyDTO.loanAmount = CustomerOnBoarding.LoanAmount;
    clientVerifyDTO.mobileNo = widget.mobileNumber;
    clientVerifyDTO.fullName = CustomerOnBoarding.FirstName +
        " " +
        CustomerOnBoarding.FatherName +
        " " +
        CustomerOnBoarding.LastName;
    clientVerifyDTO.pAN = CustomerOnBoarding.PANNumber;

    print(clientVerifyDTO.toEncodedJson());

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          clientVerifyDTO.toEncodedJson()),
    });

    await clientVerifyBloc.verifyClientSingle(formData, isSuccessful: false);

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

  authentiCateOTP() async {
    VerifyOTP verifyOTP = VerifyOTP();
    verifyOTP.oTP = pinEditingController.text;
    verifyOTP.mobileNumber = widget.mobileNumber;
    verifyOTP.refID = widget.refId;

    print(verifyOTP.toEncodedJson());
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(verifyOTP.toEncodedJson()),
    });

    plFetchBloc!.verifyOTP(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    VerifyOTPResponseDTO verifyOTPResponseDTO =
        VerifyOTPResponseDTO.fromJson(jsonDecode(dto.data!));

    if (verifyOTPResponseDTO.isValidOTP!) {
      // DialogUtils.loanAlreadyExist(context,count: widget.count);
      if (widget.statusFlag == "R") {
        DialogUtils.offerrejectedByLoan(context,
            message:
                "CUSTOMER REJECTED RECENTLY\n YOU CAN RE-APPLY AFTER 30 DAYS");
      } else if (widget.clientID == 0 && widget.loanID == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectLoanType(
              count: widget.count,
              refId: verifyOTPResponseDTO.RefId!,
            ),
          ),
        );
      } else if (widget.clientID != 0 && widget.loanID != 0) {
        DialogUtils.loanAlreadyExist(context, count: widget.count);
      } else if (widget.clientID != 0) {
        // DialogUtils.customernotCreated(context);
        DialogUtils.customernotCreatedV1(context, name: widget.name);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SelectLoanType(
        //       count: widget.count,
        //       refId: verifyOTPResponseDTO.RefId!,
        //     ),
        //   ),
        // );
      }

      // print(plFetchBloc!.onBoardingDTO!.userAddress);
      setState(() {});
    } else {
      SuccessfulResponse.showScaffoldMessage(
          verifyOTPResponseDTO.message!, context);
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(
        AppConstants.errorMessage, context); // TODO: implement showError
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
