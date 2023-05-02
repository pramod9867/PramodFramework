import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class PostalCodeBloc extends Bloc {
  AppLoadingMultiple? appLoading;

  PostalCodeBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }

  getPostalCodeDetails(FormData formData, {int index = 0}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, index),
                  appLoading!.hideProgress()
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.showError(), appLoading!.hideProgress()},
            formData,
            NetworkConstants.networkUrl.getPostalCodeDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
