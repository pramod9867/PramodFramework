import 'dart:io';

import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/add_reference.dart';
import 'package:dhanvarsha/ui/loanreward/employementproof.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/customheadlines/custom_instruction_line.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EmployementProof extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployementProofState();
}

class _EmployementProofState extends State<EmployementProof> {
  GlobalKey<MultipleFilerUploaderState> _salarySlipsKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _IdcardKey = GlobalKey();
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;

  @override
  void initState() {
    // TODO: implement initState
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        isStepShown: true,
        stepArray: CustomerOnBoarding.currentAddressSameAsPermanant
            ? const [2, 3]
            : const [3, 4],
        title: "",
        isBackDialogRequired: true,
        type: false,
        body: SingleChildScrollView(
            child: Container(
          constraints: BoxConstraints(
              minHeight: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).viewInsets.top -
                  MediaQuery.of(context).viewInsets.bottom -
                  30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _getTitleCompoenentNEW(),
                  MultipleFileUploader(
                    key: _salarySlipsKey,
                    initialData: plFetchBloc.onBoardingDTO!.salarySlips!,
                    title: "Upload Salary Slips",
                    imageNew: DhanvarshaImages.salaryImage,
                    isSalaryImage: true,
                    description: "Latest 3 months Salary slip",
                    isPasswordProtected: false,
                    isImageShown: false,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: CustomImageBuilder(
                      initialImage: plFetchBloc.onBoardingDTO!.employmentIDPhoto!,
                      key: _IdcardKey,
                      image: DhanvarshaImages.npan,
                      value: "ID Card (Optional)",
                      description: AppConstants.uploadIdentityDescription,
                      isImageShown: true,
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  onButtonPressed: () {
                    if (_salarySlipsKey.currentState!.imagepicked.value.length >
                        0) {
                      List<String> salaryPdfArray = [];
                      List<String> salaryPath = [];
                      for (int i = 0;
                          i <
                              _salarySlipsKey
                                  .currentState!.imagepicked.value.length;
                          i++) {
                        String fileName;
                        if (!Uri.parse(_salarySlipsKey
                                .currentState!.imagepicked.value[i])
                            .isAbsolute) {
                          File file = new File(_salarySlipsKey
                              .currentState!.imagepicked.value
                              .elementAt(i));
                          fileName = file.path.split('/').last;
                        } else {
                          fileName = _salarySlipsKey
                              .currentState!.imagepicked.value
                              .elementAt(i);
                        }

                        salaryPath.add(_salarySlipsKey
                            .currentState!.imagepicked.value
                            .elementAt(i));
                        salaryPdfArray.add(fileName);
                      }

                      CustomerOnBoarding.SalarySlips = salaryPdfArray;
                      CustomerOnBoarding.salaryPath = salaryPath;
                      CustomerOnBoarding.EmploymentIDPhoto =
                          _IdcardKey.currentState!.fileName;
                      CustomerOnBoarding.empIdPath =
                          _IdcardKey.currentState!.imagepicked.value;

                      print("Salary Slips");
                      print(CustomerOnBoarding.SalarySlips);
                      print("Salary Slips Path");

                      print(CustomerOnBoarding.salaryPath);

                      print("Employment Id Photo");

                      print(CustomerOnBoarding.EmploymentIDPhoto);
                      print("Employment Id Path");
                      pusDataToServer();
                      print(CustomerOnBoarding.empIdPath);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please upload salary slips")));
                    }
                  },
                  title: "CONTINUE",
                ),
              )
            ],
          ),
        )),
        context: context);
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Text(
          "Customer’s Employment Details ",
          style: CustomTextStyles.boldLargeFontsGotham,
        ),
      ),
    );
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
      onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements = [];
      onBoardingDto.salarySlips =
          !Uri.parse(CustomerOnBoarding.SalarySlips.elementAt(0)).isAbsolute
              ? CustomerOnBoarding.SalarySlips
              : [];
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

      // print("Front iMage is" + CustomerOnBoarding.AadhaarFromImage);
      onBoardingDto.aadharFrontImage = "";
      onBoardingDto.aadharBackImage = "";
      onBoardingDto.employmentProofPhoto = "";
      onBoardingDto.employmentIDPhoto =
          plFetchBloc.onBoardingDTO!.employmentIDPhoto !=
                  CustomerOnBoarding.EmploymentIDPhoto
              ? CustomerOnBoarding.EmploymentIDPhoto
              : "";
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
      onBoardingDto.addressProof = CustomerOnBoarding.AddressProof;
      onBoardingDto.addressProofPhoto = "";
      onBoardingDto.rentalAgreementImage = "";
      onBoardingDto.companyTypeCdCompanyTypeId = CustomerOnBoarding.empId;
      onBoardingDto.employmentTypeCdEmploymentType =
          CustomerOnBoarding.entityId;
      onBoardingDto.countryId = CustomerOnBoarding.empEngagementId;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      onBoardingDto.modeOfSalaryCdSalaryMode =
          CustomerOnBoarding.modeOfSalaryId;
      List<MultipartFile> appFiles = [];
      // }

      if (!Uri.parse(CustomerOnBoarding.SalarySlips[0]).isAbsolute) {
        if (CustomerOnBoarding.salaryPath.length > 0) {
          print("Salary Slip Updated");
          for (int i = 0; i < CustomerOnBoarding.salaryPath.length; i++) {
            appFiles.add(MultipartFile.fromFileSync(
                CustomerOnBoarding.salaryPath.elementAt(i),
                filename: CustomerOnBoarding.SalarySlips.elementAt(i)));
          }
        }
      }

      if (CustomerOnBoarding.empIdPath != "" &&
          plFetchBloc.onBoardingDTO!.employmentIDPhoto !=
              CustomerOnBoarding.empIdPath) {
        print("Emp ID Updated");
        appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.empIdPath,
            filename: CustomerOnBoarding.EmploymentIDPhoto));
      }

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

      // print("Array OF Files");
      print(onBoardingDto.employmentIDPhoto);
      print(appFiles);
      // // print(CustomerOnBoarding.employementType);
      // // // // print(formData.files[0].value);
      boardingBloc.applyForPersonalLoan(
          formData,
          context,
          (dto) => {
                if (dto!.status!)
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddRefrence(),
                      ),
                    )
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
}
