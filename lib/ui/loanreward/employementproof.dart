import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/add_reference.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/loanreward/repaymentdatails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/customheadlines/custom_instruction_line.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EmploymeentProof extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployementProofState();
}

class _EmployementProofState extends State<EmploymeentProof> {
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  GlobalKey<CustomImageBuilderState> _profilePickey = GlobalKey();
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;

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
        type: false,
        title: "",
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: [4,5],
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  _getTitleCompoenentNEW(),
                  _getHoirzontalImageUploadProfile()
                ],
              ),
            ),
            _getContinueButton()
          ],
        )),
        context: context);
  }

  Widget _getHoirzontalImageUploadProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          CustomImageBuilder(
            initialImage: plFetchBloc.onBoardingDTO!.oKYCDocument!,
            no: "",
            // subtitleImage: DhanvarshaImages.userphoto,
            key: _profilePickey,
            image: DhanvarshaImages.kycdocs,
            value: "Upload Selfie with Documents",
            subtitleString: "TAKE A PHOTO",
            description:
                "Mandatory for verification",
          ),
        ],
      ),
    );
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "KYC Verification",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
          ],
        ),
      ),
    );
  }
  Widget _getContinueButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: CustomButton(
        onButtonPressed: () {
          if (_profilePickey.currentState!.imagepicked.value != "") {
            CustomerOnBoarding.OKYCDocument =
                _profilePickey.currentState!.fileName;
            CustomerOnBoarding.kycPath =
                _profilePickey.currentState!.imagepicked.value;

            pusDataToServer();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please upload photo holding kyc documents")));
          }
        },
        title: "Continue",
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
      onBoardingDto.pincode =CustomerOnBoarding.Pincode; // changine
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
      onBoardingDto.oKYCDocument = plFetchBloc.onBoardingDTO!.oKYCDocument !=
              CustomerOnBoarding.OKYCDocument
          ? CustomerOnBoarding.OKYCDocument
          : "";
      ;
      onBoardingDto.loanAmount =
          CustomerOnBoarding.LoanAmount.toDouble();  // changinef
      onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
      onBoardingDto.employerName = CustomerOnBoarding.EmployerName;
      onBoardingDto.entityTypeEmployer = CustomerOnBoarding.EntityTypeEmployer;
      onBoardingDto.modeOfSalary = CustomerOnBoarding.ModeOfSalary;
      onBoardingDto.netSalary =
          double.parse(CustomerOnBoarding.NetSalary!=""?CustomerOnBoarding.NetSalary.replaceAll(",", ""):"0");
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
      onBoardingDto.modeOfSalaryCdSalaryMode=CustomerOnBoarding.modeOfSalaryId;
      onBoardingDto.genderId=CustomerOnBoarding.genderId;
      List<MultipartFile> appFiles = [];
      // }

      if (CustomerOnBoarding.kycPath != "" &&
          plFetchBloc.onBoardingDTO!.oKYCDocument !=
              CustomerOnBoarding.kycPath) {
        print("Kyc Updated");
        appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.kycPath,
            filename: CustomerOnBoarding.OKYCDocument));
      }

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

      // print("Array OF Files");
      print(CustomerOnBoarding.OKYCDocument);
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
  }
}
