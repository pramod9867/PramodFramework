import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/businessproofbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/request/businessrequestdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/incorporationdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/itrdocs.dart';
import 'package:dhanvarsha/ui/bussinessloan/residentialproof.dart';
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
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload_bl.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/CustomBtnBlackborder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BusinessProofDocument extends StatefulWidget {
  final String flag;

  const BusinessProofDocument({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessProofDocumentState();
}

class _BusinessProofDocumentState extends State<BusinessProofDocument>
    implements AppLoading {
  bool? value = false;
  bool isSwitchPressed = false;

  BLFetchBloc? blFetchBloc;
  TextEditingController pdfPassword = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  final List<BillingModel> _listOfBills = [
    BillingModel(billId: 0, billName: "Select Document"),
    BillingModel(billId: 1, billName: "GST Certficate"),
    BillingModel(billId: 2, billName: "Udyog/Udyam Aadhar"),
    BillingModel(billId: 3, billName: "Shop Act License"),
    BillingModel(billId: 3, billName: "Electricity Bill"),
  ];

  TextEditingController panTextController = TextEditingController();
  TextEditingController addressTextController =
      TextEditingController(text: CustomerBLOnboarding.completeBLAddress);
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

  GlobalKey<_BusinessProofDocumentState> _scrollViewKey = GlobalKey();
  UploadBusinessProofBloc? uploadBusinessProofBloc;

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
    _billingModelModel = _listOfBills[0];
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    uploadBusinessProofBloc = UploadBusinessProofBloc(this);

    panTextController.text =
        blFetchBloc!.fetchBLResponseDTO.businessProofBusinessPincode ?? "";
    addressTextController.text = CustomerBLOnboarding.completeBLAddress != ""
        ? CustomerBLOnboarding.completeBLAddress!
        : blFetchBloc!.fetchBLResponseDTO.businessProofAddressLine1!;

    // print(blFetchBloc!.fetchBLResponseDTO.businessProofDocumentImage);
  }

  bool isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: widget.flag == "" ? const [4, 7] : const [4, 8],
        type: false,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: Container(
            constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    45 -
                    MediaQuery.of(context).viewInsets.top -
                    MediaQuery.of(context).viewInsets.bottom -
                    20),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      _getTitleCompoenentNEW(),
                      //_getTitleCompoenent(),
                      CustomImageBuilder(
                        initialImage: blFetchBloc!.fetchBLResponseDTO
                                .businessProofDocumentImage ??
                            "",
                        key: _key,
                        value: "Upload Business Proof",
                        isAadhaarVisible: false,
                        image: DhanvarshaImages.poa,
                        dropdown: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // _getPanComponent(),
                              _getbusinessaddressComponent(),
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
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomBtnBlackborder(
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });
                      if (_key.currentState!.imagepicked.value == "") {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please select business documents", context);
                        return;
                      }

                      if (_billingModelModel.billId == 0) {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please select documents type", context);
                        return;
                      }

                      if (CustomValidator(addressTextController.text)
                          .validate(Validation.isEmpty)) {
                        uploadBusinessProof();
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

  _getPanComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: DVTextField(
        textInputType: TextInputType.number,
        controller: panTextController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Business pin code",
        hintText: "Enter business pin code",
        errorText: "Type your business pin code here",
        textInpuFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(6),
        ],
        maxLine: 1,
        isValidatePressed: isValidatePressed,
        type: Validation.isValidPinCode,
      ),
    );
  }

  _getbusinessaddressComponent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: DVTextField(
        controller: addressTextController,
        outTextFieldDecoration: BoxDecorationStyles.outButtonOfBoxGreyCorner,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Business address",
        hintText: "Enter business address",
        errorText: "Type your business address here",
        textInpuFormatter: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9 (),.\/-]"))
        ],
        maxLine: null,
        isValidatePressed: isValidatePressed,
      ),
    );
  }

  addbusinessProof() {}

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Business Address",
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

  uploadBusinessProof() async {
    BusinessProofRequestDTO businessProofRequestDTO = BusinessProofRequestDTO();
    businessProofRequestDTO.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    businessProofRequestDTO.businessProofAddressLine1 =
        addressTextController.text;
    businessProofRequestDTO.businessProofAddressLine2 =
        addressTextController.text;
    businessProofRequestDTO.businessProofBusinessPincode = "000000";
    businessProofRequestDTO.businessProofCity = "";
    businessProofRequestDTO.businessProofState = "";
    businessProofRequestDTO.businessProofCountry = "";
    businessProofRequestDTO.businessProofDocumentName =
        _billingModelModel.billName;
    businessProofRequestDTO.businessProofDocumentImage =
        _key.currentState!.fileName;
    List<MultipartFile> appFiles = [];
    if (_key.currentState!.imagepicked.value != "" &&
        !Uri.parse(_key.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _key.currentState!.imagepicked.value,
          filename: _key.currentState!.fileName));
    }

    String encodedJson = await businessProofRequestDTO.toEncodedJson();
    print(encodedJson);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await businessProofRequestDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    uploadBusinessProofBloc!.addBusinessProofDocuments(formData);
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

class IncorporationModel {
  final int? corpId;
  final String? corpName;

  IncorporationModel({this.corpId, this.corpName});
}
