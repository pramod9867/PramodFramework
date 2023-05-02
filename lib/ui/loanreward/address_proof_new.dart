import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/dropdown/billing_model.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/customheadlines/custom_instruction_line.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddressProofNew extends StatefulWidget {
  const AddressProofNew({Key? key}) : super(key: key);

  @override
  _AddressProofNewState createState() => _AddressProofNewState();
}

class _AddressProofNewState extends State<AddressProofNew> {
  final List<BillingModel> _listOfBills = [
    BillingModel(billingId: 0, billingName: "Select Document"),
    BillingModel(billingId: 1, billingName: "Electricity Bill"),
    BillingModel(billingId: 2, billingName: "Ration Card"),
    BillingModel(billingId: 3, billingName: "Water Bill"),
  ];
  BillingModel _billingModelModel = BillingModel();
  late List<DropdownMenuItem<BillingModel>> __billingModelModelDropdownList;
  List<DropdownMenuItem<BillingModel>> _buildFavouriteFoodModelDropdown(
      List billingModelModelList) {
    List<DropdownMenuItem<BillingModel>> items = [];
    for (BillingModel billingModelModel in billingModelModelList) {
      items.add(DropdownMenuItem(
        value: billingModelModel,
        child: Text(
          billingModelModel.billingName!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;
  bool isSwitchPressed = false;
  bool isCurrentSwitchPressed = false;

  onChangeFavouriteFoodModelDropdown(BillingModel? billingModel) {
    setState(() {
      _billingModelModel = billingModel!;
    });
  }

  GlobalKey<CustomImageBuilderState> _proofAddress = GlobalKey();
  GlobalKey<CustomImageBuilderState> _rentalKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __billingModelModelDropdownList =
        _buildFavouriteFoodModelDropdown(_listOfBills);


    print(_listOfBills);
    _billingModelModel = _listOfBills[0];
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();
    print("Rental Image");
    print(plFetchBloc.onBoardingDTO!.rentalAgreementImage);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        isStepShown: true,
        stepArray:const [2, 4],
        type: false,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getTitleCompoenentNEW(),
                // CustomInstruction(),
                CustomImageBuilder(
                  description: "",
                  value: "Upload Address Proof",
                  newAddress: (plFetchBloc.onBoardingDTO!.userAddress!.length>0&&plFetchBloc
                              .onBoardingDTO!.userAddress![0].addressLineOne !=
                          null)
                      ? plFetchBloc
                          .onBoardingDTO!.userAddress![0].addressLineOne!
                      : CustomerOnBoarding.userAddress[0].addressLineOne!,
                  initialImage: plFetchBloc.onBoardingDTO!.addressProofPhoto!,
                  key: _proofAddress,
                  isAadhaarVisible: false,
                  image: DhanvarshaImages.Address,
                  dropdown: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: CustomDropdown(
                        dropdownMenuItemList: __billingModelModelDropdownList,
                        onChanged: onChangeFavouriteFoodModelDropdown,
                        value: _billingModelModel,
                        isEnabled: true,
                        title: "Document",
                        isTitleVisible: true,
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: CustomImageBuilder(
                    isRentalUpload:
                        plFetchBloc.onBoardingDTO!.rentalAgreementImage != ""
                            ? true
                            : false,
                    initialImage:
                        plFetchBloc.onBoardingDTO!.rentalAgreementImage!,
                    key: _rentalKey,
                    isAadhaarVisible: true,
                    image: DhanvarshaImages.poa,
                    description:
                        "Ensure your name is mentioned in the agreement",
                    value: "Rental Agreement",
                    isRental: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                    onButtonPressed: () {
                      if (_proofAddress.currentState!.imagepicked.value != "") {
                        if (_billingModelModel.billingId != 0) {
                          if (_rentalKey.currentState!.isRentalUpload) {
                            if (_rentalKey.currentState!.imagepicked.value !=
                                "") {
                              CustomerOnBoarding.AddressProof =
                                  _billingModelModel.billingName!;
                              CustomerOnBoarding.AddressProofPhoto =
                                  _proofAddress.currentState!.fileName;
                              CustomerOnBoarding.addressProofPath =
                                  _proofAddress.currentState!.imagepicked.value;
                              CustomerOnBoarding.RentalAgreementImage =
                                  _rentalKey.currentState!.fileName;
                              CustomerOnBoarding.rentalAgreementPath =
                                  _rentalKey.currentState!.imagepicked.value;
                              pusDataToServer();
                              print(CustomerOnBoarding.AddressProof);
                              print(CustomerOnBoarding.AddressProofPhoto);
                              print(CustomerOnBoarding.addressProofPath);
                              print(CustomerOnBoarding.rentalAgreementPath);
                              print(CustomerOnBoarding.RentalAgreementImage);

                              print("push 1");
                              print(_rentalKey.currentState!.fileName);
                              print(CustomerOnBoarding.RentalAgreementImage);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please upload rental agreement")));
                            }
                          } else {
                            CustomerOnBoarding.AddressProof =
                                _billingModelModel.billingName!;
                            CustomerOnBoarding.AddressProofPhoto =
                                _proofAddress.currentState!.fileName;
                            CustomerOnBoarding.addressProofPath =
                                _proofAddress.currentState!.imagepicked.value;
                            CustomerOnBoarding.RentalAgreementImage = "";
                            CustomerOnBoarding.rentalAgreementPath = "";

                            print("Push 2");
                            pusDataToServer();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please select document type")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please upload proof of address")));
                      }
                    },
                    title: "CONTINUE",
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
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
      onBoardingDto.netSalary =
          double.parse(CustomerOnBoarding.NetSalary!=""?CustomerOnBoarding.NetSalary.replaceAll(",", ""):"0");
      onBoardingDto.presentMonthlyEMI = CustomerOnBoarding.PresentMonthlyEMI;
      onBoardingDto.employmentType = CustomerOnBoarding.employementType;
      onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
      onBoardingDto.addressProof = CustomerOnBoarding.AddressProof;
      onBoardingDto.addressProofPhoto =
          plFetchBloc.onBoardingDTO!.addressProofPhoto !=
                  CustomerOnBoarding.AddressProofPhoto
              ? CustomerOnBoarding.AddressProofPhoto
              : "";
      onBoardingDto.rentalAgreementImage =
          plFetchBloc.onBoardingDTO!.rentalAgreementImage !=
                  CustomerOnBoarding.RentalAgreementImage
              ? CustomerOnBoarding.RentalAgreementImage
              : "";
      onBoardingDto.companyTypeCdCompanyTypeId = CustomerOnBoarding.empId;
      onBoardingDto.employmentTypeCdEmploymentType =
          CustomerOnBoarding.entityId;
      onBoardingDto.countryId = CustomerOnBoarding.empEngagementId;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      onBoardingDto.modeOfSalaryCdSalaryMode =
          CustomerOnBoarding.modeOfSalaryId;
      List<MultipartFile> appFiles = [];
      // }

      print("Image" + plFetchBloc.onBoardingDTO!.addressProofPhoto.toString());
      print("Path" + CustomerOnBoarding.AddressProofPhoto);

      if (CustomerOnBoarding.addressProofPath != "" &&
          plFetchBloc.onBoardingDTO!.addressProofPhoto !=
              CustomerOnBoarding.addressProofPath) {
        print("Address Proof 1 Updated");
        appFiles.add(MultipartFile.fromFileSync(
            CustomerOnBoarding.addressProofPath,
            filename: CustomerOnBoarding.AddressProofPhoto));
      }

      if (CustomerOnBoarding.rentalAgreementPath != "" &&
          plFetchBloc.onBoardingDTO!.rentalAgreementImage !=
              CustomerOnBoarding.rentalAgreementPath) {
        print("Rental Proof 2 Updated");
        appFiles.add(MultipartFile.fromFileSync(
            CustomerOnBoarding.rentalAgreementPath,
            filename: CustomerOnBoarding.RentalAgreementImage));
      }

      print("Add Photo" + CustomerOnBoarding.AddressProofPhoto);
      print("Rental Image" + CustomerOnBoarding.RentalAgreementImage);

      print("Files");
      print(appFiles);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
        "Myfiles": appFiles,
      });

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
                        builder: (context) => EmployementProof(),
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

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Proof of Address",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
          ],
        ),
      ),
    );
  }
}
