import 'dart:convert';

import 'package:dhanvarsha/bloc/aadhaardetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/createcoapplicantbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/postalcodebloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/CoApplicantModel.dart';
import 'package:dhanvarsha/model/request/aadharuploaddto.dart';
import 'package:dhanvarsha/model/request/coapplicantadd.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/model/request/postalmappingrequest.dart';
import 'package:dhanvarsha/model/response/addcoapplicantresponse.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/postcodemappingresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantbuilder.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilderv1.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload_bl.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CoApplicantDetails extends StatefulWidget {
  final String flag;
  final CoApplicantModel? model;
  final bool isUpdate;
  final int index;

  const CoApplicantDetails(
      {Key? key,
      this.flag = "proprietor",
      this.model,
      this.isUpdate = false,
      this.index = -1})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoApplicantDetailsState();
}

class _CoApplicantDetailsState extends State<CoApplicantDetails>
    implements AppLoadingMultiple {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController middleNameEditingController =
      new TextEditingController();
  TextEditingController lastNameEditingController = new TextEditingController();
  TextEditingController shareholdingPercentage = TextEditingController();
  TextEditingController mobilenoEditingController = new TextEditingController();
  TextEditingController emailidEditingController =
      new TextEditingController(text: "");
  TextEditingController houseNoEditingController = new TextEditingController();
  late List<DropdownMenuItem<MasterDataDTO>> genderList;
  TextEditingController aadhaarController = new TextEditingController();
  TextEditingController panController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController pinEditingController = new TextEditingController();
  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _fronAadhaarCard = GlobalKey();
  GlobalKey<CustomImageBuilderState> _addressProof = GlobalKey();
  GlobalKey<CustomImageBuilderV1State> _backAadhaarCard = GlobalKey();
  var isValidatePressed = false;
  CoApplicantModel coapplicantName = new CoApplicantModel();
  late MasterBloc? masterBloc;
  final List<ProofofAddressModel> _listOfCorpDoc = [
    ProofofAddressModel(billId: 0, Name: "Select Document"),
    ProofofAddressModel(billId: 1, Name: "Electricity Bill"),
    ProofofAddressModel(billId: 2, Name: "Ration Card"),
    ProofofAddressModel(billId: 3, Name: "Water Bill"),
  ];

  bool isCurrentSwitchPressed = true;
  CreateCoapplicantBloc? createCoapplicationBloc;
  PanDetailsBloc? panDetailsBloc;
  PostalCodeBloc? postalCodeBloc;
  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;
  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select Gender", 0);
  List<DropdownMenuItem<MasterDataDTO>> _builGenderDrdown(
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

  MenueBuilder? countryBuilder, districtBuilder, talukaBuilder, stateBuilder;
  ProofofAddressModel _corpModel = ProofofAddressModel();
  late List<DropdownMenuItem<ProofofAddressModel>>
      __billingModelModelDropdownList;

  List<DropdownMenuItem<ProofofAddressModel>> _buildFavouriteFoodModelDropdown(
      List billingModelModelList) {
    List<DropdownMenuItem<ProofofAddressModel>> items = [];
    for (ProofofAddressModel corpModelModel in billingModelModelList) {
      items.add(DropdownMenuItem(
        value: corpModelModel,
        child: Text(
          corpModelModel.Name!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  GlobalKey<_CoApplicantDetailsState> _scrollViewKey = GlobalKey();
  onChangeFavouriteFoodModelDropdown(ProofofAddressModel? billingModel) {
    setState(() {
      _corpModel = billingModel!;
    });
  }

  BLFetchBloc? blFetchBloc;

  AadhaarDetailsBloc? aadhaarDetailsBloc;

  uploadAadhaarToServer() async {
    print("UPload aadhaar Called");
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
        type: "BLCoAppplicant");

    print("Encoded JSON IS");
    print(upload.id);
    print(upload.toEncodedJson());

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(upload.toEncodedJson()),
      "Myfiles": [
        await MultipartFile.fromFileSync(frontimagePath,
            filename: frontfileName),
        await MultipartFile.fromFileSync(backimagePath,
            filename: backimagefileName)
      ],
    });

    aadhaarDetailsBloc?.getAadhaarDetails(formData, () {
      nameEditingController.text = aadhaarDetailsBloc!.aadhaarDTO!.firstName!;
      middleNameEditingController.text =
          aadhaarDetailsBloc!.aadhaarDTO!.middleName!;
      lastNameEditingController.text =
          aadhaarDetailsBloc!.aadhaarDTO!.lastName!;
      dateController.text = aadhaarDetailsBloc!.aadhaarDTO!.dateOfBirth!;
      aadhaarController.text = aadhaarDetailsBloc!.aadhaarDTO!.aadharNumber!;
      houseNoEditingController.text = aadhaarDetailsBloc!.aadhaarDTO!.HouseNo!;
      pinEditingController.text = aadhaarDetailsBloc!.aadhaarDTO!.pincode!;
      print(aadhaarDetailsBloc?.aadhaarDTO?.gender);
      if (aadhaarDetailsBloc?.aadhaarDTO?.gender == "MALE") {
        print("Into the MALE");
        print(masterBloc!.masterSuperDTO!.genderOptions![1]!.name);
        _genderDropdownModel = masterBloc!.masterSuperDTO!.genderOptions![1]!;
        genderList = [];

        // print(jsonEncode(_genderDropdownModel));
        _genderDropdownlist = _builGenderDrdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      } else if (aadhaarDetailsBloc?.aadhaarDTO?.gender == "FEMALE") {
        _genderDropdownModel = masterBloc!.masterSuperDTO!.genderOptions![0]!;

        genderList = [];

        // print(jsonEncode(_genderDropdownModel));
        _genderDropdownlist = _builGenderDrdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      }

      onChangeGenderDropdown(_genderDropdownModel);

      dateController.notifyListeners();
      _fronAadhaarCard.currentState!.imagepicked.notifyListeners();

      print("PIN CODE IS -------------------------------------->");
      print(aadhaarDetailsBloc!.aadhaarDTO!.pincode);
      if (aadhaarDetailsBloc!.aadhaarDTO!.pincode != "") {
        getPostalCodeDetails(aadhaarDetailsBloc!.aadhaarDTO!.pincode!,
            index: 1);
      }
    },
        () => {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("OCR failed to detect text")))
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __billingModelModelDropdownList =
        _buildFavouriteFoodModelDropdown(_listOfCorpDoc);
    ;
    createCoapplicationBloc = CreateCoapplicantBloc(this);
    panDetailsBloc = PanDetailsBloc();
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    aadhaarDetailsBloc = AadhaarDetailsBloc();
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    countryBuilder = MenueBuilder();
    districtBuilder = MenueBuilder();
    stateBuilder = MenueBuilder();
    _corpModel = _listOfCorpDoc[0];
    postalCodeBloc = PostalCodeBloc(this);
    genderList = [];
    _genderDropdownlist = _builGenderDrdown(
        masterBloc?.masterSuperDTO?.genderOptions ?? [],
        genderList,
        _genderDropdownModel);
    _genderDropdownModel = genderList.elementAt(0).value!;

    if (widget.model != null) {
      print("Gender ID");

      int index =
          MasterDocumentId.builder.getGenderIndex(widget.model!.genderId ?? 0);

      print("Index is");
      print(index);
      genderList = [];
      _genderDropdownlist = _builGenderDrdown(
          masterBloc?.masterSuperDTO?.genderOptions ?? [],
          genderList,
          _genderDropdownModel);
      _genderDropdownModel = genderList.elementAt(index + 1).value!;

      onChangeGenderDropdown(_genderDropdownModel);
    }

    countryBuilder!.setInitialValue(
        widget.model != null ? widget!.model!.countryDTO! : []);
    stateBuilder!
        .setInitialValue(widget.model != null ? widget!.model!.stateDTO! : []);
    districtBuilder!
        .setInitialValue(widget.model != null ? widget!.model!.cityDTO! : []);
    nameEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.name : "");

    dateController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.dobOfUser : "");

    middleNameEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.middleName : "");

    aadhaarController = new TextEditingController(
        text: widget!.model != null
            ? widget!.model!.coApplicantAadhaarNumber
            : "");

    panController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.coApplicantPanNumber : "");

    lastNameEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.lastName : "");
    mobilenoEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.mobileNumber : "");
    emailidEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.emailId : "");
    addressEditingController = new TextEditingController(
        text: widget!.model != null
            ? widget!.model!.address
            : blFetchBloc!.fetchBLResponseDTO.residentialProofAddressLine1 != ""
                ? blFetchBloc!.fetchBLResponseDTO.residentialProofAddressLine1
                : CustomerBLOnboarding.addressOfCoApplicant);

    houseNoEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.houseNo : "");

    pinEditingController = new TextEditingController(
        text: widget!.model != null ? widget!.model!.pinCode : "");
    isCurrentSwitchPressed = widget!.model != null
        ? widget!.model!.isCurrentAddresSameAsAadhar!
        : false;
    if (widget.flag != "") {
      shareholdingPercentage = new TextEditingController(
          text: widget!.model != null
              ? widget!.model!.percentageShareHolding
              : "");
    }
  }

  onChangeGenderDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _genderDropdownModel = favouriteFoodModel!;
        genderList = [];
        _genderDropdownlist = _builGenderDrdown(
            masterBloc?.masterSuperDTO?.genderOptions ?? [],
            genderList,
            _genderDropdownModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: Container(
            constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    45 -
                    MediaQuery.of(context).viewInsets.top -
                    MediaQuery.of(context).viewInsets.bottom -
                    30),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _getTitle(),
                          _getAadharImageUpload(),
                          _getPANImageUpload(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: nameEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter first name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter first name",
                              errorText: "Please Enter first name",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: middleNameEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter middle name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter middle name",
                              errorText: "Please Enter middle name",
                              maxLine: 1,
                              isValidatePressed: false,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: lastNameEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter last name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter last name",
                              errorText: "Please Enter last name",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                            ),
                          ),
                          widget.flag != ""
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: DVTextField(
                                    textInputType: TextInputType.number,
                                    controller: shareholdingPercentage,
                                    outTextFieldDecoration: BoxDecorationStyles
                                        .outTextFieldBoxDecoration,
                                    inputDecoration: InputDecorationStyles
                                        .inputDecorationTextField,
                                    title: "Enter shareholding percentage",
                                    textInpuFormatter: [
                                      UpperCaseTextFormatter(),
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    hintText: "Shareholding percentage",
                                    errorText:
                                        "Please Enter valid shareholding percentage (less than 100%)",
                                    maxLine: 1,
                                    isValidatePressed: isValidatePressed,
                                    type: Validation.isMaxValue,
                                  ),
                                )
                              : Container(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: CustomDropdownMaster<MasterDataDTO>(
                              dropdownMenuItemList: _genderDropdownlist,
                              onChanged: onChangeGenderDropdown,
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
                              textInputType: TextInputType.number,
                              controller: aadhaarController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter aadhaar no",
                              hintText: "Enter aadhaar no",
                              textInpuFormatter: [
                                LengthLimitingTextInputFormatter(12),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              errorText: "Please Enter aadhaar no",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              type: Validation.isAadhaar,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              controller: panController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter pan no",
                              hintText: "Enter pan no",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Za-z0-9]')),
                              ],
                              errorText: "Please Enter pan no",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              type: Validation.isPan,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.number,
                              controller: mobilenoEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter mobile no",
                              hintText: "Enter mobile no",
                              textInpuFormatter: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              errorText: "Please Enter mobile no",
                              maxLine: 1,
                              is91: true,
                              isFlag: true,
                              isValidatePressed: isValidatePressed,
                              type: Validation.mobileNumber,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              controller: pinEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              textInputType: TextInputType.number,
                              title: "PIN Code",
                              textInpuFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              onEnterPressRequired: true,
                              onChangedText: (text) {},
                              hintText: "Please Enter Pin Code",
                              errorText: "Please Enter Valid Pin Code",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              type: Validation.isValidPinCode,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: houseNoEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter house no",
                              hintText: "Enter house no",
                              errorText: "Please Enter house no",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: addressEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Enter address",
                              hintText: "Enter address",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                              ],
                              errorText: "Please Enter address",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
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
                                    // await getStatDetailst(
                                    //     id, stateBuilder!, districtBuilder!);
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
                                    await getDistrictDetailst(
                                        id, districtBuilder!);
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
                          ValueListenableBuilder(
                              valueListenable: dateController,
                              builder: (context, snackBarBuilder, _) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDatePicker(
                                    controller: dateController,
                                    isValidateUser: isValidatePressed,
                                    selectedDate: dateController.text,
                                    title: "Date of birth",
                                    isTitleVisible: true,
                                  ),
                                );
                              }),
                          _getCardDetailsCurrent(),
                          !isCurrentSwitchPressed
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: CustomImageBuilder(
                                    key: _addressProof,
                                    initialImage: widget.model != null
                                        ? widget.model!.addressProofPath!
                                        : "",
                                    value: "Upload Address Proof",
                                    description: "",
                                    isAadhaarVisible: false,
                                    image: DhanvarshaImages.poa,
                                    dropdown: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: CustomDropdown(
                                        dropdownMenuItemList:
                                            __billingModelModelDropdownList,
                                        onChanged:
                                            onChangeFavouriteFoodModelDropdown,
                                        value: _corpModel,
                                        isEnabled: true,
                                        title: "Document",
                                        isTitleVisible: true,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: CustomButton(
                    onButtonPressed: () {
                      print(coapplicantName);

                      setState(() {
                        isValidatePressed = true;
                      });

                      print("PAN VALIDATiON IS");
                      print(CustomValidator(panController.text)
                          .validate(Validation.isPan));

                      bool percentageShareHoldingValidation = widget
                          .flag !=
                          ""
                          ? CustomValidator(shareholdingPercentage.text)
                          .validate(Validation.isMaxValue)
                          : true;

                      if (CustomValidator(nameEditingController.text)
                          .validate(Validation.isEmpty) &&
                          CustomValidator(lastNameEditingController.text)
                              .validate(Validation.isEmpty) &&
                          CustomValidator(nameEditingController.text)
                              .validate(Validation.isEmpty) &&
                          _genderDropdownModel.value != 0 &&
                          CustomValidator(aadhaarController.text)
                              .validate(Validation.isAadhaar) &&
                          CustomValidator(houseNoEditingController.text)
                              .validate(Validation.isEmpty) &&
                          CustomValidator(panController.text)
                              .validate(Validation.isPan) &&
                          mobilenoEditingController.text.length == 10 &&
                          CustomValidator(addressEditingController.text)
                              .validate(Validation.isEmpty) &&
                          countryBuilder!.menuNotifier.value.length > 0 &&
                          stateBuilder!.menuNotifier.value.length > 0 &&
                          districtBuilder!.menuNotifier.value.length >
                              0 &&
                          dateController.text.length > 0 &&
                          percentageShareHoldingValidation) {
                        if (_panPickey.currentState!.imagepicked.value ==
                            "") {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please upload pan image", context);
                          return;
                        }

                        if (!isCurrentSwitchPressed &&
                            _corpModel.billId == 0) {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please select document", context);
                          return;
                        }

                        if (_fronAadhaarCard
                            .currentState!.imagepicked.value ==
                            "") {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please upload aadhaar front", context);
                          return;
                        }
                        if (_fronAadhaarCard
                            .currentState!.imagepicked.value ==
                            "") {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please upload aadhaar back", context);
                          return;
                        }

                        if (panDetailsBloc != null) {
                          if (panDetailsBloc!.panResponseDTO != null) {
                            if (panDetailsBloc!
                                .panResponseDTO!.panNumber !=
                                null &&
                                panDetailsBloc!
                                    .panResponseDTO!.panNumber ==
                                    "") {
                              SuccessfulResponse.showScaffoldMessage(
                                  "Please upload valid pan", context);
                              return;
                            }
                          }
                        }

                        if (!isCurrentSwitchPressed &&
                            _addressProof
                                .currentState!.imagepicked.value ==
                                "") {
                          SuccessfulResponse.showScaffoldMessage(
                              "Please upload address proof", context);
                          return;
                        }

                        CoApplicantAddDTO coApplicantAddDTO =
                        CoApplicantAddDTO();
                        coApplicantAddDTO.firstName =
                            nameEditingController.text;
                        coApplicantAddDTO.id = widget.model != null
                            ? int.parse(widget.model!.Id!)
                            : 0;
                        coApplicantAddDTO.middleName =
                            middleNameEditingController.text;

                        coApplicantAddDTO.lastName =
                            lastNameEditingController.text;
                        coApplicantAddDTO.genderId =
                            _genderDropdownModel.value;
                        coApplicantAddDTO.coApplicantAadharNumber =
                            aadhaarController.text;
                        coApplicantAddDTO.coApplicantPanNumber =
                            panController.text;
                        coApplicantAddDTO.percentageCompleted = 100;
                        coApplicantAddDTO.houseNo =
                            houseNoEditingController.text;
                        coApplicantAddDTO.mobileNumber =
                            mobilenoEditingController.text;
                        coApplicantAddDTO.addressLine1 =
                            addressEditingController.text;
                        coApplicantAddDTO.state =
                            stateBuilder!.menuNotifier.value[0].name;

                        // print("PIN EDITING CONTROLLER");
                        // print(pinEditingController.text);

                        coApplicantAddDTO.pincode =
                            pinEditingController.text;
                        coApplicantAddDTO.addressLine2 = "";
                        coApplicantAddDTO.country =
                            countryBuilder!.menuNotifier.value[0].name;

                        coApplicantAddDTO.city =
                            districtBuilder!.menuNotifier.value[0].name;

                        coApplicantAddDTO.emailId =
                            emailidEditingController.text;
                        // coApplicantAddDTO.pincode = "";
                        coApplicantAddDTO.countryId =
                            countryBuilder!.menuNotifier.value[0].value;
                        coApplicantAddDTO.stateId =
                            stateBuilder!.menuNotifier.value[0].value;
                        coApplicantAddDTO.districtId =
                            districtBuilder!.menuNotifier.value[0].value;
                        coApplicantAddDTO.dob = dateController.text;
                        coApplicantAddDTO.coApplicantPanImage =
                            _panPickey.currentState!.fileName;
                        coApplicantAddDTO.coApplicantAadharFrontImage =
                            _fronAadhaarCard.currentState!.fileName;
                        coApplicantAddDTO.coApplicantAadharBackImage =
                            _backAadhaarCard.currentState!.fileName;
                        coApplicantAddDTO
                            .coApplicantProofOfAddressDocumentImage =
                        !isCurrentSwitchPressed
                            ? _addressProof.currentState!.fileName
                            : "";
                        coApplicantAddDTO
                            .coApplicantProofOfAddressDocumentType =
                            _corpModel.billId.toString();
                        coApplicantAddDTO.refBlId =
                            blFetchBloc!.fetchBLResponseDTO.refBlId;

                        coApplicantAddDTO.isCurrentAddressSameAadhaar =
                            isCurrentSwitchPressed;

                        if (widget.flag != "") {
                          coApplicantAddDTO.ShareHolderPercentage =
                              shareholdingPercentage.text;
                        }

                        coApplicantAddDTO.gender =
                            _genderDropdownModel.name;
                        print("Co-Applicant Add");
                        print(coApplicantAddDTO.toEncodedJson());

                        addUpdateCoapplicantToServer(coApplicantAddDTO);
                      } else {
                        SuccessfulResponse.showScaffoldMessage(
                            AppConstants.fillAllDetails, context);
                      }

                      // Navigator.pop(context);
                    },
                    title: "ADD CO-APPLICANT",
                    boxDecoration:
                    ButtonStyles.redButtonWithCircularBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
        context: context);
  }

  getDistrictDetailst(int id, MenueBuilder districMenuBuilder) async {
    await masterBloc!.getDistrictDetails(id: id);

    districMenuBuilder!.setInitialValue([]);
    // talukaBuilder!.setInitialValue([]);
  }

  addUpdateCoapplicantToServer(CoApplicantAddDTO coApplicantAddDTO) async {
    List<MultipartFile> appFiles = [];

    if (_fronAadhaarCard.currentState!.imagepicked.value != "" &&
        _fronAadhaarCard.currentState!.fileName != "") {
      appFiles.add(await MultipartFile.fromFileSync(
          _fronAadhaarCard.currentState!.imagepicked.value,
          filename: _fronAadhaarCard.currentState!.fileName));
    }

    if (_backAadhaarCard.currentState!.imagepicked.value != "" &&
        _backAadhaarCard.currentState!.fileName != "") {
      appFiles.add(await MultipartFile.fromFileSync(
          _backAadhaarCard.currentState!.imagepicked.value,
          filename: _backAadhaarCard.currentState!.fileName));
    }

    if (_panPickey.currentState!.imagepicked.value != "" &&
        _panPickey.currentState!.fileName != "") {
      appFiles.add(await MultipartFile.fromFileSync(
          _panPickey.currentState!.imagepicked.value,
          filename: _panPickey.currentState!.fileName));
    }

    if (!isCurrentSwitchPressed &&
        _addressProof.currentState!.imagepicked.value != "" &&
        _addressProof.currentState!.fileName != "") {
      appFiles.add(await MultipartFile.fromFileSync(
          _addressProof.currentState!.imagepicked.value,
          filename: _addressProof.currentState!.fileName));
    }

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          coApplicantAddDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    print("Co-Applicant Files");

    print(formData.files);
    createCoapplicationBloc!.addCoapplicantDetails(formData);
  }

  getTalukaDetails(int id) async {
    await masterBloc!.getTalukaDetails(id: id);
    // talukaBuilder!.setInitialValue([]);
  }

  Widget _getTitle() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Co-Applicant Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
          ],
        ),
      ),
    );
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

  Widget _getPANImageUpload() {
    return ValueListenableBuilder(
        valueListenable: panDetailsBloc!.connectionStatusOfPanDetails,
        builder: (_, status, Widget? child) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CustomImageBuilder(
                  key: _panPickey,
                  isPan: true,
                  image: DhanvarshaImages.npan,
                  value: "Upload Co-Applicant PAN",
                  description:
                      "It's required by law to verify your identity's as new user",
                  no: (panDetailsBloc?.panResponseDTO?.panNumber != null &&
                          panDetailsBloc?.panResponseDTO?.panNumber != "")
                      ? "PAN :- ${panDetailsBloc?.panResponseDTO?.panNumber}"
                      : "",
                  initialImage:
                      widget.model != null ? widget.model!.coApplicantPan! : "",
                  firstImageUploaded: () {
                    uploadPanToServer();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _getAadharImageUpload() {
    return ValueListenableBuilder(
        valueListenable: aadhaarDetailsBloc!.connectionStatusOfAadharDetails,
        builder: (_, status, Widget? child) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CustomImageBuilder(
                  no: "${(aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != null && aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber != "") ? "Aadhaar : "
                      "${aadhaarDetailsBloc?.aadhaarDTO?.aadharNumber}" : "" != ""
                      "Aadhaar : " "" ? "" : ""}",
                  key: _fronAadhaarCard,
                  anotherImageKey: _backAadhaarCard,
                  image: DhanvarshaImages.nadhar,
                  value: "Upload Co-Applicant's Aadhaar",
                  description: AppConstants.aadharUploadDescription,
                  initialImage: widget.model != null
                      ? widget.model!.customerAadhaar!
                      : "",
                  isPan: true,
                  isAadhaarImage: true,
                  secondInitialImage: widget.model != null
                      ? widget.model!.customerAadhaarBack!
                      : "",
                  firstImageUploaded: () {
                    print("Aadhaar Card Uploaded");
                    if (_backAadhaarCard.currentState != null) {
                      print("Back Aadhaar Card");
                      print(_backAadhaarCard.currentState?.imagepicked.value);
                      if (Uri.parse(
                              _backAadhaarCard.currentState!.imagepicked.value)
                          .isAbsolute) {
                        _backAadhaarCard.currentState!.imagepicked.value = "";
                      }
                    }
                    if (_fronAadhaarCard.currentState!.imagepicked.value !=
                            "" &&
                        _backAadhaarCard.currentState!.imagepicked.value !=
                            "") {
                      uploadAadhaarToServer();
                    }
                  },
                  secondImageUploaded: () {
                    if (Uri.parse(
                            _fronAadhaarCard.currentState!.imagepicked.value)
                        .isAbsolute) {
                      _fronAadhaarCard.currentState!.imagepicked.value = "";
                      _backAadhaarCard.currentState!.imagepicked.value = "";
                      _backAadhaarCard.currentState!.imagepicked
                          .notifyListeners();
                      _fronAadhaarCard.currentState!.imagepicked
                          .notifyListeners();
                      SuccessfulResponse.showScaffoldMessage(
                          "You need to change both images", context);
                      return;
                    }

                    if (_fronAadhaarCard.currentState!.imagepicked.value !=
                            "" &&
                        _backAadhaarCard.currentState!.imagepicked.value !=
                            "") {
                      uploadAadhaarToServer();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  uploadPanToServer() async {
    PanUpload panUpload = PanUpload(
        fileName: _panPickey.currentState!.fileName,
        id: blFetchBloc!.fetchBLResponseDTO.refBlId,
        type: "BLCoAppplicant");

    print("PAN DETAILS ARE");
    print(jsonEncode(panUpload!.toJson()));
    print("Uplaoding Files.......");

    //
    // if(Uri.parse(_panPickey.currentState!.imagepicked.value).isAbsolute){
    //   _panPickey.currentState!.imagepicked.value="";
    //   SuccessfulResponse.showScaffoldMessage("Please reupload customer image for face verification", context);
    //
    // }

    await panDetailsBloc!.getPanDetails(
        jsonEncode(panUpload!.toJson()),
        _panPickey.currentState!.imagepicked!.value!,
        _panPickey.currentState!.fileName,
        context);

    _panPickey.currentState!.imagepicked.notifyListeners();

    panController.text = panDetailsBloc!.panResponseDTO!.panNumber!;
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    if (index == 0) {
      AddCoapplicantResponseDTO addCoapplicantResponseDTO =
          AddCoapplicantResponseDTO.fromJson(jsonDecode(dto.data!));

      print("ADD CO-APPLICANT RESPONSE------------------------------>");
      print(jsonEncode(addCoapplicantResponseDTO.toJson()));
      if (addCoapplicantResponseDTO.status!) {
        coapplicantName.name = nameEditingController.text;
        coapplicantName.middleName = middleNameEditingController.text;
        coapplicantName.lastName = lastNameEditingController.text;
        coapplicantName.mobileNumber = mobilenoEditingController.text;
        coapplicantName.emailId = emailidEditingController.text;
        coapplicantName.address = addressEditingController.text;
        coapplicantName.coApplicantPan =
            _panPickey.currentState!.imagepicked.value;
        coapplicantName.customerAadhaar =
            _fronAadhaarCard.currentState!.imagepicked.value;
        coapplicantName.customerAadhaarBack =
            _backAadhaarCard.currentState != null
                ? _backAadhaarCard.currentState!.imagepicked.value
                : "";
        coapplicantName.proofOfAddress = _addressProof.currentState != null
            ? _addressProof.currentState!.imagepicked != null
                ? _addressProof.currentState!.imagepicked.value!
                : ""
            : "";
        coapplicantName.stateDTO = stateBuilder!.menuNotifier.value;
        coapplicantName.countryDTO = countryBuilder!.menuNotifier.value;
        coapplicantName.cityDTO = districtBuilder!.menuNotifier.value;

        coapplicantName.pinCode = pinEditingController.text;

        coapplicantName.coApplicantAadhaarNumber = aadhaarController.text;

        coapplicantName.dobOfUser = dateController.text;

        coapplicantName.houseNo = houseNoEditingController.text;

        coapplicantName.coApplicantPanNumber = panController.text;

        coapplicantName.coApplicantPan =
            _panPickey.currentState!.imagepicked!.value;
        coapplicantName.addressProofPath = _addressProof.currentState != null
            ? _addressProof.currentState!.imagepicked != null
                ? _addressProof.currentState!.imagepicked.value!
                : ""
            : "";
        coapplicantName.Id = addCoapplicantResponseDTO.id.toString();

        coapplicantName.address = addressEditingController.text;

        coapplicantName.genderId = _genderDropdownModel.value;

        coapplicantName.houseNo = houseNoEditingController.text;

        coapplicantName.Id = addCoapplicantResponseDTO.id.toString();

        coapplicantName.isCurrentAddresSameAsAadhar = isCurrentSwitchPressed;

        if (widget.flag != "") {
          coapplicantName.percentageShareHolding = shareholdingPercentage.text;
        }

        if (widget.isUpdate) {
          print("Updated");
          CoApplicantBuilder.builder.updateModel(coapplicantName, widget.index);
        } else {
          CoApplicantBuilder.builder.addUser(coapplicantName);
        }

        Navigator.of(context).pop();
      } else {
        SuccessfulResponse.showScaffoldMessage(
            addCoapplicantResponseDTO.message!, context);
      }
    } else {
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
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
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

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}

class ProofofAddressModel {
  final int? billId;
  final String? Name;

  ProofofAddressModel({this.billId, this.Name});
}
