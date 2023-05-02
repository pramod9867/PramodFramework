import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class CreateCoapplicantBloc extends Bloc {
  AppLoadingMultiple? appLoading;
  CreateCoapplicantBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }
  addCoapplicantDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 0),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.addCoApplicantDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
