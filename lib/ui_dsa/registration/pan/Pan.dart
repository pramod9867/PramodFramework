import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/registration/gst/BillingDocuments.dart';
import 'package:dhanvarsha/ui_dsa/registration/gst/Gst.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/buttonstyles.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/dvtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pan extends StatefulWidget {
  const Pan({Key? key, required BuildContext context}) : super(key: key);

  @override
  _PanState createState() => _PanState();
}

class _PanState extends State<Pan> {
  TextEditingController panEditingController = new TextEditingController();
  TextEditingController adharEditingController = new TextEditingController();
  GlobalKey<CustomImageBuilderState> _key1 = GlobalKey();
  GlobalKey<CustomImageBuilderState> _key2 = GlobalKey();
  GlobalKey<CustomImageBuilderState> _key3 = GlobalKey();
  var isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
   // SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        DhanvarshaImages.bck,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth / 4,
                      ),
                      Text(
                        'Personal Documents',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Your PAN Details',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DVTextField(
                    controller: panEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "PAN",
                    hintText: "Enter PAN",
                    errorText: "Type Your Query Here",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload PAN',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _getHoirzontalImageUpload(
                        _key1,
                        DhanvarshaImages.card1,
                        'Front View',
                      ),
                      // Container(
                      //   height: SizeConfig.screenHeight * 0.100,
                      //   width: SizeConfig.screenWidth / 3,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.rectangle,
                      //       border:
                      //       Border.all(width: 2, color: Colors.red.shade800),
                      //       borderRadius: BorderRadius.all(Radius.circular(0))),
                      //   child: Center(
                      //     child: Image.asset(
                      //       DhanvarshaImages.card1,
                      //       fit: BoxFit.fill,
                      //       width: SizeConfig.screenWidth,
                      //     ),
                      //   ),
                      // ),
                      // Text('Front View',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Your Aadhaar Details',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DVTextField(
                    controller: adharEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "Aadhaar Number",
                    hintText: "Enter Aadhaar Number",
                    errorText: "Type Your Query Here",
                    maxLine: 1,
                    isValidatePressed: isValidatePressed,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Aadhaar',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getHoirzontalImageUpload(
                            _key2,
                            DhanvarshaImages.card2,
                            'Front View',
                          ),

                          // Container(
                          //   height: SizeConfig.screenHeight * 0.100,
                          //   width: SizeConfig.screenWidth / 3,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.rectangle,
                          //       border:
                          //       Border.all(width: 2, color: Colors.red.shade800),
                          //       borderRadius: BorderRadius.all(Radius.circular(0))),
                          //   child: Center(
                          //     child: Image.asset(
                          //       DhanvarshaImages.card2,
                          //       fit: BoxFit.fill,
                          //       width: SizeConfig.screenWidth,
                          //     ),
                          //   ),
                          // ),
                          // Text('Front View',
                          // style: TextStyle(
                          //   color: Colors.grey,
                          // ),)
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getHoirzontalImageUpload(
                            _key3,
                            DhanvarshaImages.card3,
                            'Back View',
                          ),
                          // Container(
                          //   height: SizeConfig.screenHeight * 0.100,
                          //   width: SizeConfig.screenWidth / 3,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.rectangle,
                          //       border:
                          //       Border.all(width: 2, color: Colors.red.shade800),
                          //       borderRadius: BorderRadius.all(Radius.circular(0))),
                          //   child: Center(
                          //     child: Image.asset(
                          //       DhanvarshaImages.card3,
                          //       fit: BoxFit.fill,
                          //       width: SizeConfig.screenWidth,
                          //     ),
                          //   ),
                          // ),
                          // Text('Back View',
                          //   style: TextStyle(
                          //     color: Colors.grey,
                          //   ),)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: CustomButton(
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BillingDocuments(
                            context: context,
                          ),
                        ),
                      );
                    },
                    title: "CONTINUE",
                    boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHoirzontalImageUpload(Key key, String card1, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageBuilder(
          key: key,
          image: card1,
          value: value,
        ),
      ],
    );
  }
}
