import 'dart:io';

import 'package:dhanvarsha/framework/interceptors/app_session_interceptor.dart';
import 'package:dhanvarsha/framework/network/appinterceptor.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/networkurl.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio? dioClient;


  ApiClient.defaultClient({BaseOptions? baseOptions,String? token}) {
    if (baseOptions == null) {
      baseOptions = BaseOptions(
          baseUrl: NetworkConstants.networkUrl.getBaseUrl(),
          connectTimeout: 120000,
          receiveTimeout: 120000,
          headers: {
            "platform": "Android",
            "Content-Type": "application/json;charset=UTF-8",
            "Charset": "utf-8",
            "Token":token!.replaceAll("\n","")
          });
    }


    dioClient = Dio(baseOptions);




    dioClient!.interceptors.add(LogInterceptor());




    ///please do not remove this line
    dioClient!.interceptors.add(AppSessionInterceptor());




    (dioClient?.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (HttpClient? client) {




      client!.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;

      // //setup proxy
      // if (AppStrings.apiEndpoints.proxyURL != null) {
      //   client.findProxy = (uri) {
      //     return "PROXY ${AppStrings.apiEndpoints.proxyURL}";
      //   };
      // }

      //
      // client.findProxy = (uri) {
      //   return "PROXY 192.168.0.233:8888";
      // };
      return client;
    };



  }
}
