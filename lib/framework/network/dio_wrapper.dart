import 'dart:convert';

import 'package:dhanvarsha/constants/sharedprefkeys.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/dio_client.dart';
import 'package:dhanvarsha/framework/network/request_canceler.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/model/token_model.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

typedef OnSuccessful = Function(SuccessfulResponseDTO responseDTO);
typedef OnProgressed = Function();
typedef OnError = Function();

class DioDhanvarshaWrapper {
  final OnSuccessful onSuccessful;
  final OnProgressed onProgressed;
  final OnError onError;
  final FormData formData;
  final String urlBasic;

  DioDhanvarshaWrapper(this.onSuccessful, this.onProgressed, this.onError,
      this.formData, this.urlBasic);

  postDioResponse() async {
    try {
      onProgressed();

      String mobileNumber =
          await SharedPreferenceUtils.sharedPreferenceUtils.getMobileNumber();

      ApiClient apiClient = ApiClient.defaultClient(token: mobileNumber);

      // apiClient.dioClient!.interceptors.add();
      // print("Cancel Token Is");

      final response = await apiClient.dioClient?.post(
        urlBasic,
        data: formData,
        cancelToken: await RequestCanceler.canceler.token,
      );

      print("Response is");
      print(response);
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        print("Encrypted Response");
        print(response!.data);
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);

        // print("Decrypted");
        // print(decryptedString);

        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        String? token =
            await SharedPreferenceUtils.sharedPreferenceUtils.getToken();
        print("token is");

        if (dto.token == token) {
          print("In Successful");
          print("TOKEN IS");
          print(dto.token);
          onSuccessful(dto);
        } else if (dto.token!.toUpperCase() == "VALID") {
          print("In Valid");
          print("TOKEN IS");
          print(dto.token);
          onSuccessful(dto);
        } else {
          CustomLoaderBuilder.builder.hideLoader();

            DialogUtils.showMyDialog();


        }
      } else {
        onError();
      }
    } catch (e) {
      if (e is DioError) {
        if(e.type==DioErrorType.cancel){

        }else{
          onError();
        }
        //handle DioError here by error type or by error code
        // if(e.type)

      } else {
        onError();
      }
    }
  }

  getDioResponse() async {
    try {
      onProgressed();

      String? data =
          await SharedPreferenceUtils.sharedPreferenceUtils.getMobileNumber();

      // print("MOBILE NUMBER IS MOBILE NUMBER");
      //
      // print(data);

      ApiClient apiClient = ApiClient.defaultClient(token: data);
      print("Response is");
      final response = await apiClient.dioClient?.get(
        urlBasic,
        cancelToken: await RequestCanceler.canceler.token,
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);
        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        if (dto.token ==
            SharedPreferenceUtils.sharedPreferenceUtils.getToken()) {
          print("In Successful");
          print("TOKEN IS");
          print(dto.token);
          onSuccessful(dto);
        } else if (dto.token!.toUpperCase() == "VALID") {
          print("In Valid");
          print("TOKEN IS");
          print(dto.token);
          onSuccessful(dto);
        } else {
          CustomLoaderBuilder.builder.hideLoader();

          DialogUtils.showMyDialog();
          // NavigationService.navigationService.navigateTo('\login');
        }
      } else {
        onError();
      }
    } catch (e) {
      if (e is DioError) {
        if(e.type==DioErrorType.cancel){

        }else{
          onError();
        }
      } else {
        onError();
      }
    }
  }
}
