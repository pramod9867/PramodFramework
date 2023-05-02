import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/dvtextfield.dart';
import 'package:flutter/material.dart';

class GetHelp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GetHelp();
}

class _GetHelp extends State<GetHelp> {
  var isValidatePressed = false;
  TextEditingController queryEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        title: "Get Help",
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DVTextField(
                  controller: nameEditingController,
                  outTextFieldDecoration:
                      BoxDecorationStyles.outTextFieldBoxDecoration,
                  inputDecoration:
                      InputDecorationStyles.inputDecorationTextField,
                  title: "Query",
                  hintText: "Please Enter Query",
                  errorText: "Type Your Query Here",
                  maxLine: 1,
                  isValidatePressed: isValidatePressed,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DVTextField(
                  controller: queryEditingController,
                  outTextFieldDecoration:
                      BoxDecorationStyles.outTextFieldBoxDecoration,
                  inputDecoration:
                      InputDecorationStyles.inputDecorationTextField,
                  title: "Query",
                  hintText: "Please Enter Query",
                  errorText: "Type Your Query Here",
                  maxLine: 5,
                  isValidatePressed: isValidatePressed,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: CustomButton(
                  onButtonPressed: () {
                    setState(() {
                      isValidatePressed = true;
                    });
                    if (CustomValidator(queryEditingController.value.text)
                            .validate("isEmpty") &&
                        CustomValidator(nameEditingController.value.text)
                            .validate("isEmpty")) {}
                  },
                  title: "Raise Request",
                  widthScale: 0.9,
                ),
              )
            ],
          ),
        ),
        context: context);
  }
}
