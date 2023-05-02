import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IndianFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // // TODO: implement formatEditUpdate
    // var format = NumberFormat.simpleCurrency(locale: 'ko');
    //
    //
    // String newString = format.format(newValue.text);
    // print(newString);


    return newValue;
  }

}