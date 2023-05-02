import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/ui/loantype/pandetails.dart';
import 'package:dhanvarsha/ui/loantype/uploadprofile.dart';
import 'package:dhanvarsha/ui/loantype/widget.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CommonLoanStepBuilder extends StatefulWidget {
  final String mobileNumber;

  const CommonLoanStepBuilder({Key? key, this.mobileNumber="9664503167"}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CommonLoanStepState();
}

class CommonLoanStepState extends State<CommonLoanStepBuilder> {
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
        return "Aadhar Details";
      case 2:
        return "Personal Details";
      case 3:
        return "Employee Details";
    }
    return "";
  }

  Widget changeScreen(int index) {
    print("Index is"+index.toString());
    switch (index) {

      case 0:
        return PanDetails();
      case 1:
        return AadharDetails(mobileNumber: widget.mobileNumber,);
      case 2:
        return UploadProfile();
      case 3:
        return EmployeeDetails();
    }
    return PanDetails();
  }
}
