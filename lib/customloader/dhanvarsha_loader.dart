import 'package:flutter/cupertino.dart';

class DhanvarshaLoader{
  static DhanvarshaLoader loader = DhanvarshaLoader();

  ValueNotifier<bool> isLoaderShowing = ValueNotifier(false);


  show(){
    isLoaderShowing.value= true;
  }

  hide(){
    isLoaderShowing.value=false;
  }


}