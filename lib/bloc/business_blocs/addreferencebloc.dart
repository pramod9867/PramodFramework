import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class AddReferenceBloc extends Bloc {
  AppLoadingMultiple? appLoading;
  AddReferenceBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }

  addReferences(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 1),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.addReferencesData())
        .postDioResponse();
  }

  createLoanId(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, 2),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.createLoanApplication())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
