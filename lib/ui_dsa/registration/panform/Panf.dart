import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/formatters/upppercaseformatter.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widget_dsa/datepicker/custom_datepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Panf extends StatefulWidget {
  const Panf({Key? key, required BuildContext context}) : super(key: key);

  @override
  _PanfState createState() => _PanfState();
}

class _PanfState extends State<Panf> {
  TextEditingController panEditingController =
      new TextEditingController(text: BasicData.panres!.PanNumber);
  TextEditingController nameEditingController =
      new TextEditingController(text: BasicData.panres!.FirstName);
  TextEditingController mnameEditingController =
      new TextEditingController(text: BasicData.panres!.MiddleName);
  TextEditingController lnameEditingController =
      new TextEditingController(text: BasicData.panres!.LastName);
  TextEditingController dobEditingController =
      new TextEditingController(text: BasicData.panres!.DateOfBirth);
  TextEditingController bustypeEditingController = new TextEditingController();
  TextEditingController busNameEditingController = new TextEditingController();
  TextEditingController sosEditingController = new TextEditingController();

  var isValidatePressed = false;

  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Select Type", calories: 110),
    FavouriteFoodModel(foodName: "Employed", calories: 110),
    FavouriteFoodModel(foodName: "Self", calories: 110),
    FavouriteFoodModel(foodName: "Business", calories: 110),
  ];
  FavouriteFoodModel _favouriteFoodModel = FavouriteFoodModel();
  late List<DropdownMenuItem<FavouriteFoodModel>>
      _favouriteFoodModelDropdownList;
  List<DropdownMenuItem<FavouriteFoodModel>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList) {
    List<DropdownMenuItem<FavouriteFoodModel>> items = [];
    for (FavouriteFoodModel favouriteFoodModel in favouriteFoodModelList) {
      items.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(
          favouriteFoodModel.foodName!!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  onChangeFavouriteFoodModelDropdown(FavouriteFoodModel? favouriteFoodModel) {
    setState(() {
      _favouriteFoodModel = favouriteFoodModel!;
    });
  }

  @override
  void initState() {
    super.initState();
    _favouriteFoodModelDropdownList =
        _buildFavouriteFoodModelDropdown(_favouriteFoodModelList);
    _favouriteFoodModel = _favouriteFoodModelList[0];
  }

  Future<bool> _onWillPop() async {
    setState(() {
      isValidatePressed = true;
    });

    if (CustomValidator(panEditingController.value.text).validate('isPan') &&
        CustomValidator(nameEditingController.value.text).validate('isEmpty') &&
        CustomValidator(mnameEditingController.value.text)
            .validate('isEmpty') &&
        CustomValidator(lnameEditingController.value.text)
            .validate('isEmpty') &&
        CustomValidator(dobEditingController.value.text).validate('isEmpty')) {
      BasicData.panres!.PanNumber = panEditingController.text;
      BasicData.panres!.FirstName = nameEditingController.text;
      BasicData.panres!.MiddleName = mnameEditingController.text;
      BasicData.panres!.LastName = lnameEditingController.text;
      BasicData.panres!.DateOfBirth = dobEditingController.text;

      Navigator.pop(context);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgNew,
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    MediaQuery.of(context).viewInsets.top -
                    MediaQuery.of(context).viewInsets.bottom-25,
              ),
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.bgNew, AppColors.bgNew],
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isValidatePressed = true;
                                });

                                if (CustomValidator(
                                            panEditingController.value.text)
                                        .validate('isPan') &&
                                    CustomValidator(
                                            nameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            mnameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            lnameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            dobEditingController.value.text)
                                        .validate('isEmpty')) {
                                  BasicData.panres!.PanNumber =
                                      panEditingController.text;
                                  BasicData.panres!.FirstName =
                                      nameEditingController.text;
                                  BasicData.panres!.MiddleName =
                                      mnameEditingController.text;
                                  BasicData.panres!.LastName =
                                      lnameEditingController.text;
                                  BasicData.panres!.DateOfBirth =
                                      dobEditingController.text;

                                  Navigator.pop(context);
                                }
                              },
                              child: Image.asset(
                                DhanvarshaImages.bck,
                                height: 20,
                                width: 20,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth / 3.5,
                            ),
                            Text(
                              '',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm PAN details',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 24 * SizeConfig.textScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DVTextField(
                          controller: panEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          title: "PAN",
                          hintText: "Enter PAN",
                          errorText: "Please Enter Correct PAN Number",
                          maxLine: 1,
                          isValidatePressed: isValidatePressed,
                          type: "isPan",
                          formatters: [
                            UpperCaseTextFormatter(),
                          ],

                          // value: BasicData.panres!.panNumber!,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DVTextField(
                          controller: nameEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          title: "First Name",
                          hintText: "Enter First Name (as on PAN)",
                          errorText: "Please Enter Correct First Name",
                          maxLine: 1,
                          isValidatePressed: isValidatePressed,
                          value: BasicData.panres!.FirstName!,
                          textInpuFormatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z]')),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DVTextField(
                          controller: mnameEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          title: "Middle Name",
                          hintText: "Enter Middle Name (as on PAN)",
                          errorText: "Please Enter Correct Middle Name",
                          maxLine: 1,
                          textInpuFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                          ],
                          isValidatePressed: false,
                          value: BasicData.panres!.MiddleName!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DVTextField(
                          controller: lnameEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          title: "Last Name",
                          hintText: "Enter Last Name (as on PAN)",
                          errorText: "Please Enter Correct Last Name",
                          maxLine: 1,
                          textInpuFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                          ],
                          isValidatePressed: isValidatePressed,
                          value: BasicData.panres!.LastName!,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CustomDatePicker(
                          controller: dobEditingController,
                          isValidateUser: isValidatePressed,
                          selectedDate: dobEditingController.text,
                          title: "Date of Birth",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: CustomButton(
                      onButtonPressed: () {
                        setState(() {
                          isValidatePressed = true;
                        });

                        if (CustomValidator(panEditingController.value.text)
                                .validate('isPan') &&
                            CustomValidator(nameEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(lnameEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(dobEditingController.value.text)
                                .validate('isEmpty')) {
                          BasicData.panres!.PanNumber =
                              panEditingController.text;
                          BasicData.panres!.FirstName =
                              nameEditingController.text;
                          BasicData.panres!.MiddleName =
                              mnameEditingController.text;
                          BasicData.panres!.LastName =
                              lnameEditingController.text;
                          BasicData.panres!.DateOfBirth =
                              dobEditingController.text;

                          print('panres');
                          print(BasicData.panres?.PanNumber);

                          Navigator.pop(context);
                        }
                      },
                      title: "CONFIRM",
                      boxDecoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.buttonRed,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
