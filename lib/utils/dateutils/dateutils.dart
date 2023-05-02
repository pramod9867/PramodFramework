import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtilsGeneric {
  static String dateMessage = "Please Select Date Of Birth";

  static String convertToMMMdyyyyFormat(DateTime time) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    final String formatted = formatter.format(time);
    print("Formated Date" + formatted);
    return formatted;
  }


  static String converToStandardDate(DateTime time) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(time);
    print("Formated Date" + formatted);
    return formatted;
  }

  static String convertToddMMyyyyFormat(String dateString){
    List<String> splitedDate = dateString.split("/");

    String newDate ="";
    for(int i=splitedDate.length-1;i>=0;i--){
      if(((splitedDate.length-3)==i)){
        newDate+=splitedDate[i];
      }else{
        newDate+=splitedDate[i]+"/";
      }
    }
    return newDate;
  }

  static bool calculateTimeDifference(DateTime dateTime) {
   if(dateTime!=""){
     DateTime dateTimenow = DateTime.now();

     int minute = dateTimenow.difference(dateTime).inMinutes;

     print("In Minutes Time");
     print(minute);
     if (minute.abs()>= 720) {
       return true;
     } else {
       return false;
     }
   }else{
     return true;
   }
  }

 static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
