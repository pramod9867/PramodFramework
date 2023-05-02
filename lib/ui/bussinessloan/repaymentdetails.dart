import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/bankstatement.dart';
import 'package:dhanvarsha/ui/bussinessloan/numberverification.dart';
import 'package:dhanvarsha/ui/customerdetails/verifycustomernumber.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class RepaymentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RepaymentDetailsState();
}

class _RepaymentDetailsState extends State<RepaymentDetails> {
  int count = -1;
  int repaymentTenure=-1;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getHeader(),
                _getDhanVarshaCard(),
                _getFooter(),
                Divider(),
                _getRepayMentTenture(),
                MulitpleButton()
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Prakash Vishwanathan",
            style: CustomTextStyles.boldVeryLargerFont,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _getRepayMentTenture() {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              child: Text(
                "Repayment Tenture",
                style: CustomTextStyles.boldMediumFont,
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                 // repaymentTenure=1;
                });
              },
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    repaymentTenure=1;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: SizeConfig.screenWidth - 30,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration:repaymentTenure==1? BoxDecorationStyles.outButtonOfBoxOnlyBorderRed:BoxDecorationStyles.outButtonOfBox,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("6 EMI",style: CustomTextStyles.boldMediumFont,),
                      Column(
                        children: [
                          Text(
                            "20% Interset",
                            style: CustomTextStyles.regularMediumFont,
                          ),
                          Text(
                            "₹ 49,250",
                            style: CustomTextStyles.boldMediumFont,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _getFooter() {
    return Container(
      width: SizeConfig.screenWidth - 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.bggradient1,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.asset(
            //   DhanvarshaImages.i,
            //   height: 15,
            //   width: 15,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "This offer expires in 12 days",
                style: CustomTextStyles.regularMediumFont,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getDhanVarshaCard() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(DhanvarshaImages.dhanVarshaCard),
          fit: BoxFit.contain,
        ),
      ),
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.30,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Container(),
      ),
    );
  }

  Widget MulitpleButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text.rich(
            TextSpan(
              text: '',
              children: <TextSpan>[
                TextSpan(
                  text: 'By continuing, you agree to our ',
                  style: CustomTextStyles.boldsmallGreyFont,
                ),
                TextSpan(
                  text: 'Terms Of Use',
                  style: CustomTextStyles.regularsmalleFontswithUnderline,
                ),
                TextSpan(
                    text: ' and ', style: CustomTextStyles.boldsmallGreyFont),
                TextSpan(
                  text: 'Privacy Policy',
                  style: CustomTextStyles.regularsmalleFontswithUnderline,
                ),
                // can add more TextSpans here...
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 2;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NumberVerification(context: context),
                      ),
                    );
                  },
                  child: Container(
                    decoration: count == 2
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "ACCEPT OFFER",
                      style: count != 2
                          ? CustomTextStyles.buttonTextStyleRed
                          : CustomTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: count == 1
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    alignment: Alignment.center,
                    child: Text(
                      "REJECT OFFER",
                      style: count != 1
                          ? CustomTextStyles.buttonTextStyleRed
                          : CustomTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
