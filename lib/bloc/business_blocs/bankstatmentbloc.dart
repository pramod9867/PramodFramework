import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dio/dio.dart';

class BankStatementBloc extends Bloc{
  AppLoading? appLoading;

  BankStatementBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }
  addBankStatements(FormData formData) {
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
        NetworkConstants.networkUrl.addBankStatements())
        .postDioResponse();
  }

  @override
  dispose() {
   return null;
  }

}