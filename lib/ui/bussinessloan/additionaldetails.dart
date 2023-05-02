import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/additionaldetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/request/additionalrequestdto.dart';
import 'package:dhanvarsha/model/request/blsoftofferresponsedto.dart';
import 'package:dhanvarsha/model/request/clientinitiaterequest.dart';
import 'package:dhanvarsha/model/request/generatesoftofferdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/application_rejected.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/commautils/common_age_validator.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/currencyformatter.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class AdditionalDetails extends StatefulWidget {
  final String flag;

  const AdditionalDetails({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails>
    implements AppLoadingMultiple {
  GlobalKey<_AdditionalDetailsState> _scrollViewKey = GlobalKey();

  AdditionalDetailsBloc? additionalDetailsBloc;
  TextEditingController saleamount = new TextEditingController();
  TextEditingController averagesale = new TextEditingController();
  TextEditingController monthlyemi = new TextEditingController();
  TextEditingController dateController =
      new TextEditingController(text: "Business start date");
  int count = -1;
  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;
  BLFetchBloc? blFetchBloc;
  var isValidatePressed = false;

  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Retail and Wholesale", calories: 110),
    FavouriteFoodModel(foodName: "Retail", calories: 110),
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
          favouriteFoodModel.foodName!!,
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

  MasterBloc? masterBloc;

  @override
  void initState() {
    super.initState();

    masterBloc = BlocProvider.getBloc<MasterBloc>();
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    additionalDetailsBloc = AdditionalDetailsBloc(this);

    if (blFetchBloc!.fetchBLResponseDTO.natureofBusinessId != "") {
      int index = MasterDocumentId.builder.getNatureOfBusinessId(
          blFetchBloc!.fetchBLResponseDTO!.natureofBusinessId ?? 0);

      buisinessFirmTypeList = [];
      buisinessFirmTypeList = _buildBusinessModelDropdown(
          masterBloc!.masterSuperDTO.natureofBusiness!,
          buisinessFirmTypeList,
          _buisinessDropdownmodel);

      _buisinessDropdownmodel =
          buisinessFirmTypeList.elementAt(index + 1).value!;

      onChangeBusinessDropdown(_buisinessDropdownmodel);
    } else {
      buisinessFirmTypeList = [];
      buisinessFirmTypeList = _buildBusinessModelDropdown(
          masterBloc!.masterSuperDTO.natureofBusiness!,
          buisinessFirmTypeList,
          _buisinessDropdownmodel);

      _buisinessDropdownmodel = buisinessFirmTypeList.elementAt(0).value!;
    }

    saleamount.text =
        blFetchBloc!.fetchBLResponseDTO.lastYearTurnOver.toString()! ?? "500";
    averagesale.text =
        blFetchBloc!.fetchBLResponseDTO.averageMonthlySales.toString() ?? "200";
    dateController.text =
        blFetchBloc!.fetchBLResponseDTO.businessStartDate ?? "";
    monthlyemi.text =
        blFetchBloc!.fetchBLResponseDTO.presentMonthlyEmi.toString() ??
            "50000"
                "";
    count = blFetchBloc!.fetchBLResponseDTO.doesBusinessHaveCurrentBankAccount!
        ? 1
        : 2;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseView(
        title: "",
        type: false,
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: [4, 4],
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: _getBody(),
        ),
        context: context);
  }

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle(),
          _getAdditionalDetails(),
          // _getContinueButton(),
        ],
      ),
    );
  }

  MasterDataDTO _buisinessDropdownmodel =
      MasterDataDTO("Select nature of business", 0);
  onChangeBusinessDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      setState(() {
        _buisinessDropdownmodel = favouriteFoodModel!;
        buisinessFirmTypeList = [];
        buisinessFirmTypeList = _buildBusinessModelDropdown(
            masterBloc!.masterSuperDTO.natureofBusiness ?? [],
            buisinessFirmTypeList,
            _buisinessDropdownmodel);
      });
    }
  }

  List<DropdownMenuItem<MasterDataDTO>> _buildBusinessModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select nature of business"}) {
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    saleamount.dispose();
    averagesale.dispose();
    monthlyemi.dispose();
  }

  Widget _getAdditionalDetails() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: DVTextField(
            textInputType: TextInputType.number,
            controller: saleamount,
            outTextFieldDecoration:
                BoxDecorationStyles.outTextFieldBoxDecoration,
            inputDecoration: InputDecorationStyles.inputDecorationTextField,
            title: "Last Year Reported Turnover as per ITR/Banking ",
            hintText: "Last Year Reported Turnover as per ITR/Banking",
            errorText: "Please Enter Last year turnover",
            maxLine: 1,
            onChangedText: (text) {
              if (saleamount.text != '') {
                averagesale.text =
                    (int.parse(saleamount.text.replaceAll(",", "")) / 12)
                        .toStringAsFixed(0)
                        .toString();
              } else {
                averagesale.text = '';
              }
              print("Avg Sales Are");
              print(averagesale.text);
            },
            image: DhanvarshaImages.ruppeeNew,
            isFlag: true,
            textInpuFormatter: [
              CurrencyInputFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
            ],
            isValidatePressed: isValidatePressed,
            onEnterPressRequired: true,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: DVTextField(
            isEnable: false,
            textInputType: TextInputType.number,
            controller: averagesale,
            outTextFieldDecoration:
                BoxDecorationStyles.outTextFieldBoxDecoration,
            inputDecoration: InputDecorationStyles.inputDecorationTextField,
            title: "Avg. monthly sales",
            hintText: "Avg. monthly sales",
            image: DhanvarshaImages.ruppeeNew,
            isFlag: true,
            errorText: "Please Enter average monthly sale",
            maxLine: 1,
            textInpuFormatter: [
              CurrencyInputFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
            ],
            isValidatePressed: false,
          ),
        ),
        Row(
          children: [
            // Image.asset(
            //   DhanvarshaImages.i,
            //   height: 15,
            //   width: 15,
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "As per banking or GST records",
                style: CustomTextStyles.boldMediumFont,
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Divider(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: DVTextField(
            textInputType: TextInputType.number,
            controller: monthlyemi,
            outTextFieldDecoration:
                BoxDecorationStyles.outTextFieldBoxDecoration,
            inputDecoration: InputDecorationStyles.inputDecorationTextField,
            title: "Enter Present Monthly EMI",
            hintText: "Enter Present Monthly EMI",
            isFlag: true,
            image: DhanvarshaImages.ruppeeNew,
            errorText: "Please Enter Present Monthly EMI",
            maxLine: 1,
            textInpuFormatter: [
              CurrencyInputFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
            ],
            isValidatePressed: isValidatePressed,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomDropdownMaster<MasterDataDTO>(
            dropdownMenuItemList: buisinessFirmTypeList,
            onChanged: onChangeBusinessDropdown,
            value: _buisinessDropdownmodel,
            isEnabled: true,
            title: "Nature of business",
            isTitleVisible: true,
            errorText: "Please select nature of business",
            isValidate: isValidatePressed,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CustomDatePicker(
            controller: dateController,
            isValidateUser: isValidatePressed,
            selectedDate: dateController.text,
            title: "Business start date",
            isTitleVisible: true,
          ),
        ),
        _BankAccountButton(),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        // Divider(),
        // Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        //
        _getContinueButton()
      ]),
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

              if (CustomValidator(saleamount.value.text)
                      .validate(Validation.isEmpty) &&
                  CustomValidator(averagesale.value.text)
                      .validate(Validation.isEmpty) &&
                  CustomValidator(monthlyemi.value.text)
                      .validate(Validation.isEmpty) &&
                  CustomValidator(dateController.value.text)
                      .validate(Validation.isEmpty) &&
                  _buisinessDropdownmodel.value != 0) {
                if (double.parse(saleamount.value.text.replaceAll(",", "")) <
                    250000) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Minimum turnover should be 2,50,000.")));
                  return;
                }

                if(!CommonAgeValidator.isVintageYearValid(dateController.text)){
                  SuccessfulResponse.showScaffoldMessage("Business year should be before 2 years.", context);
                  return;
                }
                if (count != -1) {
                  addAdditionalDetails();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Please Select business have bank account?")));
                }
              } else {
                SuccessfulResponse.showScaffoldMessage(
                    AppConstants.fillAllDetails, context);
                // print("Not Validated");
              }
            },
            title: "SUBMIT",
            boxDecoration: ButtonStyles.redButtonWithCircularBorder,
          ),
        ],
      ),
    );
  }

  Widget _BankAccountButton() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "Does the business have a current bank account?",
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
                      count = 1;
                    });
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
                    });
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

  Widget _getTitle() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Eligibility Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
            // Image.asset(
            //   DhanvarshaImages.question,
            //   height: 25,
            //   width: 25,
            // )
          ],
        ),
      ),
    );
  }

  addAdditionalDetails() async {
    AdditionalDetailsRequestDTO additionalDetailsRequestDTO =
        AdditionalDetailsRequestDTO();
    additionalDetailsRequestDTO.refBlId =
        blFetchBloc!.fetchBLResponseDTO.refBlId;
    additionalDetailsRequestDTO.averageMonthlySales =
        int.parse(averagesale.text.replaceAll(",", ""));
    additionalDetailsRequestDTO.lastYearTurnOver =
        int.parse(saleamount.text.replaceAll(",", ""));
    additionalDetailsRequestDTO.natureofBusiness =
        _buisinessDropdownmodel.name!;
    additionalDetailsRequestDTO.natureofBusinessId =
        _buisinessDropdownmodel.value!;
    additionalDetailsRequestDTO.doesBusinessHaveCurrentBankAccount =
        count == 1 ? true : false;
    additionalDetailsRequestDTO.YesNo_cd_bankAccountFlag = count == 1
        ? MasterDocumentId.builder.getBankYesNoType(MasterDocIdentifier.yesBank)
        : MasterDocumentId.builder.getBankYesNoType(MasterDocIdentifier.noBank);

    additionalDetailsRequestDTO.businessStartDate = dateController.text;
    additionalDetailsRequestDTO.presentMonthlyEmi =
        int.parse(monthlyemi.text.replaceAll(",", ""));

    String data = additionalDetailsRequestDTO.toEncodedJson();

    // print("Business Name");
    // print(_buisinessDropdownmodel.name);
    //
    // print("Bank Details Data");
    //
    // print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          additionalDetailsRequestDTO.toEncodedJson())
    });

    additionalDetailsBloc!.addAdditionalDetails(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) async {
    if (index == 0) {
      BusinessCommonDTO commonDTO =
          BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
      if (commonDTO.status!) {
        generateSoftOffer();
      } else {
        SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
      }
    } else if (index == 1) {
      BLSoftOfferResponseDTO blSoftOfferResponseDTO =
          BLSoftOfferResponseDTO.fromJson(jsonDecode(dto.data!));

      // blSoftOfferResponseDTO.status == "Approve"

      if (blSoftOfferResponseDTO.status == "Approve") {
        RefClientRequest refClientRequest = RefClientRequest();
        refClientRequest.refId = blFetchBloc!.fetchBLResponseDTO.refBlId;

        FormData formData = FormData.fromMap({
          "json": await EncryptionUtils.getEncryptedText(
              refClientRequest.toEncodedJson())
        });

        additionalDetailsBloc!.postBLClientInitiate(formData);

        // if (!blSoftOfferResponseDTO.CBStatus!) {
        //   DialogUtils.offerrejectedByLoan(context,
        //       message: "CB Status Rejected");
        // } else {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SoftLoanOffer(
        //               flag: widget.flag,
        //               amount: blSoftOfferResponseDTO.eligibleAmount.toString(),
        //               userName: blSoftOfferResponseDTO.userName ?? "",
        //               id: blSoftOfferResponseDTO.ClientId!,
        //             )),
        //   );
        // }
      } else {
        CustomLoaderBuilder.builder.hideLoader();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApplicationRejected(
              message: "Eligibility Norms Not Met",
            ),
          ),
        );
        // SuccessfulResponse.showScaffoldMessage(
        //     "Your offer has been rejected", context);
      }
    } else if (index == 2) {
      BLSoftOfferResponseDTO blSoftOfferResponseDTO =
          BLSoftOfferResponseDTO.fromJson(jsonDecode(dto.data!));

      print("USER NAME IS");
      print(blSoftOfferResponseDTO.userName);
      if (blSoftOfferResponseDTO.status == "Approve") {
        if (blSoftOfferResponseDTO.ClientId != 0) {
          if (!blSoftOfferResponseDTO.CBStatus!) {
            DialogUtils.clientIdDialog(
                context, blSoftOfferResponseDTO.ClientId.toString(), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplicationRejected(
                    message: "Credit Bureau Norms Not Met",
                  ),
                ),
              );
            });
          } else {
            DialogUtils.clientIdDialog(
                context, blSoftOfferResponseDTO.ClientId.toString(), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SoftLoanOffer(
                          flag: widget.flag,
                          amount:
                              blSoftOfferResponseDTO.eligibleAmount.toString(),
                          userName: blSoftOfferResponseDTO.userName ?? "",
                          id: blSoftOfferResponseDTO.ClientId!,
                        )),
              );
            });
          }
        } else {
          SuccessfulResponse.showScaffoldMessage(
              blSoftOfferResponseDTO.message!, context);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } else {
        CustomLoaderBuilder.builder.hideLoader();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApplicationRejected(
              message: "Eligibility Norms Not Met",
            ),
          ),
        );
      }
    }
  }

  generateSoftOffer() async {
    GenerateSoftOfferDTO generateSoftOfferDTO = GenerateSoftOfferDTO();
    generateSoftOfferDTO.age = CustomerBLOnboarding.age;
    generateSoftOfferDTO.isPincodeServicible = 1;
    generateSoftOfferDTO.refPlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    generateSoftOfferDTO.avgSalesToCredits =
        int.parse(averagesale.text.replaceAll(",", ""));
    generateSoftOfferDTO.declaredMonthlyEmi =
        int.parse(monthlyemi.text.replaceAll(",", ""));
    generateSoftOfferDTO.salesAsPerITR =
        int.parse(saleamount.text.replaceAll(",", ""));
    generateSoftOfferDTO.entityType = "LIMITED";
    generateSoftOfferDTO.isOwnPincodeServicible = 1;
    generateSoftOfferDTO.vintage = (DateTime.now().year -
                    int.parse(
                        dateController.value.text.split("/").elementAt(2))) *
                12 ==
            0
        ? DateTime.now().month -
            int.parse(dateController.value.text.split("/").elementAt(1))
        : (DateTime.now().year -
                int.parse(dateController.value.text.split("/").elementAt(2))) *
            12;

    String data = await generateSoftOfferDTO.toEncodedJson();
    print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await generateSoftOfferDTO.toEncodedJson())
    });

    additionalDetailsBloc!.getBLSoftOffer(formData);

    // generateSoftOfferDTO.refPlId=
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoaderUIDiff();
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
