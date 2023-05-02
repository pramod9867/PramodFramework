import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailslist.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/goldloan/branchoption/NearestBranchResponse.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NearestBranchBloc extends Bloc {
  AppLoadingMultiple? appLoadingMultiple;

  ValueNotifier<List<NearestBrachDetailsResponseDTO>> get nearestBranchList =>
      _nearestBranchList ??
      ValueNotifier<List<NearestBrachDetailsResponseDTO>>([]);

  set nearestBranchList(
      ValueNotifier<List<NearestBrachDetailsResponseDTO>> value) {
    _nearestBranchList = value;
  }

  ValueNotifier<List<NearestBrachDetailsResponseDTO>>? _nearestBranchList =
      ValueNotifier<List<NearestBrachDetailsResponseDTO>>([]);
  NearestBranchBloc(AppLoadingMultiple appLoadingMultiple) {
    this.appLoadingMultiple = appLoadingMultiple;
  }

  getNearestBranchDetails(FormData formData) {
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
            NetworkConstants.networkUrl.getNearestBranchDetails())
        .postDioResponse();
  }

  bookAppointment(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingMultiple!.isSuccessful(dto, 1),
                  appLoadingMultiple!.hideProgress(),
                },
            () => {appLoadingMultiple!.showProgress()},
            () => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError()
                },
            formData,
            NetworkConstants.networkUrl.bookGLAppointment())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
