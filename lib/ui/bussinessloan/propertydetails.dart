import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/propertydetailbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/propertydetailsrequest.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/additionaldetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/custpersonalinfo.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PropertyDetails extends StatefulWidget {
  final String flag;

  const PropertyDetails({Key? key, this.flag = ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails>
    implements AppLoading {
  GlobalKey<_PropertyDetailsState> _scrollViewKey = GlobalKey();

  late PropertyDetailsBloc propertyDetailsBloc;
  TextEditingController pinEditingController = new TextEditingController();
  TextEditingController pinEditingNotownController =
      new TextEditingController();

  TextEditingController coapplicantEditingController =
      new TextEditingController();

  BLFetchBloc? blFetchBloc;
  int count = -1;
  int countbusinessplace = -1;
  int coapplicantown = -1;
  int typeofbusinessnotwon = -1;
  bool isSwitchPressed = true;
  var isValidatePressed = false;
  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Spouse", calories: 110),
    FavouriteFoodModel(foodName: "Father", calories: 110),
    FavouriteFoodModel(foodName: "Mother", calories: 110),
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

  onChangeFavouriteFoodModelDropdown(FavouriteFoodModel? favouriteFoodModel) {
    setState(() {
      _favouriteFoodModel = favouriteFoodModel!;
    });
  }

  @override
  void initState() {
    super.initState();
    propertyDetailsBloc = PropertyDetailsBloc(this);
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    _favouriteFoodModelDropdownList =
        _buildFavouriteFoodModelDropdown(_favouriteFoodModelList);


    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    _favouriteFoodModel = _favouriteFoodModelList[0];

    if (blFetchBloc != null) {
      isSwitchPressed =
          blFetchBloc!.fetchBLResponseDTO.isPropertyOwnedByACustomer!;


      coapplicantown = blFetchBloc!.fetchBLResponseDTO.ownerOwnid == 0
          ? -1
          : blFetchBloc!.fetchBLResponseDTO.coapplicantOwnid ==
                  MasterDocumentId.builder
                      .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
              ? 1
              : 2;
      countbusinessplace =   blFetchBloc!.fetchBLResponseDTO.typeOfProperty== ""
          ? -1
          : blFetchBloc!.fetchBLResponseDTO.typeOfProperty == "Business"
              ? 2
              : 1;


      if(blFetchBloc!.fetchBLResponseDTO.relationShipTypeCdCoApplicantRelationShip!=0){
        int index = MasterDocumentId.builder.getCoapplicantRelationshipId(blFetchBloc!.fetchBLResponseDTO.relationShipTypeCdCoApplicantRelationShip!);
        buisinessFirmTypeList = [];
        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.coApplicantRelationShip!,
            buisinessFirmTypeList,
            _buisinessDropdownmodel);

        _buisinessDropdownmodel = buisinessFirmTypeList.elementAt(index+1).value!;

        onChangeBusinessDropdown(_buisinessDropdownmodel);


      }else{
        buisinessFirmTypeList = [];

        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.coApplicantRelationShip!,
            buisinessFirmTypeList,
            _buisinessDropdownmodel);

        _buisinessDropdownmodel = buisinessFirmTypeList.elementAt(0).value!;
      }


      coapplicantEditingController.text =
          blFetchBloc!.fetchBLResponseDTO.propertyCoApplicantsName ?? "Avinash";
      pinEditingNotownController.text =
          blFetchBloc!.fetchBLResponseDTO.propertyCoApplicantPropertyPincode ??
              "";









      typeofbusinessnotwon =   blFetchBloc!.fetchBLResponseDTO.propertyCoApplicantPropertyType == ""
          ? -1
          : blFetchBloc!.fetchBLResponseDTO.typeOfProperty == "Business"
              ? 2
              : 1;
      pinEditingController.text =
          blFetchBloc!.fetchBLResponseDTO.propertyPincode ?? "";
    }
  }

  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;

  MasterDataDTO _buisinessDropdownmodel = MasterDataDTO("Select Firm Type", 0);

  List<DropdownMenuItem<MasterDataDTO>> _buildBusinessModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select co-applicant relationship"}) {
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

  MasterBloc? masterBloc;

  onChangeBusinessDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _buisinessDropdownmodel = favouriteFoodModel!;
        buisinessFirmTypeList = [];
        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.coApplicantRelationShip ?? [],
            buisinessFirmTypeList,
            _buisinessDropdownmodel);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pinEditingController.dispose();
    pinEditingNotownController.dispose();
    coapplicantEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        isStepShown: true,
        stepArray: [3, 4],
        isBackDialogRequired: true,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: _getBody(),
        ),
        context: context);
  }

  Widget _getBody() {
    return Container(
        constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).viewInsets.top -
                  MediaQuery.of(context).viewInsets.bottom -
                  30),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      // height: SizeConfig.screenHeight-45-SizeConfig.verticalviewinsects,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitle(),
                _getOwnPropertyDetails(),
              ],
            ),
          ),
          _getContinueButton(),
        ],
      ),
    );
  }

  Widget currentResidenceButtons() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Applicant or co-applicant's current residence is:",
            style: CustomTextStyles.regularMediumFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: count == 1
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    alignment: Alignment.center,
                    child: Text(
                      "Owned",
                      style: count != 1
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 2;
                    });
                  },
                  child: Container(
                    decoration: count == 2
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Rented",
                      style: count != 2
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
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

  Widget currentBusinessPlaceButtons() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "Current business place is:",
            style: CustomTextStyles.regularMediumFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      countbusinessplace = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: countbusinessplace == 1
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    alignment: Alignment.center,
                    child: Text(
                      "Owned",
                      style: countbusinessplace != 1
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      countbusinessplace = 2;
                    });
                  },
                  child: Container(
                    decoration: countbusinessplace == 2
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Rented",
                      style: countbusinessplace != 2
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
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

  Widget _getTitle() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child:   Text(
              "Customer’s Property Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
      ),
    );
  }

  Widget _getOwnPropertyDetails() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(7),
        width: double.infinity,
        // height: SizeConfig.screenHeight * 0.16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Owned property",
                      style: CustomTextStyles.boldLargeFonts,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          true
                              ? Text(
                                  "Does the customer own a\nproperty? ",
                                  style:
                                      CustomTextStyles.regularMedium2GreyFont1,
                                )
                              : Text(
                                  "Customer owns a property",
                                  style:
                                      CustomTextStyles.regularMedium2GreyFont1,
                                ),
                        ],
                      ),
                    )
                  ],
                ),
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
              ],
            ),
            Divider(),
            isSwitchPressed
                ? Container(
                    child: Column(children: [
                    _typeofpropertyMultipleButtons(),
                    _getPropertyPincode()
                  ]))
                : Container(
                    child: Column(children: [
                    _doesCoapplicantMultipleButtons(),
                    coapplicantown == 1
                        ? Column(
                            children: [
                              _getCoapplicantName(),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    // Image.asset(
                                    //   DhanvarshaImages.question,
                                    //   height: 15,
                                    //   width: 15,
                                    // ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "Should be part of the loan structure",
                                        style: CustomTextStyles.boldsmalleFonts,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              _coapplicantrelation(),
                              _typeofpropertyNotOwnMultipleButtons(),
                              _getPropertyPincodeNotOwn()
                            ],
                          )
                        : Container()
                  ])),
          ],
        ),
        // color: AppColors.white,
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
              setState(() {
                isValidatePressed = true;
              });

              if (isSwitchPressed) {
                if (CustomValidator(pinEditingController.value.text)
                    .validate(Validation.isValidPinCode)) {
                  if (countbusinessplace != -1) {
                    addPropertyDetails();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Select type of property")));
                  }
                } else {}
              } else {
                if (coapplicantown != -1) {
                  if (coapplicantown == 1) {
                    if (CustomValidator(coapplicantEditingController.value.text)
                            .validate(Validation.isEmpty) &&
                        CustomValidator(pinEditingNotownController.value.text)
                            .validate(Validation.isValidPinCode)) {
                      if (typeofbusinessnotwon == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Select type of property")));
                      } else {
                        addPropertyDetails();
                      }
                    }
                  } else {
                    addPropertyDetails();
                  }
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please select co-applicant own property", context);
                }
              }
            },
            title: "CONTINUE",
            boxDecoration: ButtonStyles.redButtonWithCircularBorder,
          ),
        ],
      ),
    );
  }

  Widget _typeofpropertyMultipleButtons() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            "Type of property",
            style: CustomTextStyles.regularMediumFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      countbusinessplace = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: countbusinessplace == 1
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    alignment: Alignment.center,
                    child: Text(
                      "Residence",
                      style: countbusinessplace != 1
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
                      countbusinessplace = 2;
                    });
                  },
                  child: Container(
                    decoration: countbusinessplace == 2
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Business",
                      style: countbusinessplace != 2
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

  Widget _doesCoapplicantMultipleButtons() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            "Does the co-applicant own a property",
            style: CustomTextStyles.regularMediumFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      coapplicantown = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: coapplicantown == 1
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    alignment: Alignment.center,
                    child: Text(
                      "Yes",
                      style: coapplicantown != 1
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
                      coapplicantown = 2;
                    });
                  },
                  child: Container(
                    decoration: coapplicantown == 2
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "No",
                      style: coapplicantown != 2
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

  Widget _typeofpropertyNotOwnMultipleButtons() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            "Type of property",
            style: CustomTextStyles.regularMediumFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      typeofbusinessnotwon = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: typeofbusinessnotwon == 1
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    alignment: Alignment.center,
                    child: Text(
                      "Residence",
                      style: typeofbusinessnotwon != 1
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
                      typeofbusinessnotwon = 2;
                    });
                  },
                  child: Container(
                    decoration: typeofbusinessnotwon == 2
                        ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                        : BoxDecorationStyles.outButtonOfBoxGreyCorner,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Business",
                      style: typeofbusinessnotwon != 2
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

  Widget _getPropertyPincode() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: DVTextField(
        controller: pinEditingController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        textInputType: TextInputType.number,
        title: "Pincode of owned property",
        hintText: "Please enter pincode",
        textInpuFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(6),
        ],
        errorText: "Please enter valid pincode",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isValidPinCode,
      ),
    );
  }

  Widget _getPropertyPincodeNotOwn() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: DVTextField(
        controller: pinEditingNotownController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        textInputType: TextInputType.number,
        title: "Pincode of owned property",
        hintText: "Please Enter Pincode",
        textInpuFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(6),
        ],
        errorText: "Please Enter Valid Pincode",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isValidPinCode,
      ),
    );
  }

  Widget _getCoapplicantName() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: DVTextField(
        controller: coapplicantEditingController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        textInputType: TextInputType.text,
        title: "Co-applicant's Name",
        textInpuFormatter: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z_ ]"))
        ],
        hintText: "Co-applicant name",
        errorText: "Please enter co-applicant name",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isEmpty,
      ),
    );
  }

  Widget _coapplicantrelation() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: CustomDropdownMaster<MasterDataDTO>(
          dropdownMenuItemList: buisinessFirmTypeList,
          onChanged: onChangeBusinessDropdown,
          value: _buisinessDropdownmodel,
          isEnabled: true,
          title: "Co-applicant relationship",
          isTitleVisible: true,
          errorText: "Please select co-applicant relationship",
          isValidate: isValidatePressed,
        ),
      ),
    );
  }

  addPropertyDetails() async {
    PropertyDetailsRequestDTO propertyDetailsRequestDTO =
        PropertyDetailsRequestDTO();

    print(isSwitchPressed);

    if (isSwitchPressed) {
      propertyDetailsRequestDTO.refBlId =
          blFetchBloc!.fetchBLResponseDTO.refBlId;
      propertyDetailsRequestDTO.isPropertyOwnedByACustomer = isSwitchPressed;
      propertyDetailsRequestDTO.isCoApplicantOwnsProperty = false;
      propertyDetailsRequestDTO.propertyCoApplicantPropertyPincode = "";
      propertyDetailsRequestDTO.propertyCoApplicantsName = "";
      propertyDetailsRequestDTO.propertyCoApplicantPropertyType = "";
      propertyDetailsRequestDTO.typeOfProperty =
          countbusinessplace == 1 ? "Residence" : "Business";
      propertyDetailsRequestDTO.propertyCoApplicantsRelation = "";
      propertyDetailsRequestDTO.propertyPincode = pinEditingController.text;
      propertyDetailsRequestDTO.OwnerownId = isSwitchPressed
          ? MasterDocumentId.builder
              .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
          : MasterDocumentId.builder
              .getMasterOwnYesNo(MasterDocIdentifier.noOwn);
      propertyDetailsRequestDTO.coapplicantrelationId =
          _buisinessDropdownmodel.value;
      print("Co Applicant Own");
      print(coapplicantown);

      propertyDetailsRequestDTO.CoapplicantOwnid =
          MasterDocumentId.builder.getMasterOwnYesNo(MasterDocIdentifier.noOwn);

      String data = await propertyDetailsRequestDTO.toEncodedJson();

      FormData formData = FormData.fromMap({
        "json": await EncryptionUtils.getEncryptedText(data),
      });

      propertyDetailsBloc.addPropertyDetails(formData);
    } else {
      if (coapplicantown == 1) {
        propertyDetailsRequestDTO.refBlId =
            blFetchBloc!.fetchBLResponseDTO.refBlId;
        propertyDetailsRequestDTO.isPropertyOwnedByACustomer = isSwitchPressed;
        propertyDetailsRequestDTO.isCoApplicantOwnsProperty = true;
        propertyDetailsRequestDTO.propertyCoApplicantPropertyPincode =
            pinEditingNotownController.text;
        propertyDetailsRequestDTO.propertyCoApplicantsName =
            coapplicantEditingController.text;
        propertyDetailsRequestDTO.propertyCoApplicantPropertyType =
            coapplicantown == 1 ? "Residence" : "Business";
        propertyDetailsRequestDTO.typeOfProperty = "";
        propertyDetailsRequestDTO.propertyCoApplicantsRelation =
            _buisinessDropdownmodel.name;
        propertyDetailsRequestDTO.propertyPincode = "";

        propertyDetailsRequestDTO.coapplicantrelationId =
            _buisinessDropdownmodel.value;
        propertyDetailsRequestDTO.OwnerownId = isSwitchPressed
            ? MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
            : MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.noOwn);

        propertyDetailsRequestDTO.CoapplicantOwnid = coapplicantown == 1
            ? MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
            : MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.noOwn);
        String data = await propertyDetailsRequestDTO.toEncodedJson();

        print(data);
        FormData formData = FormData.fromMap({
          "json": await EncryptionUtils.getEncryptedText(data),
        });

        propertyDetailsBloc.addPropertyDetails(formData);
      } else {
        propertyDetailsRequestDTO.refBlId =
            blFetchBloc!.fetchBLResponseDTO.refBlId;
        propertyDetailsRequestDTO.isPropertyOwnedByACustomer = isSwitchPressed;
        propertyDetailsRequestDTO.isCoApplicantOwnsProperty = false;
        propertyDetailsRequestDTO.propertyCoApplicantPropertyPincode = "";
        propertyDetailsRequestDTO.propertyCoApplicantsName = "";
        propertyDetailsRequestDTO.propertyCoApplicantPropertyType = "";
        propertyDetailsRequestDTO.typeOfProperty = "";
        propertyDetailsRequestDTO.propertyCoApplicantsRelation = "";
        propertyDetailsRequestDTO.propertyPincode = "";
        propertyDetailsRequestDTO.coapplicantrelationId =
            _buisinessDropdownmodel.value;
        propertyDetailsRequestDTO.OwnerownId = isSwitchPressed
            ? MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
            : MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.noOwn);

        propertyDetailsRequestDTO.CoapplicantOwnid = coapplicantown == 1
            ? MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.yesOwn)
            : MasterDocumentId.builder
                .getMasterOwnYesNo(MasterDocIdentifier.noOwn);

        String data = await propertyDetailsRequestDTO.toEncodedJson();

        print(data);

        FormData formData = FormData.fromMap({
          "json": await EncryptionUtils.getEncryptedText(data),
        });

        propertyDetailsBloc.addPropertyDetails(formData);
      }
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    BusinessCommonDTO commonDTO =
        BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
    if (commonDTO.status!) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdditionalDetails(flag: widget.flag)),
      );
    } else {
      SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
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
