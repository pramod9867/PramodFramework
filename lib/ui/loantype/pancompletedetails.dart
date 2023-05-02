import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/businessaadhaarbloc.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/customerdetailsbloc.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/pandetailsdto.dart';
import 'package:dhanvarsha/model/request/panplrequest.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/response/pansuccessfulresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PanCompleteDetails extends StatefulWidget {
  final bool isPanDetailsFilled;

  const PanCompleteDetails({Key? key, this.isPanDetailsFilled = true})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _PanDetailsState();
}

class _PanDetailsState extends State<PanCompleteDetails> implements AppLoading {
  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "MALE", calories: 110),
    FavouriteFoodModel(foodName: "FEMALE", calories: 110),
  ];
  FavouriteFoodModel _favouriteFoodModel = FavouriteFoodModel();
  late List<DropdownMenuItem<FavouriteFoodModel>>
      _favouriteFoodModelDropdownList;
  List<DropdownMenuItem<FavouriteFoodModel>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList) {
    List<DropdownMenuItem<FavouriteFoodModel>> items = [];
    for (FavouriteFoodModel favouriteFoodModel in favouriteFoodModelList) {
      items.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(
          favouriteFoodModel.foodName!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  BusinessAadhaarBloc? businessAadhaarBloc;
  onChangeFavouriteFoodModelDropdown(FavouriteFoodModel? favouriteFoodModel) {
    setState(() {
      _favouriteFoodModel = favouriteFoodModel!;
    });
  }

  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;
  @override
  void initState() {
    super.initState();
    businessAadhaarBloc = BusinessAadhaarBloc(this);
    PanDetailsBloc panDetailsBloc = BlocProvider.getBloc<PanDetailsBloc>();
    BlocProvider.setBloc<PanDetailsBloc>(panDetailsBloc);
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    // print(panDetailsBloc.panResponseDTO?.panNumber);
    if (true) {
      firstEditingController.text =
          (panDetailsBloc?.panResponseDTO?.firstName != null
              ? panDetailsBloc?.panResponseDTO?.firstName
              : plFetchBloc.onBoardingDTO!.panFirstName != ""
                  ? plFetchBloc.onBoardingDTO!.panFirstName
                  : "")!;

      middleEditingController.text =
          (panDetailsBloc?.panResponseDTO?.middleName != null
              ? panDetailsBloc?.panResponseDTO?.middleName
              : plFetchBloc.onBoardingDTO!.panMiddleName != ""
                  ? plFetchBloc.onBoardingDTO!.panMiddleName
                  : "")!;

      lastEditingController.text =
          (panDetailsBloc?.panResponseDTO?.lastName != null
              ? panDetailsBloc?.panResponseDTO?.lastName
              : plFetchBloc.onBoardingDTO!.panLastName != ""
                  ? plFetchBloc.onBoardingDTO!.panLastName
                  : "")!;
      ;
      dateController.text = panDetailsBloc?.panResponseDTO?.dateOfBirth != null
          ? panDetailsBloc.panResponseDTO!.dateOfBirth!
          : plFetchBloc.onBoardingDTO!.dOB!;
      aadhaarEditingController.text =
          panDetailsBloc?.panResponseDTO?.panNumber != null
              ? panDetailsBloc.panResponseDTO!.panNumber!
              : plFetchBloc.onBoardingDTO!.pANNumber!;
    }
  }

  var isValidatePressed = false;
  TextEditingController firstEditingController = new TextEditingController();
  TextEditingController middleEditingController = new TextEditingController();
  TextEditingController lastEditingController = new TextEditingController();
  TextEditingController aadhaarEditingController = new TextEditingController();
  TextEditingController aadressEditingController = new TextEditingController();
  TextEditingController pinEditingController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstEditingController.dispose();
    middleEditingController.dispose();
    lastEditingController.dispose();
    aadhaarEditingController.dispose();
    aadressEditingController.dispose();
    pinEditingController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleCompoenent(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    // textInputType: TextInputType.number,
                    controller: aadhaarEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Pan",
                    textInpuFormatter: [
                      LengthLimitingTextInputFormatter(10),
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                    ],
                    hintText: "Please enter pan number",
                    errorText: "Please enter valid pan number",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.isPan,
                    isTitleVisible: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    controller: firstEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "First name",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
                    ],
                    hintText: "Please enter first name",
                    errorText: "Please enter valid first name",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    isTitleVisible: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    controller: middleEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Middle name",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
                    ],
                    hintText: "Please enter middle name",
                    errorText: "Please enter valid middle name",
                    maxLine: 1,
                    isValidatePressed: false,
                    isTitleVisible: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    controller: lastEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Last name",
                    hintText: "Please enter last name",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
                    ],
                    errorText: "Please enter valid last name",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    isTitleVisible: true,
                  ),
                ),
                // Container(
                //     margin: EdgeInsets.symmetric(vertical: 10),
                //     child: CustomDropdown(
                //       dropdownMenuItemList: _favouriteFoodModelDropdownList,
                //       onChanged: onChangeFavouriteFoodModelDropdown,
                //       value: _favouriteFoodModel,
                //       isEnabled: true,
                //     )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDatePicker(
                    controller: dateController,
                    isValidateUser: isValidatePressed,
                    selectedDate: dateController.text,
                    isTitleVisible: true,
                  ),
                ),
                Container(
                  child: CustomButton(
                    onButtonPressed: () async {
                      setState(() {
                        isValidatePressed = true;
                      });
                      print(dateController.text);
                      //
                      // CustomValidator(middleEditingController.value.text)
                      //     .validate(Validation.isEmpty) &&
                      if (CustomValidator(firstEditingController.value.text)
                              .validate(Validation.isEmpty) &&
                          CustomValidator(aadhaarEditingController.value.text)
                              .validate(Validation.isPan) &&
                          CustomValidator(lastEditingController.value.text)
                              .validate(Validation.isEmpty) &&
                          dateController.text != "") {
                        CustomerOnBoarding.panFirstName =
                            firstEditingController.text;
                        CustomerOnBoarding.panMiddleName =
                            middleEditingController.text;
                        CustomerOnBoarding.panLastName =
                            lastEditingController.text;

                        // CustomerOnBoarding.PANNumber =
                        //     aadhaarEditingController.text;
                        addPLPanDetailsToServer();
                        // await pusDataToServer();
                      }
                    },
                    title: "CONFIRM THIS INFORMATION",
                  ),
                ),
              ],
            ),
          ),
        ),
        context: context);
  }

  addPLPanDetailsToServer() async {
    PanPLRequestDTO panResponseDTO = PanPLRequestDTO();

    panResponseDTO.firstName = firstEditingController.text;
    panResponseDTO.middleName = middleEditingController.text;
    panResponseDTO.lastName = lastEditingController.text;
    panResponseDTO.refPLId = plFetchBloc.onBoardingDTO!.id;
    panResponseDTO.panNumber = aadhaarEditingController.text;
    panResponseDTO.dOB=dateController.text;

    FormData formData = FormData.fromMap({
      'json':
          await EncryptionUtils.getEncryptedText(panResponseDTO.toEncodedJson())
    });

    // print(formData.files);
    businessAadhaarBloc!.addPLPanDetails(formData);
    // aadh
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
      onBoardingDto.pANNumber = CustomerOnBoarding.PANNumber;
      onBoardingDto.pANImage = "";
      onBoardingDto.isAadharLinkedToMobile =
          plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
      onBoardingDto.customerImage = "";
      onBoardingDto.emailID = plFetchBloc.onBoardingDTO!.emailID;
      onBoardingDto.presentMonthlyEMI =
          plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
      onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = CustomerOnBoarding.DOB;
      onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
      onBoardingDto.currentAddress1 = CustomerOnBoarding.CurrentAddress1;
      ;
      onBoardingDto.currentAddress2 = CustomerOnBoarding.CurrentAddress2;
      ;
      onBoardingDto.currentAddress3 = CustomerOnBoarding.CurrentAddress3;
      onBoardingDto.permanentAddress1 = CustomerOnBoarding.PermanentAddress1;
      onBoardingDto.permanentAddress2 = CustomerOnBoarding.PermanentAddress2;
      onBoardingDto.permanentAddress3 = CustomerOnBoarding.PermanentAddress3;

      print("Front iMage is" + CustomerOnBoarding.AadhaarFromImage);
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
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      onBoardingDto.rentalAgreementImage = "";
      // onBoardingDto.isCurrentAndPermanentAddressSame =
      //     CustomerOnBoarding.currentAddressSameAsPermanant;
      // List<MultipartFile> appFiles = [];
      // //
      // // print(plFetchBloc.onBoardingDTO!.aadharFrontImage);
      // // print(CustomerOnBoarding.AadhaarFronPath);
      // if (CustomerOnBoarding.panImagePath != "" &&
      //     plFetchBloc.onBoardingDTO!.pANImage !=
      //         CustomerOnBoarding.panImagePath) {
      //   print("Pan Updated");
      //   appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
      //       filename: CustomerOnBoarding.PANImage));
      // }
      //
      // if (CustomerOnBoarding.ProfilePhoto != "" &&
      //     plFetchBloc.onBoardingDTO!.aadharBackImage !=
      //         CustomerOnBoarding.profileImagePath) {
      //   print("Profile Updated");
      //   appFiles.add(MultipartFile.fromFileSync(
      //       CustomerOnBoarding.profileImagePath,
      //       filename: CustomerOnBoarding.ProfilePhoto));
      // }
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
      });
      //
      //
      // // print(formData.files[0].value);
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

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "Please Confirm the Customer's Pan details",
        style: CustomTextStyles.BoldTitileFont,
      ),
    );
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    PanSuccessfulResponseDTO panSuccessfulResponseDTO =
        PanSuccessfulResponseDTO.fromJson(jsonDecode(dto.data!));

    if (panSuccessfulResponseDTO.status!) {
      SuccessfulResponse.showScaffoldMessage(
          panSuccessfulResponseDTO.message!, context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetails(),
        ),
      );
    } else {
      SuccessfulResponse.showScaffoldMessage(
          panSuccessfulResponseDTO.message!, context);
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

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
