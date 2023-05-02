import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class UploadImageBloc extends Bloc {
  AppLoading? appLoading;
  AppLoadingMultiple? appLoadingMultiple;

  UploadImageBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }

  UploadImageBloc.appLoadingMultiple(AppLoadingMultiple appLoadingMultiple) {
    this.appLoadingMultiple = appLoadingMultiple;
  }

  uploadKycImages(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {
                  appLoading!.hideProgress(),
                  appLoading!.showError(),
                },
            formData,
            NetworkConstants.networkUrl.addBusinessBasicDocuments())
        .postDioResponse();
  }

  uploadKycImagesMultiple(FormData formData, {index = 0}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingMultiple!.isSuccessful(dto, index),
                  appLoadingMultiple!.hideProgress(),
                },
            () => {appLoadingMultiple!.showProgress()},
            () => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError(),
                },
            formData,
            NetworkConstants.networkUrl.addBusinessBasicDocuments())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
