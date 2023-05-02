import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/aadhaardetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/postalcodebloc.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/aadharuploaddto.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/postalmappingrequest.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/postcodemappingresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/loantype/aadharcompletedetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilderv1.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/switch/switch_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AadharDetails extends StatefulWidget {
  final String mobileNumber;
  final String flag;

  const AadharDetails(
      {Key? key, this.mobileNumber = "9664503167", this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AadhaarDetailsState();
}

class _AadhaarDetailsState extends State<AadharDetails>
    implements AppLoadingMultiple {
  AadhaarDetailsBloc? aadhaarDetailsBloc;
  TextEditingController pinEditingController = TextEditingController();
  GlobalKey<CustomImageBuilderState> _fronAadhaarCard = GlobalKey();
  GlobalKey<CustomImageBuilderV1State> _backAadhaarCard = GlobalKey();
  late PLFetchBloc plFetchBloc;
  bool isSwitchPressed = false;
  bool isNoPressed = true;
  late CustomerBoardingBloc boardingBloc;

  PostalCodeMapping? postalCodeMapping =
      PostalCodeMapping(districtMaster: null, stateMaster: null);
  PostalCodeBloc? postalCodeBloc;
  @override
  void initState() {
    // TODO: implement initState
    boardingBloc = CustomerBoardingBloc();
    aadhaarDetailsBloc = AadhaarDetailsBloc();
    BlocProvider.setBloc<AadhaarDetailsBloc>(aadhaarDetailsBloc);
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    postalCodeBloc = PostalCodeBloc(this);
    super.initState();

    if (plFetchBloc!.onBoardingDTO!.isAadharLinkedToMobile != null) {
      isSwitchPressed = plFetchBloc!.onBoardingDTO!.isAadharLinkedToMobile!;
    }
  }

  GlobalKey<_AadhaarDetailsState> _scrollViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView(
        isHeaderColor: false,
        isBurgerVisble: false,
        isdhavarshalogovisible: true,
        isBackDialogRequired: true,
        body: ValueListenableBuilder(
            valueListenable:
                aadhaarDetailsBloc!.connectionStatusOfAadharDetails,
            builder: (_, status, Widget? child) {
              return SingleChildScrollView(
                key: _scrollViewKey,
                child: _getBody(),
              );
            }),
        context: context,
        isStepShown: false);
  }

  Widget _getBody() {
    return Stack(
      children: [
        ClipPath(
            clipper: CurveImage(),
            child: Container(
              height: 200,
              width: SizeConfig.screenWidth,
              color: AppColors.white,
            )),
        Container(
          constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).viewInsets.top -
                  MediaQuery.of(context).viewInsets.bottom -
                  30),
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              // _getTitleCompoenentNEW(),
                              Text(
                                "",
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "",
                                  style: CustomTextStyles.regularMediumGreyFontGotham,
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Image.asset(
                                  DhanvarshaImages.plpic,
                                  height: 125,
                                  width: 125,
                                ),
                              ),
                              _getTitleCompoenentNEW(),
                              // Container(
                              //   margin: EdgeInsets.symmetric(vertical: 10),
                              //   child: _getCardDetails(),
                              // ),
                              _getHoirzontalImageUpload()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _getCardDetails(),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              CustomButton(
                onButtonPressed: () async {
                  navigateToOtherScreen();
                },
                title: "CONTINUE",
              ),
            ],
          ),
        )
      ],
    );
  }

  uploadAadhaarToServer() async {
    print(_fronAadhaarCard.currentState?.imagepicked.value);
    if (_fronAadhaarCard.currentState?.imagepicked.value == null ||
        _fronAadhaarCard.currentState?.imagepicked.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Upload Aadhaar Front View")));
      return;
    }

    print(_backAadhaarCard.currentState?.imagepicked.value);

    if (_backAadhaarCard.currentState?.imagepicked.value == null ||
        _backAadhaarCard.currentState?.imagepicked.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Upload Aadhaar Back View")));
      return;
    }

    String frontimagePath = _fronAadhaarCard.currentState!.imagepicked.value;
    String frontfileName = _fronAadhaarCard.currentState!.fileName;
    String backimagePath = _backAadhaarCard.currentState!.imagepicked.value;
    String backimagefileName = _backAadhaarCard.currentState!.fileName;

    List<String> aadharFilesName = [frontfileName, backimagefileName];

    AadharUploadDTO upload = AadharUploadDTO(
        fileNames: aadharFilesName,
        id: plFetchBloc.onBoardingDTO?.id,
        type: "PL");

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(upload.toEncodedJson()),
      "Myfiles": [
        await MultipartFile.fromFileSync(frontimagePath,
            filename: frontfileName),
        await MultipartFile.fromFileSync(backimagePath,
            filename: backimagefileName)
      ],
    });

    aadhaarDetailsBloc?.getAadhaarDetails(
        formData,
        () => {
              print("Aadhaar Details Are"),
              getPostalCodeDetails(aadhaarDetailsBloc!.aadhaarDTO!.pincode!),
              // getPostalCodeDetails(aadhaarDetailsBloc!.aadhaarDTO!.pincode!),
            },
        () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("OCR failed to detect text")))
            });
  }

  Widget _getTitleCompoenent() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConstants.customerAadhaarDetails,
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
            // SwitchScreen()
          ],
        ),
      ),
    );
  }

  navigateToOtherScreen() async {
    int aadhaarFronId = MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    int aadhaarBackId = MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarBackKey);
    print("Front Id" + aadhaarFronId.toString());
    print("Back Id" + aadhaarBackId.toString());
    if (_fronAadhaarCard.currentState?.imagepicked.value == null ||
        _fronAadhaarCard.currentState?.imagepicked.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload aadhaar front view")));
      return;
    }

    print(_backAadhaarCard.currentState?.imagepicked.value);

    if (_backAadhaarCard.currentState?.imagepicked.value == null ||
        _backAadhaarCard.currentState?.imagepicked.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload aadhaar back view")));
      return;
    }

    // if (aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber == "" ||
    //     aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text("Please Upload Valid Aadhaar Card")));
    //   return;
    // }

    if (false) {
      CustomerOnBoarding.IsAadharLinkedToMobile = true;
      CustomerOnBoarding.AadhaarFromImage = "";
      CustomerOnBoarding.AaadhaarBackImage = "";
      CustomerOnBoarding.AadhaarFronPath = "";
      CustomerOnBoarding.AadhaarBackPath = "";
    } else {
      CustomerOnBoarding.AadhaarFromImage =
          _fronAadhaarCard.currentState!.fileName;

      print("Here seeting");
      print(_fronAadhaarCard.currentState!.fileName);
      print(_fronAadhaarCard.currentState!.imagepicked.value);
      CustomerOnBoarding.AaadhaarBackImage =
          _backAadhaarCard.currentState!.fileName;
      CustomerOnBoarding.AadhaarFronPath =
          _fronAadhaarCard.currentState!.imagepicked.value;
      CustomerOnBoarding.AadhaarBackPath =
          _backAadhaarCard.currentState!.imagepicked.value;
      CustomerOnBoarding.IsAadharLinkedToMobile = isSwitchPressed;

      pusDataToServer();
    }
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        // height: SizeConfig.screenHeight * 0.16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aadhaar mobile number",
                    style: CustomTextStyles.boldLargeFonts,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Is the below mobile number linked\nto customer’s Aadhaar",
                          style: CustomTextStyles.regularMedium2GreyFont1,
                        ),
                        Text(
                          "+91 ${CustomerDetailsDTO.mobileNumber}",
                          style: CustomTextStyles.boldMedium1Font,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 55,
                      height: 35,
                      activeColor: AppColors.buttonRed,
                      value: isSwitchPressed,
                      onToggle: (value) {
                        setState(() {
                          isSwitchPressed = value;
                        });
                        print(value);
                      },
                    ),
                  ]),
            ],
          ),
        ),
        // color: AppColors.white,
      ),
    );
  }

  Widget _getOKKycDetails() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Verify With O-KYC",
                    style: CustomTextStyles.boldLargeFonts,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Aadhaar verifications using O-KYC helps increase the chance of eligibility and make the loan approval disbursment faster",
                      style: CustomTextStyles.regularMedium2GreyFont1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Instantly verify your Aadhaar by opting this proces",
                      style: CustomTextStyles.regularMediumGreyFont1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DialogUtils.showKycDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Learn More",
                        style: CustomTextStyles.boldMediumRedFont,
                      ),
                    ),
                  )
                ],
              ),
            )),
        // color: AppColors.white,
      ),
    );
  }

  getPostalCodeDetails(String pinCode) async {
    PostMappingRequest postMappingRequest = PostMappingRequest();
    postMappingRequest.pincode = pinCode;

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          postMappingRequest.toEncodedJson())
    });

    postalCodeBloc!.getPostalCodeDetails(formData);
  }

  Widget _getButtonCompoenent() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Text(
              "Is The Customer's Aadhaar Card link to their register mobile number . +91 9867106967?",
              style: CustomTextStyles.regularSmallGreyFont,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      DialogUtils.aadhaarOtpVerificationDialog(context,
                          onVerifyPressed: (text) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AadhaarCompleteDetails(
                              isaadhaarDetailsFilled: true,
                            ),
                          ),
                        );
                      },
                          pineditingController: pinEditingController,
                          mobileNumber: CustomerDetailsDTO.mobileNumber);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecorationStyles.outButtonOfBox,
                      width: (SizeConfig.screenWidth - 40) / 2,
                      height: 50,
                      child: Text(
                        "YES",
                        style: CustomTextStyles.regularMediumFont,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isNoPressed = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecorationStyles.outButtonOfBox,
                      width: (SizeConfig.screenWidth - 40) / 2,
                      height: 50,
                      child: Text(
                        "NO",
                        style: CustomTextStyles.regularMediumFont,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
      onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements = [];
      onBoardingDto.salarySlips = [];
      onBoardingDto.aadharNumber = plFetchBloc.onBoardingDTO!.aadharNumber;
      onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
      onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
      onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
      onBoardingDto.pANNumber = plFetchBloc.onBoardingDTO!.pANNumber;
      onBoardingDto.pANImage = "";
      onBoardingDto.isAadharLinkedToMobile =
          plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
      onBoardingDto.aadharNumber = plFetchBloc.onBoardingDTO!.aadharNumber;
      onBoardingDto.customerImage = "";
      onBoardingDto.emailID = plFetchBloc.onBoardingDTO!.emailID;
      onBoardingDto.presentMonthlyEMI =
          plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
      onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = plFetchBloc.onBoardingDTO!.dOB;

      onBoardingDto.pincode = plFetchBloc.onBoardingDTO!.pincode; // changine
      onBoardingDto.currentAddress1 =
          plFetchBloc.onBoardingDTO!.currentAddress1;
      ;
      onBoardingDto.currentAddress2 =
          plFetchBloc.onBoardingDTO!.currentAddress2;
      ;
      onBoardingDto.currentAddress3 =
          plFetchBloc.onBoardingDTO!.currentAddress3;
      onBoardingDto.permanentAddress1 =
          plFetchBloc.onBoardingDTO!.permanentAddress1;
      onBoardingDto.permanentAddress2 =
          plFetchBloc.onBoardingDTO!.permanentAddress2;
      onBoardingDto.permanentAddress3 =
          plFetchBloc.onBoardingDTO!.permanentAddress3;

      print("Front iMage is" + CustomerOnBoarding.AadhaarFromImage);
      onBoardingDto.aadharFrontImage =
          plFetchBloc.onBoardingDTO!.aadharFrontImage !=
                  CustomerOnBoarding.AadhaarFronPath
              ? CustomerOnBoarding.AadhaarFromImage
              : "";
      onBoardingDto.aadharBackImage =
          plFetchBloc.onBoardingDTO!.aadharBackImage !=
                  CustomerOnBoarding.AadhaarBackPath
              ? CustomerOnBoarding.AaadhaarBackImage
              : "";
      onBoardingDto.employmentProofPhoto = "";
      onBoardingDto.employmentIDPhoto = "";
      onBoardingDto.oKYCDocument = "";
      onBoardingDto.loanAmount =
          CustomerOnBoarding.LoanAmount.toDouble(); // changinef
      onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
      onBoardingDto.employerName = plFetchBloc.onBoardingDTO!.employerName;
      onBoardingDto.entityTypeEmployer =
          plFetchBloc.onBoardingDTO!.entityTypeEmployer;
      onBoardingDto.modeOfSalary = plFetchBloc.onBoardingDTO!.modeOfSalary;
      onBoardingDto.netSalary = plFetchBloc.onBoardingDTO!.netSalary;
      onBoardingDto.employmentType = plFetchBloc.onBoardingDTO!.employmentType;
      onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
      onBoardingDto.addressProof = plFetchBloc.onBoardingDTO!.addressProof;
      onBoardingDto.addressProofPhoto = "";
      onBoardingDto.rentalAgreementImage = "";

      List<MultipartFile> appFiles = [];

      print("Aadhaar Fron kEy" +
          onBoardingDto.aadharBackDocumentTypeId.toString());
      print("AAdhaar Back Key" +
          onBoardingDto.aadharBackDocumentTypeId.toString());
      print(plFetchBloc.onBoardingDTO!.aadharFrontImage);
      print(CustomerOnBoarding.AadhaarFronPath);
      if (CustomerOnBoarding.AadhaarFronPath != "" &&
          plFetchBloc.onBoardingDTO!.aadharFrontImage !=
              CustomerOnBoarding.AadhaarFronPath) {
        print("Aadhaar 1 Updated");
        appFiles.add(MultipartFile.fromFileSync(
            CustomerOnBoarding.AadhaarFronPath,
            filename: CustomerOnBoarding.AadhaarFromImage));
      }

      if (CustomerOnBoarding.AadhaarBackPath != "" &&
          plFetchBloc.onBoardingDTO!.aadharBackImage !=
              CustomerOnBoarding.AadhaarBackPath) {
        print("Aadhaar 2 Updated");
        appFiles.add(MultipartFile.fromFileSync(
            CustomerOnBoarding.AadhaarBackPath,
            filename: CustomerOnBoarding.AaadhaarBackImage));
      }
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

      print("Front Image" + onBoardingDto.aadharFrontImage.toString());

      print(plFetchBloc.onBoardingDTO!.aadharFrontImage !=
          CustomerOnBoarding.AadhaarFronPath);
      print("Back Image" + onBoardingDto.aadharBackImage.toString());
      // print(formData.files[0].value);
      boardingBloc.applyForPersonalLoan(
          formData,
          context,
          (dto) => {
                if (dto!.status!)
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AadhaarCompleteDetails(
                          countryDTO: postalCodeMapping!.countryMaster != null
                              ? [postalCodeMapping!.countryMaster!]
                              : const [],
                          stateDTO: postalCodeMapping!.stateMaster != null
                              ? [postalCodeMapping!.stateMaster!]
                              : const [],
                          districtDTO: postalCodeMapping!.districtMaster != null
                              ? [postalCodeMapping!.districtMaster!]
                              : const [],
                        ),
                      ),
                    )
                  }
                else
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                  }
              });
    }
    // print(onBoardingDto.toJsonEncode());
  }

  Widget _getTitleCompoenentNEW() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "Customers Aadhaar details",
              style: CustomTextStyles.MediumBoldLightFont,
            ),
          ),
          GestureDetector(
            onTap: () {
              DialogUtils.UploadInsturctionDialog(context);
            },
            child: Image.asset(
              DhanvarshaImages.question,
              height: 25,
              width: 25,
            ),
          )
        ],
      ),
    );
  }

  // Widget _getHoirzontalImageUpload() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 10),
  //     child: Row(
  //       children: [
  //         CustomImageBuilder(
  //           key: _fronAadhaarCard,
  //           image: DhanvarshaImages.nadhar,
  //           value: "Your Aadhaar",
  //           description: AppConstants.aadharUploadDescription,
  //           isAadhaarImage: true,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CustomButton(
            onButtonPressed: () {
              // navigateToOtherScreen();
            },
            title: "CONTINUE",
            boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
          ),
          Text(
            "I DON'T HAVE AADHAAR CARD",
            style: CustomTextStyles.boldsmallRedFontGotham,
          )
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CustomImageBuilder(
            isAadhaarORPan: false,
            isPan: true,
            initialImage: plFetchBloc.onBoardingDTO!.aadharFrontImage!,
            key: _fronAadhaarCard,
            image: DhanvarshaImages.nadhar,
            value: "Upload Aadhaar",
            description: AppConstants.aadharUploadDescription,
            isAadhaarImage: true,
            no: "${(aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != null && aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != "") ? "Aadhaar : "
                "${aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber}" : plFetchBloc.onBoardingDTO!.aadharNumber != ""
                "Aadhaar : ${plFetchBloc.onBoardingDTO!.aadharNumber}" ? "" : ""}",
            anotherImageKey: _backAadhaarCard,
            firstImageUploaded: () {
              if (_backAadhaarCard.currentState != null) {
                print("Back Aadhaar Card");
                print(_backAadhaarCard.currentState?.imagepicked.value);
                if (Uri.parse(_backAadhaarCard.currentState!.imagepicked.value)
                    .isAbsolute) {
                  _backAadhaarCard.currentState!.imagepicked.value = "";
                }
              }
              if (_fronAadhaarCard.currentState!.imagepicked.value != "" &&
                  _backAadhaarCard.currentState!.imagepicked.value != "") {
                uploadAadhaarToServer();
              }
            },
            secondImageUploaded: () {
              if (Uri.parse(_fronAadhaarCard.currentState!.imagepicked.value)
                  .isAbsolute) {
                _fronAadhaarCard.currentState!.imagepicked.value = "";
                _backAadhaarCard.currentState!.imagepicked.value = "";
                _backAadhaarCard.currentState!.imagepicked.notifyListeners();
                _fronAadhaarCard.currentState!.imagepicked.notifyListeners();
                SuccessfulResponse.showScaffoldMessage(
                    "You need to change both images", context);
                return;
              }

              if (_fronAadhaarCard.currentState!.imagepicked.value != "" &&
                  _backAadhaarCard.currentState!.imagepicked.value != "") {
                uploadAadhaarToServer();
              }
            },
            secondInitialImage: plFetchBloc.onBoardingDTO!.aadharBackImage!,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pinEditingController.dispose();
    _backAadhaarCard.currentState?.dispose();
    _fronAadhaarCard.currentState?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  fetchPostCodeDetails() {}

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    print("Successful Response ---------");
    print(jsonEncode(dto));

    postalCodeMapping = PostalCodeMapping.fromJson(jsonDecode(dto.data!));

    print("All Masters ---------");
    print(postalCodeMapping!.districtMaster);
    print(postalCodeMapping!.stateMaster);
    print(postalCodeMapping!.countryMaster);

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
