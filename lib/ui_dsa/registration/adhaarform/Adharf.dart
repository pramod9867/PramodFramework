import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widget_dsa/datepicker/custom_datepicker.dart';
import 'package:dhanvarsha/widget_dsa/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Adharf extends StatefulWidget {
  const Adharf({Key? key, required BuildContext context}) : super(key: key);

  @override
  _AdharfState createState() => _AdharfState();
}

class _AdharfState extends State<Adharf> {
  TextEditingController adharNumberEditingController =
      new TextEditingController(text: BasicData.adharres!.AadharNumber);
  TextEditingController nameEditingController =
      new TextEditingController(text: BasicData.adharres!.FirstName);
  TextEditingController mnameEditingController =
      new TextEditingController(text: BasicData.adharres!.MiddleName);
  TextEditingController lnameEditingController =
      new TextEditingController(text: BasicData.adharres!.LastName);
  TextEditingController dobEditingController =
      new TextEditingController(text: BasicData.adharres!.DateOfBirth);
  TextEditingController pinEditingController =
      new TextEditingController(text: BasicData.adharres!.Pincode);
  TextEditingController ad1EditingController =
      new TextEditingController(text: BasicData.adharres!.AddressLine1);
  TextEditingController ad2EditingController =
      new TextEditingController(text: BasicData.adharres!.AddressLine2);
  TextEditingController ad3EditingController =
      new TextEditingController(text: BasicData.adharres!.AddressLine3);

  var isValidatePressed = false;

  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Select Type", calories: 110),
    FavouriteFoodModel(foodName: "Male", calories: 110),
    FavouriteFoodModel(foodName: "Female", calories: 110),
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

    if (BasicData?.adharres?.Gender.toString().toLowerCase() == "male") {
      _favouriteFoodModel = _favouriteFoodModelList[1];
    } else if (BasicData?.adharres?.Gender.toString().toLowerCase() == "female") {
      _favouriteFoodModel = _favouriteFoodModelList[2];
    } else{
      _favouriteFoodModel = _favouriteFoodModelList[0];
    }
  }

  Future<bool> _onWillPop() async {
    setState(() {
      isValidatePressed = true;
    });
    if (CustomValidator(adharNumberEditingController.value.text)
            .validate('isAadhaar') &&
        CustomValidator(nameEditingController.value.text).validate('isEmpty') &&
        CustomValidator(mnameEditingController.value.text)
            .validate('isEmpty') &&
        CustomValidator(lnameEditingController.value.text)
            .validate('isEmpty') &&
        CustomValidator(dobEditingController.value.text).validate('isEmpty') &&
        CustomValidator(pinEditingController.value.text).validate('isEmpty') &&
        CustomValidator(ad1EditingController.value.text).validate('isEmpty') &&
        CustomValidator(ad2EditingController.value.text).validate('isEmpty') &&
        CustomValidator(ad3EditingController.value.text).validate('isEmpty')) {
      BasicData.adharres!.AadharNumber = adharNumberEditingController.text;
      BasicData.adharres!.FirstName = nameEditingController.text;
      BasicData.adharres!.MiddleName = mnameEditingController.text;
      BasicData.adharres!.LastName = lnameEditingController.text;
      BasicData.adharres!.DateOfBirth = dobEditingController.text;
      BasicData.adharres!.Gender = _favouriteFoodModel.foodName;
      BasicData.adharres!.Pincode = pinEditingController.text;
      BasicData.adharres!.AddressLine1 = ad1EditingController.text;
      BasicData.adharres!.AddressLine2 = ad2EditingController.text;
      BasicData.adharres!.AddressLine3 = ad3EditingController.text;

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
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.bgNew, AppColors.bgNew],
              )),
              child: Column(
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
                                        adharNumberEditingController.value.text)
                                    .validate('isAadhaar') &&
                                CustomValidator(
                                        nameEditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(
                                        mnameEditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(
                                        lnameEditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(dobEditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(pinEditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(ad1EditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(ad2EditingController.value.text)
                                    .validate('isEmpty') &&
                                CustomValidator(ad3EditingController.value.text)
                                    .validate('isEmpty')) {
                              BasicData.adharres!.AadharNumber =
                                  adharNumberEditingController.text;
                              BasicData.adharres!.FirstName =
                                  nameEditingController.text;
                              BasicData.adharres!.MiddleName =
                                  mnameEditingController.text;
                              BasicData.adharres!.LastName =
                                  lnameEditingController.text;
                              BasicData.adharres!.DateOfBirth =
                                  dobEditingController.text;
                              BasicData.adharres!.Gender =
                                  _favouriteFoodModel.foodName;
                              BasicData.adharres!.Pincode =
                                  pinEditingController.text;
                              BasicData.adharres!.AddressLine1 =
                                  ad1EditingController.text;
                              BasicData.adharres!.AddressLine2 =
                                  ad2EditingController.text;
                              BasicData.adharres!.AddressLine3 =
                                  ad3EditingController.text;

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
                          'Confirm Aadhaar Details',
                          style: TextStyle(
                            fontFamily: 'Poppins',
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
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: adharNumberEditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "Aadhaar Number",
                      hintText: "Enter Aadhaar Number",
                      errorText: "Please Enter Valid Aadhaar Number",
                      maxLine: 1,
                      isValidatePressed: isValidatePressed,
                      type: 'isAadhaar',
                      textInpuFormatter: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: nameEditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "First Name",
                      hintText: "Enter First Name",
                      errorText: "Please Enter Valid First Name",
                      maxLine: 1,
                      textInpuFormatter: [
                        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                      ],
                      isValidatePressed: isValidatePressed,
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
                      hintText: "Enter Middle Name",
                      errorText: "Please Enter Valid Middle Name",
                      maxLine: 1,
                      textInpuFormatter: [
                        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                      ],
                      isValidatePressed: false,
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
                      hintText: "Enter Last Name",
                      errorText: "Please Enter Valid Last Name",
                      maxLine: 1,
                      textInpuFormatter: [
                        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                      ],
                      isValidatePressed: isValidatePressed,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: CustomDatePicker(
                      controller: dobEditingController,
                      isValidateUser: isValidatePressed,
                      selectedDate: dobEditingController.text,
                      title: "Date Of Birth",
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: CustomDropdown(
                        dropdownMenuItemList: _favouriteFoodModelDropdownList,
                        onChanged: onChangeFavouriteFoodModelDropdown,
                        value: _favouriteFoodModel,
                        isEnabled: true,
                        title: "Gender",
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: pinEditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "PIN",
                      hintText: "Enter PIN",
                      errorText: "Please Enter Valid PIN Number",
                      maxLine: 1,
                      isValidatePressed: isValidatePressed,
                      type: "isPin",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: ad1EditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "Address Line 1",
                      hintText: "Enter Address Line 1",
                      errorText: "Please Enter Valid Address",
                      maxLine: 1,
                      isValidatePressed: isValidatePressed,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: ad2EditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "Adress Line 2",
                      hintText: "Enter Address Line 2",
                      errorText: "Please Enter Valid Address",
                      maxLine: 1,
                      isValidatePressed: isValidatePressed,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: DVTextField(
                      controller: ad3EditingController,
                      outTextFieldDecoration:
                          BoxDecorationStyles.outTextFieldBoxDecoration,
                      inputDecoration:
                          InputDecorationStyles.inputDecorationTextField,
                      title: "Adress Line 3",
                      hintText: "Enter Address Line 3",
                      errorText: "Please Enter Valid Address",
                      maxLine: 1,
                      isValidatePressed: isValidatePressed,
                    ),
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
                        if (_favouriteFoodModel.foodName == 'Select Type') {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content:
                        Text("Please Select Gender")));
                        }
                        else if (CustomValidator(
                                    adharNumberEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(
                                adharNumberEditingController.value.text)
                                .validate('isAadhaar') &&
                            CustomValidator(nameEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(lnameEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(dobEditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(pinEditingController.value.text)
                                .validate('isPin') &&
                            CustomValidator(ad1EditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(ad2EditingController.value.text)
                                .validate('isEmpty') &&
                            CustomValidator(ad3EditingController.value.text)
                                .validate('isEmpty')) {
                          BasicData.adharres!.AadharNumber =
                              adharNumberEditingController.text;
                          BasicData.adharres!.FirstName =
                              nameEditingController.text;
                          BasicData.adharres!.MiddleName =
                              mnameEditingController.text;
                          BasicData.adharres!.LastName =
                              lnameEditingController.text;
                          BasicData.adharres!.DateOfBirth =
                              dobEditingController.text;
                          BasicData.adharres!.Pincode =
                              pinEditingController.text;
                          BasicData.adharres!.AddressLine1 =
                              ad1EditingController.text;
                          BasicData.adharres!.AddressLine2 =
                              ad2EditingController.text;
                          BasicData.adharres!.AddressLine3 =
                              ad3EditingController.text;

                          Navigator.pop(context);
                        }else{
                          print("in else");
                          print(adharNumberEditingController.value.text);
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
