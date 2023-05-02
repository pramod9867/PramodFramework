import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appreview extends StatelessWidget {
  const Appreview({Key? key, required BuildContext context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          // color: AppColors.blue,
          constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  DhanvarshaImages.ar,
                  height: 250,
                  // color: AppColors.bgNew,
                  width: 250,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Thank you for your',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 20 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'interest!',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 20 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'We will review your application and get back to you within 48 hours.',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 13 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  BasicData.clearData();
                },
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: SizeConfig.screenHeight / 14,
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColors.buttonRed,
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'BACK TO HOME',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gotham',
                              fontSize: 16 * SizeConfig.textScaleFactor,
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
