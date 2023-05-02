import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/businessdetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/gold_details.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/basicbusinessdetailsdto.dart';
import 'package:dhanvarsha/model/request/golddetailsrequest.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/response/golddetailrepsonse.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessaadhardetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/custpersonalinfo.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/goldloan/bookappointment/BookAppointment.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/currencyformatter.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/geo_locator/dhanvarsha_geo_locator.dart';
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
import 'package:geolocator/geolocator.dart';

class GoldAddDetails extends StatefulWidget {
  //final BuildContext context;

  const GoldAddDetails({
    Key? key,
    //required this.context,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoldAddDetailsState();
}

class _GoldAddDetailsState extends State<GoldAddDetails>
    implements AppLoadingMultiple {
  String firmTypeValue = "";

  GoldDetailsBloc? goldDetailsBloc;

  GLFetchBloc? glFetchBloc;
  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;
  BusinessDetailsBloc? businessDetailsBloc;
  MasterDataDTO _buisinessDropdownmodel = MasterDataDTO("Enter Gold Karat", 0);

  List<DropdownMenuItem<MasterDataDTO>> _buildBusinessModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Enter Gold Karat"}) {
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

  GlobalKey<_GoldAddDetailsState> _scrollViewKey = GlobalKey();
  onChangeBusinessDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _buisinessDropdownmodel = favouriteFoodModel!;
        buisinessFirmTypeList = [];
        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.goldKarat ?? [],
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

    glFetchBloc = BlocProvider.getBloc<GLFetchBloc>();
    masterBloc = BlocProvider.getBloc<MasterBloc>();

    goldDetailsBloc = GoldDetailsBloc(this);
    // MasterDocumentId.builder.getIndexOfFirmType(0);

    /*pincodeEditingController.text =
    blFetchBloc!.fetchBLResponseDTO.businessPincode!;*/

    if (false) {
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
          masterBloc!.masterSuperDTO.goldKarat!,
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
        isBackDialogRequired: true,
        isdhavarshalogovisible: true,
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
          constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom-50),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _getTitleCompoenentNEW(),
                          Column(
                            children: [
                              Center(
                                child: Text(
                                  "Gold Loan",
                                  style: CustomTextStyles.boldLargeFonts,
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "",
                                    style: CustomTextStyles
                                        .regularMediumGreyFontGotham,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Image.asset(
                                    DhanvarshaImages.gl,
                                    height: 135,
                                    width: 135,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text(
                                  "Details of Gold to be pledge",
                                  style: CustomTextStyles.boldMediumFont,
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
                                  title: "Enter Gold Karat",
                                  isTitleVisible: true,
                                  errorText: "Please select Gold Karat",
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
                                  title: "Weight",
                                  textInpuFormatter: [
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[A-Za-z0-9]')),
                                  ],
                                  hintText: "Enter Weight (in grams)",
                                  errorText: "Please enter Weight",
                                  maxLine: 1,
                                  isValidatePressed: isValidatePressed,
                                  type: Validation.isEmpty,
                                ),
                              ),
                            ],
                          ),
                          /*Container(
                            child: Row(
                              children: [
                                Align(
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.red,
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "Please provide the pincode of the location where your factory/shop is situated.",
                                    style:
                                    CustomTextStyles.regularSmallGreyFont1,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),*/

                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomButton(
                                onButtonPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       //builder: (context) => CommonScreen(),
                                  //       builder: (context) => BookAppointment(),
                                  //     ));
                                  setState(() {
                                    isValidatePressed = true;
                                  });

                                  // CustomValidator(pincodeEditingController
                                  //     .value.text)
                                  //     .validate(Validation.isEmpty) &&
                                  //     _buisinessDropdownmodel.value != 0

                                  if (CustomValidator(pincodeEditingController
                                              .value.text)
                                          .validate(Validation.isEmpty) &&
                                      _buisinessDropdownmodel.value != 0) {
                                    addGoldAddDetails();
                                  }
                                },
                                title: "CONTINUE",
                                boxDecoration:
                                    ButtonStyles.redButtonWithCircularBorder,
                              ),
                            ),
                          ),
            ],
          ),
        ),
        
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

  addGoldAddDetails() async {
    GoldDetailsRequest goldDetailsRequest = GoldDetailsRequest();
    goldDetailsRequest.goldKarat = _buisinessDropdownmodel.name;
    goldDetailsRequest.dsaId =
        await SharedPreferenceUtils.sharedPreferenceUtils.getDSAID();
    goldDetailsRequest.employmentType = CustomerOnBoarding.ModeOfSalary;
    goldDetailsRequest.isSubDsa =
        await SharedPreferenceUtils.sharedPreferenceUtils.isSubDsa();
    goldDetailsRequest.refGlId = glFetchBloc!.fetchGLResponseDTO!.refGLId!;
    goldDetailsRequest.goldWeight = pincodeEditingController.text;

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          goldDetailsRequest.toEncodedJson()),
    });

    print(goldDetailsRequest.toEncodedJson());

    goldDetailsBloc!.addGoldDetails(formData);
    // print(goldDetailsRequest.toEncodedJson());
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) async {
    if (index == 0) {
      GoldDetailsResponse goldDetailsResponse =
          GoldDetailsResponse.fromJson(jsonDecode(dto.data!));

      print("Successful Response ------------>");
      print(jsonEncode(dto.data!));

      if (goldDetailsResponse.status!) {
        DhanvarshaGeoLocator.determinePosition((Position position) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookAppointment(
                    position: position,
                  ),
                ),
              )
            });

        SuccessfulResponse.showScaffoldMessage(
            goldDetailsResponse.message!, context);
      } else {
        SuccessfulResponse.showScaffoldMessage(
            goldDetailsResponse.message!, context);
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
}

class FavouriteFoodModel {
  final String? name;
  final int? value;

  FavouriteFoodModel({this.name, this.value});
}
