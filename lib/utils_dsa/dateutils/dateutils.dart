import 'package:intl/intl.dart';

class DateUtilsGeneric{

  static String dateMessage ="Please Select Date Of Birth";

  static String convertToMMMdyyyyFormat(DateTime time){

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(time);
    print("Formated Date"+formatted);
    return formatted;
  }


}