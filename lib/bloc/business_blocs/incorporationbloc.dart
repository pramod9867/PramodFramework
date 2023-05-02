
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class IncorporationBloc extends Bloc{

  AppLoading? appLoading;


  IncorporationBloc(AppLoading appLoading){
    this.appLoading =appLoading;
  }

  addIncorporationDocuments(FormData formData){
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) =>
        {appLoading!.isSuccessful(dto), appLoading!.hideProgress()},
            () => {appLoading!.showProgress()},
            () => {appLoading!.showError(),
          appLoading!.hideProgress()
        },
        formData,
        NetworkConstants.networkUrl.addIncorporationDocs())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }

}