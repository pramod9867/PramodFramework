import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FAQScreen();
}

class _FAQScreen extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          child: Container(
            // height: SizeConfig.screenHeight,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "FAQs",
                    style: CustomTextStyles.BoldTitileFont,
                  ),
                ),
                Container(
                  child: new ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: vehicles.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(10),
                          child: ExpansionTile(
                            iconColor: AppColors.buttonRed,
                            collapsedIconColor: AppColors.buttonRed,
                            childrenPadding: EdgeInsets.all(0),
                            title: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.fromBorderSide(BorderSide.none)),
                              child: new Text(
                                vehicles[i].title,
                                style: CustomTextStyles.boldMediumFont,
                              ),
                            ),
                            children: <Widget>[
                              new Column(
                                children: _buildExpandableContent(vehicles[i]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: CustomTextStyles.regularSmallGreyFont,
          ),
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];

  Vehicle(this.title, this.contents);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'Who can become a partner?',
    [
      'Any individual who is of 18 years age can sign up. This app also provides a good opportunity for all channel partners and DSA’s to grow their business network.'
    ],
  ),
  new Vehicle(
    'What documents details do I require to sign up as a partner?',
    [
      'a. PAN Card & Aadhar Card \n b. Address Proof \n c. Business Address & Business Document \n d. Bank details & Cancelled Check (A/C Number, IFSC Code)'
    ],
  ),
  new Vehicle(
    'How to get started on Dhan Setu app?',
    [
      'There are two ways to get starts:\n\n 1. For a new partner registration, follow the below steps:\na. Download the Dhan Setu App (available on Android Play Store)\n b. Complete the registration process\nc. Check your registration process on the app\nd. Login using your Registered Mobile no and OTPe. Generate business by filing cases\n\n 2. For an existing partner, follow the below steps:\n\na. Download the Dhan Setu App (available on Android Play Store)\nb. Login using your Registered Mobile no and OTP'
    ],
  ),
  new Vehicle(
    'I do not have a bank account registered in my name. Can I still proceed with my application?',
    ['You need a bank account registered on your name.'],
  ),
  new Vehicle(
    'I do not have a bank account registered in my name. Can I still proceed with my application?',
    ['You need a bank account registered on your name.'],
  ),
  new Vehicle(
    'How long will it take for partner registration to be completed?',
    [
      'Post registration has been completed, we will review your application and get back to you within 48 hours.'
    ],
  ),
  new Vehicle(
    'How will I understand if my partner registration application has been accepted or rejected?',
    [
      'You can start creating leads once you are registered with us.The status will be displayed on the Dhan Setu app and you can instantly start creating new loan applications.'
    ],
  ),
  new Vehicle(
    'What loan products do you offer?',
    ['We offer Personal, Business and Gold loans up to Rs. 20 lakh.'],
  ),
  new Vehicle(
    'What interest rates are the customers eligible for?',
    [
      'There is no fixed interest rate, it depends on the product offered and credit profile of the customer such as the duration of loan you request, your credit history etc.'
    ],
  ),
  new Vehicle(
    'Do the customers need to submit any collateral to the bank before applying for a loan?',
    [
      'For personal & business loans, there is no collateral. However for a Gold loan you will be submitted some jewellery or other gold as the collateral.'
    ],
  ),
  new Vehicle(
    'What is the procedure for applying for a loan on Dhan Setu?',
    [
      'You can apply a loan by following the below steps: \n a. Login using your Registered Mobile no and OTP\nb. Click on Add new application\nc. Submit all relevant information & documents on the app\nd. Click on application submitted\ne. Customer loan application will be reviewed'
    ],
  ),
  new Vehicle(
    'How do I track my applications post submission of application on the Dhan Setu App?',
    [
      'a. Login to Dhan Setu App post submitting a case successfully\nb. Check your app Dashboard on the Homepage for the status\nc. Our customer associate will get in contact in case of any pending documents.'
    ],
  ),
  new Vehicle(
    'What can I track from the dashboard of the Dhan Setu app?',
    [
      'a. Track Loans Disbursed and Conversion Rate date wise\nb. Business Overview case tracking including:\n\t1. App status tracking\n\ta. Pending and Rejected on app\n2. Business overview tracking\n\ta. Pending\n\tb. Approved\n\tc. Rejected\n\td. Disbursed'
    ],
  ),
  new Vehicle(
    'Can I check individual case status of customers?',
    [
      'Yes, you can check individual case status by\n\ta. Login into the Dhan Setu app\n\tb. Click on Application & Loan Status count\nt\tc. You view all the Applications under the status\n\td. Click on Individual case'
    ],
  ),
  new Vehicle(
    'Can I check individual case status of customers?',
    [
      'Yes, you can check individual case status by\n\ta. Login into the Dhan Setu app\n\tb. Click on Application & Loan Status count\n\tc. You view all the Applications under the status\n\td. Click on Individual case'
    ],
  ),
  new Vehicle(
    'Can I check individual case status of customers?',
    [
      'Yes, you can check individual case status by\n\ta. Login into the Dhan Setu app\n\tb. Click on Application & Loan Status count\n\tc. You view all the Applications under the status\n\td. Click on Individual case'
    ],
  ),
  new Vehicle(
    'How to apply for a Personal Loan?',
    [
      '\ta) Apply for a Personal loan from the Dhan Setu App by:\n\tb) Downloading the Dhan Setu App\n\tc) Click on Add new applicatio\n\td) Enter Personal Details & click on Personal Loan'
    ],
  ),
  new Vehicle(
    'What is the minimum salary required to get a personal loan?',
    [
      'The minimum monthly salary required to avail personal loan is Rs. 15,000 per month and above. However, this salary needs to come into the bank account.'
    ],
  ),
  new Vehicle(
    'What documents are required for a Personal Loan?',
    [
      '\ta) Pan Card\n\tb) Aadhar Card\n\tc) Photograph\n\td) Bank Statement\n\te) Proof of Address/Rent Agreement\n\tf) Salary Slips/ID Card'
    ],
  ),
  new Vehicle(
    'What is the Initial Loan eligibility amount?',
    [
      'The initial loan eligibility amount is the maximum loan amount that your customer is eligible for.'
    ],
  ),
  new Vehicle(
    'On what basis my initial loan eligibility amount is calculated?',
    [
      'The initial loan eligibility amount is calculated based on basic customer details and as per credit norms.'
    ],
  ),
  new Vehicle(
    'How long will it take for customers to get money into their account after the loan is approved?',
    [
      'Post customer’s loan is approved, and the loan agreement is signed, the money will be disbursed in the account shortly.'
    ],
  ),
  new Vehicle(
    'What happens if the loan application is rejected?',
    [
      'If your loan application is rejected, you may apply again after 30 days on Dhan Setu app.'
    ],
  ),
  new Vehicle(
    'What are the common reasons for rejection in prequalification?',
    [
      'The common reasons are loan amount not as per policy, low income, job instability, unpaid dues and low Cibil score'
    ],
  ),
  new Vehicle(
    'How to apply for a Business Loan?',
    [
      'Apply for a Personal loan from the Dhan Setu App by:\n\ta) Downloading the Dhan Setu App\n\tb) Click on Add new application\n\tc) Enter Personal Details & click on Business Loan'
    ],
  ),
  new Vehicle(
    'What is the income from required to get a business loan?',
    [
      'The minimum income from business required to avail business loan is Rs. 15,000 per month and above. However, this salary needs to come into the bank account.'
    ],
  ),
  new Vehicle(
    'What documents are required for a Business Loan?',
    [
      '\na) Pan Card\nb) Aadhar Card\nc) Photograph\nd) Bank Statement\ne) Business Address Proof\nf) Residential Address Proof\ng) Business Duration Proof\nh) Financial Documents'
    ],
  ),
  new Vehicle(
    'What is the Initial Loan eligibility amount?',
    [
      'The initial loan eligibility amount is the maximum loan amount that your customer is eligible for.'
    ],
  ),
  new Vehicle(
    'On what basis my initial loan eligibility amount is calculated?',
    [
      'The initial loan eligibility amount is calculated based on basic customer details and as per credit norms.'
    ],
  ),
  new Vehicle(
    'How long will it take for customers to get money into their account after the loan is approved?',
    [
      'Post customer’s loan is approved, and the loan agreement is signed, the money will be disbursed in the account shortly.'
    ],
  ),
  new Vehicle(
    'What happens if the loan application is rejected?',
    [
      'If your loan application is rejected, you may apply again after 30 days on Dhan Setu app.'
    ],
  ),
  new Vehicle(
    'What are the common reasons for rejection in prequalification?',
    [
      'The common reasons are loan amount not as per policy, low income, job instability, unpaid dues and low cibil score'
    ],
  ),
  new Vehicle(
    'For business loan, is permission from the partners (Co-applicants) required before applying for a loan?',
    [
    'Yes. All partners need to give their consent & sign the loan agreement form.'
    ],
  ),
  new Vehicle(
    'What is the impact of GST on business loans for businesses?',
    [
     'GST plays an important role in availing business loans and better interest rates.'
    ],
  ),
];
