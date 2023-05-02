import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/customerdetails/verifycustomernumber.dart';
import 'package:dhanvarsha/ui/loantype/numberverification.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration/otp/OTP.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RepaymentOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RepaymentOptionState();
}

class RepaymentOptionState extends State<RepaymentOptions> {
  bool? value = false;
  int count = -1;
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;

  int repaymentTenure = -1;

  void initState() {
    // TODO: implement initState
    super.initState();

    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    print("Rental Image");
    print(plFetchBloc.onBoardingDTO!.employmentProofPhoto);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _getHeader(),
                _getDhanVarshaCard(),
                _getFooter(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
                _getRepayMentTenture(),
                MulitpleButton()
              ],
            )),
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
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10, bottom: 3),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Personal Income: ",
          //         style: CustomTextStyles.regularMediumFont,
          //       ),
          //       Text(
          //         "₹ 8,58,0000",
          //         style: CustomTextStyles.boldMediumFont,
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _getFooter() {
    return Container(
      width: SizeConfig.screenWidth - 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.bggradient1,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              DhanvarshaImages.question,
              height: 15,
              width: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "This offer expires in 12 days",
                style: CustomTextStyles.regularMediumFont,
              ),
            ),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        count = 1;
                      });

                      if (repaymentTenure != -1) {
                        pusDataToServer();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please select repayment tenure")));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: count == 1
                          ? ButtonStyles.redButtonWithCircularBorder
                          : ButtonStyles.greyButtonWithCircularBorder,
                      alignment: Alignment.center,
                      child: Text(
                        "ACCEPT OFFER",
                        style: count != 1
                            ? CustomTextStyles.buttonTextStyleRed
                            : CustomTextStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        count = 2;
                      });
                      // DialogUtils.offerrejectedOffer(context);
                    },
                    child: Container(
                      decoration: count == 2
                          ? ButtonStyles.redButtonWithCircularBorder
                          : ButtonStyles.greyButtonWithCircularBorder,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      child: Text(
                        "REJECT OFFER",
                        style: count != 2
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
      ),
    );
  }

  Widget _getRepayMentTenture() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "REPAYMENT TENURE",
            style: CustomTextStyles.boldLargeFonts,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              repaymentTenure = 1;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: SizeConfig.screenWidth - 30,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: repaymentTenure == 1
                ? BoxDecorationStyles.outButtonOfBox
                : BoxDecorationStyles.outButtonOfBox,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                        value: repaymentTenure == 1,
                        onChanged: (bool) => {},
                        checkColor: AppColors.white,
                        activeColor: AppColors.buttonRed,
                      ),
                      Text(
                        "18 EMIs",
                        style: CustomTextStyles.boldLargeFonts,
                      )
                    ],
                  ),
                ),
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
        GestureDetector(
          onTap: () {
            setState(() {
              repaymentTenure = 2;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: SizeConfig.screenWidth - 30,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: repaymentTenure == 2
                ? BoxDecorationStyles.outButtonOfBox
                : BoxDecorationStyles.outButtonOfBox,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                        value: repaymentTenure == 2,
                        onChanged: (bool) => {},
                        checkColor: AppColors.white,
                        activeColor: AppColors.buttonRed,
                      ),
                      Text(
                        "18 EMIs",
                        style: CustomTextStyles.boldLargeFonts,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "20% Interset",
                      style: CustomTextStyles.regularMediumFont,
                    ),
                    Text(
                      "₹ 29,500",
                      style: CustomTextStyles.boldMediumFont,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              repaymentTenure = 3;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: SizeConfig.screenWidth - 30,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: repaymentTenure == 3
                ? BoxDecorationStyles.outButtonOfBox
                : BoxDecorationStyles.outButtonOfBox,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Checkbox(
                        value: repaymentTenure == 3,
                        onChanged: (bool) => {},
                        checkColor: AppColors.white,
                        activeColor: AppColors.buttonRed,
                      ),
                      Text(
                        "18 EMIs",
                        style: CustomTextStyles.boldLargeFonts,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "20% Interset",
                      style: CustomTextStyles.regularMediumFont,
                    ),
                    Text(
                      "₹ 19,250",
                      style: CustomTextStyles.boldMediumFont,
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget _getCheckBoxWithTextfield() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: this.value,
              focusColor: AppColors.buttonRed,
              activeColor: AppColors.buttonRed,
              onChanged: (bool? value) {
                setState(() {
                  this.value = value;
                });
              },
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'By continuing, you agree to our',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        ' Terms of Use',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ' and',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
    onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
    onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
    onBoardingDto.bankStatements = [];
    onBoardingDto.salarySlips = [];
    onBoardingDto.aadharNumber = CustomerOnBoarding.AadharNumber;
    onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
    onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
    onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
    onBoardingDto.pANNumber = CustomerOnBoarding.PANNumber;
    onBoardingDto.pANImage = "";
    onBoardingDto.isAadharLinkedToMobile =
        plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
    onBoardingDto.customerImage = "";
    onBoardingDto.emailID = CustomerOnBoarding.EmailID;
    onBoardingDto.presentMonthlyEMI =
        plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
    onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
    onBoardingDto.allFormFlag = "Y";
    onBoardingDto.dOB = CustomerOnBoarding.DOB;
    onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
    onBoardingDto.currentAddress1 = CustomerOnBoarding.CurrentAddress1;
    onBoardingDto.currentAddress2 = CustomerOnBoarding.CurrentAddress2;
    ;
    onBoardingDto.currentAddress3 = CustomerOnBoarding.CurrentAddress3;
    onBoardingDto.permanentAddress1 = CustomerOnBoarding.PermanentAddress1;
    onBoardingDto.permanentAddress2 = CustomerOnBoarding.PermanentAddress2;
    onBoardingDto.permanentAddress3 = CustomerOnBoarding.PermanentAddress3;
    onBoardingDto.aadharFrontImage = "";
    onBoardingDto.aadharBackImage = "";
    onBoardingDto.employmentProofPhoto = "";
    onBoardingDto.employmentIDPhoto = "";
    onBoardingDto.oKYCDocument = "";
    ;
    onBoardingDto.loanAmount =
        CustomerOnBoarding.LoanAmount.toDouble(); // changinef
    onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
    onBoardingDto.employerName = CustomerOnBoarding.EmployerName;
    onBoardingDto.entityTypeEmployer = CustomerOnBoarding.EntityTypeEmployer;
    onBoardingDto.modeOfSalary = CustomerOnBoarding.ModeOfSalary;
    onBoardingDto.netSalary =
        double.parse(CustomerOnBoarding.NetSalary.replaceAll(",", ""));
    onBoardingDto.presentMonthlyEMI = CustomerOnBoarding.PresentMonthlyEMI;
    onBoardingDto.employmentType = CustomerOnBoarding.employementType;
    onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
    onBoardingDto.addressProof = CustomerOnBoarding.AddressProof;
    onBoardingDto.addressProofPhoto = "";
    onBoardingDto.rentalAgreementImage = "";
    onBoardingDto.companyTypeCdCompanyTypeId = CustomerOnBoarding.empId;
    onBoardingDto.employmentTypeCdEmploymentType = CustomerOnBoarding.entityId;
    onBoardingDto.countryId = CustomerOnBoarding.empEngagementId;
    onBoardingDto.modeOfSalaryCdSalaryMode = CustomerOnBoarding.modeOfSalaryId;
    onBoardingDto.genderId = CustomerOnBoarding.genderId;
    // List<MultipartFile> appFiles = [];
    //
    // if (CustomerOnBoarding.AadhaarFronPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(
    //       CustomerOnBoarding.AadhaarFronPath,
    //       filename: CustomerOnBoarding.AadhaarFromImage));
    // }
    //
    // if (CustomerOnBoarding.AadhaarBackPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(
    //       CustomerOnBoarding.AadhaarFronPath,
    //       filename: CustomerOnBoarding.AaadhaarBackImage));
    // }
    // if (CustomerOnBoarding.panImagePath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
    //       filename: CustomerOnBoarding.PANImage));
    // }
    //
    // if (CustomerOnBoarding.profileImagePath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(
    //       CustomerOnBoarding.profileImagePath,
    //       filename: CustomerOnBoarding.ProfilePhoto));
    // }
    //
    // if (CustomerOnBoarding.rentalAgreementPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(
    //       CustomerOnBoarding.rentalAgreementPath,
    //       filename: CustomerOnBoarding.RentalAgreementImage));
    // }
    //
    // if (CustomerOnBoarding.addressProofPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(
    //       CustomerOnBoarding.addressProofPath,
    //       filename: CustomerOnBoarding.AddressProofPhoto));
    // }
    //
    // if (CustomerOnBoarding.empIdPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.empIdPath,
    //       filename: CustomerOnBoarding.EmploymentIDPhoto));
    // }
    // if (CustomerOnBoarding.kycPath != "") {
    //   appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.kycPath,
    //       filename: CustomerOnBoarding.OKYCDocument));
    // }
    // if (CustomerOnBoarding.bankPath.length > 0) {
    //   for (int i = 0; i < CustomerOnBoarding.bankPath.length; i++) {
    //     appFiles.add(MultipartFile.fromFileSync(
    //         CustomerOnBoarding.bankPath.elementAt(i),
    //         filename: CustomerOnBoarding.bankFileName.elementAt(i)));
    //   }
    // }
    // if (CustomerOnBoarding.salaryPath.length > 0) {
    //   for (int i = 0; i < CustomerOnBoarding.salaryPath.length; i++) {
    //     appFiles.add(MultipartFile.fromFileSync(
    //         CustomerOnBoarding.salaryPath.elementAt(i),
    //         filename: CustomerOnBoarding.SalarySlips.elementAt(i)));
    //   }
    // }
    //
    ;


    print(onBoardingDto.toJsonEncode());
    FormData formData = FormData.fromMap({
      'json':
          await EncryptionUtils.getEncryptedText(await onBoardingDto.toJsonEncode()),
    });

    // print(formData.files[0].value);
    boardingBloc.applyForPersonalLoan(
        formData,
        context,
        (dto) => {
              if (dto!.status!)
                {
                  SuccessfulResponse.showScaffoldMessage(dto.message!, context),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NumberVerification(context: context),
                    ),
                  )
                }
              else
                {
                  SuccessfulResponse.showScaffoldMessage(dto.message!, context),
                }
            });
    // print(onBoardingDto.toJsonEncode());
  }
}
