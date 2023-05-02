import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/generateotpresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/otp/OTP.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dhanvarsha/utils_dsa/encryptionutils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class OTPServiceBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(NetworkCallConnectionStatus.statle);
  GenerateOTPRes? otpres;
  bool isOtp = false;
  String phone = '';
  String otp = '';
  String token = '';
  Uuid uuid = new Uuid();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getOtp(String phoneNumber, BuildContext context,
      {bool isNavigate = true}) async {
    try {
      String reqid = uuid.v4();
      String uniqid = uuid.v4()+DateTime.now().microsecondsSinceEpoch.toString();

      print("req id");
      print(reqid);
      print("uniqid id");
      print(uniqid);
      CustomLoader.customloaderbuilder.showLoader();
      ApiClient apiClient = ApiClient.defaultClient();

      print("without encryption");
      print({
        "MobileNumber": phoneNumber,
        "RequestId": reqid,
        "UniqueId": uniqid
      }.toString());

      print("encryption");
      String? encryptedData = await EncryptionUtils.getEncryptedText(jsonEncode({
        "MobileNumber": phoneNumber,
        "RequestId": reqid,
        "UniqueId": uniqid
      }));

      print("encrypted data");
      print(encryptedData);
      print("dencrypted data");
      String? dec = await EncryptionUtils.decryptString(encryptedData!);
      print(dec);

      FormData formData = FormData.fromMap({
        'json': encryptedData,
      });
      print("foelds");
      print(formData.fields);

      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.getOtp(),
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

        otpres = GenerateOTPRes.fromJson(jsonDecode(dto.data!));
        if (otpres?.isSuccess ?? false) {
          otp = otpres!.otp!;
          BasicData.otp = otp;
          BasicData.phone = phoneNumber;
          print('phone');
          print(BasicData.phone);
          String? token =
              await EncryptionUtils.getEncryptedText(BasicData.phone);
          print("token in otp");
          print(token);
          BasicData.token = token!;

          //setOTPinfo();
          //getOTPinfo();
          CustomLoader.customloaderbuilder.hideLoader();

          if (isNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTP(
                        context: context,
                      )),
            );
          } else {}
          ;
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

  Future<void> setOTPinfo() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('phone', phone);
    await prefs.setString('otp', otp);
    await prefs.setString('token', token);
  }

  getOTPinfo() async {
    final SharedPreferences prefs = await _prefs;
    String? phone = prefs.getString('phone');
    String? otp = prefs.getString('otp');
    String? token = prefs.getString('token');
    print('from shared pred phone $phone');
    print('from shared pred otp $otp');
  }

  @override
  dispose() {
    return null;
  }
}
