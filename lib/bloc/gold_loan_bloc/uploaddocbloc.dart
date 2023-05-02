import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class UploadGoldDocBloc extends Bloc{

  AppLoadingMultiple? appLoadingMultiple;

  UploadGoldDocBloc(AppLoadingMultiple appLoadingMultiple){
    this.appLoadingMultiple= appLoadingMultiple;
  }

  uploadAddressProof(FormData formData){
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
          appLoadingMultiple!.isSuccessful(dto, 0),
          appLoadingMultiple!.hideProgress(),
        },
            () => {appLoadingMultiple!.showProgress()},
            () => {
          appLoadingMultiple!.hideProgress(),
          appLoadingMultiple!.showError()
        },
        formData,
        NetworkConstants.networkUrl.uploadAddressProof())
        .postDioResponse();
  }
  uploadBusinessProof(FormData formData){
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
          appLoadingMultiple!.isSuccessful(dto, 0),
          appLoadingMultiple!.hideProgress(),
        },
            () => {appLoadingMultiple!.showProgress()},
            () => {
          appLoadingMultiple!.hideProgress(),
          appLoadingMultiple!.showError()
        },
        formData,
        NetworkConstants.networkUrl.uploadAddressProofGL())
        .postDioResponse();
  }
  @override
  dispose() {
    return null;
  }

}