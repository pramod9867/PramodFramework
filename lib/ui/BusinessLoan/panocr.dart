import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/BusinessLoan/AppPanDetails.dart';
import 'package:dhanvarsha/ui/BusinessLoan/priAadhardetails.dart';
import 'package:dhanvarsha/ui/BusinessLoan/residence.dart';
import 'package:dhanvarsha/ui/BusinessLoan/selfie.dart';
import 'package:dhanvarsha/ui/loantype/uploadprofile.dart';
import 'package:dhanvarsha/ui/loantype/widget.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class panocr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => panocrState();
}

class panocrState extends State<panocr> {
  ValueNotifier<int> _textHasErrorNotifier = ValueNotifier(0);
  int newCount = 0;

  @override
  Widget build(BuildContext context) {

    return BaseView(
        title: getTitleName(newCount),
        type: false,
        body: InheritedWrapper(
          initialCount: newCount,
          buttonPressed: (index) {

            setState(() {
              newCount = index;
              print("New Count"+newCount.toString());
            });

          },
          child: SingleChildScrollView(
            child: _getContainer(),
          ),
        ),
        context: context);
  }

  Widget _getContainer() {
    return Column(
      children: [
        Container(
          height: 20,
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 20),
          child: CustomFormProgress(),
        ),
        changeScreen(newCount)
      ],
    );
  }

  String getTitleName(index){
    switch(index){
      case 0:
        return "Pan Details";
      case 1:
        return "Aadhar Card Details";
      case 2:
        return "Pan Details";
      case 3:
        return "Residence";
      case 4:
        return "Add Co-Applicant";
      case 5:
        return "Business Details";
    }
    return "";
  }

  Widget changeScreen(int index) {
    print("Index is----"+index.toString());
    switch (index) {

      case 0:
        return AppPanDetails();
      case 1:
        return priAadhardetails();
      case 2:
        return selfie();
      case 3:
        return residence();
    }
    return AppPanDetails();

  }
}
