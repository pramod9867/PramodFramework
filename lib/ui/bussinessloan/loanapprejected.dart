import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanRejectedApp extends StatelessWidget {
  const LoanRejectedApp({Key? key, required BuildContext context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      DhanvarshaImages.bck,
                      height: 20,
                      width: 20,
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

              Padding(
                padding: const EdgeInsets.all(0),
                child: Center(
                  child: Image.asset(
                    DhanvarshaImages.otp,width: 130,height: 130,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Application Rejected',
                  style: CustomTextStyles.boldLargeFonts,

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Text(
                  'You can re-apply again for the customer after 30 days',
                  style: CustomTextStyles.regularMediumFont
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Reason For Rejection',
                  style: CustomTextStyles.boldMediumFont
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 8,
                        ),
                        Text(
                          "  Inadequate credit score.",
                          style:
                          CustomTextStyles.regularsmalleFonts,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 8,
                        ),
                        Text(
                          "  Job instability.",
                          style:
                          CustomTextStyles.regularsmalleFonts,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 8,
                        ),
                        Text(
                          "  Upaid dues.",
                          style:
                          CustomTextStyles.regularsmalleFonts,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: SizeConfig.screenHeight / 15,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red[800],
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'GO TO HOME',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16* SizeConfig.textScaleFactor,
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
