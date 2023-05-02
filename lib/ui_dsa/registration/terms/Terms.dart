import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key, required BuildContext context}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  TextEditingController nameEditingController = new TextEditingController();

  int counter = -1;
  var isValidatePressed = false;

  @override
  void initState() {
    // TODO: implement initState
    counter = -1;
    super.initState();
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          DhanvarshaImages.bck,
                          height: 20,
                          width: 20,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: AppColors.buttonRed,
                              fontSize: 16 * SizeConfig.textScaleFactor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 0, 10),
                  child: Text(
                    'Terms & Condition',
                    style: TextStyle(
                      fontSize: 24 * SizeConfig.textScaleFactor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Section One',
                    style: TextStyle(
                      fontSize: 22 * SizeConfig.textScaleFactor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Sub Section One',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                  child: Text(
                    'Lorem ipsum is typically a corrupted version of  a 1st century BC text by the Roman statesman and philosopher Cicero,corrupted version of  a 1st century BC text by the Roman statesman and philosopher Cicero,',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 13 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Sub Section One',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                  child: Text(
                    'Lorem ipsum is typically a corrupted version of  a 1st century BC text by the Roman statesman and philosopher Cicero,corrupted version of  '
                        'a 1st century BC text by the Roman statesman and philosopher Cicero,Lorem ipsum is typically a corrupted version of  a 1st '
                        'century BC text by the Roman statesman and philosopher Cicero,',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 13 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               /* Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Section Two',
                    style: TextStyle(
                      fontSize: 22 * SizeConfig.textScaleFactor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Sub Section Two',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                  child: Text(
                    'Lorem ipsum is typically a corrupted version of icero,corrupted version of  a 1st century BC text by the Roman statesman and philosopher Cicero,',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 13 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Section Three',
                    style: TextStyle(
                      fontSize: 22 * SizeConfig.textScaleFactor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Sub Section Three',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                  child: Text(
                    'Lorem ipsum is typically a corrupted version of,corrupted version of  a 1st century BC text by the Roman statesman and philosopher Cicero,',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 13 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),*/
                GestureDetector(
                  onTap: () {
                    setState(() {
                      counter = 1;
                    });
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Container(
                      height: SizeConfig.screenHeight / 15,
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // decoration: counter==1? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                      //     : BoxDecorationStyles.outButtonOfBox,
                      decoration:
                      BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.buttonRed,
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'ACCEPT',
                          style: TextStyle(
                              // color: counter==1?Colors.white:AppColors.buttonRed,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15 * SizeConfig.textScaleFactor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        counter = 2;
                      });
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Container(
                        height: SizeConfig.screenHeight / 15,
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: counter == 2
                            ? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed
                            : BoxDecorationStyles.outButtonOfBox,

                        child: Center(
                          child: Text(
                            'BACK',
                            style: TextStyle(
                              color: counter == 2
                                  ? Colors.white
                                  : AppColors.buttonRed,
                              fontFamily: 'Poppins',
                              fontSize: 15 * SizeConfig.textScaleFactor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
