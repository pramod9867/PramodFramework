import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/aadhaardetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/postalcodebloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/uploadimagebloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/aadharuploaddto.dart';
import 'package:dhanvarsha/model/request/basicdetailsupload.dart';
import 'package:dhanvarsha/model/request/postalmappingrequest.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/response/postcodemappingresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessaadharcompletedetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/propertydetails.dart';
import 'package:dhanvarsha/ui/loantype/aadharcompletedetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs7padding/aes_encryption_helper.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilderv1.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/switch/switch_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BusinessAadharDetails extends StatefulWidget {
  final String mobileNumber;
  final String flag;

  const BusinessAadharDetails(
      {Key? key, this.mobileNumber = "9664503167", this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessAadharDetailsState();
}

class _BusinessAadharDetailsState extends State<BusinessAadharDetails>
    implements AppLoadingMultiple {
  TextEditingController pinEditingController = TextEditingController();
  GlobalKey<CustomImageBuilderState> _fronAadhaarCard = GlobalKey();
  GlobalKey<CustomImageBuilderV1State> _backAadhaarCard = GlobalKey();
  AadhaarDetailsBloc? aadhaarDetailsBloc;
  bool isSwitchPressed = true;
  bool isNoPressed = true;
  BLFetchBloc? blFetchBloc;
  PostalCodeMapping? postalCodeMapping =
      PostalCodeMapping(districtMaster: null, stateMaster: null);
  late UploadImageBloc? uploadImageBloc;
  PostalCodeBloc? postalCodeBloc;
  @override
  void initState() {
    aadhaarDetailsBloc = AadhaarDetailsBloc();
    BlocProvider.setBloc<AadhaarDetailsBloc>(aadhaarDetailsBloc);
    uploadImageBloc = UploadImageBloc.appLoadingMultiple(this);
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    postalCodeBloc = PostalCodeBloc(this);
    // TODO: implement initState
    isSwitchPressed = blFetchBloc!.fetchBLResponseDTO.isAadharLinkedToMobile!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      type: false,
      isBackDialogRequired: true,
      body: ValueListenableBuilder(
          valueListenable: aadhaarDetailsBloc!.connectionStatusOfAadharDetails,
          builder: (_, status, Widget? child) {
            return SingleChildScrollView(
              child: _getBody(),
            );
          }),
      context: context,
      isStepShown: true,
      stepArray: [1, 4],
    );
  }

  Widget _getBody() {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            minHeight: SizeConfig.screenHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                45),
        // height: SizeConfig.screenHeight - SizeConfig.verticalviewinsects-50,
     
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            _getTitleCompoenentNEW(),
                            true
                                ? _getHoirzontalImageUpload()
                                : _getOKKycDetails(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _getCardDetails(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            CustomButton(
              onButtonPressed: () {
                if (_fronAadhaarCard.currentState?.imagepicked.value == null ||
                    _fronAadhaarCard.currentState?.imagepicked.value == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please upload aadhaar front view")));
                  return;
                }

                if (_backAadhaarCard.currentState?.imagepicked.value == null ||
                    _backAadhaarCard.currentState?.imagepicked.value == "") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please upload aadhaar back view")));
                  return;
                }

                addDocumentToServer();
              },
              title: "CONTINUE",
            ),
          ],
        ),
      ),
    );
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

  Widget _getCardDetails() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10),
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
                          " ${CustomerOnBoarding.MobileNumber != null ? "+91 " + CustomerOnBoarding.MobileNumber : ""}?",
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
                  ])
            ],
          ),
        ),
        // color: AppColors.white,
      ),
    );
  }

  Widget _getOKKycDetails() {
    return Material(
      elevation: 0,
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

  Widget _getButtonCompoenent() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Text(
              "Is The Customer's Aadhaar Card link to their register mobile number . ${CustomerOnBoarding.MobileNumber}?",
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

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AadhaarCompleteDetails(
                    isaadhaarDetailsFilled: true,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Customer Details",
                  style: CustomTextStyles.boldSubtitleLargeFonts,
                ),
              ],
            ),
            // Container(
            //   child: Text("Mandatory for KYC Verification",
            //       style: CustomTextStyles.regularSmallGreyFont),
            // ),
          ],
        ),
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
            onButtonPressed: () {},
            title: "Continue",
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
            key: _fronAadhaarCard,
            isPan: true,
            image: DhanvarshaImages.nadhar,
            initialImage:
                blFetchBloc!.fetchBLResponseDTO.customersAadharFrontImage!,
            secondInitialImage:
                blFetchBloc!.fetchBLResponseDTO.customersAadharBackImage!,
            value: "Upload Aadhaar",
            description: AppConstants.aadharUploadDescription,
            isAadhaarImage: true,
            no: "${(aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != null && aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != "") ? "Aadhaar : ${aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber}" : ""}",
            anotherImageKey: _backAadhaarCard,
            firstImageUploaded: () {
              if (Uri.parse(_backAadhaarCard.currentState!.imagepicked.value)
                  .isAbsolute) {
                _backAadhaarCard.currentState!.imagepicked.value = "";
              }
            },
            secondImageUploaded: () {
              uploadAadhaarToServer();
            },
          ),
        ],
      ),
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
        id: blFetchBloc!.fetchBLResponseDTO.refBlId,
        type: "BL");

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
        () => {getPostalCodeDetails(aadhaarDetailsBloc!.aadhaarDTO!.pincode!)},
        () => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Something went wrong")))
            });
    // print(formData.files);
  }

  @override
  void dispose() {
    pinEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  getPostalCodeDetails(String pinCode) async {
    PostMappingRequest postMappingRequest = PostMappingRequest();
    postMappingRequest.pincode = pinCode;

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          postMappingRequest.toEncodedJson())
    });

    postalCodeBloc!.getPostalCodeDetails(formData, index: 1);
  }

  addDocumentToServer() async {
    BasicDetailsUpload basicDetailsUpload = BasicDetailsUpload();

    basicDetailsUpload.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    basicDetailsUpload.customersPanImage = "";
    basicDetailsUpload.customersPhotoImage = "";
    basicDetailsUpload.customersAadharFrontImage =
        _fronAadhaarCard.currentState!.fileName;
    basicDetailsUpload.customersAadharBackImage =
        _backAadhaarCard.currentState!.fileName;
    print(basicDetailsUpload.toEncodedJson());
    basicDetailsUpload.isAadharLinkedToMobile = isSwitchPressed;
    List<MultipartFile> appFiles = [];

    if (_fronAadhaarCard.currentState!.imagepicked != "" &&
        !Uri.parse(_fronAadhaarCard.currentState!.imagepicked.value)
            .isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _fronAadhaarCard.currentState!.imagepicked.value,
          filename: _fronAadhaarCard.currentState!.fileName));
    }

    if (_backAadhaarCard.currentState!.imagepicked != "" &&
        !Uri.parse(_backAadhaarCard.currentState!.imagepicked.value)
            .isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _backAadhaarCard.currentState!.imagepicked.value,
          filename: _backAadhaarCard.currentState!.fileName));
    }
    String data = await basicDetailsUpload.toEncodedJson();

    print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(data),
      "Myfiles": appFiles
    });
    ;
    uploadImageBloc!.uploadKycImagesMultiple(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    if (index == 0) {
      BusinessCommonDTO commonDTO =
          BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
      if (commonDTO.status!) {
        SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessAadharCompleteDetails(
              flag: widget.flag,
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
        );
      } else {
        SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
      }
    } else {
      print("INTO THE POSTAL CODE MAPPING -------------------------->");
      print(jsonDecode(dto.data!));
      postalCodeMapping = PostalCodeMapping.fromJson(jsonDecode(dto.data!));
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
