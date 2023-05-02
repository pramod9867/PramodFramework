import 'package:dhanvarsha/bloc_dsa/PartialFormBloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/model_dsa/response/dropdownresponse.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils_dsa/formatters/currencyformatter.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/BDtextfield.dart';
import 'package:dhanvarsha/widget_dsa/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicDetails extends StatefulWidget {
  const BasicDetails({Key? key, required BuildContext context})
      : super(key: key);

  @override
  _BasicDetailsState createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  /*TextEditingController nameEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.firstName ?? '');*/
  TextEditingController nameEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.firstName ?? '');

  TextEditingController mnameEditingController = new TextEditingController(
      text:
          BasicData.otpres?.distributorDetails?.distributor?.middleName ?? '');
  TextEditingController lnameEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.lastName ?? '');
  TextEditingController monthlyincomeEditingController =
      new TextEditingController(
          text: BasicData
                  .otpres?.distributorDetails?.distributor?.monthlyIncome ??
              '');
  TextEditingController bustypeEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.businessType ??
          '');
  TextEditingController busNameEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.businessName ??
          '');
  TextEditingController sosEditingController = new TextEditingController(
      text:
          BasicData.otpres?.distributorDetails?.distributor?.sizeOfShop ?? '');

  var isValidatePressed = false;

  var nameflag = 0;

  @override
  void dispose() {
    nameEditingController.dispose();
    nameEditingController.removeListener(() {
      if (nameEditingController.text != '') {
        setState(() {
          buttoncolor = AppColors.buttonRed;
          buttontextcolor = Colors.white;
        });
      } else {
        setState(() {
          buttoncolor = Colors.grey.shade300;
          buttontextcolor = Colors.grey.shade600;
        });
      }
    });
  }

  PartialFormBloc p1 = new PartialFormBloc();

  BussinessType bussinessType = new BussinessType();
  late List<DropdownMenuItem<BussinessType>> _BussinessTypeModelDropdownList;

  bool flag = false;

  Color btnyColor = AppColors.lighterGrey;
  Color btnnColor = AppColors.lighterGrey;

  Color buttoncolor = AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;

  List<DropdownMenuItem<BussinessType>> _buildBussinessTypeModelDropdown(
      List BussinessTypeModelList) {
    List<DropdownMenuItem<BussinessType>> items = [];
    for (BussinessType businesstypeModel in BussinessTypeModelList) {
      items.add(DropdownMenuItem(
        value: businesstypeModel,
        child: Text(
          businesstypeModel.name!!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  onChangeFavouriteFoodModelDropdown(BussinessType? bType) {
    setState(() {
      bussinessType = bType!;
    });
  }

  @override
  void initState() {
    super.initState();

    if (BasicData.dd!.bussinessType![0].name != 'Select Business Type') {
      BussinessType b1 =
          new BussinessType(name: 'Select Business Type', value: 1001);
      BasicData.dd!.bussinessType!.insert(0, b1);
      print('1st value');
      print(BasicData.dd!.bussinessType![0].name);
      print('2nd value');
      print(BasicData.dd!.bussinessType![1].name);
    } else {
      print('in Else');
      print('1st value');
      print(BasicData.dd!.bussinessType![0].name);
      print('2nd value');
      print(BasicData.dd!.bussinessType![1].name);
    }

    print('bussiness type');
    print(BasicData.otpres?.distributorDetails?.distributor?.businessType);
    _BussinessTypeModelDropdownList =
        _buildBussinessTypeModelDropdown(BasicData.dd!.bussinessType!);

    bussinessType = BasicData.dd!.bussinessType![0];

    for (int i = 0; i < BasicData.dd!.bussinessType!.length; i++) {
      if (BasicData.otpres?.distributorDetails?.distributor?.businessType!
              .replaceAll(' ', '') ==
          BasicData.dd!.bussinessType![i].name!.replaceAll(' ', '')) {
        bussinessType = BasicData.dd!.bussinessType![i];
        print(BasicData.dd!.bussinessType![i].name);
        print('in if');
      }
    }

    if (BasicData.otpres?.distributorDetails?.distributor?.firstName != '') {
      setState(() {
        buttoncolor = AppColors.buttonRed;
        buttontextcolor = Colors.white;
      });
    }

    if (BasicData.otpres?.distributorDetails?.distributor?.businessName != '') {
      setState(() {
        flag = true;
      });
    }

    nameEditingController.addListener(() {
      if (nameEditingController.text != '') {
        setState(() {
          buttoncolor = AppColors.buttonRed;
          buttontextcolor = Colors.white;
          nameflag = 1;
        });
      } else {
        setState(() {
          buttoncolor = AppColors.buttonRedWithOpacity;
          buttontextcolor = AppColors.white;
        });
      }
    });
  }

  GlobalKey<_BasicDetailsState> _scrollViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        stepArray: [1, 5],
        type: false,
        body: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.bgNew,
            key: _scrollViewKey,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: SizeConfig.screenHeight -
                          MediaQuery.of(context).viewInsets.top -
                          MediaQuery.of(context).viewInsets.bottom -
                          45 -
                          20,
                    ),
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.bgNew, AppColors.bgNew],
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              /*Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
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
                      ),*/
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Personal Details',
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize:
                                            24 * SizeConfig.textScaleFactor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Enter your details to help us '
                                      'verify your application',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Gotham',
                                        fontSize:
                                            15 * SizeConfig.textScaleFactor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: BDtextfield(
                          controller: nameEditingController,
                          outTextFieldDecoration:
                              BoxDecorationStyles.outTextFieldBoxDecoration,
                          inputDecoration:
                              InputDecorationStyles.inputDecorationTextField,
                          textInpuFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                          ],
                          title: "First Name",
                          hintText: "Enter First Name (as on PAN)",
                          errorText: "Please Enter First Name",
                          maxLine: 1,
                          isValidatePressed: isValidatePressed,
                        ),
                      ),*/
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: BDtextfield(
                                  controller: nameEditingController,
                                  outTextFieldDecoration: BoxDecorationStyles
                                      .outTextFieldBoxDecoration,
                                  inputDecoration: InputDecorationStyles
                                      .inputDecorationTextField,
                                  title: "First Name",
                                  hintText: "Enter First Name (as on PAN)",
                                  errorText: "Please Enter First Name",
                                  maxLine: 1,
                                  textInpuFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-z A-Z]')),
                                  ],
                                  isValidatePressed: isValidatePressed,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: BDtextfield(
                                  controller: mnameEditingController,
                                  outTextFieldDecoration: BoxDecorationStyles
                                      .outTextFieldBoxDecoration,
                                  inputDecoration: InputDecorationStyles
                                      .inputDecorationTextField,
                                  title: "Middle Name",
                                  hintText: "Enter Middle Name (Optional)",
                                  errorText: "Please Enter Middle Name",
                                  maxLine: 1,
                                  textInpuFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-z A-Z]')),
                                  ],
                                  isValidatePressed: false,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: BDtextfield(
                                  controller: lnameEditingController,
                                  outTextFieldDecoration: BoxDecorationStyles
                                      .outTextFieldBoxDecoration,
                                  inputDecoration: InputDecorationStyles
                                      .inputDecorationTextField,
                                  title: "Last Name",
                                  hintText: "Enter Last Name (as on PAN)",
                                  errorText: "Please Enter Last Name",
                                  maxLine: 1,
                                  textInpuFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-z A-Z]')),
                                  ],
                                  isValidatePressed: isValidatePressed,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: BDtextfield(
                                  controller: monthlyincomeEditingController,
                                  outTextFieldDecoration: BoxDecorationStyles
                                      .outTextFieldBoxDecoration,
                                  inputDecoration: InputDecorationStyles
                                      .inputDecorationTextField,
                                  title: "Monthly Income",
                                  isRsIconVisible: true,
                                  keyboardtype: TextInputType.number,
                                  textInpuFormatter: [CurrencyInputFormatter()],
                                  hintText: "  Enter Monthly Income",
                                  errorText: "Please Enter monthly income",
                                  maxLine: 1,
                                  isValidatePressed: isValidatePressed,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text(
                                        'Is your business registered?',
                                        style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontSize:
                                              12 * SizeConfig.textScaleFactor,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                flag = true;
                                                btnyColor = AppColors.buttonRed;
                                                btnnColor =
                                                    AppColors.lighterGrey;
                                              });

                                              if (nameEditingController.text !=
                                                  "") {
                                                setState(() {
                                                  buttoncolor =
                                                      AppColors.buttonRed;
                                                  buttontextcolor =
                                                      Colors.white;
                                                  nameflag = 1;
                                                });
                                              } else {
                                                setState(() {
                                                  buttoncolor =
                                                      Colors.grey.shade300;
                                                  buttontextcolor =
                                                      Colors.grey.shade600;
                                                  nameflag = 0;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: SizeConfig.screenHeight *
                                                  0.060,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: btnyColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                child: Text(
                                                  'YES',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'GothamMedium'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                flag = false;
                                                btnyColor =
                                                    AppColors.lighterGrey;
                                                btnnColor = AppColors.buttonRed;
                                              });

                                              if (nameEditingController.text !=
                                                  "") {
                                                setState(() {
                                                  btnnColor =
                                                      AppColors.buttonRed;
                                                  buttontextcolor =
                                                      Colors.white;
                                                  nameflag = 1;
                                                });
                                              } else {
                                                setState(() {
                                                  buttoncolor =
                                                      Colors.grey.shade300;
                                                  buttontextcolor =
                                                      Colors.grey.shade600;
                                                  nameflag = 0;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: SizeConfig.screenHeight *
                                                  0.060,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: btnnColor),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                  child: Text(
                                                'NO',
                                                style: TextStyle(
                                                    fontFamily: 'GothamMedium'),
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              //   child: BDtextfield(
                              //     controller: bustypeEditingController,
                              //     outTextFieldDecoration:
                              //         BoxDecorationStyles.outTextFieldBoxDecoration,
                              //     inputDecoration:
                              //         InputDecorationStyles.inputDecorationTextField,
                              //     title: "Business Type",
                              //     hintText: "Select Type",
                              //     errorText: "Type Your Query Here",
                              //     maxLine: 1,
                              //     isValidatePressed: isValidatePressed,
                              //   ),
                              // ),
                              Visibility(
                                visible: flag,
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: CustomDropdown(
                                      dropdownMenuItemList:
                                          _BussinessTypeModelDropdownList,
                                      onChanged:
                                          onChangeFavouriteFoodModelDropdown,
                                      value: bussinessType,
                                      isEnabled: true,
                                      title: "Business Type",
                                    )),
                              ),
                              Visibility(
                                visible: flag,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: BDtextfield(
                                    controller: busNameEditingController,
                                    outTextFieldDecoration: BoxDecorationStyles
                                        .outTextFieldBoxDecoration,
                                    inputDecoration: InputDecorationStyles
                                        .inputDecorationTextField,
                                    title: "Business Name",
                                    hintText: "Business Name",
                                    errorText: "Please Enter Business Name",
                                    maxLine: 1,
                                    textInpuFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-z A-Z]')),
                                    ],
                                    isValidatePressed: isValidatePressed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        // Visibility(
                        //   visible: flag,
                        //   child: Container(
                        //     margin:
                        //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //     child: BDtextfield(
                        //       controller: sosEditingController,
                        //       outTextFieldDecoration:
                        //           BoxDecorationStyles.outTextFieldBoxDecoration,
                        //       inputDecoration:
                        //           InputDecorationStyles.inputDecorationTextField,
                        //       title: "Size of Shop",
                        //       hintText: "Size of Shop",
                        //       errorText: "Please Enter Size of Shop",
                        //       maxLine: 1,
                        //       keyboardtype: TextInputType.number,
                        //       isInfoVisible: true,
                        //       isValidatePressed: isValidatePressed,
                        //       onInfoPressed: () {
                        //         DialogUtils.CalculateShopAreaDialog(context);
                        //       },
                        //     ),
                        //   ),
                        // ),,
                        ,
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: CustomButton(
                            onButtonPressed: () {
                              setState(() {
                                isValidatePressed = true;
                              });
                              //
                              // if (CustomValidator(nameEditingController.value.text)
                              //     .validate(Validation.isEmpty){
                              //
                              // }

                              if (flag) {
                                if (CustomValidator(
                                            nameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            lnameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            monthlyincomeEditingController
                                                .value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            busNameEditingController.value.text)
                                        .validate('isEmpty')) {
                                  BasicData.fName = nameEditingController.text;
                                  BasicData.mName = mnameEditingController.text;
                                  BasicData.lName = lnameEditingController.text;
                                  BasicData.moninName =
                                      monthlyincomeEditingController.text
                                          .replaceAll(",", "");
                                  BasicData.isbusinessregistred = flag;
                                  BasicData.bustype = bussinessType.name!;
                                  BasicData.busname =
                                      busNameEditingController.text;
                                  BasicData.sizeofshop =
                                      sosEditingController.text;
                                  print('name is ' + BasicData.fName);
                                  print('bustype is ' + BasicData.bustype);
                                  if (bussinessType.name! ==
                                      "Select Business Type") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please Select Business Type")));
                                    return;
                                  }

                                  p1.submitform('a', context);

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => PersonalDocCapture(
                                  //             context: context,
                                  //           )),
                                  // );
                                }
                              } else {
                                if (CustomValidator(
                                            nameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            lnameEditingController.value.text)
                                        .validate('isEmpty') &&
                                    CustomValidator(
                                            monthlyincomeEditingController
                                                .value.text)
                                        .validate('isEmpty')) {
                                  BasicData.fName = nameEditingController.text;
                                  BasicData.mName = mnameEditingController.text;
                                  BasicData.lName = lnameEditingController.text;
                                  BasicData.moninName =
                                      monthlyincomeEditingController.text;
                                  BasicData.isbusinessregistred = flag;
                                  BasicData.bustype = bussinessType.name!;
                                  BasicData.busname =
                                      busNameEditingController.text;
                                  BasicData.sizeofshop =
                                      sosEditingController.text;
                                  print('name is ' + BasicData.fName);
                                  print('bustype is ' + BasicData.bustype);

                                  p1.submitform('a', context);

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => PersonalDocCapture(
                                  //             context: context,
                                  //           )),
                                  // );
                                }
                              }
                            },
                            title: "START REGISTRATION",
                            boxDecoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: buttoncolor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            textColor: buttontextcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DhanvarshaLoader(),
              ],
            ),
          ),
        ),
        context: context);
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
