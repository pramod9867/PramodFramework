import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/constant_dsa/index.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationRejected extends StatefulWidget {
  final String? message;

  const ApplicationRejected({Key? key, this.message="Credit Bureau Norms Not Met"}) : super(key: key);

  @override
  _ApplicationRejectedState createState() => _ApplicationRejectedState();
}






class _ApplicationRejectedState extends State<ApplicationRejected> {


  @override
  void initState() {

    CustomLoaderBuilder.builder.hideLoaderDiff();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseView(
          title: "",
          type: false,
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: SizeConfig.screenWidth - 20,
                height: SizeConfig.screenHeight * 0.80 -
                    SizeConfig.verticalviewinsects,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      DhanvarshaImages.activeLoan,
                      height: 80,
                      width: 80,
                    ),
                    Text(
                      "Application Rejected",
                      style: CustomTextStyles.boldLargeFonts,
                    ),
                    Text(
                      "As per our policy we are unable\n to offer loan to this customer",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.regularsmalleFonts,
                    ),
                    Text(
                      "You can re-apply for customer \nafter 30 days",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.regularsmalleFonts,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "COMMON REASONS FOR\n APPLICATION REJECTION ",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 7,
                                      width: 7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.5),
                                          color: AppColors.buttonRed),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        widget.message!,
                                        style:
                                            CustomTextStyles.regularsmalleFonts,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            child: CustomButton(
                              onButtonPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              title: "OK",
                              widthScale: 0.5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          context: context),
    );
  }

  Future<bool> _onWillPop() async {
    // DialogUtils.existfromapplications(context);

    Navigator.of(context).popUntil((route) => route.isFirst);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }
}
