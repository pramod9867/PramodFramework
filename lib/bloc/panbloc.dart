import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/dio_client.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/model/response/facerecognitionresponse.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/loantype/pancompletedetails.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanDetailsBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusOfPanDetails =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  ValueNotifier<NetworkCallConnectionStatus> get connectionStatusOfPanDetails =>
      _connectionStatusOfPanDetails;

  PanResponseDTO? panResponseDTO;
  FaceRegonizeResponseDTO? faceRegonizeResponseDTO;

  set connectionStatusOfPanDetails(
      ValueNotifier<NetworkCallConnectionStatus> value) {
    _connectionStatusOfPanDetails = value;
  }

  getPanDetails(String panstring, String imagePath, String filename,
      BuildContext context) async {
    try {
      print("Image Path is" + imagePath);
      print("Image Pan String is" + panstring);
      CustomLoaderBuilder.builder.showLoader();

      String? headerToken =
          await SharedPreferenceUtils.sharedPreferenceUtils.getMobileNumber();

      ApiClient apiClient = ApiClient.defaultClient(token: headerToken);
      print(apiClient.dioClient!.options);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(panstring),
        "Myfiles":
            await MultipartFile.fromFileSync(imagePath, filename: filename),
      });
      final response = await apiClient.dioClient?.post(
        NetworkConstants.networkUrl.getOcrUrl(),
        data: formData,
      );
      print(apiClient.dioClient?.options);
      print(response?.statusCode);
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);

        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        String? myToken =
            await SharedPreferenceUtils.sharedPreferenceUtils.getToken();

        if (myToken == dto.token) {
          panResponseDTO = PanResponseDTO.fromJson(jsonDecode(dto.data!));
          print("Response OF PAN");
          print(jsonEncode(panResponseDTO));
          if (panResponseDTO?.panNumber != null &&
              panResponseDTO?.panNumber != "") {
            _connectionStatusOfPanDetails.notifyListeners();
            CustomLoaderBuilder.builder.hideLoader();
          } else {
            _connectionStatusOfPanDetails.notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("OCR failed to detect user details")));
            CustomLoaderBuilder.builder.hideLoader();
          }
        } else {
          DialogUtils.showMyDialog();
          CustomLoaderBuilder.builder.hideLoader();
        }
      } else {
        _connectionStatusOfPanDetails.notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
      CustomLoaderBuilder.builder.hideLoader();
      _connectionStatusOfPanDetails.notifyListeners();
    }
  }

  getFaceDetails(FormData formData) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  faceRegonizeResponseDTO =
                      FaceRegonizeResponseDTO.fromJson(jsonDecode(dto.data!)),
                  CustomLoaderBuilder.builder.hideLoader()
                },
            () => {CustomLoaderBuilder.builder.showLoader()},
            () => {CustomLoaderBuilder.builder.hideLoader()},
            formData,
            NetworkConstants.networkUrl.getFaceRecognition())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
