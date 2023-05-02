import 'package:flutter/material.dart';

class ErrorUtility{
  static BuildContext? buildContext;





  static getCatchBlock(){
    showDialog(context: buildContext!, builder: (_) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content:Container(
            child: Text("Hello world"),
          )
      );
  });
  }
}