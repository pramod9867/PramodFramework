import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/businessdetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/basicbusinessdetailsdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessaadhardetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/custpersonalinfo.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/currencyformatter.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BusinessDetails extends StatefulWidget {
  final BuildContext context;

  const BusinessDetails({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails>
    implements AppLoading {
  String firmTypeValue = "";

  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;
  BusinessDetailsBloc? businessDetailsBloc;
  MasterDataDTO _buisinessDropdownmodel =
      MasterDataDTO("Select entity type", 0);

  List<DropdownMenuItem<MasterDataDTO>> _buildBusinessModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select entity type"}) {
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

  GlobalKey<_BusinessDetailsState> _scrollViewKey = GlobalKey();
  onChangeBusinessDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _buisinessDropdownmodel = favouriteFoodModel!;
        buisinessFirmTypeList = [];
        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.businessFirmType ?? [],
            buisinessFirmTypeList,
            _buisinessDropdownmodel);
      });
    }
  }

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
          favouriteFoodModel.name!!,
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

  BLFetchBloc? blFetchBloc;

  MasterBloc? masterBloc;

  @override
  void initState() {
    super.initState();

    buisinessFirmTypeList = [];

    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    businessDetailsBloc = BusinessDetailsBloc(this);

    // MasterDocumentId.builder.getIndexOfFirmType(0);

    pincodeEditingController.text =
        blFetchBloc!.fetchBLResponseDTO.businessPincode!;

    if (blFetchBloc!.fetchBLResponseDTO.firmId != 0) {
      int index = MasterDocumentId.builder
          .getIndexOfFirmType(blFetchBloc!.fetchBLResponseDTO.firmId!);

      buisinessFirmTypeList = _buildBusinessModelDropdown(
          masterBloc!.masterSuperDTO.businessFirmType!,
          buisinessFirmTypeList,
          _buisinessDropdownmodel);

      _buisinessDropdownmodel =
          buisinessFirmTypeList.elementAt(index + 1).value!;

      onChangeBusinessDropdown(_buisinessDropdownmodel);
    } else {
      buisinessFirmTypeList = _buildBusinessModelDropdown(
          masterBloc!.masterSuperDTO.businessFirmType!,
          buisinessFirmTypeList,
          _buisinessDropdownmodel);

      _buisinessDropdownmodel = buisinessFirmTypeList.elementAt(0).value!;
    }
  }

  var isValidatePressed = false;
  TextEditingController pincodeEditingController = new TextEditingController();

  @override
  void dispose() {
    pincodeEditingController.dispose();
    // dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return BaseView(
        title: "",
        isHeaderColor: false,
        isBurgerVisble: false,
        isdhavarshalogovisible: true,
        isBackDialogRequired: true,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: _getNewBLBody(),
        ),
        context: context);
  }

  Widget _getNewBLBody() {
    return Stack(
      children: [
        ClipPath(
            clipper: CurveImage(),
            child: Container(
              height: 220,
              width: SizeConfig.screenWidth,
              color: AppColors.white,
            )),
        Container(
          // color: AppColors.blue,
          constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).viewInsets.top -
                  MediaQuery.of(context).viewInsets.bottom -
                  30),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          // _getTitleCompoenentNEW(),
                          Column(
                            children: [
                              Text(
                                "",
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "",
                                  style: CustomTextStyles
                                      .regularMediumGreyFontGotham,
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Image.asset(
                                  DhanvarshaImages.blDetailsNew,
                                  height: 125,
                                  width: 125,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Customers Business details",
                                        style: CustomTextStyles
                                            .MediumBoldLightFont,
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     DialogUtils.UploadInsturctionDialog(
                                    //         context);
                                    //   },
                                    //   child: Image.asset(
                                    //     DhanvarshaImages.question,
                                    //     height: 25,
                                    //     width: 25,
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              // Container(
                              //     margin: EdgeInsets.symmetric(vertical: 10),
                              //     child: CustomDropdown(
                              //       title: "Firm Type",
                              //       dropdownMenuItemList: _favouriteFoodModelDropdownList,
                              //       onChanged: onChangeFavouriteFoodModelDropdown,
                              //       value: _favouriteFoodModel,
                              //       isEnabled: true,
                              //     )),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: CustomDropdownMaster<MasterDataDTO>(
                                  dropdownMenuItemList: buisinessFirmTypeList,
                                  onChanged: onChangeBusinessDropdown,
                                  value: _buisinessDropdownmodel,
                                  isEnabled: true,
                                  title: "Entity Type",
                                  isTitleVisible: true,
                                  errorText: "Please select entity type",
                                  isValidate: isValidatePressed,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: DVTextField(
                                  textInputType: TextInputType.number,
                                  controller: pincodeEditingController,
                                  outTextFieldDecoration: BoxDecorationStyles
                                      .outTextFieldBoxDecoration,
                                  inputDecoration: InputDecorationStyles
                                      .inputDecorationTextField,
                                  title: "Business Pincode",
                                  textInpuFormatter: [
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[A-Za-z0-9]')),
                                  ],
                                  hintText: "Enter business pincode",
                                  errorText: "Please enter business pincode",
                                  maxLine: 1,
                                  isValidatePressed: isValidatePressed,
                                  type: Validation.isValidPinCode,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    // Align(
                                    //   child: Icon(
                                    //     Icons.info,
                                    //     color: Colors.red,
                                    //   ),
                                    //   alignment: Alignment.topLeft,
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Expanded(
                                      child: Text(
                                        "Please provide the pincode of the location where your factory/shop is situated.",
                                        style: CustomTextStyles
                                            .regularSmallGreyFont1,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });

                      // CustomValidator(pincodeEditingController
                      //     .value.text)
                      //     .validate(Validation.isEmpty) &&
                      //     _buisinessDropdownmodel.value != 0

                      if (CustomValidator(pincodeEditingController.value.text)
                              .validate(Validation.isValidPinCode) &&
                          _buisinessDropdownmodel.value != 0) {
                        addBusinessDetails();
                      }
                    },
                    title: "CONTINUE",
                    boxDecoration: ButtonStyles.redButtonWithCircularBorder,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight - 60 - SizeConfig.verticalviewinsects,
        child: Column(
          children: [
            _getTitleCompoenent(),
          ],
        ),
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      alignment: Alignment.topLeft,
      child: Text(
        "Business Details",
        style: CustomTextStyles.boldLargeFonts,
      ),
    );
  }

  addBusinessDetails() async {
    BasicBusinessDetailsRequestDTO basicBusinessDetailsRequestDTO =
        BasicBusinessDetailsRequestDTO();
    basicBusinessDetailsRequestDTO.firmId = _buisinessDropdownmodel.value;
    basicBusinessDetailsRequestDTO.firmType = _buisinessDropdownmodel.name;
    basicBusinessDetailsRequestDTO.businessPincode =
        pincodeEditingController.text;
    basicBusinessDetailsRequestDTO.isSubDsa =
        await SharedPreferenceUtils.sharedPreferenceUtils.isSubDsa();

    basicBusinessDetailsRequestDTO.refBlId =
        blFetchBloc!.fetchBLResponseDTO.refBlId;
    basicBusinessDetailsRequestDTO.categoryId = _buisinessDropdownmodel.value;

    String data = await basicBusinessDetailsRequestDTO.toEncodedJson();
    print(data);
    print(data);
    FormData formData = FormData.fromMap(
        {"json": await EncryptionUtils.getEncryptedText(data)});

    businessDetailsBloc!.addBusinessDetails(formData);
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
      SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
      if (_buisinessDropdownmodel.name == "Proprietorship") {
        print("Proprietorship");
        print("INTO THE PROPRIETORSHIP");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessAadharDetails(
              flag: "",
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessAadharDetails(
              flag: "noproprietor",
            ),
          ),
        );
      }
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
  final String? name;
  final int? value;

  FavouriteFoodModel({this.name, this.value});
}
