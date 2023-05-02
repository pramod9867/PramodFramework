import 'dart:io';

import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/address_proof_new.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/loanreward/customerloanreward.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/CustomBtnBlackborder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BankStatement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BankStatementState();
}

class _BankStatementState extends State<BankStatement> {
  bool? value = false;
  bool isSwitchPressed = false;
  TextEditingController pdfPassword = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;

  GlobalKey<MultipleFilerUploaderState> _fileUploadingKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: BaseView(
            isBackPressed: false,
            title: "",
            type: false,
            isStepShown: true,
            stepArray: CustomerOnBoarding.currentAddressSameAsPermanant?const [1,3]: const [1, 4],
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    minHeight: SizeConfig.screenHeight -
                        45 -
                        MediaQuery.of(context).viewInsets.top -
                        MediaQuery.of(context).viewInsets.bottom -
                        30),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTitleCompoenent(),
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 15),
                          //   child: _getCardDetails(),
                          // ),
                          true
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: MultipleFileUploader(
                                    isBankStatements: true,
                                    title: "Add Bank Statement",
                                    key: _fileUploadingKey,
                                    initialData: plFetchBloc
                                        .onBoardingDTO!.bankStatements!,
                                    // imageNew: DhanvarshaImages.bankstatement,
                                  ),
                                )
                              : _getOKKycDetails()
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: CustomBtnBlackborder(
                        onButtonPressed: () async {
                          if (_fileUploadingKey
                                  .currentState!.imagepicked.value.length >
                              0) {
                            // CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
                            // onBoardingDto.firstName=CustomerOnBoarding.FirstName;
                            // onBoardingDto.gender="MALE";
                            // onBoardingDto.bankStatement="BankStatement.pdf";
                            // onBoardingDto.aadharNumber=CustomerOnBoarding.AadharNumber;
                            // onBoardingDto.middleName=CustomerOnBoarding.FatherName;
                            // onBoardingDto.lastName=CustomerOnBoarding.LastName;
                            // onBoardingDto.mobileNumber=CustomerOnBoarding.MobileNumber;
                            // onBoardingDto.pANNumber=CustomerOnBoarding.PANNumber;
                            // onBoardingDto.pANImage=CustomerOnBoarding.PANImage;
                            // onBoardingDto.isAadharLinkedToMobile=CustomerOnBoarding.IsAadharLinkedToMobile;
                            // onBoardingDto.aadharNumber= CustomerOnBoarding.AadharNumber;
                            // onBoardingDto.customerImage=CustomerOnBoarding.ProfilePhoto;
                            // onBoardingDto.emailID=CustomerOnBoarding.EmailID;
                            // onBoardingDto.presentMonthlyEMI=CustomerOnBoarding.PresentMonthlyEMI;
                            // onBoardingDto.requestID="1";
                            // onBoardingDto.allFormFlag="Y";
                            // onBoardingDto.dOB=CustomerOnBoarding.DOB;
                            // onBoardingDto.pincode=CustomerOnBoarding.Pincode;
                            // onBoardingDto.currentAddress1=CustomerOnBoarding.CurrentAddress1;
                            // onBoardingDto.currentAddress2=CustomerOnBoarding.CurrentAddress2;
                            // onBoardingDto.currentAddress3=CustomerOnBoarding.CurrentAddress3;
                            // onBoardingDto.permanentAddress1=CustomerOnBoarding.PermanentAddress1;
                            // onBoardingDto.permanentAddress2=CustomerOnBoarding.PermanentAddress2;
                            // onBoardingDto.permanentAddress3=CustomerOnBoarding.PermanentAddress3;
                            // onBoardingDto.aadharFrontImage=CustomerOnBoarding.AadhaarFromImage;
                            // onBoardingDto.aadharBackImage=CustomerOnBoarding.AaadhaarBackImage;
                            // onBoardingDto.incomeProof="";
                            List<String> bankStatementArray = [];
                            List<String> bankPathArray = [];
                            for (int i = 0;
                                i <
                                    _fileUploadingKey
                                        .currentState!.imagepicked.value.length;
                                i++) {
                              String fileName;
                              if (!Uri.parse(_fileUploadingKey
                                      .currentState!.imagepicked.value[i])
                                  .isAbsolute) {
                                File file = new File(_fileUploadingKey
                                    .currentState!.imagepicked.value
                                    .elementAt(i));
                                fileName = file.path.split('/').last;
                              } else {
                                fileName = _fileUploadingKey
                                    .currentState!.imagepicked.value
                                    .elementAt(i);
                              }
                              bankPathArray.add(_fileUploadingKey
                                  .currentState!.imagepicked.value
                                  .elementAt(i));
                              bankStatementArray.add(fileName);
                            }

                            CustomerOnBoarding.bankPath = bankPathArray;
                            CustomerOnBoarding.bankFileName =
                                bankStatementArray;
                            // onBoardingDto.employmentProofPhoto=CustomerOnBoarding.ProfilePhoto;
                            // onBoardingDto.employmentIDPhoto="";
                            // onBoardingDto.oKYCDocument="";
                            // onBoardingDto.loanAmount=CustomerOnBoarding.LoanAmount;
                            // onBoardingDto.fatherName=CustomerOnBoarding.FatherName;
                            // onBoardingDto.employerName=CustomerOnBoarding.EmployerName;
                            // onBoardingDto.entityTypeEmployer=CustomerOnBoarding.EntityTypeEmployer;
                            // onBoardingDto.modeOfSalary=CustomerOnBoarding.ModeOfSalary;
                            // onBoardingDto.netSalary =CustomerOnBoarding.NetSalary;
                            // onBoardingDto.employmentType="FULL-TIME";
                            // onBoardingDto.id=0;
                            // onBoardingDto.addressProofPhoto="";

                            print(CustomerOnBoarding.bankPath);
                            print(CustomerOnBoarding.bankFileName);
                            if (_fileUploadingKey
                                .currentState!.isSwitchPressed) {
                              if (CustomValidator(_fileUploadingKey
                                      .currentState!.pdfPassword.text)
                                  .validate(Validation.isEmpty)) {
                                CustomerOnBoarding.pdfPasswordField =
                                    _fileUploadingKey
                                        .currentState!.pdfPassword.text;
                                await pusDataToServer();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Please enter pdf password")));
                              }
                            } else {
                              await pusDataToServer();
                            }

                            ;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Please upload bank statements")));
                          }

                          // print(onBoardingDto.toJson().toString());
                          // FormData formData = FormData.fromMap({
                          //   'json': await EncryptionUtils.getEncryptedText(onBoardingDto.toJsonEncode()),
                          //   "Myfiles": [
                          //     await MultipartFile.fromFileSync(CustomerOnBoarding.AadhaarFronPath,
                          //         filename: CustomerOnBoarding.AadhaarFromImage),
                          //     await MultipartFile.fromFileSync(CustomerOnBoarding.AadhaarBackPath,
                          //         filename: CustomerOnBoarding.AaadhaarBackImage),
                          //     await MultipartFile.fromFileSync(_fileUploadingKey.currentState!.imagepicked.value[0],
                          //         filename:"BankStatement.pdf"),
                          //     await MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
                          //         filename:CustomerOnBoarding.PANImage),
                          //     await MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
                          //         filename:CustomerOnBoarding.PANImage),
                          //     await MultipartFile.fromFileSync(CustomerOnBoarding.profileImagePath,
                          //         filename:CustomerOnBoarding.ProfilePhoto),
                          //
                          //   ],
                          // });
                          //
                          //
                          // print(formData.files[0].value);
                          // boardingBloc.applyForPersonalLoan(formData,context);
                          // print(onBoardingDto.toJsonEncode());
                        },
                        title: "SUBMIT",
                      ),
                    )
                  ],
                ),
              ),
            ),
            context: context),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    DialogUtils.existfromapplications(context);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  Widget _getOKKycDetails() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isSwitchPressed
                        ? "Verify Income Using Netbanking"
                        : "Verify by uploading bank statement",
                    style: CustomTextStyles.boldLargeFontsGotham,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Send sms link to the customer to verify the income, Customers need to open link and log in using their net banking to verify income",
                      style: CustomTextStyles.regularMedium2GreyFont1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "This process is 100% safe and secure",
                      style: CustomTextStyles.boldMediumFontGotham,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DialogUtils.showKycDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "SEND SMS LINK",
                        style: CustomTextStyles.boldMediumRedFontGotham,
                      ),
                    ),
                  )
                ],
              ),
            )),
        // color: AppColors.white,
      ),
    );
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Automatic Verification",
                    style: CustomTextStyles.boldLargeFonts,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSwitchPressed
                              ? "Verify Income Using Netbanking"
                              : "Verify by uploading bank statement",
                          style: CustomTextStyles.regularMedium2GreyFont1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 55,
                      height: 35,
                      activeColor: AppColors.buttonRed,
                      value: isSwitchPressed,
                      onToggle: (value) {
                        setState(() {
                          isSwitchPressed = value;
                        });
                        print(value);
                      },
                    ),
                  ])
            ],
          ),
        ),
        // color: AppColors.white,
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Customer’s Bank Details",
            style: CustomTextStyles.boldLargeFontsGotham,
          ),
        ),
        // Text(
        //   "Upload Bank Statement from January 18, 2020 to February 18, 2021",
        //   style: CustomTextStyles.regularSmallGreyFont,
        // )
      ],
    );
  }

  Widget _getSubtitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manually Upload Bank Statement",
            style: CustomTextStyles.boldMediumFont,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Provide e-statement in PDF format. Scanned bank statements are not valid",
              style: CustomTextStyles.regularSmallGreyFont,
            ),
          ),
          _getHoirzontalImageUpload(),
          _getCheckBoxWithTextfield()
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Row(
      children: [
        CustomImageBuilder(
          key: _key,
          image: DhanvarshaImages.poa,
          value: "Bank Statement",
          type: "pan",
          description:
              "Provide e-statement in pdf format, scanned bank statements are not valid",
        ),
      ],
    );
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
            Text(
              "My PDF is password protected.",
              style: CustomTextStyles.regularMediumFont,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: _getTextField(),
        )
      ],
    );
  }

  Widget _getTextField() {
    bool getValue = this.value!;
    return getValue
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: DVTextField(
              controller: pdfPassword,
              outTextFieldDecoration:
                  BoxDecorationStyles.outTextFieldBoxDecorationWithBlack,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Password",
              hintText: "Enter PDF Password",
              errorText: "Please Enter Valid PDF Password",
              maxLine: 1,
              isValidatePressed: false,
              type: Validation.isEmpty,
            ),
          )
        : Container();
  }

  Widget _getHorizontalDividerCompoenent() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Divider(),
        )),
        Text("OR"),
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Divider(),
        )),
      ],
    );
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
      onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements =
          !Uri.parse(CustomerOnBoarding.bankFileName.elementAt(0)).isAbsolute
              ? CustomerOnBoarding.bankFileName
              : [];
      onBoardingDto.salarySlips = [];

      // print(CustomerOnBoarding.AadharNumber);
      print("Aadhaar New" + plFetchBloc.onBoardingDTO!.aadharNumber.toString());
      print(plFetchBloc.onBoardingDTO!.aadharNumber);
      onBoardingDto.aadharNumber = CustomerOnBoarding.AadharNumber != ""
          ? CustomerOnBoarding.AadharNumber
          : plFetchBloc.onBoardingDTO!.aadharNumber;
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
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = CustomerOnBoarding.DOB;
      onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
      onBoardingDto.currentAddress1 = CustomerOnBoarding.CurrentAddress1;
      ;
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
      onBoardingDto.loanAmount =
          CustomerOnBoarding.LoanAmount.toDouble(); // changinef
      onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
      onBoardingDto.employerName = CustomerOnBoarding.EmployerName;
      onBoardingDto.entityTypeEmployer = CustomerOnBoarding.EntityTypeEmployer;
      onBoardingDto.modeOfSalary = CustomerOnBoarding.ModeOfSalary;
      onBoardingDto.netSalary = double.parse(CustomerOnBoarding.NetSalary != ""
          ? CustomerOnBoarding.NetSalary.replaceAll(",", "")
          : "0");
      onBoardingDto.presentMonthlyEMI = CustomerOnBoarding.PresentMonthlyEMI;
      onBoardingDto.employmentType = CustomerOnBoarding.employementType;
      onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
      onBoardingDto.addressProof = plFetchBloc.onBoardingDTO!.addressProof;
      onBoardingDto.addressProofPhoto = "";
      onBoardingDto.rentalAgreementImage = "";
      onBoardingDto.companyTypeCdCompanyTypeId = CustomerOnBoarding.empId;
      onBoardingDto.employmentTypeCdEmploymentType =
          CustomerOnBoarding.entityId;
      onBoardingDto.countryId = CustomerOnBoarding.empEngagementId;
      onBoardingDto.modeOfSalaryCdSalaryMode =
          CustomerOnBoarding.modeOfSalaryId;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      List<MultipartFile> appFiles = [];
      // }

      if (!Uri.parse(CustomerOnBoarding.bankFileName[0]).isAbsolute) {
        if (CustomerOnBoarding.bankPath.length > 0) {
          for (int i = 0; i < CustomerOnBoarding.bankPath.length; i++) {
            appFiles.add(MultipartFile.fromFileSync(
                CustomerOnBoarding.bankPath.elementAt(i),
                filename: CustomerOnBoarding.bankFileName.elementAt(i)));
          }
        }
      }

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

      print("Array OF Files");
      print(onBoardingDto.bankStatements);
      print(appFiles);
      // print(CustomerOnBoarding.employementType);
      // // // print(formData.files[0].value);
      boardingBloc.applyForPersonalLoan(
          formData,
          context,
          (dto) => {
                if (dto!.status!)
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                    if (CustomerOnBoarding.currentAddressSameAsPermanant)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployementProof(),
                          ),
                        )
                      }
                    else
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressProofNew(),
                          ),
                        )
                      }
                  }
                else
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                  }
              });
    }
    // print(onBoardingDto.toJsonEncode());
  }

  Widget _getSendLinkCustomer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send Link to Customer",
            style: CustomTextStyles.boldMediumFont,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Here we need to explain with what Perifos in two to three sentences",
              style: CustomTextStyles.regularMediumFont,
            ),
          ),
          Text(
            "SEND LINK TO CUSTOMER",
            style: CustomTextStyles.boldMediumRedFont,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: CustomButton(
              onButtonPressed: () {},
              title: "Submit",
            ),
          )
        ],
      ),
    );
  }
}
