import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';

class BusinessGSTDetailsBloc extends Bloc {
  AppLoadingMultiple? appLoadingMultiple;

  BusinessGSTDetailsBloc(AppLoadingMultiple appLoadingMultiple) {
    this.appLoadingMultiple = appLoadingMultiple;
  }

  addBusinessGSTDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingMultiple!.isSuccessful(dto, 1),
                  appLoadingMultiple!.hideProgress(),
                },
            () => {appLoadingMultiple!.showProgress()},
            () => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError()
                },
            formData,
            NetworkConstants.networkUrl.getBusinessGSTDetails())
        .postDioResponse();
  }

  pushBusinessDetailsToMgenius(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingMultiple!.isSuccessful(dto, 2),
                  appLoadingMultiple!.hideProgress(),
                },
            () => {appLoadingMultiple!.showProgress()},
            () => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError()
                },
            formData,
            NetworkConstants.networkUrl.addBusinessDetailsToServer())
        .postDioResponse();
  }

  getGstDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.isSuccessful(dto, 3),
                  print(jsonEncode(dto.data)),
                },
            () => {
                  CustomLoaderBuilder.builder.showLoaderDiff(),
                  // appLoadingMultiple!.showProgress(),
                },
            () => {
                  CustomLoaderBuilder.builder.hideLoaderDiff(),
                  // appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError()
                },
            formData,
            NetworkConstants.networkUrl.getGstnDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
