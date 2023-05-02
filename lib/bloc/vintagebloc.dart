import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class VintageProofBloc extends Bloc {
  AppLoading? appLoading;

  VintageProofBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }

  addVintageProof(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) =>
        {appLoading!.isSuccessful(dto), appLoading!.hideProgress()},
            () => {appLoading!.showProgress()},
            () => {appLoading!.showError(),
            appLoading!.hideProgress(),
            },
        formData,
        NetworkConstants.networkUrl.uploadBusinessDurationDocs())
        .postDioResponse();
  }


  uploadItrReturnDocs(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) =>
        {appLoading!.isSuccessful(dto), appLoading!.hideProgress()},
            () => {appLoading!.showProgress()},
            () => {appLoading!.showError(),
            appLoading!.hideProgress(),
            },
        formData,
        NetworkConstants.networkUrl.uploadIncomeTaxReturnDocs())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
