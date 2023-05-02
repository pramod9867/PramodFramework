import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class BusinessAadhaarBloc extends Bloc {
  AppLoading? appLoading;
  AppLoadingMultiple? appLoadingMultiple;

  BusinessAadhaarBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }

  BusinessAadhaarBloc.appLoadingMultiple(AppLoadingMultiple appLoadingMultiple){
    this.appLoadingMultiple = appLoadingMultiple;
  }

  addBusinessPanDetails(FormData formData) {
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
            NetworkConstants.networkUrl.addBusinessPanDetails())
        .postDioResponse();
  }

  addPLPanDetails(FormData formData) {
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
            NetworkConstants.networkUrl.addPLPanDetails())
        .postDioResponse();
  }

  addBusinessAadhaarDetials(FormData formData) {
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
            NetworkConstants.networkUrl.addBusinessAadhaarDetails())
        .postDioResponse();
  }



  addBusinessAadhaarDetialsMultiple(FormData formData,{int index=3}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
          appLoadingMultiple!.isSuccessful(dto,index),
              appLoadingMultiple!.hideProgress(),
        },
            () => {appLoadingMultiple!.showProgress()},
            () => {
              appLoadingMultiple!.hideProgress(),
              appLoadingMultiple!.showError(),
        },
        formData,
        NetworkConstants.networkUrl.addBusinessAadhaarDetails())
        .postDioResponse();
  }
  @override
  dispose() {
    return null;
  }
}
