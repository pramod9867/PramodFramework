import 'dart:convert';
import 'dart:math';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/dio_client.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/main.dart';
import 'package:dhanvarsha/model/pinverificationdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/error_handler/error_utility.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDetailsBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  ValueNotifier<NetworkCallConnectionStatus> get connectionStatusLiveData =>
      _connectionStatusLiveData;

  Pinverificationresponse? get pinverificationresponse =>
      _pinverificationresponse;
  Pinverificationresponse? _pinverificationresponse;

  verifyPINNumber(String pincode, BuildContext context) async {
    try {
      print("Pincode is" + pincode);

      String? headerToken =await SharedPreferenceUtils.sharedPreferenceUtils.getMobileNumber();

      connectionStatusLiveData.value = NetworkCallConnectionStatus.inProgress;
      ApiClient apiClient = ApiClient.defaultClient(token: headerToken);
      FormData formData = FormData.fromMap(
          {'json': await EncryptionUtils.getEncryptedText(pincode)});
      final response = await apiClient.dioClient?.post(
        NetworkConstants.networkUrl.getPinCodeNumber(),
        data: formData,
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {

        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);
        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);
        String? myToken = await SharedPreferenceUtils.sharedPreferenceUtils.getToken();
        if(dto.token==myToken){
          _pinverificationresponse =
              Pinverificationresponse.fromJson(jsonDecode(dto.data!));

          connectionStatusLiveData.value =
              NetworkCallConnectionStatus.completedSuccessfully;
        }else{
          DialogUtils.showMyDialog();
          connectionStatusLiveData.value =
              NetworkCallConnectionStatus.completedSuccessfully;
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong")));

        connectionStatusLiveData.value = NetworkCallConnectionStatus.failed;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
      connectionStatusLiveData.value = NetworkCallConnectionStatus.failed;
    }
  }

  VerifyPinNew(String pincode, BuildContext context) async {
    FormData formData = FormData.fromMap(
        {'json': await EncryptionUtils.getEncryptedText(pincode)});
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _pinverificationresponse =
                      Pinverificationresponse.fromJson(jsonDecode(dto.data!)),
                  connectionStatusLiveData.value =
                      NetworkCallConnectionStatus.completedSuccessfully,
                  CustomLoaderBuilder.builder.hideLoader()
                },
            () => {
                  connectionStatusLiveData.value =
                      NetworkCallConnectionStatus.inProgress,
                  CustomLoaderBuilder.builder.showLoader()
                },
            () => {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong"))),
                  connectionStatusLiveData.value =
                      NetworkCallConnectionStatus.failed,
                  CustomLoaderBuilder.builder.hideLoader()
                },
            formData,
            NetworkConstants.networkUrl.getPinCodeNumber())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
