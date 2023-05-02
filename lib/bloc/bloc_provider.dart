import 'package:dhanvarsha/customloader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/network/typedef.dart';
import 'package:flutter/cupertino.dart';


abstract class Bloc{
  dispose();
}

class LoginDataBloc extends Bloc{


  ValueNotifier<NetworkConnectionStatus> _liveData= ValueNotifier(NetworkConnectionStatus.onAborted);

  ValueNotifier<NetworkConnectionStatus> get liveData => this._liveData;



  void getDataFromApi(){
    _liveData.value =NetworkConnectionStatus.onCompleted;

    DhanvarshaLoader.loader.show();
  }


  void hideLoader(){
    DhanvarshaLoader.loader.hide();
  }

  @override
  dispose() {
    return null;
  }

 


}