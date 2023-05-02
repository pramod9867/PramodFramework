import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/registration/addressproof/AddressProof.dart';
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

class Gst extends StatefulWidget {
  const Gst({Key? key, required BuildContext context}) : super(key: key);

  @override
  _GstState createState() => _GstState();
}

class _GstState extends State<Gst> {
  TextEditingController panEditingController = new TextEditingController();
  TextEditingController gstEditingController = new TextEditingController();
  GlobalKey<CustomImageBuilderState> _key1 = GlobalKey();
  GlobalKey<CustomImageBuilderState> _key2 = GlobalKey();

  var isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
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
                        'Billing Documents',
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
                        'Your Business PAN Details',
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
                      //       border: Border.all(
                      //           width: 2, color: Colors.red.shade800),
                      //       borderRadius: BorderRadius.all(Radius.circular(0))),
                      //   child: Center(
                      //     child: Image.asset(
                      //       DhanvarshaImages.card1,
                      //       fit: BoxFit.fill,
                      //       width: SizeConfig.screenWidth,
                      //     ),
                      //   ),
                      // ),
                      // Text(
                      //   'Front View',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      // )
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.tick,
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'My Business has a GST number',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Image.asset(
                        DhanvarshaImages.question,
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DVTextField(
                    controller: gstEditingController,
                    outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                    inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                    title: "GST Number",
                    hintText: "Enter GST Number",
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
                            'Upload GST Certificate',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getHoirzontalImageUpload(
                            _key2,
                            DhanvarshaImages.pin,
                            '',
                          ),
                          // Container(
                          //   height: SizeConfig.screenHeight * 0.100,
                          //   width: SizeConfig.screenWidth / 3,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.rectangle,
                          //       border: Border.all(
                          //           width: 2, color: Colors.red.shade800),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(0))),
                          //   child: Center(
                          //     child: Image.asset(
                          //       DhanvarshaImages.pin,
                          //       fit: BoxFit.fill,
                          //       width: SizeConfig.screenWidth,
                          //     ),
                          //   ),
                          // ),
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
                            builder: (context) => AddressProof(
                                  context: context,
                                )),
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
