import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/faceregonitiondto.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/ui/loantype/pancompletedetails.dart';
import 'package:dhanvarsha/ui/loantype/pandetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UploadProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  GlobalKey<CustomImageBuilderState> _profilePickey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  late PLFetchBloc plFetchBloc;
  PanDetailsBloc? panDetailsBloc;
  late CustomerBoardingBloc boardingBloc;
  @override
  void initState() {
    // TODO: implement initState
    panDetailsBloc = PanDetailsBloc();
    BlocProvider.setBloc<PanDetailsBloc>(panDetailsBloc);
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        stepArray: [1, 2],
        isStepShown: true,
        isBackDialogRequired: true,
        body: ValueListenableBuilder(
            valueListenable: panDetailsBloc!.connectionStatusOfPanDetails,
            builder: (_, status, Widget? child) {
              return _getBody();
            }),
        context: context);
  }

  Widget _getBody() {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitleCompoenentNEW(),
            // _getHoirzontalImageUpload(),
            _getHoirzontalImageUploadProfile(),
            _getContinueButton()
          ],
        ));
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Personal Details .",
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Customer Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
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
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      child: Column(
        children: [
          CustomImageBuilder(
            isAadhaarORPan: false,
            isPan: true,
            initialImage: plFetchBloc.onBoardingDTO!.pANImage!,
            key: _panPickey,
            image: DhanvarshaImages.npan,
            value: "Upload Customer's PAN",
            description: AppConstants.aadharUploadDescription,
            no: (panDetailsBloc?.panResponseDTO?.panNumber != null &&
                    panDetailsBloc?.panResponseDTO?.panNumber != "")
                ? "PAN :- ${panDetailsBloc?.panResponseDTO?.panNumber}"
                : "",
            firstImageUploaded: () {
              uploadPanToServer();
              if (_profilePickey.currentState!.imagepicked.value != "" &&
                  _panPickey.currentState!.imagepicked.value != "" &&
                  !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                      .isAbsolute &&
                  !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                      .isAbsolute) {
                faceMatch();
              }
            },
          ),
        ],
      ),
    );
  }

  uploadPanToServer() {
    PanUpload panUpload = PanUpload(
        fileName: _panPickey.currentState!.fileName,
        id: plFetchBloc.onBoardingDTO!.id,
        type: "PL");

    print("PAN DETAILS ARE");
    print(jsonEncode(panUpload!.toJson()));
    print("Uplaoding Files.......");

    if (Uri.parse(_profilePickey.currentState!.imagepicked.value).isAbsolute) {
      _profilePickey.currentState!.imagepicked.value = "";
      SuccessfulResponse.showScaffoldMessage(
          "Please reupload customer image for face verification", context);
    }

    // Map<String,String> jsonMap = new Map();
    // jsonMap.putIfAbsent("FileName", ()=>"Pramod".toString());
    //
    // String json=jsonEncode(jsonMap);
    // print(json);

    panDetailsBloc!.getPanDetails(
        jsonEncode(panUpload!.toJson()),
        _panPickey.currentState!.imagepicked!.value!,
        _panPickey.currentState!.fileName,
        context);
  }

  faceMatch() async {
    FaceRegonizationDTO recognitionDTO = FaceRegonizationDTO();
    // if (_panPickey.currentState!.imagepicked.value == "") {
    //   return;
    // }

    // if (Uri.parse(_panPickey.currentState!.imagepicked.value).isAbsolute) {
    //   _panPickey.currentState!.imagepicked.value = "";
    //   SuccessfulResponse.showScaffoldMessage(
    //       "Please reupload pan image for face verification", context);
    //   _panPickey.currentState!.imagepicked.notifyListeners();
    //   return;
    // }

    List<String> fileName = [
      // _panPickey.currentState!.fileName,
      _profilePickey.currentState!.fileName
    ];
    recognitionDTO.fileNames = fileName;
    recognitionDTO.id = plFetchBloc.onBoardingDTO!.id;

    List<MultipartFile> files = [];

    // files.add(MultipartFile.fromFileSync(
    //     _panPickey.currentState!.imagepicked.value,
    //     filename: _panPickey.currentState!.fileName));

    files.add(MultipartFile.fromFileSync(
        _profilePickey.currentState!.imagepicked.value,
        filename: _profilePickey.currentState!.fileName));

    print("MY FILES");
    print(files);
    print(fileName);

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          recognitionDTO.toEncodedJson()),
      "Myfiles": files,
    });

    panDetailsBloc?.getFaceDetails(formData);
  }

  Widget _getHoirzontalImageUploadProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CustomImageBuilder(
            isAadhaarORPan: false,
            initialImage: plFetchBloc.onBoardingDTO!.customerImage!,
            no: "",
            isPan: true,
            isProfilePic: true,
            // subtitleImage: DhanvarshaImages.userphoto,
            subtitleImage: DhanvarshaImages.userphoto,
            key: _profilePickey,
            image: DhanvarshaImages.usernewpicprofile,
            value: "Customer's Photo",
            subtitle: "Photo Added",
            subtitleString: "UPLOAD",
            description: AppConstants.aadharUploadDescription,
            firstImageUploaded: () {
              faceMatch();
              // uploadPanToServer();
            },
          ),
        ],
      ),
    );
  }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CustomButton(
            onButtonPressed: () async {
              // faceMatch();
              // if (_panPickey.currentState?.imagepicked.value == null ||
              //     _panPickey.currentState?.imagepicked.value == "") {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("Please upload pan card")));
              //   return;
              // }

              if (_profilePickey.currentState?.imagepicked.value == null ||
                  _profilePickey.currentState?.imagepicked.value == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please upload profile pic")));
                return;
              }

              // if (!Uri.parse(_panPickey.currentState!.imagepicked.value)
              //     .isAbsolute) {
              //   if (panDetailsBloc != null) {
              //     if (panDetailsBloc!.panResponseDTO != null) {
              //       if (panDetailsBloc!.panResponseDTO!.panNumber != null &&
              //           panDetailsBloc!.panResponseDTO!.panNumber != "") {
              //       } else {
              //         SuccessfulResponse.showScaffoldMessage(
              //             "Please upload valid pan", context);
              //         return;
              //       }
              //     } else {
              //       SuccessfulResponse.showScaffoldMessage(
              //           "Please upload valid pan", context);
              //       return;
              //     }
              //   } else {
              //     SuccessfulResponse.showScaffoldMessage(
              //         "Please upload valid pan", context);
              //     return;
              //   }
              // }

              if (Uri.parse(_profilePickey.currentState!.imagepicked.value)
                  .isAbsolute) {
                CustomerOnBoarding.PANImage = "";
                CustomerOnBoarding.panImagePath = "";
                CustomerOnBoarding.profileImagePath =
                    _profilePickey.currentState!.imagepicked.value;
                CustomerOnBoarding.ProfilePhoto =
                    _profilePickey.currentState!.fileName;

                await pusDataToServer();
              } else {
                if (panDetailsBloc!.faceRegonizeResponseDTO!.matchScore! >=
                    30) {
                  CustomerOnBoarding.PANImage = "";
                  CustomerOnBoarding.panImagePath = "";
                  CustomerOnBoarding.profileImagePath =
                      _profilePickey.currentState!.imagepicked.value;
                  CustomerOnBoarding.ProfilePhoto =
                      _profilePickey.currentState!.fileName;

                  await pusDataToServer();
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Face not recognized with adhaar front image please reupload image",
                      context);
                }
              }

              // CustomerOnBoarding.printAll();
            },
            title: "CONTINUE",
            boxDecoration: ButtonStyles.redButtonWithCircularBorder,
          ),
        ],
      ),
    );
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
      onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements = [];
      onBoardingDto.salarySlips = [];
      onBoardingDto.aadharNumber = CustomerOnBoarding.AadharNumber;
      onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
      onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
      onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
      onBoardingDto.pANNumber = plFetchBloc.onBoardingDTO!.pANNumber;
      onBoardingDto.pANImage =
          plFetchBloc.onBoardingDTO!.pANImage != CustomerOnBoarding.panImagePath
              ? CustomerOnBoarding.PANImage
              : "";
      onBoardingDto.isAadharLinkedToMobile =
          plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
      onBoardingDto.customerImage = plFetchBloc.onBoardingDTO!.customerImage !=
              CustomerOnBoarding.profileImagePath
          ? CustomerOnBoarding.ProfilePhoto
          : "";
      onBoardingDto.emailID = plFetchBloc.onBoardingDTO!.emailID;
      onBoardingDto.presentMonthlyEMI =
          plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
      onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = CustomerOnBoarding.DOB;
      onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
      onBoardingDto.currentAddress1 = CustomerOnBoarding.CurrentAddress1;
      onBoardingDto.currentAddress2 = CustomerOnBoarding.CurrentAddress2;
      onBoardingDto.currentAddress3 = CustomerOnBoarding.CurrentAddress3;
      onBoardingDto.permanentAddress1 = CustomerOnBoarding.PermanentAddress1;
      onBoardingDto.permanentAddress2 = CustomerOnBoarding.PermanentAddress2;
      onBoardingDto.permanentAddress3 = CustomerOnBoarding.PermanentAddress3;
      onBoardingDto.aadharFrontImage = "";
      onBoardingDto.aadharBackImage = "";
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
      // onBoardingDto.isCurrentAndPermanentAddressSame =
      //     CustomerOnBoarding.currentAddressSameAsPermanant;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      List<MultipartFile> appFiles = [];
      //
      // print(plFetchBloc.onBoardingDTO!.aadharFrontImage);
      // print(CustomerOnBoarding.AadhaarFronPath);
      if (CustomerOnBoarding.panImagePath != "" &&
          plFetchBloc.onBoardingDTO!.pANImage !=
              CustomerOnBoarding.panImagePath) {
        print("Pan Updated");
        appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
            filename: CustomerOnBoarding.PANImage));
      }

      if (CustomerOnBoarding.ProfilePhoto != "" &&
          plFetchBloc.onBoardingDTO!.aadharBackImage !=
              CustomerOnBoarding.profileImagePath) {
        print("Profile Updated");
        appFiles.add(MultipartFile.fromFileSync(
            CustomerOnBoarding.profileImagePath,
            filename: CustomerOnBoarding.ProfilePhoto));
      }
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

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
                        builder: (context) => EmployeeDetails(),
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
}
