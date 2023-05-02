import 'package:flutter/material.dart';

class InputDecorationStyles{
  static InputDecoration inputDecorationTextField =InputDecoration(
    isDense: true,// this will remove the default content padding
    hintText: "Please Enter Query",
    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
    border: InputBorder.none,
  );


}