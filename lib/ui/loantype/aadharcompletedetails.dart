import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/aadhaardetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/postalcodebloc.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/postalmappingrequest.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/postcodemappingresponse.dart';
import 'package:dhanvarsha/model/response/refuseraddressdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/addcoapplicant.dart';
import 'package:dhanvarsha/ui/loantype/uploadprofile.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/commautils/common_age_validator.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

class AadhaarCompleteDetails extends StatefulWidget {
  final bool isaadhaarDetailsFilled;
  final List<MasterDataDTO>? stateDTO;
  final List<MasterDataDTO>? districtDTO;
  final List<MasterDataDTO>? countryDTO;

  const AadhaarCompleteDetails(
      {Key? key,
      this.isaadhaarDetailsFilled = false,
      this.stateDTO = const [],
      this.districtDTO = const [],
      this.countryDTO = const []})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AadhaarCompleteState();
}

class _AadhaarCompleteState extends State<AadhaarCompleteDetails>
    implements AppLoadingMultiple {
  late CustomerBoardingBloc boardingBloc;
  late PLFetchBloc plFetchBloc;

  MenueBuilder? countryBuilder, districtBuilder, talukaBuilder, stateBuilder;
  PostalCodeBloc? postalCodeBloc;
  MenueBuilder? currentCountryBuilder,
      currentDistricBuilder,
      currentStateBuilder;

  MenueBuilder? permanantCountryBuilder,
      permanntDistricBuilder,
      permanantStateBuilder;

  late List<DropdownMenuItem<MasterDataDTO>> genderList;
  late List<DropdownMenuItem<MasterDataDTO>> countryList;
  late List<DropdownMenuItem<MasterDataDTO>> stateList;
  late List<DropdownMenuItem<MasterDataDTO>> districtList;
  late List<DropdownMenuItem<MasterDataDTO>> talukatList;
  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select Gender", 0);

  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;

  //setting dropdown values
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select Gender"}) {
    dropdownMenuItems.add(DropdownMenuItem(
      value: MasterDataDTO(initialType, 0),
      child: Text(
        initialType!,
        style: CustomTextStyles.regularMediumFontGothamTextFieldGreyCalendar,
      ),
    ));
    for (MasterDataDTO favouriteFoodModel in favouriteFoodModelList) {
      dropdownMenuItems.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(favouriteFoodModel.name!,
            style: model.value == favouriteFoodModel.value
                ? CustomTextStyles.regularMediumFontGothamTextField
                : CustomTextStyles.boldMediumFontGotham),
      ));
    }
    return dropdownMenuItems;
  }

  bool isSwitchPressed = false;
  bool isCurrentSwitchPressed = true;

  //changing dropdown value in dropdown

  AadhaarDetailsBloc? aadhaarDetailsBloc;
  late MasterBloc? masterBloc;
  GlobalKey<_AadhaarCompleteState> _scrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // BlocProvider.setBloc<AadhaarDetailsBloc>(aadhaarDetailsBloc);
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    if (plFetchBloc == null) {
      plFetchBloc = PLFetchBloc();
    }

    postalCodeBloc = PostalCodeBloc(this);
    var currentAddress = "";
    var aadhaarAddress = "";
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    countryBuilder = MenueBuilder();
    districtBuilder = MenueBuilder();
    stateBuilder = MenueBuilder();

    currentCountryBuilder = MenueBuilder();
    currentDistricBuilder = MenueBuilder();
    currentStateBuilder = MenueBuilder();

    permanantCountryBuilder = MenueBuilder();
    permanntDistricBuilder = MenueBuilder();
    permanantStateBuilder = MenueBuilder();

    aadhaarDetailsBloc = BlocProvider.getBloc<AadhaarDetailsBloc>();
    genderList = [];
    _genderDropdownlist = _buildFavouriteFoodModelDropdown(
        masterBloc?.masterSuperDTO?.genderOptions ?? [],
        genderList,
        _genderDropdownModel);

    if (true) {
      if (plFetchBloc.onBoardingDTO!.userAddress!.length > 0) {
        for (int i = 0;
            i < plFetchBloc.onBoardingDTO!.userAddress!.length;
            i++) {
          if (plFetchBloc.onBoardingDTO!.userAddress![i].addressTypes ==
              MasterDocumentId.builder
                  .getMasterAddressID(MasterDocIdentifier.aadhaarAddress)) {
            aadhaarAddress =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineOne ?? "";
            aadressEditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineOne ?? "";
            countryBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectCountry(
                    plFetchBloc.onBoardingDTO!.userAddress![i].countryId ?? 0));

            stateBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectState(
                    plFetchBloc.onBoardingDTO!.userAddress![i].stateId ?? 0));

            districtBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectDistrict(
                    plFetchBloc.onBoardingDTO!.userAddress![i].districtId ??
                        0));

            aadress1EditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineTwo ?? "";

            aadress2EditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineTwo ?? "";
            // talukaBuilder!.setInitialValue(MasterDocumentId.builder
            //     .getMasterObjectTaluka(
            //         plFetchBloc.onBoardingDTO!.userAddress![0].villageTown ?? ""));

            houseNumberController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].houseNo ?? "";
          } else if (plFetchBloc.onBoardingDTO!.userAddress![i].addressTypes ==
              MasterDocumentId.builder
                  .getMasterAddressID(MasterDocIdentifier.permanantAddress)) {
            isSwitchPressed = true;

            permanantaddressEditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineOne ?? "";
            permanantCountryBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectCountry(
                    plFetchBloc.onBoardingDTO!.userAddress![i].countryId ?? 0));

            permanantStateBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectState(
                    plFetchBloc.onBoardingDTO!.userAddress![i].stateId ?? 0));

            permanntDistricBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectDistrict(
                    plFetchBloc.onBoardingDTO!.userAddress![i].districtId ??
                        0));
            permanantaddressEditingController1.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineTwo ?? "";
            // talukaBuilder!.setInitialValue(MasterDocumentId.builder
            //     .getMasterObjectTaluka(
            //         plFetchBloc.onBoardingDTO!.userAddress![0].villageTown ?? ""));

            permanantpinEditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].postalCode ?? "";

            permananthouseNumberController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].houseNo ?? "";
          } else if (plFetchBloc.onBoardingDTO!.userAddress![i].addressTypes ==
              MasterDocumentId.builder
                  .getMasterAddressID(MasterDocIdentifier.currentAddress)) {
            currentAddress =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineOne ?? "";

            currentaadressEditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineOne ?? "";
            currentCountryBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectCountry(
                    plFetchBloc.onBoardingDTO!.userAddress![i].countryId ?? 0));

            currentStateBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectState(
                    plFetchBloc.onBoardingDTO!.userAddress![i].stateId ?? 0));

            currentDistricBuilder!.setInitialValue(MasterDocumentId.builder
                .getMasterObjectDistrict(
                    plFetchBloc.onBoardingDTO!.userAddress![i].districtId ??
                        0));
            currentaadressEditingController1.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].addressLineTwo ?? "";
            currentpinEditingController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].postalCode ?? "";
            currenthouseNumberController.text =
                plFetchBloc.onBoardingDTO!.userAddress![i].houseNo ?? "";
          }
        }

        // pinEditingController.text= plFetchBloc.onBoardingDTO!.userAddress![0].postalCode.toString()??"";
      }

      if (aadhaarDetailsBloc?.aadhaarDTO?.gender == "MALE") {
        print("Into the MALE");
        print(masterBloc!.masterSuperDTO!.genderOptions![1]!.name);
        _genderDropdownModel = masterBloc!.masterSuperDTO!.genderOptions![1]!;
        genderList = [];

        // print(jsonEncode(_genderDropdownModel));
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      } else if (aadhaarDetailsBloc?.aadhaarDTO?.gender == "FEMALE") {
        _genderDropdownModel = masterBloc!.masterSuperDTO!.genderOptions![0]!;

        genderList = [];

        // print(jsonEncode(_genderDropdownModel));
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      } else {
        int index = MasterDocumentId.builder
            .getGenderIndex(plFetchBloc?.onBoardingDTO?.genderId ?? 0);

        print("Index Is");
        print(index);
        if (index == -1) {
          print("Gender List Length");
          print(genderList.length);
          _genderDropdownModel = genderList.elementAt(0).value!;
        } else {
          print("Into the Else");
          _genderDropdownModel =
              masterBloc!.masterSuperDTO!.genderOptions![index];

          print("Gender Model");

          genderList = [];

          // print(jsonEncode(_genderDropdownModel));
          _genderDropdownlist = _buildFavouriteFoodModelDropdown(
              masterBloc?.masterSuperDTO?.genderOptions ?? [],
              genderList,
              _genderDropdownModel);
        }
      }
      houseNumberController!.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.HouseNo != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.HouseNo
              : plFetchBloc.onBoardingDTO!.userAddress!.length > 0
                  ? plFetchBloc.onBoardingDTO!.userAddress![0].houseNo
                  : "")!;
      firstEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.firstName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.firstName
              : plFetchBloc.onBoardingDTO!.aadhaarFirstName != ""
                  ? plFetchBloc.onBoardingDTO!.aadhaarFirstName
                  : "")!;
      //
      middleEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.middleName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.middleName
              : plFetchBloc.onBoardingDTO!.aadhaarMiddleName != ""
                  ? plFetchBloc.onBoardingDTO!.aadhaarMiddleName
                  : "")!;

      lastEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.lastName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.lastName
              : plFetchBloc.onBoardingDTO!.aadhaarLastName != ""
                  ? plFetchBloc.onBoardingDTO!.aadhaarLastName
                  : "")!;
      dateController.text = (aadhaarDetailsBloc?.aadhaarDTO?.dateOfBirth != null
          ? aadhaarDetailsBloc?.aadhaarDTO?.dateOfBirth
          : plFetchBloc.onBoardingDTO!.dOB != ""
              ? plFetchBloc.onBoardingDTO!.dOB
              : "")!;

      aadhaarEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber
              : plFetchBloc.onBoardingDTO!.aadharNumber != ""
                  ? plFetchBloc.onBoardingDTO!.aadharNumber
                  : "")!;

      String totalText = "";

      if (aadhaarDetailsBloc?.aadhaarDTO?.addressLine1 != null) {
        totalText += aadhaarDetailsBloc?.aadhaarDTO?.addressLine1 ?? "";
      }

      // if (aadhaarDetailsBloc?.aadhaarDTO?.addressLine2 != null) {
      //   totalText += aadhaarDetailsBloc?.aadhaarDTO?.addressLine2 ?? "";
      // }
      //
      // if (aadhaarDetailsBloc?.aadhaarDTO?.addressLine3 != null) {
      //   totalText += aadhaarDetailsBloc?.aadhaarDTO?.addressLine3 ?? "";
      // }

      aadressEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.addressLine1 != null
              ? totalText
              : plFetchBloc.onBoardingDTO!.userAddress!.length > 0
                  ? plFetchBloc.onBoardingDTO!.userAddress![0].addressLineOne
                  : "")!;
      ;

      aadress1EditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.addressLine2 != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.addressLine2
              : plFetchBloc.onBoardingDTO!.userAddress!.length > 0
                  ? plFetchBloc.onBoardingDTO!.userAddress![0].addressLineTwo
                  : "")!;

      pinEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.pincode != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.pincode
              : plFetchBloc.onBoardingDTO!.userAddress!.length > 0
                  ? plFetchBloc.onBoardingDTO!.userAddress![0].postalCode
                  : "")!;

      // aadress1EditingController.text = "";
      // aadress2EditingController.text =
      //     (aadhaarDetailsBloc?.aadhaarDTO?.addressLine3 != null
      //         ? aadhaarDetailsBloc?.aadhaarDTO?.addressLine3
      //         : plFetchBloc.onBoardingDTO!.permanentAddress3 != ""
      //             ? plFetchBloc.onBoardingDTO!.permanentAddress3
      //             : "")!;
    } else {}
    if (aadhaarDetailsBloc != null) {
      if (aadhaarDetailsBloc!.aadhaarDTO != null &&
          aadhaarDetailsBloc!.aadhaarDTO!.aadharNumber != "") {
        stateBuilder!.setInitialValue(widget.stateDTO!);
        districtBuilder!.setInitialValue(widget.districtDTO!);
        countryBuilder!.setInitialValue(widget.countryDTO!);
      }
    }
    if (currentAddress != aadhaarAddress) {
      isCurrentSwitchPressed = false;
    }
  }

  var isValidatePressed = false;
  TextEditingController firstEditingController = new TextEditingController();
  TextEditingController middleEditingController = new TextEditingController();
  TextEditingController lastEditingController = new TextEditingController();
  TextEditingController aadhaarEditingController = new TextEditingController();
  TextEditingController aadressEditingController = new TextEditingController();
  TextEditingController houseNumberController = new TextEditingController();
  TextEditingController pinEditingController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController aadress1EditingController = new TextEditingController();
  TextEditingController aadress2EditingController = new TextEditingController();

  TextEditingController currentaadressEditingController =
      new TextEditingController();

  TextEditingController currentaadressEditingController1 =
      new TextEditingController();
  TextEditingController currenthouseNumberController =
      new TextEditingController();
  TextEditingController currentpinEditingController =
      new TextEditingController();

  TextEditingController permanantaddressEditingController =
      new TextEditingController();
  TextEditingController permanantaddressEditingController1 =
      new TextEditingController();
  TextEditingController permananthouseNumberController =
      new TextEditingController();
  TextEditingController permanantpinEditingController =
      new TextEditingController();

  TextEditingController? houseNoController = new TextEditingController();

  @override
  void dispose() {
    firstEditingController.dispose();
    middleEditingController.dispose();
    lastEditingController.dispose();
    aadhaarEditingController.dispose();
    aadressEditingController.dispose();
    pinEditingController.dispose();
    dateController.dispose();
    aadress1EditingController.dispose();
    aadress2EditingController.dispose();
    houseNumberController.dispose();
    currentaadressEditingController1.dispose();
    permanantaddressEditingController1.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        isBackDialogRequired: true,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleCompoenent(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    textInputType: TextInputType.number,
                    controller: aadhaarEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(12)
                    ],
                    title: "Aadhaar number",
                    hintText: "Please enter aadhaar number",
                    errorText: "Please enter valid aadhaar number",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.isAadhaar,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    controller: firstEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
                    ],
                    title: "First name",
                    hintText: "Please enter first name",
                    errorText: "Please enter valid first name",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
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
                    isTitleVisible: true,
                    isValidatePressed: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    controller: lastEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Last name",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
                    ],
                    hintText: "Please Enter Last Name",
                    errorText: "Please enter valid last name",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDatePicker(
                    controller: dateController,
                    isValidateUser: isValidatePressed,
                    selectedDate: dateController.text,
                    title: "Date of birth",
                    dateTime: dateController.text != ""
                        ? new DateFormat("dd/MM/yyyy")
                            .parse(dateController.text)
                        : DateTime.now(),
                    isTitleVisible: true,  
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDropdownMaster<MasterDataDTO>(
                    dropdownMenuItemList: _genderDropdownlist,
                    onChanged: onChangeFavouriteFoodModelDropdown,
                    value: _genderDropdownModel,
                    isEnabled: true,
                    title: "Gender",
                    isTitleVisible: true,
                    errorText: "Please select gender",
                    isValidate: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    textInputType: TextInputType.text,
                    controller: houseNumberController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "House no",
                    hintText: "Please enter house no",
                    errorText: "Please enter valid house no",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    controller: aadressEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Address line 1",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z0-9 (),.\/-]"))
                    ],
                    hintText: "Please enter address line 1",
                    errorText: "Please enter valid address",
                    maxLine: null,
                    isValidatePressed: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    controller: aadress1EditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Address line 2",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z0-9 (),.\/-]"))
                    ],
                    hintText: "Please enter address line 2",
                    errorText: "Please enter valid address",
                    maxLine: null,
                    isValidatePressed: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    controller: pinEditingController,
                    outTextFieldDecoration:
                    BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                    InputDecorationStyles.inputDecorationTextField,
                    textInputType: TextInputType.number,
                    title: "Pin",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onEnterPressRequired: true,
                    onChangedText: (text) {
                      if (text.length == 6) {
                        getPostalCodeDetails(text);
                      }
                    },
                    hintText: "Please enter pin",
                    errorText: "Please enter valid pin",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.isValidPinCode,
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: masterBloc!.countryDTO,
                    builder: (_, status, __) {
                      return MenuDropDown(
                        headerTitle: "Country name",
                        builder: countryBuilder!,
                        isValidatePressed: isValidatePressed,
                        masterDto: masterBloc?.countryDTO.value,
                        hintText: "Search country name",
                        errorText: "Select country name",
                        title: "Select country name",
                        isEmpPressed: false,
                        isCallBackRequired: true,
                        callback: (id) async {
                          await getStatDetailst(
                              id, stateBuilder!, districtBuilder!);
                        },
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: masterBloc!.stateDTO,
                    builder: (_, status, __) {
                      return MenuDropDown(
                        headerTitle: "State name",
                        builder: stateBuilder!,
                        isValidatePressed: isValidatePressed,
                        masterDto: masterBloc!.stateDTO.value!,
                        hintText: "Search state name",
                        errorText: "Select state name",
                        title: "Select state name",
                        isEmpPressed: false,
                        isCallBackRequired: true,
                        callback: (id) async {
                          await getDistrictDetailst(id, districtBuilder!);
                        },
                      );
                    }),
                ValueListenableBuilder(
                    valueListenable: masterBloc!.districtDTO,
                    builder: (_, status, __) {
                      return MenuDropDown(
                        headerTitle: "District name",
                        builder: districtBuilder!,
                        isValidatePressed: isValidatePressed,
                        masterDto: masterBloc?.districtDTO.value,
                        hintText: "Search district name",
                        errorText: "Select district name",
                        title: "Select district name",
                        isEmpPressed: false,
                        isCallBackRequired: true,
                        callback: (id) async {
                          await getTalukaDetails(id);
                        },
                      );
                    }),
                // ValueListenableBuilder(
                //     valueListenable: masterBloc!.talukaDTO,
                //     builder: (_, status, __) {
                //       return MenuDropDown(
                //         headerTitle: "Taluka name",
                //         builder: talukaBuilder!,
                //         isValidatePressed: isValidatePressed,
                //         masterDto: masterBloc?.talukaDTO.value,
                //         hintText: "Select taluka name",
                //         errorText: "Select taluka name",
                //         title: "Select taluka name",
                //         isEmpPressed: false,
                //       );
                //     }),


                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: DVTextField(
                //     isTitleVisible: true,
                //     controller: aadress2EditingController,
                //     outTextFieldDecoration:
                //         BoxDecorationStyles.outTextFieldBoxDecoration,
                //     inputDecoration:
                //         InputDecorationStyles.inputDecorationTextField,
                //     title: "Address line 3",
                //     hintText: "Please enter address",
                //     errorText: "Please enter valid address",
                //     maxLine: 1,
                //     isValidatePressed: isValidatePressed,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: _getCardDetails(),
                ),
                isSwitchPressed
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                textInputType: TextInputType.text,
                                controller: permananthouseNumberController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "House no",
                                hintText: "Please enter house no",
                                errorText: "Please enter valid house no",
                                maxLine: 1,
                                isValidatePressed: isValidatePressed,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: permanantaddressEditingController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "Address line 1",
                                textInpuFormatter: [
                                  UpperCaseTextFormatter(),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z0-9 (),.\/-]"))
                                ],
                                hintText: "Please enter address line 1",
                                errorText: "Please enter valid address",
                                maxLine: null,
                                isValidatePressed: isValidatePressed,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: permanantaddressEditingController1,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "Address line 2",
                                textInpuFormatter: [
                                  UpperCaseTextFormatter(),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z0-9 (),.\/-]"))
                                ],
                                hintText: "Please enter address line 2",
                                errorText: "Please enter valid address",
                                maxLine: null,
                                isValidatePressed: false,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: permanantpinEditingController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                textInputType: TextInputType.number,
                                title: "Pin",
                                textInpuFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                hintText: "Please enter pin",
                                errorText: "Please enter valid pin",
                                maxLine: 1,
                                onEnterPressRequired: true,
                                onChangedText: (text) {
                                  if (text.length == 6) {
                                    getPostalCodeDetails(text, index: 2);
                                  }
                                },
                                isValidatePressed: isValidatePressed,
                                type: Validation.isValidPinCode,
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.countryDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "Country name",
                                    builder: permanantCountryBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc?.countryDTO.value,
                                    hintText: "Search country name",
                                    errorText: "Select country name",
                                    title: "Select country name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getStatDetailst(
                                          id,
                                          permanantStateBuilder!,
                                          permanntDistricBuilder!);
                                    },
                                  );
                                }),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.stateDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "State name",
                                    builder: permanantStateBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc!.stateDTO.value!,
                                    hintText: "Search state name",
                                    errorText: "Select state name",
                                    title: "Select state name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getDistrictDetailst(
                                          id, permanntDistricBuilder!);
                                    },
                                  );
                                }),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.districtDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "District name",
                                    builder: permanntDistricBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc?.districtDTO.value,
                                    hintText: "Search district name",
                                    errorText: "Select district name",
                                    title: "Select district name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getTalukaDetails(id);
                                    },
                                  );
                                }),

                          ],
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: _getCardDetailsCurrent(),
                ),
                isCurrentSwitchPressed || true
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                textInputType: TextInputType.text,
                                controller: isCurrentSwitchPressed
                                    ? houseNumberController!
                                    : currenthouseNumberController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "House no",
                                hintText: "Please enter house no",
                                errorText: "Please enter valid house no",
                                maxLine: 1,
                                isValidatePressed: isValidatePressed,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: isCurrentSwitchPressed
                                    ? aadressEditingController
                                    : currentaadressEditingController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "Address line 1",
                                textInpuFormatter: [
                                  UpperCaseTextFormatter(),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z0-9 (),.\/-]"))
                                ],
                                hintText: "Please enter address line 1",
                                errorText: "Please enter valid address",
                                maxLine: null,
                                isValidatePressed: isValidatePressed,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: isCurrentSwitchPressed
                                    ? aadress1EditingController!
                                    : currentaadressEditingController1,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                title: "Address line 2",
                                textInpuFormatter: [
                                  UpperCaseTextFormatter(),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[A-Za-z0-9 (),.\/-]"))
                                ],
                                hintText: "Please enter address line 2",
                                errorText: "Please enter valid address",
                                maxLine: null,
                                isValidatePressed: false,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: DVTextField(
                                isTitleVisible: true,
                                controller: isCurrentSwitchPressed
                                    ? pinEditingController
                                    : currentpinEditingController,
                                outTextFieldDecoration: BoxDecorationStyles
                                    .outTextFieldBoxDecoration,
                                inputDecoration: InputDecorationStyles
                                    .inputDecorationTextField,
                                textInputType: TextInputType.number,
                                title: "Pin",
                                textInpuFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                onEnterPressRequired: true,
                                onChangedText: (text) {
                                  if (!isCurrentSwitchPressed &&
                                      text.length == 6) {
                                    getPostalCodeDetails(text, index: 1);
                                  }
                                },
                                hintText: "Please enter pin",
                                errorText: "Please enter valid pin",
                                maxLine: 1,
                                isValidatePressed: isValidatePressed,
                                type: Validation.isValidPinCode,
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.countryDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "Country name",
                                    builder: isCurrentSwitchPressed
                                        ? countryBuilder!
                                        : currentCountryBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc?.countryDTO.value,
                                    hintText: "Search country name",
                                    errorText: "Select country name",
                                    title: "Select country name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getStatDetailst(
                                          id,
                                          currentStateBuilder!,
                                          currentDistricBuilder!);
                                    },
                                  );
                                }),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.stateDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "State name",
                                    builder: isCurrentSwitchPressed
                                        ? stateBuilder!
                                        : currentStateBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc!.stateDTO.value!,
                                    hintText: "Search state name",
                                    errorText: "Select state name",
                                    title: "Select state name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getDistrictDetailst(
                                          id, currentDistricBuilder!);
                                    },
                                  );
                                }),
                            ValueListenableBuilder(
                                valueListenable: masterBloc!.districtDTO,
                                builder: (_, status, __) {
                                  return MenuDropDown(
                                    headerTitle: "District name",
                                    builder: isCurrentSwitchPressed
                                        ? districtBuilder!
                                        : currentDistricBuilder!,
                                    isValidatePressed: isValidatePressed,
                                    masterDto: masterBloc?.districtDTO.value,
                                    hintText: "Search district name",
                                    errorText: "Select district name",
                                    title: "Select district name",
                                    isEmpPressed: false,
                                    isCallBackRequired: true,
                                    callback: (id) async {
                                      await getTalukaDetails(id);
                                    },
                                  );
                                }),

                          ],
                        ),
                      )
                    : Container(),
                CustomButton(
                  onButtonPressed: () async {
                    setState(() {
                      isValidatePressed = true;
                    });

                    if (CustomValidator(firstEditingController.value.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(aadhaarEditingController.value.text)
                            .validate(Validation.isAadhaar) &&
                        CustomValidator(lastEditingController.value.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(aadressEditingController.value.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(dateController.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(houseNumberController.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(pinEditingController.value.text)
                            .validate(Validation.isValidPinCode) &&
                        _genderDropdownModel.value != 0 &&
                        countryBuilder!.menuNotifier.value.length > 0 &&
                        stateBuilder!.menuNotifier.value.length > 0 &&
                        districtBuilder!.menuNotifier.value.length > 0) {
                      if (!CommonAgeValidator.isAgeValidate(
                          dateController.text)) {
                        SuccessfulResponse.showScaffoldMessage(
                            "Age should be in between 21 to 65 year", context);
                        return;
                      }

                      RefUserAddress refuserAddress = RefUserAddress();
                      List<RefUserAddress> refuserAdderssList = [];
                      refuserAddress.countryId =
                          countryBuilder!.menuNotifier.value[0].value;
                      refuserAddress.districtId =
                          districtBuilder!.menuNotifier.value[0].value;
                      refuserAddress.stateId =
                          stateBuilder!.menuNotifier.value[0].value;
                      refuserAddress.postalCode = pinEditingController.text;
                      refuserAddress.addressLineOne =
                          aadressEditingController.text;
                      refuserAddress.houseNo = houseNumberController.text;
                      refuserAddress.addressTypes = MasterDocumentId.builder
                          .getMasterAddressID(
                              MasterDocIdentifier.aadhaarAddress);
                      refuserAddress.addressLineTwo =
                          aadress1EditingController.text;

                      refuserAdderssList.add(refuserAddress);

                      CustomerOnBoarding.AadharNumber =
                          aadhaarEditingController.text;
                      CustomerOnBoarding.DOB = dateController.text;
                      CustomerOnBoarding.genderId =
                          _genderDropdownModel.value ?? 0;
                      CustomerOnBoarding.Gender =
                          _genderDropdownModel.name ?? "MALE";

                      int age = DateTime.now().year -
                          int.parse(dateController.value.text
                              .split("/")
                              .elementAt(2));
                      CustomerOnBoarding.ageInNumber = age;
                      // CustomerOnBoarding.currentAddressSameAsPermanant = false;

                      if (!isCurrentSwitchPressed) {
                        if (currentCountryBuilder!.menuNotifier.value.length > 0 &&
                            currentStateBuilder!.menuNotifier.value.length >
                                0 &&
                            currentDistricBuilder!.menuNotifier.value.length >
                                0 &&
                            CustomValidator(currenthouseNumberController.text)
                                .validate(Validation.isEmpty) &&
                            CustomValidator(
                                    currentpinEditingController.value.text)
                                .validate(Validation.isValidPinCode) &&
                            CustomValidator(
                                    currentaadressEditingController.value.text)
                                .validate(Validation.isEmpty)) {
                          RefUserAddress currentRefuserAddress =
                              RefUserAddress();
                          currentRefuserAddress.addressTypes =
                              MasterDocumentId.builder.getMasterAddressID(
                                  MasterDocIdentifier.currentAddress);
                          currentRefuserAddress.countryId =
                              currentCountryBuilder!
                                  .menuNotifier.value[0].value;
                          currentRefuserAddress.districtId =
                              currentDistricBuilder!
                                  .menuNotifier.value[0].value;
                          currentRefuserAddress.stateId =
                              currentStateBuilder!.menuNotifier.value[0].value;
                          currentRefuserAddress.postalCode =
                              currentpinEditingController.text;
                          currentRefuserAddress.addressLineOne =
                              currentaadressEditingController.text;
                          currentRefuserAddress.houseNo =
                              currenthouseNumberController.text;

                          currentRefuserAddress.addressLineTwo =
                              currentaadressEditingController1.text;
                          refuserAdderssList.add(currentRefuserAddress);
                        } else {
                          SuccessfulResponse.showScaffoldMessage(
                              AppConstants.fillAllDetails, context);
                          print("INto THE REturn");
                          return;
                        }
                      } else {
                        RefUserAddress currentRefuserAddress = RefUserAddress();
                        currentRefuserAddress.addressTypes =
                            MasterDocumentId.builder.getMasterAddressID(
                                MasterDocIdentifier.currentAddress);
                        currentRefuserAddress.countryId =
                            countryBuilder!.menuNotifier.value[0].value;
                        currentRefuserAddress.districtId =
                            districtBuilder!.menuNotifier.value[0].value;
                        currentRefuserAddress.stateId =
                            stateBuilder!.menuNotifier.value[0].value;
                        currentRefuserAddress.postalCode =
                            pinEditingController.text;
                        currentRefuserAddress.addressLineOne =
                            aadressEditingController.text;
                        currentRefuserAddress.houseNo =
                            houseNumberController.text;
                        currentRefuserAddress.addressLineTwo =
                            aadress1EditingController.text;
                        refuserAdderssList.add(currentRefuserAddress);
                      }

                      if (isSwitchPressed) {
                        if (permanantCountryBuilder!.menuNotifier.value.length >
                                0 &&
                            permanantStateBuilder!.menuNotifier.value.length >
                                0 &&
                            permanntDistricBuilder!.menuNotifier.value.length >
                                0 &&
                            CustomValidator(permananthouseNumberController.text)
                                .validate(Validation.isEmpty) &&
                            CustomValidator(
                                    permanantpinEditingController.value.text)
                                .validate(Validation.isValidPinCode) &&
                            CustomValidator(permanantaddressEditingController
                                    .value.text)
                                .validate(Validation.isEmpty)) {
                          RefUserAddress permanantRefAddress = RefUserAddress();

                          print("Residential Address");

                          permanantRefAddress.addressTypes =
                              MasterDocumentId.builder.getMasterAddressID(
                                  MasterDocIdentifier.permanantAddress);
                          permanantRefAddress.countryId =
                              permanantCountryBuilder!
                                  .menuNotifier.value[0].value;
                          permanantRefAddress.districtId =
                              permanntDistricBuilder!
                                  .menuNotifier.value[0].value;
                          permanantRefAddress.stateId = permanantStateBuilder!
                              .menuNotifier.value[0].value;
                          permanantRefAddress.postalCode =
                              permanantpinEditingController.text;
                          permanantRefAddress.addressLineOne =
                              permanantaddressEditingController.text;
                          permanantRefAddress.houseNo =
                              permananthouseNumberController.text;
                          permanantRefAddress.addressLineTwo =
                              permanantaddressEditingController1.text;

                          refuserAdderssList.add(permanantRefAddress);
                        } else {
                          SuccessfulResponse.showScaffoldMessage(
                              AppConstants.fillAllDetails, context);
                          return;
                        }
                      }

                      CustomerOnBoarding.userAddress = refuserAdderssList;
                      CustomerOnBoarding.aadhaarFirstName =
                          firstEditingController.text;
                      CustomerOnBoarding.aadhaarMiddleName =
                          middleEditingController.text;
                      CustomerOnBoarding.aadhaarLastName =
                          lastEditingController.text;

                      print("ADDRESS LIST");
                      print(jsonEncode(refuserAdderssList));
                      await pusDataToServer();
                    } else {
                      SuccessfulResponse.showScaffoldMessage(
                          AppConstants.fillAllDetails, context);
                    }
                  },
                  title: "CONFIRM DETAILS",
                ),
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.16,
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
                    "Permanent address",
                    style: CustomTextStyles.boldLargeFontsGotham,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !isSwitchPressed
                              ? "This is not the customer's"
                              : "This is customer's",
                          style: CustomTextStyles.regularMedium2GreyFont1,
                        ),
                        Text(
                          "permanent address",
                          style: CustomTextStyles.regularMedium2GreyFont1,
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

  getStatDetailst(int id, MenueBuilder stateMenuBuilder,
      MenueBuilder districMenueBuilder) async {
    await masterBloc!.getStateDetails(id: id);
    stateMenuBuilder!.setInitialValue([]);
    districMenueBuilder!.setInitialValue([]);
    // talukaBuilder!.setInitialValue([]);
  }

  getDistrictDetailst(int id, MenueBuilder districMenuBuilder) async {
    await masterBloc!.getDistrictDetails(id: id);

    districMenuBuilder!.setInitialValue([]);
    // talukaBuilder!.setInitialValue([]);
  }

  getTalukaDetails(int id) async {
    await masterBloc!.getTalukaDetails(id: id);
    // talukaBuilder!.setInitialValue([]);
  }

  Widget _getCardDetailsCurrent() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.16,
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
                    "Current address",
                    style: CustomTextStyles.boldLargeFontsGotham,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          true
                              ? "Is Your Current Address Same As\nAadhaar Address?"
                              : "Customer currently resides here",
                          maxLines: 2,
                          style: CustomTextStyles.regularMedium2GreyFont1,
                        ),
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
                      value: isCurrentSwitchPressed ? true : false,
                      onToggle: (value) {
                        setState(() {
                          isCurrentSwitchPressed = value;
                        });
                        if (!isCurrentSwitchPressed) {
                          DialogUtils.changeCurrentAddress(context, () {
                            currentaadressEditingController.text = "";
                            currentpinEditingController.text = "";
                            currenthouseNumberController.text = "";
                            currentaadressEditingController1.text = "";

                            currenthouseNumberController.notifyListeners();
                            currentDistricBuilder!.setInitialValue([]);
                            currentCountryBuilder!.setInitialValue([]);
                            currentStateBuilder!.setInitialValue([]);

                            Navigator.of(context).pop();
                          });
                        }
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

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine

      onBoardingDto.gender = "";
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements = [];
      onBoardingDto.salarySlips = [];
      onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
      onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
      onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
      onBoardingDto.pANNumber = plFetchBloc.onBoardingDTO!.pANNumber;
      onBoardingDto.pANImage = "";
      onBoardingDto.isAadharLinkedToMobile =
          plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
      onBoardingDto.aadharNumber = CustomerOnBoarding.AadharNumber;
      onBoardingDto.customerImage = "";
      onBoardingDto.emailID = plFetchBloc.onBoardingDTO!.emailID;
      onBoardingDto.presentMonthlyEMI =
          plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
      onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = CustomerOnBoarding.DOB;
      onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
      onBoardingDto.currentAddress1 = "";
      onBoardingDto.currentAddress2 = "";
      onBoardingDto.currentAddress3 = "";
      onBoardingDto.permanentAddress1 = "";
      onBoardingDto.permanentAddress2 = "";
      onBoardingDto.permanentAddress3 = "";
      onBoardingDto.genderId = _genderDropdownModel.value;
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
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      CustomerOnBoarding.currentAddressSameAsPermanant = isCurrentSwitchPressed;
      // onBoardingDto.isCurrentAndPermanentAddressSame =
      //     CustomerOnBoarding.currentAddressSameAsPermanant;
    }

    // print("REF USER ADDRESS");
    //
    // print(jsonEncode(CustomerOnBoarding.userAddress));

    print(onBoardingDto.aadharNumber);
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          await onBoardingDto.toJsonEncode()),
    });

    boardingBloc = CustomerBoardingBloc();
    boardingBloc.applyForPersonalLoan(
        formData,
        context,
        (dto) => {
              if (dto!.status!)
                {
                  SuccessfulResponse.showScaffoldMessage(dto.message!, context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadProfile(),
                    ),
                  )
                }
              else
                {
                  SuccessfulResponse.showScaffoldMessage(dto.message!, context),
                }
            });
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "Confirm Customer's Aadhaar details",
        style: CustomTextStyles.BoldTitileFont,
      ),
    );
  }

  onChangeFavouriteFoodModelDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _genderDropdownModel = favouriteFoodModel!;
        genderList = [];
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      });
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }
  // comments to pass variables ---->
  //0 -> aadhaar
  //1 -> current
  // 2 -> permanant

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    if (index == 0) {
      PostalCodeMapping postalCodeMapping =
          PostalCodeMapping.fromJson(jsonDecode(dto.data!));
      if (postalCodeMapping.stateMaster != "") {
        stateBuilder!.setInitialValue([postalCodeMapping.stateMaster!]);
      } else {
        stateBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.countryMaster != "") {
        countryBuilder!.setInitialValue([postalCodeMapping.countryMaster!]);
      } else {
        countryBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.districtMaster != "") {
        districtBuilder!.setInitialValue([postalCodeMapping.districtMaster!]);
      } else {
        districtBuilder!.setInitialValue([]);
      }
    } else if (index == 1) {
      PostalCodeMapping postalCodeMapping =
          PostalCodeMapping.fromJson(jsonDecode(dto.data!));
      if (postalCodeMapping.stateMaster != "") {
        currentStateBuilder!.setInitialValue([postalCodeMapping.stateMaster!]);
      } else {
        currentStateBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.countryMaster != "") {
        currentCountryBuilder!
            .setInitialValue([postalCodeMapping.countryMaster!]);
      } else {
        currentCountryBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.districtMaster != "") {
        currentDistricBuilder!
            .setInitialValue([postalCodeMapping.districtMaster!]);
      } else {
        currentDistricBuilder!.setInitialValue([]);
      }
    } else if (index == 2) {
      PostalCodeMapping postalCodeMapping =
          PostalCodeMapping.fromJson(jsonDecode(dto.data!));
      if (postalCodeMapping.stateMaster != "") {
        permanantStateBuilder!
            .setInitialValue([postalCodeMapping.stateMaster!]);
      } else {
        permanantStateBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.countryMaster != "") {
        permanantCountryBuilder!
            .setInitialValue([postalCodeMapping.countryMaster!]);
      } else {
        permanantCountryBuilder!.setInitialValue([]);
      }

      if (postalCodeMapping.districtMaster != "") {
        permanntDistricBuilder!
            .setInitialValue([postalCodeMapping.districtMaster!]);
      } else {
        permanntDistricBuilder!.setInitialValue([]);
      }
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

  getPostalCodeDetails(String pinCode, {int index = 0}) async {
    PostMappingRequest postMappingRequest = PostMappingRequest();
    postMappingRequest.pincode = pinCode;

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          postMappingRequest.toEncodedJson())
    });

    postalCodeBloc!.getPostalCodeDetails(formData, index: index);
  }
}

class FavouriteFoodModel {
  late final String? foodName;
  late final double? calories;
}
