import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class BusinessPanDetailsBloc extends Bloc {
  AppLoading? appLoading;

  getGstDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.hideProgress(),
                  print("COMPLETE GST DETAILS"),
                  print(jsonEncode(dto.data)),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getGstnDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
