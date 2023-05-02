import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/basicdetails/BasicDetails.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key, required BuildContext context})
      : super(key: key);

  _launchURL() async {
    const url = 'https://dhanvarsha.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Image.asset(
                    //     DhanvarshaImages.bck,
                    //     height: 20,
                    //     width: 20,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Image.asset(
                        DhanvarshaImages.dhanvarshalogo,
                        width: SizeConfig.screenWidth / 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Image.asset(
                    DhanvarshaImages.party,
                    width: SizeConfig.screenWidth * 0.7,
                    height: SizeConfig.screenWidth * 0.7,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text('Welcome to Dhan Setu!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GothamMedium',
                        fontSize: 24 * SizeConfig.textScaleFactor,
                      )),
                ),
              ),
              // Center(
              //   child: Text(
              //     'To start using Dhanvarsha Partner',
              //     style: TextStyle(
              //       color: Colors.grey[400],
              //       fontFamily: 'Poppins',
              //       fontSize: 16 * SizeConfig.textScaleFactor,
              //     ),
              //   ),
              // ),
              // Center(
              //   child: Text(
              //     'app kindly register below',
              //     style: TextStyle(
              //       color: Colors.grey[400],
              //       fontFamily: 'Poppins',
              //       fontSize: 16 * SizeConfig.textScaleFactor,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicDetails(
                                context: context,
                              )),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    elevation: 10,
                    child: Container(
                      height: SizeConfig.screenHeight / 14,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.buttonRed,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          "REGISTER NOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'GothamMedium',
                            fontSize: 18 * SizeConfig.textScaleFactor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),*/
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Want a quick and easy loan?',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontSize: 13 * SizeConfig.textScaleFactor,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _launchURL,
                      child: Center(
                        child: Text(
                          'VISIT OUR WEBSITE',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 13 * SizeConfig.textScaleFactor,
                            color: AppColors.buttonRed,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
