import 'package:dhanvarsha/utils_dsa/constants/constants/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Function mathFunc = (Match match) => '${match[1]},';
class CurrencyInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    int selectionIndex = newValue.selection.end;
    String result = newValue.text.replaceAllMapped(new RegExp(RegExPattern.commaSeprated), (Match m) => '${m[1]},');

    selectionIndex = result.length;


    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
