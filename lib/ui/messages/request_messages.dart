
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfulResponse{
  static showScaffoldMessage(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
  }

}