import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FAQScreen();
}

class _FAQScreen extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "FAQ",
        type: false,
        body: new ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, i) {
            return Theme(
                data: Theme.of(context).copyWith(
                    accentColor: AppColors.buttonRed,
                    focusColor: AppColors.black),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.all(0),
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide.none)),
                    child: new Text(
                      vehicles[i].title,
                      style: CustomTextStyles.boldMediumFont,
                    ),
                  ),
                  children: <Widget>[
                    new Column(
                      children: _buildExpandableContent(vehicles[i]),
                    ),
                  ],
                ));
          },
        ),
        context: context);
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: CustomTextStyles.regularSmallGreyFont,
          ),
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];

  Vehicle(this.title, this.contents);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'When Can I Option For Personal Loan',
    [
      'Personal Loans can be used for variety of reasons. A Personal Loans can be use for wedding,education, travel , medical or any other events'
    ],
  ),
  new Vehicle(
    'What are the mandotary documents required?',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  ),
  new Vehicle(
    'What are the mandotary documents required?',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  ),
  new Vehicle(
    'Do i need to provide any security or collatral or gurantors?',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  ),
  new Vehicle(
    'What are the mandotary documents required?',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  ),
  new Vehicle(
    'What is maximum and minimum loan amounts',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  ),
  new Vehicle(
    'What are tenture option for personal loan',
    ['PAN, Aadhaar Card, Any Educational Documents'],
  )
];
