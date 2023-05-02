import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String title;

  const ProfileScreen({Key? key, this.title = "My Profile"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "My Profile",
      type: false,
      context: context,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleCompoenent(),
                _getDhanVarshaCard(),
                _getAddressField(),
                _getBuisinessDetails(),
                _getBankDetails()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Your Buisiness Card",
            style: CustomTextStyles.boldLargeFonts,
          ),
          Image.asset(
            DhanvarshaImages.share,
            height: 20,
            width: 20,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _getDhanVarshaCard() {
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.30,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 40,
              child: Container(
                width: double.infinity,
                color: AppColors.lighBox,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prakash",
                      style: CustomTextStyles.regularLargeGreyFont,
                    ),
                    Text(
                      "Viswanathan",
                      style: CustomTextStyles.regularLargeGreyFont,
                    ),
                    Text(
                      "MALIK ELECTRICAL WORK",
                      style: CustomTextStyles.regularSmallGreyFont,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Container(
                color: AppColors.lighterGrey4,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "M : +9867106967",
                      style: CustomTextStyles.boldMediumFont,
                    ),
                    Image.asset(
                      DhanvarshaImages.dhanvarshalogo,
                      height: 30,
                      width: 100,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAddressField() {
    return Container(
      child: Text(
        "Akshay Nagar 1st Block 1st Cross, Rammurthy Nagar, Banglore - 400056",
        style: CustomTextStyles.regularMediumFont,
      ),
      margin: EdgeInsets.symmetric(vertical: 20),
    );
  }

  Widget _getBuisinessDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Buisiness Details",
              style: CustomTextStyles.regularLargeGreyFont,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Buisiness Name",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "XYZ",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Buisiness Type",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Private",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Size Of Shop",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "1000 Sq.Ft",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Monthly Income",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "450000",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getBankDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Bank Details",
              style: CustomTextStyles.regularLargeGreyFont,
            ),
            margin: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Account Number",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "123456789",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child:
                      Text("Bank Name", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "ICICI Bank",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child:
                      Text("IFSC CODE", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "ABCDE1234F",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Name Of Account Holder",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Prakash Vishwanathan",
                    style: CustomTextStyles.regularMediumFont,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
