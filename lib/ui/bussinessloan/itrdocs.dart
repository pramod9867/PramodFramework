import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/vintagebloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/businessvintageproofdto.dart';
import 'package:dhanvarsha/model/request/itrreturndto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/business_add_ref.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/incorporationdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/repaymentdetails.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
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
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ITRDocument extends StatefulWidget {
  final String flag;

  const ITRDocument({Key? key, this.flag = "proprietor"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ITRDocumentState();
}

class _ITRDocumentState extends State<ITRDocument> implements AppLoading {
  bool? value = false;
  bool isSwitchPressed = false;
  TextEditingController pdfPassword = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  GlobalKey<CustomImageBuilderState> _itrProofImage = GlobalKey();
  GlobalKey<CustomImageBuilderState> _profitLossImage = GlobalKey();

  BLFetchBloc? blFetchBloc;
  VintageProofBloc? vintageBloc;

  @override
  void initState() {
    vintageBloc = VintageProofBloc(this);
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: widget.flag == "" ? const [6, 7] : [7, 8],
        type: false,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
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
                        initialImage: blFetchBloc!
                                .fetchBLResponseDTO.profitAndLossBalanceSheet ??
                            "",
                        no: "",
                        // subtitleImage: DhanvarshaImages.userphoto,
                        subtitleImage: DhanvarshaImages.uploadnew,
                        key: _itrProofImage,
                        image: DhanvarshaImages.poa,
                        value: "Upload ITR Document",
                        subtitleString: "Upload",
                        description: AppConstants.uploadDocumentInstructions,
                        firstImageUploaded: () {
                          // uploadPanToServer();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomImageBuilder(
                        initialImage:
                            blFetchBloc!.fetchBLResponseDTO.iTRDocumentImage ??
                                "",
                        no: "",
                        // subtitleImage: DhanvarshaImages.userphoto,
                        subtitleImage: DhanvarshaImages.uploadnew,
                        key: _profitLossImage,
                        image: DhanvarshaImages.poa,
                        value: "Upload Profit & Loss /\n Balance Sheet",
                        subtitleString: "Upload",
                        description: AppConstants.uploadDocumentInstructions,
                        firstImageUploaded: () {
                          // uploadPanToServer();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomBtnBlackborder(
                    onButtonPressed: () {
                      if (_itrProofImage.currentState!.imagepicked.value ==
                          "") {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please select itr proof documents", context);
                        return;
                      }

                      if (_profitLossImage.currentState!.imagepicked.value ==
                          "") {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please select profit & loss documents", context);
                        return;
                      }

                      uploadITRDocuments();
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

  Widget _getTitleCompoenent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Income Tax Return",
            style: CustomTextStyles.boldLargeFonts,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  uploadITRDocuments() async {
    ITRReturnDocDTO itrReturnDocDTO = ITRReturnDocDTO();

    itrReturnDocDTO.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    itrReturnDocDTO.profitAndLossBalanceSheet =
        _itrProofImage.currentState!.fileName;
    itrReturnDocDTO.iTRDocumentImage = _profitLossImage.currentState!.fileName;

    List<MultipartFile> appFiles = [];

    if (_itrProofImage.currentState!.imagepicked.value != "" &&
        !Uri.parse(_itrProofImage.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(
        MultipartFile.fromFileSync(
            _itrProofImage.currentState!.imagepicked.value,
            filename: _itrProofImage.currentState!.fileName),
      );
    }

    if (_profitLossImage.currentState!.imagepicked.value != "" &&
        !Uri.parse(_profitLossImage.currentState!.imagepicked.value)
            .isAbsolute) {
      appFiles.add(
        MultipartFile.fromFileSync(
            _profitLossImage.currentState!.imagepicked.value,
            filename: _profitLossImage.currentState!.fileName),
      );
    }

    print(_profitLossImage.currentState!.fileName);

    print(_itrProofImage.currentState!.fileName);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await itrReturnDocDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    vintageBloc!.uploadItrReturnDocs(formData);
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
            builder: (context) => BusinessAddRef(
              flag: widget.flag,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessAddRef(
              flag: widget.flag,
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

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Income Tax Return",
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
}
