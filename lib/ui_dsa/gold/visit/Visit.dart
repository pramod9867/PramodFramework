import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/appreview/Appreview.dart';
import 'package:dhanvarsha/ui_dsa/registration/payment/PaymentScreen.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fdottedline/fdottedline.dart';

class Visit extends StatelessWidget {
  Visit({Key? key, required BuildContext context}) : super(key: key);
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'Add Visit Details',
                  style: TextStyle(
                    fontSize: 20 * SizeConfig.textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Image.asset(DhanvarshaImages.card1,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight / 3,
                    fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(0.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            print("on Change Text Called");
                          },
                          initialValue: 'Raj',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            // isDense: true,// this will remove the default content padding
                            hintText: "Enter Name.",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "Flat Number/Plot Number/House Number",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            print("on Change Text Called");
                          },
                          initialValue: 'C-903',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            // isDense: true,// this will remove the default content padding
                            hintText: "Enter Name.",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "Building Number/Society Name",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            print("on Change Text Called");
                          },
                          initialValue: 'Laxmi Niwas',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            // isDense: true,// this will remove the default content padding
                            hintText: "Enter Name.",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "Road Number/Road Name/Area/Locality",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            print("on Change Text Called");
                          },
                          initialValue: 'VitBhatti',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            // isDense: true,// this will remove the default content padding
                            hintText: "Enter Name.",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "Pincode",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        TextFormField(
                          onChanged: (text) {
                            print("on Change Text Called");
                          },
                          initialValue: '400632',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          cursorColor: AppColors.black,
                          decoration: InputDecoration(
                            // isDense: true,// this will remove the default content padding
                            hintText: "Enter Name.",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                          ),
                        ),
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
                                height: SizeConfig.screenHeight / 17,
                                width: SizeConfig.screenWidth / 1.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.red[800],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Center(
                                  child: Text(
                                    'Confirm Appointment',
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
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
