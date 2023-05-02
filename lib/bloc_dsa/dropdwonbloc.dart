import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/dropdownresponse.dart';
import 'package:dhanvarsha/model_dsa/response/generateotpresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/login/Login.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dhanvarsha/utils_dsa/encryptionutils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
  ValueNotifier(NetworkCallConnectionStatus.statle);
  GenerateOTPRes? otpres;
  DropDownResponse? dd;
  bool isOtp = false;
  String phone = '';
  String otp = '';

  getdropdowndata(BuildContext context) async {
    try {
      CustomLoader.customloaderbuilder.showLoader();
      ApiClient apiClient = ApiClient.defaultClient();
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            {}.toString()),
      });

      /*String token = await EncryptionUtils.getEncryptedText("8879809953").toString();
      print('token');*/
      //print(token.toString());

      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.getdropdown(),
          data: formData,
          /*options: Options(headers: {"Platform": "Android",
            "Token": token})*/
      );

      print(response?.statusCode);
      print(EncryptionUtils.decryptString(response.toString()));
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
        await EncryptionUtils.decryptString(response?.data);

        print('decryptedString $decryptedString');

        SuccessfulResponseDTO dto =
        SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        //otpres = GenerateOTPRes.fromJson(jsonDecode(dto.data!));
        dd = DropDownResponse.fromJson(jsonDecode(dto.data!));
        if (dd?.addressProof?[0].name != null) {

          BasicData.dd = dd;
          //setOTPinfo();
          //getOTPinfo();
          CustomLoader.customloaderbuilder.hideLoader();

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                    context: context,
                  )),
            );

        } else {
          CustomLoader.customloaderbuilder.hideLoader();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong")));
        }
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();

      print('in catch');
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  dispose() {
    return null;
  }
}
