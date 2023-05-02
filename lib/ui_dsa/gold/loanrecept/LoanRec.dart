import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/appreview/Appreview.dart';
import 'package:dhanvarsha/ui_dsa/registration/payment/PaymentScreen.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fdottedline/fdottedline.dart';

class LoanRec extends StatelessWidget {
  const LoanRec({Key? key, required BuildContext context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'Send Your Loan Receipts',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: FDottedLine(
                    color: Colors.grey.shade200,
                    height: 400.0,
                    width: 250,
                    strokeWidth: 4.0,
                    dottedLength: 10.0,
                    space: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                      child: Image.asset(
                        DhanvarshaImages.pan,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Center(
                  child: Text(
                    '+ Add more loan receipts',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20 * SizeConfig.textScaleFactor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              DhanvarshaImages.camerabutton,
                              height: 130,
                            ),
                          ),
                          Text(
                            "Take Photo",
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0)),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              DhanvarshaImages.gallerybutton,
                              height: 130,
                            ),
                          ),
                          Text(
                            "Upload",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => Appreview(
                  //             context: context,
                  //           )),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        //builder: (context) => Login(
                        builder: (context) => PaymentScreen(
                              context: context,
                            )),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: SizeConfig.screenHeight / 14,
                      width: SizeConfig.screenWidth / 2,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.red[800],
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
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
