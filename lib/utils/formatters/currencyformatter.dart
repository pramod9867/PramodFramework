import 'package:dhanvarsha/utils/constants/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Function mathFunc = (Match match) => '${match[1]},';

class CurrencyInputFormatter extends TextInputFormatter {
  // var formatter = NumberFormat('#,##,000');
  // static const separator = ','; // Change this to '.' for other locales
  // @override
  // TextEditingValue formatEditUpdate(
  //     TextEditingValue oldValue, TextEditingValue newValue) {
  //   // Short-circuit if the new value is empty
  //   if (newValue.text.length == 0) {
  //     return newValue.copyWith(text: '');
  //   }
  //
  //   int selectionIndex = newValue.selection.end;
  //   String result = newValue.text.replaceAllMapped(
  //       new RegExp(RegExPattern.commaSeprated), (Match m) => '${m[1]},');
  //   selectionIndex = result.length;
  //
  //   return TextEditingValue(
  //     text: result,
  //     selection: TextSelection.collapsed(offset: selectionIndex),
  //   );
  //   // Handle "deletion" of separator character
  //   // String oldValueText = oldValue.text.replaceAll(separator, '');
  //   // String newValueText = newValue.text.replaceAll(separator, '');
  //   // if (oldValue.text.endsWith(separator) &&
  //   //     oldValue.text.length == newValue.text.length + 1) {
  //   //   newValueText = newValueText.substring(0, newValueText.length - 1);
  //   // }
  //   // // Only process if the old value and new value are different
  //   // if (oldValueText != newValueText) {
  //   //   int selectionIndex =
  //   //       newValue.text.length - newValue.selection.extentOffset;
  //   //   final chars = newValueText.split('');
  //   //   String newString = '';
  //   //   for (int i = chars.length - 1; i >= 0; i--) {
  //   //     if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1 && i < 4)
  //   //       newString = separator + newString;
  //   //     newString = chars[i] + newString;
  //   //   }
  //   //   return TextEditingValue(
  //   //     text: newString.toString(),
  //   //     selection: TextSelection.collapsed(
  //   //       offset: newString.length - selectionIndex,
  //   //     ),
  //   //   );
  //   // }
  //   // // If the new value and old value are the same, just return as-is
  //   // return newValue;
  // }



  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,##,###");
      final number =
      int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
