import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/business_blocs/businessgstdetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/request/BusinessPanGst.dart';
import 'package:dhanvarsha/model/request/addbusinesspandetailsdto.dart';
import 'package:dhanvarsha/model/request/businessgstrequest.dart';
import 'package:dhanvarsha/model/request/pangstrequestdto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/mastdto/master_super_dto.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/response/pansuccessfulresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessproofdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/itrdocs.dart';
import 'package:dhanvarsha/ui/bussinessloan/residentialproof.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class BusinessPanDetails extends StatefulWidget {
  final String flag;

  const BusinessPanDetails({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessPanDetailsState();
}

class _BusinessPanDetailsState extends State<BusinessPanDetails>
    implements AppLoadingMultiple {
  bool AddCoflag = false;
  BLFetchBloc? blFetchBloc;
  var isValidatePressed = false;
  var isBValidatePressed = false;
  var showBusinessDetails = false;
  var showAddBusinessDetails = false;
  var isGstNumber = false;
  int count = -1;
  BusinessGSTDetailsBloc? businessGSTDetailsBloc;
  TextEditingController BspanController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController panController = new TextEditingController();
  TextEditingController gstinController = new TextEditingController();
  TextEditingController legalnameController = new TextEditingController();
  TextEditingController servicetxController = new TextEditingController();
  TextEditingController tradeController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController vintageController = new TextEditingController();
  GlobalKey<_BusinessPanDetailsState> _scrollViewKey = GlobalKey();
  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select Gender", 0);
  MasterBloc? masterBloc;
  bool isApiCall = true;
  @override
  void initState() {
    super.initState();

    genderList = [];
    _genderDropdownlist = _buildFavouriteFoodModelDropdown(
        masterBloc?.masterSuperDTO?.genderOptions ?? [],
        genderList,
        _genderDropdownModel);
    _genderDropdownModel = genderList.elementAt(0).value!;
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    businessGSTDetailsBloc = BusinessGSTDetailsBloc(this);
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    panController.text =
        blFetchBloc!.fetchBLResponseDTO.businessPanNumber ?? "";
    count = blFetchBloc!.fetchBLResponseDTO.businessHaveGSTRegistered! ? 1 : 2;
    legalnameController.text =
        blFetchBloc!.fetchBLResponseDTO.gSTLegalName ?? "";
    tradeController.text = blFetchBloc!.fetchBLResponseDTO.gSTTradeName ?? "";
    servicetxController.text =
        blFetchBloc!.fetchBLResponseDTO.gSTServiceTaxRegistrationNumber ?? "";
    gstinController.text = blFetchBloc!.fetchBLResponseDTO.gSTINNumber ?? "";

    vintageController.text = blFetchBloc!.fetchBLResponseDTO.VintageYears ?? "";
    if (count == 2) {
      showBusinessDetails = true;
      showAddBusinessDetails = false;
      isGstNumber = false;
    } else {
      showBusinessDetails = true;
      showAddBusinessDetails = false;
      isGstNumber = true;
    }

    panController.addListener(addListner);
    // print("Business Pan Image");
    // print(blFetchBloc!.fetchBLResponseDTO.businessPanImageName);

    dateController.text =
        blFetchBloc!.fetchBLResponseDTO.gSTDateOfRegistration!;
  }

  List<MasterDataDTO> masterdtoList = [];
  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;
  late List<DropdownMenuItem<MasterDataDTO>> genderList;
  //setting dropdown values
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select GSTIN Number"}) {
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

  addListner() async {
    // print(CustomValidator(panController.text).validate(Validation.isPan));
    //
    // print(isTextField);
    //
    // print(isApiCall);
    //
    // print(count == 1);
    // print(CustomValidator(panController.text).validate(Validation.isPan) &&
    //     isTextField &&
    //     isApiCall &&
    //     count == 1);
    if (CustomValidator(panController.text).validate(Validation.isPan) &&
        count == 1) {
      PanGstnRequestDTO panGstnRequestDTO = PanGstnRequestDTO();
      panGstnRequestDTO.consent = "Y";
      panGstnRequestDTO.pan = panController.text;

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            panGstnRequestDTO.toEncodedJson()),
      });
      businessGSTDetailsBloc!.getGstDetails(formData);
      isApiCall = false;
    } else {
      isApiCall = true;
    }
  }

  @override
  void dispose() {
    panController.removeListener(addListner);
    BspanController.dispose();
    panController.dispose();
    gstinController.dispose();
    legalnameController.dispose();
    servicetxController.dispose();
    tradeController.dispose();
    dateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        isBackDialogRequired: true,
        isStepShown: true,
        stepArray: widget.flag == "" ? const [3, 7] : const [3, 8],
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: Container(
            constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    45 -
                    MediaQuery.of(context).viewInsets.top -
                    MediaQuery.of(context).viewInsets.bottom -
                    30),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // <-- spaceBetween
              children: [
                _getTitleCompoenent("Business Details", false),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // _getMobileNumberDocument(),
                      _getPanComponent(),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: _BankAccountButton(),
                      )
                    ],
                  ),
                ),
                widget.flag != "" ? _getHoirzontalImageUpload() : Container(),
                (showBusinessDetails) ? _getBusinessDetail() : Container(),
                (!showBusinessDetails) ? _getContinueButton() : Container(),
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _BankAccountButton() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "Is Your Business GST Registered?",
            style: CustomTextStyles.regularsmalleFonts,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      count = 1;
                      isGstNumber = true;
                      showBusinessDetails = true;
                    });

                    if (CustomValidator(panController.text)
                        .validate(Validation.isPan)) {
                      PanGstnRequestDTO panGstnRequestDTO = PanGstnRequestDTO();
                      panGstnRequestDTO.consent = "Y";
                      panGstnRequestDTO.pan = panController.text;

                      FormData formData = FormData.fromMap({
                        'json': await EncryptionUtils.getEncryptedText(
                            panGstnRequestDTO.toEncodedJson()),
                      });
                      businessGSTDetailsBloc!.getGstDetails(formData);
                      // isApiCall = false;
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: count == 1
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBox,
                    alignment: Alignment.center,
                    child: Text(
                      "Yes",
                      style: count != 1
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularsmalleFonts,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 2;
                      isGstNumber = false;
                      showBusinessDetails = true;
                    });

                    legalnameController.text = "";
                    tradeController.text = "";
                    dateController.text = "";
                    vintageController.text = "";
                  },
                  child: Container(
                    decoration: count == 2
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBox,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "No",
                      style: count != 2
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularsmalleFonts,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  _getPanComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: DVTextField(
        controller: panController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBox,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "PAN",
        hintText: "Enter business pan",
        textInpuFormatter: [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
        ],
        errorText: "Type your business pan here",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isPan,
      ),
    );
  }

  _getMobileNumberDocument() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: DVTextField(
        controller: mobileNumberController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBox,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Enter Mobile number",
        hintText: "Enter mobile number",
        errorText: "please enter mobile number",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
      ),
    );
  }

  Widget _getTitleCompoenent(String title, bool check) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              overflow: TextOverflow.clip,
              style: CustomTextStyles.boldSubtitleLargeFonts,
              maxLines: 2),
          // Image.asset(
          //   DhanvarshaImages.question,
          //   height: 25,
          //   width: 25,
          // )
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
            onButtonPressed: () {
              print("Continue Pressed");

              setState(() {
                isValidatePressed = true;
              });

              if (CustomValidator(panController.text)
                  .validate(Validation.isPan)) {
                if (count == -1) {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please select gst whether gst registered or not",
                      context);

                  return;
                }

                pusBusinessDetailsToServer();
              } else {
                SuccessfulResponse.showScaffoldMessage(
                    AppConstants.fillAllDetails, context);
              }

              // if (count == 1) {
              //   setState(() {
              //     isValidatePressed = true;
              //   });
              //
              //   pusBusinessDetailsToServer();
              // } else {
              //   pusBusinessDetailsToServer();
              // }
            },
            title: "Continue",
            boxDecoration: ButtonStyles.redButtonWithCircularBorder,
          ),
        ],
      ),
    );
  }

  void Nextpage() {
    print("inside next page ");
    InheritedWrapperState wrapper = InheritedWrapper.of(context);
    wrapper.incrementCounter();
  }

  bool isTextField = true;

  Widget _getBusinessDetail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                thickness: 1,
              )),
          isGstNumber
              ? isTextField
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: DVTextField(
                        onEnterPressRequired: true,
                        textInputType: TextInputType.text,
                        controller: gstinController,
                        outTextFieldDecoration:
                            BoxDecorationStyles.outTextFieldBoxDecoration,
                        inputDecoration:
                            InputDecorationStyles.inputDecorationTextField,
                        title: "GSTIN",
                        hintText: "Please Enter GSTIN",
                        errorText: "Please Enter Valid GSTIN",
                        maxLine: 1,
                        textInpuFormatter: [
                          UpperCaseTextFormatter(),
                          LengthLimitingTextInputFormatter(15),
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z0-9]')),
                        ],
                        onChangedText: (text) {
                          print("On Changed Called");
                          print(text.length == 13);
                          if (text.length == 15) {
                            fetchBusinessPanDetails();
                          }
                        },
                        isValidatePressed: isBValidatePressed,
                        isTitleVisible: true,
                        type: Validation.isGstnLength,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: CustomDropdownMaster<MasterDataDTO>(
                        dropdownMenuItemList: _genderDropdownlist,
                        onChanged: onChangeFavouriteFoodModelDropdown,
                        value: _genderDropdownModel,
                        isEnabled: true,
                        title: "GSTIN Number",
                        isTitleVisible: true,
                        errorText: "Please select gender",
                        isValidate: isValidatePressed,
                      ),
                    )
              : Container(),
          isGstNumber
              ? isTextField
                  ? Container()
                  : Container(
                      child: Row(
                        children: [
                          // Image.asset(
                          //   DhanvarshaImages.i,
                          //   height: 15,
                          //   width: 15,
                          // ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Select GSTIN number from dropdown",
                              style: CustomTextStyles.boldMediumFont,
                            ),
                          )
                        ],
                      ),
                    )
              : Container(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DVTextField(
              textInputType: TextInputType.text,
              controller: legalnameController,
              outTextFieldDecoration:
                  BoxDecorationStyles.outTextFieldBoxDecoration,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Legal Name",
              textInpuFormatter: [UpperCaseTextFormatter()],
              hintText: "Please Enter Legal Name",
              errorText: "Please Enter Valid Legal Name",
              maxLine: 1,
              isValidatePressed: isBValidatePressed,
              isTitleVisible: true,
              type: Validation.isEmpty,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DVTextField(
              textInputType: TextInputType.text,
              controller: tradeController,
              outTextFieldDecoration:
                  BoxDecorationStyles.outTextFieldBoxDecoration,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Trade Name",
              textInpuFormatter: [UpperCaseTextFormatter()],
              hintText: "Please Enter Trade Name",
              errorText: "Please Enter Valid Trade Name",
              maxLine: 1,
              isValidatePressed: isBValidatePressed,
              isTitleVisible: true,
              type: Validation.isEmpty,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   child: DVTextField(
          //     textInputType: TextInputType.number,
          //     controller: servicetxController,
          //     textInpuFormatter: [UpperCaseTextFormatter()],
          //     outTextFieldDecoration:
          //         BoxDecorationStyles.outTextFieldBoxDecoration,
          //     inputDecoration: InputDecorationStyles.inputDecorationTextField,
          //     title: "Service Tax Registration Number",
          //     hintText: "Please Enter Service Tax Registration Number",
          //     errorText: "Please Enter Valid Service Tax Registration Number",
          //     maxLine: 1,
          //     isValidatePressed: isBValidatePressed,
          //     isTitleVisible: true,
          //     type: Validation.isEmpty,
          //   ),
          // ),
          ValueListenableBuilder(
              valueListenable: dateController,
              builder: (context, snackBarBuilder, _) {
                print("VALUE UPDATED");
                print(dateController.text);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDatePicker(
                    title: "Date of registration",
                    controller: dateController,
                    isValidateUser: isBValidatePressed,
                    selectedDate: dateController.text,
                    isTitleVisible: true,
                    onTimeUpdate: () {
                      if (dateController.text.length > 0) {
                        vintageController.text = (DateTime.now().year -
                                int.parse(dateController.value.text
                                    .split("/")
                                    .elementAt(2)))
                            .toString();

                        CustomerBLOnboarding.noOfYearsRegistration =
                            int.parse(vintageController.text);
                      }
                    },
                  ),
                );
              }),

          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: DVTextField(
              textInputType: TextInputType.number,
              controller: vintageController,
              textInpuFormatter: [UpperCaseTextFormatter()],
              outTextFieldDecoration:
                  BoxDecorationStyles.outTextFieldBoxDecoration,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Year of Business Vintage",
              hintText: "Year of Business Vintage",
              errorText: "Year of Business Vintage",
              maxLine: 1,
              isValidatePressed: isBValidatePressed,
              isTitleVisible: true,
              image: DhanvarshaImages.calendar,
              isCalendarIcon: true,
              isEnable: false,
              type: Validation.isEmpty,
            ),
          ),
          CustomButton(
            onButtonPressed: () {
              // InheritedWrapperState wrapper = InheritedWrapper.of(context);
              // wrapper.incrementCounter();

              if (isGstNumber) {
                if (CustomValidator(panController.text)
                        .validate(Validation.isPan) &&
                    CustomValidator(gstinController.text)
                        .validate(Validation.isGstnLength) &&
                    CustomValidator(legalnameController.text)
                        .validate(Validation.isEmpty) &&
                    CustomValidator(tradeController.text)
                        .validate(Validation.isEmpty) &&
                    CustomValidator(dateController.text)
                        .validate(Validation.isEmpty)) {
                  print("Value is");
                  print(_genderDropdownModel.value);

                  if (!isTextField && _genderDropdownModel.value == 0) {
                    SuccessfulResponse.showScaffoldMessage(
                        "Please select gstin number", context);

                    return;
                  }
                  pusBusinessDetailsToServer();
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      AppConstants.fillAllDetails, context);
                }
              } else {
                if (CustomValidator(panController.text)
                        .validate(Validation.isPan) &&
                    CustomValidator(legalnameController.text)
                        .validate(Validation.isEmpty) &&
                    CustomValidator(tradeController.text)
                        .validate(Validation.isEmpty) &&
                    CustomValidator(dateController.text)
                        .validate(Validation.isEmpty)) {
                  pusBusinessDetailsToServer();
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      AppConstants.fillAllDetails, context);
                }
              }
            },
            title: "CONTINUE",
          )
        ],
      ),
    );
  }

  fetchBusinessPanDetails() async {
    BusinesGstRequest businesGstRequest = BusinesGstRequest();
    businesGstRequest.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    businesGstRequest.type = "BL";
    businesGstRequest.consent = count == 1 ? "Y" : "N";
    businesGstRequest.gstNumber = gstinController.text;

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          businesGstRequest.toEncodedJson())
    });

    print(businesGstRequest.toEncodedJson());
    businessGSTDetailsBloc!.addBusinessGSTDetails(formData);
  }

  onChangeFavouriteFoodModelDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) async {
    if (favouriteFoodModel!.value != 0) {
      setState(() {
        _genderDropdownModel = favouriteFoodModel!;
        genderList = [];
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            masterdtoList, genderList, _genderDropdownModel);
      });
      BusinesGstRequest businesGstRequest = BusinesGstRequest();
      businesGstRequest.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
      businesGstRequest.type = "BL";
      businesGstRequest.consent = count == 1 ? "Y" : "N";
      businesGstRequest.gstNumber = favouriteFoodModel.name;

      FormData formData = FormData.fromMap({
        "json": await EncryptionUtils.getEncryptedText(
            businesGstRequest.toEncodedJson())
      });

      // print(businesGstRequest.toEncodedJson());
      businessGSTDetailsBloc!.addBusinessGSTDetails(formData);
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    if (type == 1) {
      try {
        setState(() {
          isBValidatePressed = false;
        });

        BusinessPanResponse businessPanResponse =
            BusinessPanResponse.fromJson(jsonDecode(dto.data!));

        gstinController.text = businessPanResponse.gstIN!;
        legalnameController.text = businessPanResponse.legalName!;
        tradeController.text = businessPanResponse.tradeName!;
        servicetxController.text = "";
        dateController.text = businessPanResponse.registrationdate!;
        print("COMPLETE ADDRESS OF BUSINESS");
        print(businessPanResponse.completeAddress!);
        CustomerBLOnboarding.completeBLAddress =
            businessPanResponse.completeAddress!;
      } catch (e) {
        print(e);
      }
    } else if (type == 2) {
      PanSuccessfulResponseDTO panSuccessfulResponseDTO =
          PanSuccessfulResponseDTO.fromJson(jsonDecode(dto.data!));

      if (panSuccessfulResponseDTO.status!) {
        if (widget.flag == "proprietor") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessProofDocument(
                flag: widget.flag,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessProofDocument(
                flag: widget.flag,
              ),
            ),
          );
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(
            AppConstants.errorMessage, context);
      }
    } else if (type == 3) {
      try {
        masterdtoList = jsonDecode(dto.data!) as List != null &&
                jsonDecode(dto.data!).length != 0
            ? (jsonDecode(dto.data!) as List).map((i) {
                return MasterDataDTO.fromGSTDetails(i);
              }).toList()
            : [];

        print("Master DTO Length");
        print(jsonEncode(masterdtoList));

        if (masterdtoList.length > 0) {
          setState(() {
            isTextField = false;
          });
          genderList = [];
          _genderDropdownlist = _buildFavouriteFoodModelDropdown(
              masterdtoList, genderList, _genderDropdownModel);
          _genderDropdownModel = genderList.elementAt(0).value!;
        } else {
          setState(() {
            isTextField = true;
          });
        }

        gstinController.text = "";
        legalnameController.text = "";
        tradeController.text = "";
        dateController.text = "";
        vintageController.text = "";
      } catch (e) {
        print(e);
      }

      // print(masterdtoList);
    }
  }

  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  Widget _getHoirzontalImageUpload() {
    return Container(
      child: Column(
        children: [
          CustomImageBuilder(
            initialImage:
                blFetchBloc!.fetchBLResponseDTO.businessPanImageName ?? "",
            key: _panPickey,
            image: DhanvarshaImages.npan,
            value: "Upload Business PAN",
            description: AppConstants.aadharUploadDescription,
            no: "",
            firstImageUploaded: () {},
          ),
        ],
      ),
    );
  }

  pusBusinessDetailsToServer() async {
    print("Print Data To Server");

    if (count == 1) {
      CustomerBLOnboarding.isGstActive = true;
    } else {
      CustomerBLOnboarding.isGstActive = false;
    }

    AddBusinessPanDetailsDTO addBusinessPanDetailsDTO =
        AddBusinessPanDetailsDTO();
    addBusinessPanDetailsDTO.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    addBusinessPanDetailsDTO.businessPanNumber = panController.text;
    addBusinessPanDetailsDTO.gSTINNumber =
        isTextField ? gstinController.text : _genderDropdownModel.name;
    addBusinessPanDetailsDTO.gSTDateOfRegistration = dateController.text;
    addBusinessPanDetailsDTO.gSTServiceTaxRegistrationNumber = "";
    addBusinessPanDetailsDTO.gSTTradeName = tradeController.text;
    addBusinessPanDetailsDTO.gSTLegalName = legalnameController.text;
    addBusinessPanDetailsDTO.VintageYears = vintageController.text;
    // addBusinessPanDetailsDTO.BusinessPanId=MenueBuilder.
    // addBusinessPanDetailsDTO.yesNoCdBankAccountFlag = 1;
    addBusinessPanDetailsDTO.businessHaveGSTRegistered =
        count == 1 ? true : false;
    addBusinessPanDetailsDTO.BusinessPanId =
        MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);

    addBusinessPanDetailsDTO.businessPanImages = _panPickey.currentState != null
        ? _panPickey.currentState!.fileName != null
            ? _panPickey.currentState!.fileName
            : ""
        : "";

    addBusinessPanDetailsDTO.VintageYears = vintageController.text;
    if (widget.flag != "") {
      if (_panPickey.currentState!.imagepicked.value == "") {
        SuccessfulResponse.showScaffoldMessage(
            "Please upload business pan", context);
        return;
      }
    }

    if (count == 1) {
      if (isTextField) {
        if (gstinController.text.isEmpty) {
          SuccessfulResponse.showScaffoldMessage(
              "Please enter gstin details", context);
          return;
        }
      } else {
        if (_genderDropdownModel.value == 0) {
          SuccessfulResponse.showScaffoldMessage(
              "Please select gstin details", context);
          return;
        }
      }
    }

    List<MultipartFile> appFiles = [];

    if (_panPickey.currentState != null &&
        _panPickey.currentState!.fileName != null &&
        _panPickey.currentState!.fileName != "" &&
        !Uri.parse(_panPickey.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _panPickey.currentState!.imagepicked.value,
          filename: _panPickey.currentState!.fileName));
    }

    String data = await addBusinessPanDetailsDTO.toEncodedJson();

    print("Data is");
    print(data);

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(data),
      'MyFiles': appFiles
    });

    businessGSTDetailsBloc!.pushBusinessDetailsToMgenius(formData);
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
