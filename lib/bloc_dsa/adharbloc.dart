import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/adharresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AdharBlock extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusOfPanDetails =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  ValueNotifier<NetworkCallConnectionStatus> get connectionStatusOfPanDetails =>
      _connectionStatusOfPanDetails;

  AdharResponse? ahdarres;

  getAdharDetails(String panstring, String fimagePath, String bimagePath,
      BuildContext context) async {
    try {
      print("fimagePath Path is" + fimagePath);
      print("bimagePath Path is" + bimagePath);
      var ffilename = fimagePath.split('/').last;
      var bfilename = bimagePath.split('/').last;
      print("Image Pan String is" + panstring);
      print("Image ffilename filename String is" + ffilename);
      print("Image bfilename filename String is" + bfilename);
      _connectionStatusOfPanDetails.value =
          NetworkCallConnectionStatus.inProgress;
      CustomLoader.customloaderbuilder.showLoader();
      Uuid uuid = new Uuid();
      String reqid = uuid.v4();
      String uniqid = uuid.v4()+DateTime.now().microsecondsSinceEpoch.toString();
      ApiClient apiClient = ApiClient.defaultClient(token : BasicData.token);
      print(apiClient.dioClient!.options);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(jsonEncode({
          "FileNames": [ffilename, bfilename],
          "Id": BasicData.id,
          "Type": "DSA",
          "RequestId": reqid,
          "UniqueId": uniqid
        })),
        // "Myfiles":
        // await MultipartFile.fromFileSync(imagePath, filename: filename),
        "Myfiles": [
          await MultipartFile.fromFileSync(fimagePath, filename: ffilename),
          await MultipartFile.fromFileSync(bimagePath, filename: bfilename),
        ]
      });
      final response = await apiClient.dioClient?.post(
        NetworkConstants.networkUrl.getAdharOcrUrl(),
        data: formData,
      );
      print(apiClient.dioClient?.options);
      print(response?.statusCode);
      print(EncryptionUtils.decryptString(response.toString()));

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);

        print('decryptedString $decryptedString');

        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        ahdarres = AdharResponse.fromJson(jsonDecode(dto.data!));
        print('ahdarres number' + ahdarres!.AadharNumber!);
        if (ahdarres?.AadharNumber != null) {
          BasicData.adharres = ahdarres;
          BasicData.adharfrontImagepath = fimagePath;
          BasicData.adharbackImagepath = bimagePath;
          CustomLoader.customloaderbuilder.hideLoader();

          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Adharf(
                      context: context,
                    )),
          );*/
          return true;
          _connectionStatusOfPanDetails.notifyListeners();
        } else {
          CustomLoader.customloaderbuilder.hideLoader();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong")));
          return false;
        }
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));

      return false;
    }
  }

  @override
  dispose() {
    return null;
  }
}
