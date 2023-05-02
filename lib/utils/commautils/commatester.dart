import 'package:intl/intl.dart';

class CommaTester {
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static String Function(Match) mathFunc = (Match match) => '${match[1]},';
  static String addCommaToString(String test) {
    // String result = test.replaceAllMapped(reg, mathFunc);

    var indiaFormat = NumberFormat('#,##,000');
    return indiaFormat.format(double.parse(test));

    return test;
  }


  static String addCommaToStringNew(String test) {
    // String result = test.replaceAllMapped(reg, mathFunc);

    if (double.parse(test) > 0) {
      print("Into the indian Format");
      var indiaFormat = NumberFormat('#,##,000');
      return indiaFormat.format(double.parse(test));
    } else {
      return "0";
    }

    return test;
  }
}
