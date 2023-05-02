
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/fetchblrequestdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class BLFetchBloc extends Bloc{
  AppLoading? appLoading;
  FetchBLResponseDTO? _fetchBLResponseDTO;
  BLFetchBloc(AppLoading appLoading){
    this.appLoading = appLoading;
  }


  fetchBLDetails(FormData formData){
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) =>
        {appLoading!.isSuccessful(dto), appLoading!.hideProgress()},
            () => {appLoading!.showProgress()},
            () => {appLoading!.showError(),
            appLoading!.hideProgress()
            },
        formData,
        NetworkConstants.networkUrl.fetchBLDetails())
        .postDioResponse();

  }


  FetchBLResponseDTO get fetchBLResponseDTO => _fetchBLResponseDTO!;

  set fetchBLResponseDTO(FetchBLResponseDTO value) {
    _fetchBLResponseDTO = value;
  }

  @override
  dispose() {
    return null;
  }

}