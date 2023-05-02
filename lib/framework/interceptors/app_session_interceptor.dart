import 'dart:convert';

import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppSessionInterceptor extends Interceptor {
  @override
  dynamic onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // if (response.statusCode == 200 && response.statusCode == 201) {
    //   String? decryptedString =
    //       await EncryptionUtils.decryptString(response?.data);
    //
    //   SuccessfulResponseDTO dto =
    //       SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);
    //
    //   String? token =
    //       await SharedPreferenceUtils.sharedPreferenceUtils.getToken();
    //   if (dto.token != token && dto.token!.toUpperCase() != "VALID") {
    //     print("Navigate to Login Screen");
    //   }
    //
    //   print("Response Is");
    //   print(response.data);
    // }

    super.onResponse(response, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('Token')) {
      if (options.data != null && options.data.fields.length > 0) {
        var uuid = Uuid();
        String? decryptedString =
            await EncryptionUtils.decryptString(options.data.fields[0].value);
        dynamic decodedJson = jsonDecode(decryptedString!);
        decodedJson["RequestId"] = uuid.v4();
        decodedJson['UniqueId'] =
            uuid.v4() + DateTime.now().microsecondsSinceEpoch.toString();
        String? encodedString =
            await EncryptionUtils.getEncryptedText(jsonEncode(decodedJson));
        List<MultipartFile> appFiles = [];
        for (int i = 0; i < options.data.files.length; i++) {
          appFiles.add(options.data.files[i].value);
        }
        options.data = FormData.fromMap({
          'json': encodedString,
          'Myfiles': appFiles,
        });

        // print("Body: ${options.data.files}");
        // print("Body: ${options.data.fields}");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    super.onError(err, handler);
  }
}
