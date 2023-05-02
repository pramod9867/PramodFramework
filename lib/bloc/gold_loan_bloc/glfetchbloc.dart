import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/response/fetchglresponsedto.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';
import 'package:dio/dio.dart';

class GLFetchBloc extends Bloc {
  FetchGLResponseDTO? fetchGLResponseDTO;
  AppLoadingMultiple? appLoadingMultiple;

  NearestBrachDetailsResponseDTO get selectedBranch => _selectedBranch!;
  NearestBrachDetailsResponseDTO? _selectedBranch;

  AppLoadingGeneric? appLoadingGeneric;
  GLFetchBloc(AppLoadingMultiple appLoadingMultiple) {
    this.appLoadingMultiple = appLoadingMultiple;
  }

  GLFetchBloc.init(){

  }

  set selectedBranch(NearestBrachDetailsResponseDTO value) {
    _selectedBranch = value;
  }

  GLFetchBloc.appLoadingGeneric(AppLoadingGeneric appLoadingGeneric){
    this.appLoadingGeneric = appLoadingGeneric;
  }

  fethcGLDetails(FormData formData) {}

  @override
  dispose() {
    return null;
  }
}
