import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/generateotpresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
  ValueNotifier(NetworkCallConnectionStatus.statle);
  GenerateOTPRes? otpres;
  bool isOtp = false;
  String phone = '';
  String otp = '';

  getpayment( BuildContext context) async {
    try {
      CustomLoader.customloaderbuilder.showLoader();
      ApiClient apiClient = ApiClient.defaultClient(token : BasicData.token);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            {"DsaId": 'gI0X0Bt8L7Ywg0vFNXWxrA=='}.toString()),
      });
      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.payment(),
          data: formData,
          options: Options(headers: {"Platform": "Android"}));

      print(response?.statusCode);
      print(EncryptionUtils.decryptString(response.toString()));
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
        await EncryptionUtils.decryptString(response?.data);

        print('decryptedString $decryptedString');

        SuccessfulResponseDTO dto =
        SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }




  @override
  dispose() {
    return null;
  }
}
