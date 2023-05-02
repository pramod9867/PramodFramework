import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dio/dio.dart';

class DsaLoginBloc extends Bloc {
  AppLoading? appLoading;

  DsaLoginBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }

  loginDsa(FormData formData,{bool isSuccesfulCalled=true}) {
    DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {
      if(isSuccesfulCalled){
        appLoading!.isSuccessful(dto);
      }
      appLoading!.hideProgress();
    }, () {
      appLoading!.showProgress();
    }, () {
      appLoading!.hideProgress();
      appLoading!.showError();
    }, formData, NetworkConstants.networkUrl.loginDsa())
        .postDioResponse();
  }



  verifyOTP(FormData formData) {
    DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {
      appLoading!.isSuccessful(dto);
      appLoading!.hideProgress();
    }, () {
      appLoading!.showProgress();
    }, () {
      appLoading!.hideProgress();
      appLoading!.showError();
    }, formData, NetworkConstants.networkUrl.verifyDsaOtp())
        .postDioResponse();
  }


  @override
  dispose() {
    return null;
  }
}
