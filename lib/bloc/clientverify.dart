import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/response/clientresponsedto.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/networkurl.dart';
import 'package:dio/dio.dart';

class ClientVerifyBloc extends Bloc {
  AppLoadingMultiple? appLoading;
  AppLoading? appLoadingSingle;
  ClientVerifyResponseDTO? verifyResponseDTO;

  PanResponseDTO? panResponseDTO;

  ClientVerifyBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }

  ClientVerifyBloc.appLoading(AppLoading appLoadingSingle) {
    this.appLoadingSingle = appLoadingSingle;
  }

  verifyClient(FormData formData, {isSuccessful = true}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  if (isSuccessful)
                    {
                      appLoading!.isSuccessful(dto, 0),
                    },
                  verifyResponseDTO =
                      ClientVerifyResponseDTO.fromJson(jsonDecode(dto.data!)),
                  appLoading!.hideProgress(),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.clientVerify())
        .postDioResponse();
  }

  verifyClientSingle(FormData formData, {isSuccessful = true}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  if (isSuccessful)
                    {
                      appLoadingSingle!.isSuccessful(dto),
                    },
                  verifyResponseDTO =
                      ClientVerifyResponseDTO.fromJson(jsonDecode(dto.data!)),
                  appLoadingSingle!.hideProgress(),
                },
            () => {
                  appLoadingSingle!.showProgress(),
                },
            () => {
                  appLoadingSingle!.hideProgress(),
                  appLoadingSingle!.showError()
                },
            formData,
            NetworkConstants.networkUrl.clientVerify())
        .postDioResponse();
  }

  getPanOcrDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 1),
                  panResponseDTO =
                      PanResponseDTO.fromJson(jsonDecode(dto.data!)),
                  appLoading!.hideProgress(),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getOcrUrl())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
