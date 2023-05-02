import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/incorporationbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/dropdown/billing_model.dart';
import 'package:dhanvarsha/model/request/incorporationdto.dart';
import 'package:dhanvarsha/model/response/pansuccessfulresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/numberverification.dart';
import 'package:dhanvarsha/ui/bussinessloan/repaymentdetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/vintageproof.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
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
import 'package:flutter_switch/flutter_switch.dart';

class IncorporationDocument extends StatefulWidget {
  final String flag;

  const IncorporationDocument({Key? key, this.flag = ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IncorporationDocumentState();
}

class _IncorporationDocumentState extends State<IncorporationDocument>
    implements AppLoading {
  bool? value = false;
  bool isSwitchPressed = false;
  TextEditingController pdfPassword = TextEditingController();

  BLFetchBloc? blFetchBloc;

  final List<IncorporationModel> _listOfCorpDoc = [
    IncorporationModel(corpId: 0, corpName: "Select Document"),
    IncorporationModel(corpId: 1, corpName: "Electricity Bill"),
    IncorporationModel(corpId: 2, corpName: "Ration Card"),
    IncorporationModel(corpId: 3, corpName: "Water Bill"),
  ];

  IncorporationBloc? incorporationBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();

    incorporationBloc = IncorporationBloc(this);
  }

  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        stepArray: const [5, 8],
        isBackDialogRequired: true,
        type: false,
        body: SingleChildScrollView(
          child: Container(
            height:
                SizeConfig.screenHeight - SizeConfig.verticalviewinsects - 70,
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
                      SizedBox(
                        height: 15,
                      ),
                      CustomImageBuilder(
                        initialImage: blFetchBloc!.fetchBLResponseDTO
                                .incorporationDocumentImage ??
                            "",
                        no: "",
                        subtitleImage: DhanvarshaImages.uploadnew,
                        key: _key,
                        image: DhanvarshaImages.poa,
                        value: "Incorporation Document",
                        isAadhaarVisible: true,
                        subtitleString: "Upload",
                        description: AppConstants.aadharUploadDescription,
                        firstImageUploaded: () {
                          // uploadPanToServer();
                        },
                      ),
                      // MultipleFileUploader(
                      //   title: "Incorporation Document",
                      //   descr: "Mandatory For KYC Verification",
                      //   imageaddText: "Document Added",
                      //   isPasswordProtected: false,
                      //   isDropdownShow: true,
                      //   dropdown: Container(
                      //     margin: EdgeInsets.symmetric(
                      //         vertical: 10, horizontal: 20),
                      //     child: CustomDropdown(
                      //       dropdownMenuItemList:
                      //           __billingModelModelDropdownList,
                      //       onChanged: onChangeFavouriteFoodModelDropdown,
                      //       value: _corpModel,
                      //       isEnabled: true,
                      //       title: "Document",
                      //       isTitleVisible: true,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomBtnBlackborder(
                    onButtonPressed: () {
                      if (_key.currentState!.imagepicked.value != "") {
                        UploadIncorporationToServer();
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
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Firm Registration",
              style: CustomTextStyles.boldLargeFonts,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  UploadIncorporationToServer() async {
    IncorporationDTO incorporationDTO = IncorporationDTO();
    incorporationDTO.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    incorporationDTO.incorporationDocumentImage = _key.currentState!.fileName;
    incorporationDTO.incorporationDocumentName = "";

    List<MultipartFile> appFiles = [];
    if (_key.currentState!.imagepicked.value != "" &&
        !Uri.parse(_key.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _key.currentState!.imagepicked.value,
          filename: _key.currentState!.fileName));
    }

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          await incorporationDTO.toEncodedJson()),
      "MyFiles": appFiles
    });

    incorporationBloc!.addIncorporationDocuments(formData);

    // incorporationDTO.incorporationDocumentName=
    // incorporationDTO.refBlId
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    PanSuccessfulResponseDTO panSuccessfulResponseDTO =
        PanSuccessfulResponseDTO.fromJson(jsonDecode(dto.data!));

    if (panSuccessfulResponseDTO.status!) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VintageProof(flag: "non")),
      );
      SuccessfulResponse.showScaffoldMessage(
          panSuccessfulResponseDTO.message!, context);
    } else {
      SuccessfulResponse.showScaffoldMessage(
          AppConstants.errorMessage, context);
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
