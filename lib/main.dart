// @dart=2.9
///DHANVARSHA ORIGINAL PROJECT V1.0 !!
/// DropOut Flow Started Final Issues !!
/// Dhanvarsha Final Project With DROP OUT AND CONTINUE
/// 
/// 
/// new changes done on 27-2-2022
import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/customerdetails/customerdetails.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/loanreward/bankstatement.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/ui/loantype/selectloantype.dart';
import 'package:dhanvarsha/ui/registration/login/Login.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/ui/registration_new/splash.dart';
import 'package:dhanvarsha/utils/error_handler/error_utility.dart';
import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarwindow.dart';
import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarwindowbuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  closeDrawer() {}
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigationService.navigatorKey,
      routes: {
        '/dashboard': (context) => DVDashboard(context: context),
        '/loanFlow': (context) => const SelectLoanType(),
        '/offerFlow': (context) => BankStatement(),
        '/login': (context) => LoginNewScreen()
      },
      theme: new ThemeData(
        appBarTheme: new AppBarTheme(elevation: 0, color: Colors.transparent),
      ),
      home: SplashScreen(),
    );
  }
}
