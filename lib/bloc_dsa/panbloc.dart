import 'dart:convert';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/panresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/panform/Panf.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dhanvarsha/utils_dsa/encryptionutils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PanDetailsBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusOfPanDetails =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  ValueNotifier<NetworkCallConnectionStatus> get connectionStatusOfPanDetails =>
      _connectionStatusOfPanDetails;

  PanResponseDTO? panres;

  getPanDetails(String panstring, String imagePath, String filename,
      BuildContext context) async {
    try {
      print("Image Path is" + imagePath);
      filename = imagePath.split('/').last;
      print("Image Pan String is" + panstring);
      print("Image Pan filename String is" + filename);
      _connectionStatusOfPanDetails.value =
          NetworkCallConnectionStatus.inProgress;
      CustomLoader.customloaderbuilder.showLoader();
      Uuid uuid = new Uuid();
      String reqid = uuid.v4();
      String uniqid = uuid.v4()+DateTime.now().microsecondsSinceEpoch.toString();
      ApiClient apiClient = ApiClient.defaultClient(token : BasicData.token);
      print(apiClient.dioClient!.options);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            jsonEncode({"FileName": filename,
              "Id": BasicData.id,
              "Type": "DSA",
              "RequestId": reqid,
              "UniqueId": uniqid
            })),
        "Myfiles":
            await MultipartFile.fromFileSync(imagePath, filename: filename),

        // "Myfiles":[
        //   await MultipartFile.fromFileSync(imagePath, filename: filename),
        //   await MultipartFile.fromFileSync(imagePath, filename: filename),
        //
        // ]
      });
      final response = await apiClient.dioClient?.post(
        NetworkConstants.networkUrl.getOcrUrl(),
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

        panres = PanResponseDTO.fromJson(jsonDecode(dto.data!));
        print('pan number' + panres!.PanNumber!);
        if (panres?.PanNumber != null) {
          BasicData.panres = panres;
          BasicData.panImagepath = imagePath;
          CustomLoader.customloaderbuilder.hideLoader();


          return true;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Panf(
          //             context: context,
          //           )),
          // );
        } else {
          CustomLoader.customloaderbuilder.hideLoader();
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
