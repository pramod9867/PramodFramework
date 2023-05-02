import 'package:flutter/material.dart';


class FlutterWindowBuilder extends ChangeNotifier{
  static FlutterWindowBuilder windowBuilder= FlutterWindowBuilder();

  List<Widget> windows =[];

  addWindow(Widget window){
    windows.add(window);
    notifyListeners();
  }


  removeWindow(Widget window){
    windows.remove(windows);
    notifyListeners();
  }

}