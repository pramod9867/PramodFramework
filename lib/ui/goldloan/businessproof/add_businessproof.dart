import 'dart:convert';

import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/uploaddocbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/businessproofglrequest.dart';
import 'package:dhanvarsha/model/request/uploadaddressproofrequestdto.dart';
import 'package:dhanvarsha/model/response/golddetailrepsonse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBusinessProof extends StatefulWidget {
  final String date;
  final String time;

  const AddBusinessProof({Key? key, this.date="", this.time=""}) : super(key: key);
  @override
  _AddBusinessProofPrState createState() => _AddBusinessProofPrState();
}

class _AddBusinessProofPrState extends State<AddBusinessProof>
    implements AppLoadingMultiple {
  var isValidatePressed = false;
  MenueBuilder? countryBuilder, districtBuilder, talukaBuilder, stateBuilder;
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  late List<DropdownMenuItem<BillingModel>> __billingModelModelDropdownList;
  BillingModel _billingModelModel = BillingModel();
  final List<BillingModel> _listOfBills = [
    BillingModel(billId: 0, billName: "Aadhaar"),
    BillingModel(billId: 1, billName: "Utility Bill"),
    BillingModel(billId: 2, billName: "Voter ID Card"),
    BillingModel(billId: 3, billName: "Passport"),
    BillingModel(billId: 4, billName: "Driving License"),
  ];
  TextEditingController panTextController = TextEditingController();
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

  late MasterBloc? masterBloc;
  GLFetchBloc? glFetchBloc;
  UploadGoldDocBloc? uploadGoldDocBloc;
  @override
  void initState() {
    super.initState();
    __billingModelModelDropdownList =
        _buildFavouriteFoodModelDropdown(_listOfBills);
    _billingModelModel = _listOfBills[0];
    uploadGoldDocBloc = UploadGoldDocBloc(this);
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    glFetchBloc = BlocProvider.getBloc<GLFetchBloc>();
    districtBuilder = MenueBuilder();
    stateBuilder = MenueBuilder();
    districtBuilder!.setInitialValue([]);
    stateBuilder!.setInitialValue([]);
  }

  onChangeFavouriteFoodModelDropdown(BillingModel? billingModel) {
    setState(() {
      _billingModelModel = billingModel!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: SingleChildScrollView(
        child: _getNewBLBody(),
      ),
      context: context,
      isheaderShown: true,
      isBackPressed: true,
      type: false,
      isBurgerVisble: true,
    );
  }

  Widget _getNewBLBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gold Loan",
            style: CustomTextStyles.regularMediumGreyFontGotham,
          ),
          Text(
            "Business Proof",
            style: CustomTextStyles.boldVeryLargerFont2Gotham,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "Kindly upload the following\ndocuments",
              style: CustomTextStyles.regularMediumGreyFontGotham,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: CustomImageBuilder(
              initialImage: "",
              key: _key,
              value: "Upload Business Proof",
              isAadhaarVisible: false,
              image: DhanvarshaImages.poa,
              dropdown: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getPanComponent(),
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
                      dropdownMenuItemList: __billingModelModelDropdownList,
                      onChanged: onChangeFavouriteFoodModelDropdown,
                      value: _billingModelModel,
                      isEnabled: true,
                      title: "Document",
                      isTitleVisible: true,
                    )),
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
                              // await getTalukaDetails(id);
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onButtonPressed: () {
                  if (_key.currentState!.imagepicked.value != "" &&
                      _billingModelModel.billId != 0 &&
                      stateBuilder!.menuNotifier.value.length > 0 &&
                      districtBuilder!.menuNotifier.value.length > 0) {
                    uploadAddressProof();
                  } else {
                    if (_key.currentState!.imagepicked.value == "") {
                      SuccessfulResponse.showScaffoldMessage(
                          "Please upload document", context);
                      return;
                    }

                    if (_billingModelModel.billId == 0) {
                      SuccessfulResponse.showScaffoldMessage(
                          "Please upload document type", context);
                      return;
                    }
                  }
                  /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        //builder: (context) => CommonScreen(),
                        //builder: (context) => KycDocuments(),
                        builder: (context) => BranchOptionPage(),
                      ));*/
                },
                title: "CONTINUE",
                boxDecoration: ButtonStyles.redButtonWithCircularBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController addressTextController = TextEditingController(text: "");
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
          // FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9 (),.\/-]"))
        ],
        maxLine: null,
        isValidatePressed: isValidatePressed,
      ),
    );
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

  getDistrictDetailst(int id, MenueBuilder districMenuBuilder) async {
    await masterBloc!.getDistrictDetails(id: id);

    districMenuBuilder!.setInitialValue([]);
    // talukaBuilder!.setInitialValue([]);
  }

  getTalukaDetails(int id) async {
    await masterBloc!.getTalukaDetails(id: id);
    // talukaBuilder!.setInitialValue([]);
  }

  uploadAddressProof() async {
    BusinessProofGLRequestDTO businessProofGLRequestDTO =
        BusinessProofGLRequestDTO();

    businessProofGLRequestDTO.refGLId =
        glFetchBloc!.fetchGLResponseDTO!.refGLId;
    businessProofGLRequestDTO.allFormFlag = "N";
    businessProofGLRequestDTO.documentType = _billingModelModel.billName;
    businessProofGLRequestDTO.documentNames = [_key.currentState!.fileName];
    businessProofGLRequestDTO.addressLine1 = addressTextController.text;
    businessProofGLRequestDTO.businessPincode = panTextController.text;
    businessProofGLRequestDTO.businessPin = panTextController.text;
    businessProofGLRequestDTO.addressLine2 = "";
    businessProofGLRequestDTO.state = stateBuilder!.menuNotifier.value.elementAt(0).name;
    businessProofGLRequestDTO.city = districtBuilder!.menuNotifier.value.elementAt(0).name;

    List<MultipartFile> appFiles = [];
    if (_key.currentState!.imagepicked.value != "" &&
        !Uri.parse(_key.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _key.currentState!.imagepicked.value,
          filename: _key.currentState!.fileName));
    }

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          businessProofGLRequestDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    print(businessProofGLRequestDTO.toEncodedJson());
    uploadGoldDocBloc!.uploadBusinessProof(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
    // TODO: implement hideProgress
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    if (type == 0) {
      GoldDetailsResponse goldDetailsResponse =
          GoldDetailsResponse.fromJson(jsonDecode(dto.data!));

      print("Successful Response ------------>");
      print(jsonEncode(dto.data!));

      if (goldDetailsResponse.status!) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentSumm(
              branchAddress: glFetchBloc!.selectedBranch.addressLine1,
              branchName: glFetchBloc!.selectedBranch.branchName,
              day: glFetchBloc!.fetchGLResponseDTO!.appointmentDate!=""?glFetchBloc!.fetchGLResponseDTO!.appointmentDate:widget.date,
              time:  glFetchBloc!.fetchGLResponseDTO!.appointmentTime!=""?glFetchBloc!.fetchGLResponseDTO!.appointmentTime:widget.time,
              isDocumentUploaded: false,
            ),
          ),
        );
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

class BillingModel {
  final int? billId;
  final String? billName;

  BillingModel({this.billId, this.billName});
}
