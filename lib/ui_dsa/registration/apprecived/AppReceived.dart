import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/appreview/Appreview.dart';
import 'package:dhanvarsha/ui_dsa/registration/payment/PaymentScreen.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AppReceived extends StatelessWidget {
  const AppReceived({Key? key, required BuildContext context})
      : super(key: key);

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
                child: Center(
                  child: Image.asset(
                    DhanvarshaImages.ar,
                    height: SizeConfig.screenWidth * 0.28,
                    width: SizeConfig.screenWidth * 0.28,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Almost Done!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  'As a Dhanvarsha agent you can receive the benefit of:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  '\u2022 Lorem Ipsum is simply dummy text',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  '\u2022 established fact that a reader distracted:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  '\u2022 Where does it come from',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11 * SizeConfig.textScaleFactor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 30),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11 * SizeConfig.textScaleFactor,
                  ),
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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: SizeConfig.screenHeight / 12,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red[800],
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'PAY RS. 1,000',
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
            ],
          ),
        ),
      ),
    );
  }
}
