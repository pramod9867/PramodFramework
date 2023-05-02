import 'dart:convert';

import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/uploaddocbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/uploadaddressproofrequestdto.dart';
import 'package:dhanvarsha/model/response/golddetailrepsonse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddPr extends StatefulWidget {
  final String? date;
  final String? time;
  const AddPr({Key? key, this.date = "0", this.time = "0"}) : super(key: key);
  @override
  _AddPrState createState() => _AddPrState();
}

class _AddPrState extends State<AddPr> implements AppLoadingMultiple {
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

  GLFetchBloc? glFetchBloc;
  UploadGoldDocBloc? uploadGoldDocBloc;
  @override
  void initState() {
    super.initState();
    __billingModelModelDropdownList =
        _buildFavouriteFoodModelDropdown(_listOfBills);
    _billingModelModel = _listOfBills[0];
    uploadGoldDocBloc = UploadGoldDocBloc(this);
    glFetchBloc = BlocProvider.getBloc<GLFetchBloc>();
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
            "Address Proof",
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
              value: "Address Proof",
              isAadhaarVisible: false,
              image: DhanvarshaImages.poa,
              dropdown: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: CustomDropdown(
                      dropdownMenuItemList: __billingModelModelDropdownList,
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
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onButtonPressed: () {
                  if (_key.currentState!.imagepicked.value != "" &&
                      _billingModelModel.billId != 0) {
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

  uploadAddressProof() async {
    UploadAddressProofRequestDTO uploadAddressProofRequestDTO =
        UploadAddressProofRequestDTO();

    uploadAddressProofRequestDTO.refGLId =
        glFetchBloc!.fetchGLResponseDTO!.refGLId;
    uploadAddressProofRequestDTO.allFormFlag = "N";
    uploadAddressProofRequestDTO.documentType = _billingModelModel.billName;
    uploadAddressProofRequestDTO.documentNames = [_key.currentState!.fileName];
    List<MultipartFile> appFiles = [];
    if (_key.currentState!.imagepicked.value != "" &&
        !Uri.parse(_key.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _key.currentState!.imagepicked.value,
          filename: _key.currentState!.fileName));
    }

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          uploadAddressProofRequestDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    print(uploadAddressProofRequestDTO.toEncodedJson());
    uploadGoldDocBloc!.uploadAddressProof(formData);
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

      print("Emp Type ------------->");
      print(glFetchBloc!.fetchGLResponseDTO!.employmentType!);

      if (goldDetailsResponse.status!) {
        if (CustomerOnBoarding.ModeOfSalary.toUpperCase() == "SALARIED") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentSumm(
                branchAddress: glFetchBloc!.selectedBranch.addressLine1,
                branchName: glFetchBloc!.selectedBranch.branchName,
                day: glFetchBloc!.fetchGLResponseDTO!.appointmentDate != ""
                    ? glFetchBloc!.fetchGLResponseDTO!.appointmentDate
                    : widget.date,
                time: glFetchBloc!.fetchGLResponseDTO!.appointmentTime != ""
                    ? glFetchBloc!.fetchGLResponseDTO!.appointmentTime
                    : widget.time,
                isDocumentUploaded: false,
              ),
            ),
          );
        } else {
          Navigator.pop(context, true);
        }
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
