import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class BusinessDetailsBloc extends Bloc {
  AppLoading? appLoading;

  BusinessDetailsBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }
  addBusinessDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto),
                  appLoading!.hideProgress(),
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(),
              appLoading!.showError()

            },
            formData,
            NetworkConstants.networkUrl.addBusinessBasicDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
