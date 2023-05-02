import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/material.dart';

class LoanFlowSuccessful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoanOfferState();
}

class _LoanOfferState extends State<LoanFlowSuccessful> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        isheaderShown: false,
        type: false,
        title: "",
        body: Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset(DhanvarshaImages.right,height: 15,width: 15,color: AppColors.black,),
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          DhanvarshaImages.offeracceptedNew,
                          height: SizeConfig.screenHeight*0.40,
                          width:SizeConfig.screenHeight*0.40,
                          fit: BoxFit.fill,

                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Offer Accepted !",
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Our Customer relation associate will get in touch with customer to further process the loan application",
                                style: CustomTextStyles.regularMediumFont,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 25),
                              child: Text(
                                "We will update you on successful disbursment of loan.",
                                style: CustomTextStyles.regularMediumFont,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomButton(
                    onButtonPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    title: "GO TO HOME",
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }
}
