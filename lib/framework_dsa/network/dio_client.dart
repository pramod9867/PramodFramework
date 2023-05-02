import 'dart:io';

import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio? dioClient;

  ApiClient.defaultClient({BaseOptions? baseOptions,String? token =""}) {
    if (baseOptions == null) {

      //String token =await EncryptionUtils.getEncryptedText("8879809953").toString();


      baseOptions = BaseOptions(
          baseUrl: NetworkConstants.networkUrl.getBaseUrl(),
          connectTimeout: 60000,
          receiveTimeout: 60000,
          headers: {"Platform": "Android",
          "Token": token!.replaceAll("\n","")});
    }
    dioClient = Dio(baseOptions);

    (dioClient?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient? client) {
      //bypass SSL pinning
      client!.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;

      //
      // //setup proxy
      // if (AppStrings.apiEndpoints.proxyURL != null) {
      //   client.findProxy = (uri) {
      //     return "PROXY ${AppStrings.apiEndpoints.proxyURL}";
      //   };
      // }

      return client;
    };

    //log api calls
    dioClient?.interceptors.add(LogInterceptor());
//    dioClient.interceptors.add(CustomeMockHandler());
  }
}
