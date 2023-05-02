import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class AdditionalDetailsBloc extends Bloc {
  AppLoadingMultiple? appLoading;

  AdditionalDetailsBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }

  addAdditionalDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 0),
                  // appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.addAdditionalDetails())
        .postDioResponse();
  }

  getBLSoftOffer(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 1),
                  // appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getBLOffer())
        .postDioResponse();
  }

  postBLClientInitiate(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 2),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.createBLClientInitiate())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
