import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/resindentialbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/residentialproofrequestdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/incorporationdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/itrdocs.dart';
import 'package:dhanvarsha/ui/bussinessloan/vintageproof.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/CustomBtnBlackborder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BusinessResidentialProof extends StatefulWidget {
  final String flag;

  const BusinessResidentialProof({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessResidentialProofState();
}

class _BusinessResidentialProofState extends State<BusinessResidentialProof>
    implements AppLoading {
  final List<BillingModel> _listOfBills = [
    BillingModel(billId: 0, billName: "Select Document"),
    BillingModel(billId: 1, billName: "Electricity Bill"),
    BillingModel(billId: 2, billName: "Ration Card"),
    BillingModel(billId: 3, billName: "Water Bill"),
  ];

  BLFetchBloc? blFetchBloc;

  TextEditingController panTextController = TextEditingController();

  MenueBuilder? districtBuilder, stateBuilder;
  TextEditingController addressLine1 = TextEditingController();
  TextEditingController addressLine2 = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  late bool isRentalUpload = false;
  late ResidentialProofBloc? residentialProofBloc;
  bool isValidatePressed = false;
  BillingModel _billingModelModel = BillingModel();
  late List<DropdownMenuItem<BillingModel>> __billingModelModelDropdownList;
  List<DropdownMenuItem<BillingModel>> _buildFavouriteFoodModelDropdown(
      List billingModelModelList) {
    List<DropdownMenuItem<BillingModel>> items = [];
    for (BillingModel billingModelModel in billingModelModelList) {
      items.add(DropdownMenuItem(
        value: billingModelModel,
        child: Text(
          billingModelModel.billName!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  MasterBloc? masterBloc;

  GlobalKey<_BusinessResidentialProofState> _scrollViewKey = GlobalKey();
  bool isSwitchPressed = false;
  bool isCurrentSwitchPressed = false;
  onChangeFavouriteFoodModelDropdown(BillingModel? billingModel) {
    setState(() {
      _billingModelModel = billingModel!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __billingModelModelDropdownList =
        _buildFavouriteFoodModelDropdown(_listOfBills);
    ;

    masterBloc = BlocProvider.getBloc<MasterBloc>();
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    residentialProofBloc = ResidentialProofBloc(this);
    _billingModelModel = _listOfBills[0];

    districtBuilder = MenueBuilder();
    stateBuilder = MenueBuilder();

    panTextController.text =
        blFetchBloc!.fetchBLResponseDTO.residentialProofResidentialPincode ??
            "";
    addressLine1.text =
        blFetchBloc!.fetchBLResponseDTO.residentialProofAddressLine1 ?? "";
    addressLine2.text =
        blFetchBloc!.fetchBLResponseDTO.residentialProofAddressLine12 ?? "";
    stateBuilder!.setInitialValue(MasterDocumentId.builder
        .getMasterObjectStateByName(
            blFetchBloc!.fetchBLResponseDTO.residentialProofState ?? ""));
    districtBuilder!.setInitialValue(MasterDocumentId.builder
        .getMasterObjectDistrictByName(
            blFetchBloc!.fetchBLResponseDTO.residentialProofCity ?? ""));

    isRentalUpload =
        blFetchBloc!.fetchBLResponseDTO!.residentialProofIsBillOnMyName ==
                'true'
            ? true
            : false ?? false;
  }

  GlobalKey<CustomImageBuilderState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        isStepShown: true,
        stepArray: widget.flag == "" ? const [5, 8] : const [5, 9],
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                _getTitleCompoenentNEW(),
                CustomImageBuilder(
                  initialImage: blFetchBloc!
                          .fetchBLResponseDTO.residentialProofDocumentImage ??
                      "",
                  key: _key,
                  value: "Upload Residential Proof",
                  isAadhaarVisible: false,
                  image: DhanvarshaImages.poa,
                  dropdown: Column(
                    children: [
                      _getPanComponent(),
                      _getbusinessaddressComponent(),
                      _getbusinessaddressComponent2(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ValueListenableBuilder(
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
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ValueListenableBuilder(
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
                                  // await getTalukaDetails(id);
                                },
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Upload Document with above address",
                          style: CustomTextStyles.regularSmallGreyFont,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: CustomDropdown(
                            dropdownMenuItemList:
                                __billingModelModelDropdownList,
                            onChanged: onChangeFavouriteFoodModelDropdown,
                            value: _billingModelModel,
                            isEnabled: true,
                            title: "Document",
                            isTitleVisible: true,
                          ))
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth - 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name on bill",
                                  style: CustomTextStyles.boldLargeFonts,
                                ),
                                Text(
                                  "Bill is on customers name",
                                  style: CustomTextStyles.regularSmallGreyFont,
                                ),
                              ],
                            ),
                          ),
                          FlutterSwitch(
                            width: 55,
                            height: 35,
                            activeColor: AppColors.buttonRed,
                            value: isRentalUpload,
                            onToggle: (value) {
                              setState(() {
                                isRentalUpload = value;
                              });
                              print(value);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.flag == "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VintageProof(flag: widget.flag)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IncorporationDocument()),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "SKIP",
                      style: CustomTextStyles.buttonTextStyleRed,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });

                      if (_key.currentState!.imagepicked.value == "") {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please upload rental proof", context);
                        return;
                      }

                      if (_billingModelModel.billId == 0) {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please select type of documents", context);
                        return;
                      }

                      if (CustomValidator(panTextController.text)
                              .validate(Validation.isValidPinCode) &&
                          CustomValidator(addressLine1.text)
                              .validate(Validation.isEmpty) &&
                          CustomValidator(addressLine2.text)
                              .validate(Validation.isEmpty) &&
                          stateBuilder!.menuNotifier.value.length > 0 &&
                          districtBuilder!.menuNotifier.value.length > 0) {
                        addResidentialProof();
                      } else {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please enter valid details", context);
                      }
                    },
                    title: "CONTINUE",
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Residential Address",
              style: CustomTextStyles.boldLargeFonts,
              textAlign: TextAlign.left,
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

  addResidentialProof() async {
    print("Add Residential Proof");
    ResidentialProofRequestDTO residentialProofRequestDTO =
        ResidentialProofRequestDTO();
    residentialProofRequestDTO.refBlId =
        blFetchBloc!.fetchBLResponseDTO.refBlId;
    residentialProofRequestDTO.residentialProofAddressLine1 = addressLine1.text;
    residentialProofRequestDTO.residentialProofAddressLine12 =
        addressLine2.text;
    residentialProofRequestDTO.customersPanImage = "";
    residentialProofRequestDTO.residentialProofIsBillOnMyName = isRentalUpload;
    residentialProofRequestDTO.residentialProofCity =
        districtBuilder!.menuNotifier.value[0].name;
    residentialProofRequestDTO.residentialProofState =
        stateBuilder!.menuNotifier.value[0].name;
    residentialProofRequestDTO.residentialProofCountry = "";
    residentialProofRequestDTO.residentialProofDocumentImage =
        _key.currentState!.fileName;
    residentialProofRequestDTO.residentialProofResidentialPincode =
        panTextController.text;
    residentialProofRequestDTO.residentialProofDocumentName =
        _billingModelModel.billName;

    String data = await residentialProofRequestDTO.toEncodedJson();
    print(data);

    List<MultipartFile> appFiles = [];

    print(_key.currentState!.imagepicked.value);

    if (_key.currentState!.imagepicked.value != "" &&
        !Uri.parse(_key.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _key.currentState!.imagepicked.value,
          filename: _key.currentState!.fileName));
    }

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await residentialProofRequestDTO.toEncodedJson()),
      "Myfiles": appFiles
    });

    print(appFiles);

    residentialProofBloc!.addResidentialProof(formData);
  }

  _getPanComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: DVTextField(
        textInputType: TextInputType.number,
        controller: panTextController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Residential pin code",
        textInpuFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(6),
        ],
        hintText: "Enter residential pincode",
        errorText: "Enter your business pin code here",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isValidPinCode,
      ),
    );
  }

  _getbusinessaddressComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: DVTextField(
        controller: addressLine1,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Address Line 1",
        hintText: "Enter Address Line 1",
        textInpuFormatter: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(
              RegExp("[A-Za-z0-9 (),.\/-]"))
        ],
        errorText: "Enter your Address Line 1",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isEmpty,
      ),
    );
  }

  _getState() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: DVTextField(
        controller: stateController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "State",
        hintText: "Enter State",
        errorText: "Enter your State",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
      ),
    );
  }

  getDistrictDetailst(int id, MenueBuilder districMenuBuilder) async {
    await masterBloc!.getDistrictDetails(id: id);

    districMenuBuilder!.setInitialValue([]);
    // talukaBuilder!.setInitialValue([]);
  }

  _getCity() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: DVTextField(
        controller: cityController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "City",
        hintText: "Enter City",
        errorText: "Enter your city",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
      ),
    );
  }

  _getbusinessaddressComponent2() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: DVTextField(
        controller: addressLine2,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Address Line 2",
        textInpuFormatter: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(
              RegExp("[A-Za-z0-9 (),.\/-]"))
        ],
        hintText: "Enter Address Line 2",
        errorText: "Enter your Address Line 2",
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isEmpty,
      ),
    );
  }

  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    BusinessCommonDTO commonDTO =
        BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
    if (commonDTO.status!) {
      if (widget.flag == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VintageProof(flag: widget.flag)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IncorporationDocument()),
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

class BillingModel {
  final int? billId;
  final String? billName;

  BillingModel({this.billId, this.billName});
}
