import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dio/dio.dart';

class OfferBloc extends Bloc {
  AppLoadingMultiple? appLoading;

  OfferBloc(AppLoadingMultiple appLoading) {
    this.appLoading = appLoading;
  }

  offerAccepted(FormData formData, {int type = 0}) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto, type),
                  appLoading!.hideProgress(),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {
                  appLoading!.showError(),
                  appLoading!.hideProgress(),
                },
            formData,
            NetworkConstants.networkUrl.getApprovalUrl())
        .postDioResponse();
  }

  offerAcceptedStatusBL(FormData formData, {int type = 0}) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful(dto,type),
                  appLoading!.hideProgress(),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {
                  appLoading!.showError(),
                  appLoading!.hideProgress(),
                },
            formData,
            NetworkConstants.networkUrl.offerAcceptedStatusBL())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
