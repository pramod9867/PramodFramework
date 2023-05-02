import 'dart:io';
import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/ui/registration_new/splash.dart';
import 'package:dhanvarsha/ui_dsa/registration/splaash/Splash.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// var data = {
//   "Status": "true",
//   "Message": "",
//   "Response":
//   "{\"SlotsAvailable\":[{\"AppointmentDate\":\"08-01-2021\",\"availableSlots\":[]},{\"AppointmentDate\":\"09-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]},{\"AppointmentDate\":\"11-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]},{\"AppointmentDate\":\"12-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]},{\"AppointmentDate\":\"13-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]},{\"AppointmentDate\":\"14-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]},{\"AppointmentDate\":\"15-01-2021\",\"availableSlots\":[{\"Id\":\"1\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"09:00 AM\",\"EndTime\":\"11:00 AM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"2\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"11:00 AM\",\"EndTime\":\"01:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"3\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"01:00 PM\",\"EndTime\":\"03:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"4\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"03:00 PM\",\"EndTime\":\"05:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false},{\"Id\":\"5\",\"NoOfAppointment\":\"0\",\"NoOfAssignedTeam\":\"0\",\"TotalTeams\":\"2\",\"StartTime\":\"05:00 PM\",\"EndTime\":\"07:00 PM\",\"IsTeamAvailable\":\"Available\",\"isTimePassed\":false}]}],\"Token\":\"1234\"}",
//   "Token": "1234"
// };

class CommonScreen extends StatefulWidget {
  const CommonScreen({Key? key}) : super(key: key);

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> implements AppLoading {
  GlobalKey<_CommonScreenState> _scrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        key: _scrollViewKey,
        isheaderShown: false,
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  DhanvarshaImages.dhanSetu,
                  height: 40,
                  width: 150,
                  fit: BoxFit.fill,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        DhanvarshaImages.grpfinal,
                        height: 250,
                        width: 250,
                      ),
                    ),
                    Image.asset(
                      DhanvarshaImages.shakehands,
                      height: 125,
                      width: 125,
                    ),
                  ],
                ),
                Text(
                  "Become our Partner !",
                  style: CustomTextStyles.boldLargeFontsGotham,
                ),
                Column(
                  children: [
                    CustomButton(
                      onButtonPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Spalsh(context: context),
                            ));
                        BasicData.clearData();
                        // SuccessfulResponse.showScaffoldMessage("Coming Soon !", context);
                      },
                      title: "REGISTER NOW",
                      widthScale: 0.85,
                    ),
                    CustomButton(
                      onButtonPressed: () async {
                        // isAdult("16/12/2000");

                        String data = await SharedPreferenceUtils
                            .sharedPreferenceUtils
                            .getLoginData();


                        print("Data is");

                        print(data);

                        if (data != "") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DVDashboard(context: context),
                              ),
                              (Route<dynamic> route) => false);
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginNewScreen(),
                              ),
                              (Route<dynamic> route) => false);
                        }
                      },
                      title: "EXISTING PARTNER LOGIN",
                      widthScale: 0.85,
                    ),
                  ],
                ),
                Divider(),
                Text(
                  "Want a quick and easy loan?",
                  style: CustomTextStyles.regularMediumFontGotham,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("https://dhanvarsha.co/");
                  },
                  child: Text(
                    "VISIT OUR WEBSITE",
                    style: CustomTextStyles.boldMediumRedFontGotham,
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  _launchURL(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      var staticurl = url;
      if (await canLaunch(staticurl)) {
        await launch(staticurl);
      } else {
        //SuccessfulResponse.showScaffoldMessage("Couldn't launch apk", context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Couldn't launch apk")));
        throw 'Could not launch $staticurl';
      }
    }
  }

  bool isAdult(String birthDateString) {
    String datePattern = "dd/MM/yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    print(yearDiff > 21 || yearDiff == 21 && monthDiff >= 0 && dayDiff >= 0);
    return yearDiff > 21 || yearDiff == 21 && monthDiff >= 0 && dayDiff >= 0;
  }

  @override
  void hideProgress() {}

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {}

  @override
  void showError() {}

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
