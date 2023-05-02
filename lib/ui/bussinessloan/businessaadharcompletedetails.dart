import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/aadhaardetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/businessaadhaarbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/postalcodebloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/aadhaardetailsuploadbldto.dart';
import 'package:dhanvarsha/model/request/postalmappingrequest.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/pansuccessfulresponse.dart';
import 'package:dhanvarsha/model/response/postcodemappingresponse.dart';
import 'package:dhanvarsha/model/response/refuseraddressdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/custpersonalinfo.dart';
import 'package:dhanvarsha/ui/bussinessloan/propertydetails.dart';
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

class BusinessAadharCompleteDetails extends StatefulWidget {
  final bool isaadhaarDetailsFilled;
  final String flag;
  final List<MasterDataDTO>? stateDTO;
  final List<MasterDataDTO>? districtDTO;
  final List<MasterDataDTO>? countryDTO;
  const BusinessAadharCompleteDetails(
      {Key? key,
      this.isaadhaarDetailsFilled = false,
      this.flag = "proprietor",
      this.stateDTO = const [],
      this.districtDTO = const [],
      this.countryDTO = const []})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessAadharCompleteDetailsState();
}

class _BusinessAadharCompleteDetailsState
    extends State<BusinessAadharCompleteDetails> implements AppLoadingMultiple {
  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select Gender", 0);
  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;
  FavouriteFoodModel _favouriteFoodModel = FavouriteFoodModel();
  late List<DropdownMenuItem<FavouriteFoodModel>>
      _favouriteFoodModelDropdownList;
  late List<DropdownMenuItem<MasterDataDTO>> genderList;
  GlobalKey<_BusinessAadharCompleteDetailsState> _scrollViewKey = GlobalKey();
  late MasterBloc? masterBloc;

  late BLFetchBloc? blFetchBloc;
  MenueBuilder? countryBuilder, districtBuilder, talukaBuilder, stateBuilder;
  PostalCodeBloc? postalCodeBloc;
  MenueBuilder? currentCountryBuilder,
      currentDistricBuilder,
      currentStateBuilder;

  MenueBuilder? permanantCountryBuilder,
      permanntDistricBuilder,
      permanantStateBuilder;

  bool isCurrentSwitchPressed = true;
  bool isSwitchPressed = false;

  BusinessAadhaarBloc? businessAadhaarBloc;
  List<MasterDataDTO> genderListMaster = [
    new MasterDataDTO("Male", 0),
    new MasterDataDTO("Female", 1),
  ];

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

  AadhaarDetailsBloc? aadhaarDetailsBloc;
  @override
  void initState() {
    super.initState();
    aadhaarDetailsBloc = BlocProvider.getBloc<AadhaarDetailsBloc>();

    masterBloc = BlocProvider.getBloc<MasterBloc>();
    var currentAddress = "";
    var aadhaarAddress = "";
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    businessAadhaarBloc = BusinessAadhaarBloc.appLoadingMultiple(this);

    genderList = [];
    _genderDropdownlist = _buildFavouriteFoodModelDropdown(
        masterBloc?.masterSuperDTO?.genderOptions ?? [],
        genderList,
        _genderDropdownModel);
    postalCodeBloc = PostalCodeBloc(this);
    if (true) {
      countryBuilder = MenueBuilder();
      districtBuilder = MenueBuilder();
      stateBuilder = MenueBuilder();

      currentCountryBuilder = MenueBuilder();
      currentDistricBuilder = MenueBuilder();
      currentStateBuilder = MenueBuilder();

      permanantCountryBuilder = MenueBuilder();
      permanntDistricBuilder = MenueBuilder();
      permanantStateBuilder = MenueBuilder();

      firstEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.firstName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.firstName
              : blFetchBloc!.fetchBLResponseDTO.firstName != ""
                  ? blFetchBloc!.fetchBLResponseDTO.firstName
                  : "")!;

      middleEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.middleName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.middleName
              : blFetchBloc!.fetchBLResponseDTO.middleName != ""
                  ? blFetchBloc!.fetchBLResponseDTO.middleName
                  : "")!;

      lastEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.lastName != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.lastName
              : blFetchBloc!.fetchBLResponseDTO.lastName != ""
                  ? blFetchBloc!.fetchBLResponseDTO.lastName
                  : "")!;

      dateController.text = (aadhaarDetailsBloc?.aadhaarDTO?.dateOfBirth != null
          ? aadhaarDetailsBloc?.aadhaarDTO?.dateOfBirth
          : blFetchBloc!.fetchBLResponseDTO.dateOfBirth != ""
              ? blFetchBloc!.fetchBLResponseDTO.dateOfBirth
              : "")!;

      aadhaarEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber
              : blFetchBloc!.fetchBLResponseDTO.aadharNumber != ""
                  ? blFetchBloc!.fetchBLResponseDTO.aadharNumber
                  : "")!;

      aadressEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.addressLine1 != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.addressLine1
              : blFetchBloc!.fetchBLResponseDTO!.refAddressRequest!.length > 0
                  ? blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![0].addressLineOne
                  : "")!;

      aadress1EditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.addressLine2 != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.addressLine2
              : blFetchBloc!.fetchBLResponseDTO!.refAddressRequest!.length > 0
                  ? blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![0].addressLineTwo
                  : "")!;

      pinEditingController.text =
          (aadhaarDetailsBloc?.aadhaarDTO?.pincode != null
              ? aadhaarDetailsBloc?.aadhaarDTO?.pincode
              : "")!;

      houseNoController.text = (aadhaarDetailsBloc?.aadhaarDTO?.HouseNo != null
          ? aadhaarDetailsBloc?.aadhaarDTO?.HouseNo
          : "")!;

      // aadress1EditingController.text = "";
      // aadress2EditingController.text =
      //     (aadhaarDetailsBloc?.aadhaarDTO?.addressLine3 != null
      //         ? aadhaarDetailsBloc?.aadhaarDTO?.addressLine3
      //         : blFetchBloc!.fetchBLResponseDTO.firstName != ""
      //             ? blFetchBloc!.fetchBLResponseDTO.firstName
      //             : "")!;
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
      int index = MasterDocumentId.builder.getGenderIndex(int.parse(
              blFetchBloc!.fetchBLResponseDTO!.genderId != ""
                  ? blFetchBloc!.fetchBLResponseDTO!.genderId!
                  : "0") ??
          0);

      if (index == -1) {
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

    if (blFetchBloc!.fetchBLResponseDTO!.refAddressRequest!.length > 0) {
      for (int i = 0;
          i < blFetchBloc!.fetchBLResponseDTO!.refAddressRequest!.length;
          i++) {
        if (blFetchBloc!
                .fetchBLResponseDTO!.refAddressRequest![i].addressTypes ==
            MasterDocumentId.builder
                .getMasterAddressID(MasterDocIdentifier.aadhaarAddress)) {
          aadhaarAddress = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].addressLineOne ??
              "";
          aadressEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].addressLineOne ??
              "";
          countryBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectCountry(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].countryId ??
                  0));

          stateBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectState(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].stateId ??
                  0));

          districtBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectDistrict(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].districtId ??
                  0));

          pinEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO.refAddressRequest![i].postalCode ??
              "";
          // talukaBuilder!.setInitialValue(MasterDocumentId.builder
          //     .getMasterObjectTaluka(
          //         plFetchBloc.onBoardingDTO!.userAddress![0].villageTown ?? ""));

          aadress1EditingController.text = blFetchBloc!
                  .fetchBLResponseDTO.refAddressRequest![i].addressLineTwo ??
              "";
          houseNoController.text =
              blFetchBloc!.fetchBLResponseDTO!.refAddressRequest![i].houseNo ??
                  "";
        } else if (blFetchBloc!
                .fetchBLResponseDTO!.refAddressRequest![i].addressTypes ==
            MasterDocumentId.builder
                .getMasterAddressID(MasterDocIdentifier.permanantAddress)) {
          isSwitchPressed = true;

          permanantaddressEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].addressLineOne ??
              "";
          permanantCountryBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectCountry(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].countryId ??
                  0));

          permanantStateBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectState(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].stateId ??
                  0));

          permanntDistricBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectDistrict(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].districtId ??
                  0));

          // talukaBuilder!.setInitialValue(MasterDocumentId.builder
          //     .getMasterObjectTaluka(
          //         plFetchBloc.onBoardingDTO!.userAddress![0].villageTown ?? ""));

          permanantpinEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].postalCode ??
              "";
          permanantaddressEditingController1.text = blFetchBloc!
                  .fetchBLResponseDTO.refAddressRequest![i].addressLineTwo ??
              "";
          permananthouseNumberController.text =
              blFetchBloc!.fetchBLResponseDTO!.refAddressRequest![i].houseNo ??
                  "";
        } else if (blFetchBloc!
                .fetchBLResponseDTO!.refAddressRequest![i].addressTypes ==
            MasterDocumentId.builder
                .getMasterAddressID(MasterDocIdentifier.currentAddress)) {
          currentAddress = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].addressLineOne ??
              "";

          print(currentAddress);
          currentaadressEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].addressLineOne ??
              "";
          currentCountryBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectCountry(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].countryId ??
                  0));

          currentStateBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectState(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].stateId ??
                  0));

          currentDistricBuilder!.setInitialValue(MasterDocumentId.builder
              .getMasterObjectDistrict(blFetchBloc!
                      .fetchBLResponseDTO!.refAddressRequest![i].districtId ??
                  0));

          currentaadressEditingController1.text = blFetchBloc!
                  .fetchBLResponseDTO.refAddressRequest![i].addressLineTwo ??
              "";
          // talukaBuilder!.setInitialValue(MasterDocumentId.builder
          //     .getMasterObjectTaluka(
          //         plFetchBloc.onBoardingDTO!.userAddress![0].villageTown ?? ""));
          currentpinEditingController.text = blFetchBloc!
                  .fetchBLResponseDTO!.refAddressRequest![i].postalCode ??
              "";
          currenthouseNumberController.text =
              blFetchBloc!.fetchBLResponseDTO!.refAddressRequest![i].houseNo ??
                  "";
        }
      }

      // pinEditingController.text= plFetchBloc.onBoardingDTO!.userAddress![0].postalCode.toString()??"";
    }

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
  TextEditingController pinEditingController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController aadress1EditingController = new TextEditingController();
  TextEditingController aadress2EditingController = new TextEditingController();
  TextEditingController houseNoController = new TextEditingController();
  TextEditingController currentaadressEditingController =
      new TextEditingController();

  TextEditingController currentaadressEditingController1 =
      new TextEditingController();

  TextEditingController permanantaddressEditingController1 =
      new TextEditingController();
  TextEditingController currenthouseNumberController =
      new TextEditingController();
  TextEditingController currentpinEditingController =
      new TextEditingController();

  TextEditingController permanantaddressEditingController =
      new TextEditingController();
  TextEditingController permananthouseNumberController =
      new TextEditingController();
  TextEditingController permanantpinEditingController =
      new TextEditingController();
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
    houseNoController.dispose();
    currentaadressEditingController1.dispose();
    permanantaddressEditingController1.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isBackDialogRequired: true,
        type: false,
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
                    textInputType: TextInputType.number,
                    controller: aadhaarEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(12),
                    ],
                    title: "Aadhaar Number",
                    hintText: "Please Enter Aadhaar Number",
                    errorText: "Please Enter Valid Aadhaar Number",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.isAadhaar,
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
                    title: "First Name",
                    hintText: "Please Enter First Name",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]")),
                      UpperCaseTextFormatter()
                    ],
                    errorText: "Please Enter Valid First Name",
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
                    title: "Middle Name",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]")),
                      UpperCaseTextFormatter()
                    ],
                    hintText: "Please Enter Middle Name",
                    errorText: "Please Enter Valid Middle Name",
                    maxLine: 1,
                    isValidatePressed: false,
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
                    title: "Last Name",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]")),
                      UpperCaseTextFormatter()
                    ],
                    hintText: "Please Enter Last Name",
                    errorText: "Please Enter Valid Last Name",
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
                    // isValidate: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    isTitleVisible: true,
                    textInputType: TextInputType.text,
                    controller: houseNoController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "House no",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      UpperCaseTextFormatter()
                    ],
                    hintText: "Please enter house no",
                    errorText: "Please enter valid house no",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DVTextField(
                    controller: aadressEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Address",
                    textInpuFormatter: [
                      UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z0-9 (),.\/-]"))
                    ],
                    hintText: "Please Enter Address",
                    errorText: "Please Enter Valid Address",
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
                    controller: pinEditingController,
                    outTextFieldDecoration:
                    BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                    InputDecorationStyles.inputDecorationTextField,
                    textInputType: TextInputType.number,
                    title: "PIN Code",
                    textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(6),
                    ],
                    onEnterPressRequired: true,
                    onChangedText: (text) {},
                    hintText: "Please Enter PIN",
                    errorText: "Please Enter Valid PIN",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                    type: Validation.isValidPinCode,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: DVTextField(
                //     isTitleVisible: true,
                //     controller: aadress1EditingController,
                //     outTextFieldDecoration:
                //     BoxDecorationStyles.outTextFieldBoxDecoration,
                //     inputDecoration:
                //     InputDecorationStyles.inputDecorationTextField,
                //     title: "Address Line 2",
                //     hintText: "Please Enter Address",
                //     errorText: "Please Enter Valid Address",
                //     maxLine: 1,
                //     isValidatePressed: isValidatePressed,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: DVTextField(
                //     isTitleVisible: true,
                //     controller: aadress2EditingController,
                //     outTextFieldDecoration:
                //     BoxDecorationStyles.outTextFieldBoxDecoration,
                //     inputDecoration:
                //     InputDecorationStyles.inputDecorationTextField,
                //     title: "Address Line 3",
                //     hintText: "Please Enter Address",
                //     errorText: "Please Enter Valid Address",
                //     maxLine: 1,
                //     isValidatePressed: isValidatePressed,
                //   ),
                // ),
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
                                textInpuFormatter: [
                                  UpperCaseTextFormatter(),
                                ],
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
                                onEnterPressRequired: true,
                                onChangedText: (text) {
                                  if (text.length == 6) {
                                    getPostalCodeDetails(text, index: 2);
                                  }
                                },
                                textInpuFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  LengthLimitingTextInputFormatter(6),
                                ],
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
                                    ? houseNoController
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
                                type: Validation.isEmpty,
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
                                type: Validation.isEmpty,
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
                                onEnterPressRequired: true,
                                onChangedText: (text) {
                                  if (!isCurrentSwitchPressed &&
                                      text.length == 6) {
                                    getPostalCodeDetails(text, index: 1);
                                  }
                                },
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
                                  LengthLimitingTextInputFormatter(6),
                                ],
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
                  onButtonPressed: () {
                    // Navigator.pop(context);

                    setState(() {
                      isValidatePressed = true;
                    });

                    print("CURRENT TEXT");
                    print(currentpinEditingController.text.length);

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
                        CustomValidator(houseNoController.text)
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
                      refuserAddress.houseNo = houseNoController.text;

                      refuserAddress.addressLineTwo =
                          aadress1EditingController.text;
                      refuserAddress.addressTypes = MasterDocumentId.builder
                          .getMasterAddressID(
                              MasterDocIdentifier.aadhaarAddress);

                      refuserAdderssList.add(refuserAddress);

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
                          currenthouseNumberController.text;

                          currentRefuserAddress.addressLineTwo =
                              currentaadressEditingController1.text;
                          refuserAdderssList.add(currentRefuserAddress);
                        } else {
                          SuccessfulResponse.showScaffoldMessage(
                              AppConstants.fillAllDetails, context);
                          return;
                        }
                      } else {
                        RefUserAddress refuserAddress = RefUserAddress();

                        refuserAddress.countryId =
                            countryBuilder!.menuNotifier.value[0].value;
                        refuserAddress.districtId =
                            districtBuilder!.menuNotifier.value[0].value;
                        refuserAddress.stateId =
                            stateBuilder!.menuNotifier.value[0].value;
                        refuserAddress.postalCode = pinEditingController.text;
                        refuserAddress.addressLineOne =
                            aadressEditingController.text;
                        refuserAddress.houseNo = houseNoController.text;
                        refuserAddress.addressTypes = MasterDocumentId.builder
                            .getMasterAddressID(
                                MasterDocIdentifier.currentAddress);
                        refuserAddress.addressLineTwo =
                            aadress1EditingController.text;
                        print("INTO THE ELSE");
                        print(jsonEncode(refuserAddress));
                        refuserAdderssList.add(refuserAddress);
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

                      CustomerBLOnboarding.addressOfCoApplicant =
                          aadressEditingController.text;

                      print("Upload Details");

                      print(jsonEncode(refuserAdderssList));
                      uploadAadhaarToServer(refuserAdderssList);
                    } else {
                      SuccessfulResponse.showScaffoldMessage(
                          AppConstants.fillAllDetails, context);
                    }
                  },
                  title: "CONFIRM THIS INFORMATION",
                ),
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 0,
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
                    style: CustomTextStyles.boldLargeFonts,
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
                        // print(value);
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

  uploadAadhaarToServer(List<RefUserAddress> refuserAdderssList) async {
    print("Into the aadhaar server");

    CustomerBLOnboarding.isAadhaarAddSameAsCurrent = isCurrentSwitchPressed;
    AadhaarDetailsUploadBLDto aadhaarDetailsUploadBLDto =
        AadhaarDetailsUploadBLDto();
    aadhaarDetailsUploadBLDto.firstName = firstEditingController.text;
    aadhaarDetailsUploadBLDto.middleName = middleEditingController.text;
    aadhaarDetailsUploadBLDto.lastName = lastEditingController.text;
    aadhaarDetailsUploadBLDto.dateOfBirth = dateController.text;
    aadhaarDetailsUploadBLDto.genderId = _genderDropdownModel.value.toString();
    aadhaarDetailsUploadBLDto.gender = _genderDropdownModel.name;
    aadhaarDetailsUploadBLDto.aadharNumber = aadhaarEditingController.text;
    aadhaarDetailsUploadBLDto.refID =
        blFetchBloc!.fetchBLResponseDTO.refBlId.toString();
    aadhaarDetailsUploadBLDto.refAddressRequest = refuserAdderssList;
    aadhaarDetailsUploadBLDto.pincode = pinEditingController.text;
    aadhaarDetailsUploadBLDto.dob = dateController.text;
    int age = DateTime.now().year -
        int.parse(dateController.value.text.split("/").elementAt(2));

    CustomerBLOnboarding.age = age;

    print("Age is");
    print(CustomerBLOnboarding.age);

    print(aadhaarDetailsUploadBLDto.toEncodedJson());
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          aadhaarDetailsUploadBLDto.toEncodedJson())
    });

    businessAadhaarBloc!.addBusinessAadhaarDetialsMultiple(formData);
  }

  Widget _getCardDetailsCurrent() {
    return Material(
      elevation: 0,
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
                    style: CustomTextStyles.boldLargeFonts,
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
                      value: isCurrentSwitchPressed,
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
                            currentDistricBuilder!.setInitialValue([]);
                            currentCountryBuilder!.setInitialValue([]);
                            currentStateBuilder!.setInitialValue([]);

                            currentpinEditingController.notifyListeners();

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

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "Please Confirm the Customer's Aadhaar details",
        style: CustomTextStyles.boldMediumFont,
      ),
    );
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

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
    } else if (index == 3) {
      PanSuccessfulResponseDTO panSuccessfulResponseDTO =
          PanSuccessfulResponseDTO.fromJson(jsonDecode(dto.data!));

      if (panSuccessfulResponseDTO.status!) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerProfile(flag: widget.flag),
          ),
        );
      } else {
        SuccessfulResponse.showScaffoldMessage(
            panSuccessfulResponseDTO.message!, context);
      }
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
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
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
