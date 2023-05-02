import 'dart:convert';

import 'package:dhanvarsha/bloc/clientverify.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/customerdetails/customerdetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanCommonDetails extends StatefulWidget {
  const PanCommonDetails({Key? key}) : super(key: key);

  @override
  _PanCommonDetailsState createState() => _PanCommonDetailsState();
}

class _PanCommonDetailsState extends State<PanCommonDetails>
    implements AppLoadingMultiple {
  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  late ClientVerifyBloc clientVerifyBloc;
  @override
  void initState() {
    clientVerifyBloc = ClientVerifyBloc(this);
    BlocProvider.setBloc<ClientVerifyBloc>(clientVerifyBloc,
        identifier: "PANCOMMON");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        isBackDialogRequired: false,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _getTitleCompoenentNEW(),
                  _getHoirzontalImageUpload(),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomButton(
                    onButtonPressed: () {
                      if (_panPickey.currentState!.imagepicked.value != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerDetails(
                              context: context,
                              panFileName: _panPickey.currentState!.fileName,
                              panFilePath:
                                  _panPickey.currentState!.imagepicked.value,
                            ),
                          ),
                        );
                      } else {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please upload pan card", context);
                      }
                    },
                    title: "SUBMIT",
                  ))
            ],
          ),
        ),
        context: context);
  }

  Widget _getTitleCompoenentNEW() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "Customers Pan details",
              style: CustomTextStyles.MediumBoldLightFont,
            ),
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
    );
  }

  Future<bool> _onWillPop() async {
    DialogUtils.existfromapplications(context);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CustomImageBuilder(
              isAadhaarORPan: false,
              isPan: true,
              initialImage: "",
              key: _panPickey,
              image: DhanvarshaImages.npan,
              value: "Upload Customer's PAN",
              description: AppConstants.aadharUploadDescription,
              no: (clientVerifyBloc?.panResponseDTO?.panNumber != null &&
                      clientVerifyBloc?.panResponseDTO?.panNumber != "")
                  ? "PAN :- ${clientVerifyBloc?.panResponseDTO?.panNumber}"
                  : "",
              firstImageUploaded: () {
                uploadPanToServer();
                // if (_profilePickey.currentState!.imagepicked.value != "" &&
                //     _panPickey.currentState!.imagepicked.value != "" &&
                //     !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                //         .isAbsolute &&
                //     !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                //         .isAbsolute) {
                //   faceMatch();
              }),
        ],
      ),
    );
  }

  uploadPanToServer() async {
    PanUpload panUpload = PanUpload(
        fileName: _panPickey.currentState!.fileName, id: 0, type: "Common");
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(jsonEncode(panUpload)),
      "Myfiles": await MultipartFile.fromFileSync(
          _panPickey.currentState!.imagepicked.value,
          filename: _panPickey.currentState!.fileName),
    });

    clientVerifyBloc.getPanOcrDetails(formData);
    // panDetailsBloc!.getPanDetails(
    //     jsonEncode(panUpload!.toJson()),
    //     _panPickey.currentState!.imagepicked!.value!,
    //     _panPickey.currentState!.fileName,
    //     context);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
    // TODO: implement hideProgress
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    PanResponseDTO panResponseDTO =
        PanResponseDTO.fromJson(jsonDecode(dto.data!));

    if (panResponseDTO.panNumber != "") {
      SuccessfulResponse.showScaffoldMessage(
          "OCR Details Successfully Fetched", context);
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
    // TODO: implement showError
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
