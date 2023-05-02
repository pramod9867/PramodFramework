import 'dart:convert';

import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/referencdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/loanreward/refrence_form/reference_form.dart';
import 'package:dhanvarsha/ui/loanreward/repaymentdatails.dart';
import 'package:dhanvarsha/ui/loantype/widget.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRefrence extends StatefulWidget {
  const AddRefrence({Key? key}) : super(key: key);

  @override
  _AddRefrenceState createState() => _AddRefrenceState();
}

class _AddRefrenceState extends State<AddRefrence> implements AddRefLoading {
  List<GlobalKey<RefrenceFormState>> form = [];
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;
  bool isValidateForm = true;
  List<ReferenceDTO> listOfReferences = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc.appLoadingRef(this);

    if (plFetchBloc.onBoardingDTO?.referenceDetails != null &&
        plFetchBloc!.onBoardingDTO?.referenceDetails!.length != 0) {
      List<ReferenceDTO>? refDto = plFetchBloc!.onBoardingDTO?.referenceDetails;

      for (int i = 0; i < refDto!.length; i++) {
        final GlobalKey<RefrenceFormState> _key = GlobalKey();
        form.add(_key);

        // _key.currentState!.fullNameController.text=refDto[i].contactName!;
      }
    } else {
      print("INTO THE ELSE ADD REFERENCES");
      for (int i = 0; i < 2; i++) {
        final GlobalKey<RefrenceFormState> _key = GlobalKey();
        form.add(_key);

        // _key.currentState!.fullNameController.text=refDto[i].contactName!;
      }
    }

    // print(plFetchBloc.onBoardingDTO!.referenceDetails![0].mobno);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      isheaderShown: true,
      type: false,
      title: "",
      isStepShown: true,
      isBackDialogRequired: true,
      stepArray: CustomerOnBoarding.currentAddressSameAsPermanant
          ? const [3, 3]
          : const [4, 4],
      body: SingleChildScrollView(
        child:Container(
        constraints: BoxConstraints(
            minHeight: SizeConfig.screenHeight -
                45 -
                MediaQuery.of(context).viewInsets.top -
                MediaQuery.of(context).viewInsets.bottom -
                30),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _getTitleCompoenentNEW(),
                  Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      // color: AppColors.newBg,
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: form.length,
                                itemBuilder: (context, index) {
                                  return plFetchBloc.onBoardingDTO!
                                                  .referenceDetails!.length -
                                              1 >=
                                          index
                                      ? RefrenceForm(
                                          index: index,
                                          key: form[index],
                                          initialName: plFetchBloc
                                                  .onBoardingDTO!
                                                  .referenceDetails![index]
                                                  .contactName ??
                                              "",
                                          emailId: plFetchBloc
                                                  .onBoardingDTO!
                                                  .referenceDetails![index]
                                                  .emailID ??
                                              "",
                                          mobileNumber: plFetchBloc
                                                  .onBoardingDTO!
                                                  .referenceDetails![index]
                                                  .mobno ??
                                              "",
                                          id: plFetchBloc
                                                  .onBoardingDTO!
                                                  .referenceDetails![index]
                                                  .relationShipTypeCdRelationType ??
                                              0,
                                          deletItem: () {
                                            for (int i = 0;
                                                i < form.length;
                                                i++) {
                                              if (i == index) {
                                                form.removeAt(i);
                                              }
                                            }
                                            setState(() {
                                              form = form;
                                            });
                                            // form.removeAt(index);
                                          },
                                        )
                                      : RefrenceForm(
                                          index: index,
                                          key: form[index],
                                          initialName: "",
                                          emailId: "",
                                          mobileNumber: "",
                                          id: 0,
                                          deletItem: () {
                                            for (int i = 0;
                                                i < form.length;
                                                i++) {
                                              if (i == index) {
                                                form.removeAt(i);
                                              }
                                            }
                                            setState(() {
                                              form = form;
                                            });
                                          },
                                        );
                                }),
                          ),
                          GestureDetector(
                            onTap: () {
                              _addRefForms();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Add References",
                                style: CustomTextStyles.boldMediumRedFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ), // Expanded(child: SizedBox()),
              form.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: CustomButton(
                        onButtonPressed: () async {
                          bool isAddtoArray = true;

                          listOfReferences = [];

                          for (int i = 0; i < form.length; i++) {
                            isValidateForm =
                                true & form[i].currentState!.onSubmitPressed();

                            ReferenceDTO referenceDTO = ReferenceDTO();
                            referenceDTO.contactName =
                                form[i].currentState!.fullNameController.text;
                            referenceDTO.emailID =
                                form[i].currentState!.emailIdController.text;
                            referenceDTO.mobno = form[i]
                                .currentState!
                                .mobileNumberController
                                .text;
                            referenceDTO.relationShipTypeCdRelationType =
                                form[i].currentState!.favouriteFoodModel.value;

                            isAddtoArray =
                                CustomerOnBoarding.MobileNumber != null
                                    ? CustomerOnBoarding.MobileNumber !=
                                        form[i]
                                            .currentState!
                                            .mobileNumberController
                                            .text
                                    : plFetchBloc.onBoardingDTO!.mobileNumber !=
                                            form[i]
                                                .currentState!
                                                .mobileNumberController &&
                                        isAddtoArray;

                            listOfReferences.add(referenceDTO);
                          }

                          CustomerOnBoarding.referenceDetails =
                              listOfReferences;

                          bool isDuplicateNumber = false;

                          print(listOfReferences);
                          for (int i = 0; i < listOfReferences!.length; i++) {
                            for (int j = 0; j < listOfReferences!.length; j++) {
                              if (i != j &&
                                  listOfReferences![i].mobno ==
                                      listOfReferences![j].mobno) {
                                print("IS DUPLICATE");
                                print(listOfReferences![i].mobno);
                                print(listOfReferences![j].mobno);
                                print(i);
                                print(j);
                                isDuplicateNumber = true;
                              }
                            }
                          }

                          if (isDuplicateNumber) {
                            SuccessfulResponse.showScaffoldMessage(
                                "References should not have same mobile number",
                                context);
                            return;
                          }

                          if (!isAddtoArray) {
                            SuccessfulResponse.showScaffoldMessage(
                                "Mobile number should not be same as customer number",
                                context);
                            return;
                          }

                          if (form.length < 2) {
                            SuccessfulResponse.showScaffoldMessage(
                                "Please add atleast two references", context);
                            return;
                          }

                          if (isValidateForm && isAddtoArray) {
                            await pusDataToServer();
                          }
                        },
                        title: "SUBMIT",
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      context: context,
    );
  }

  _addRefForms() {
    final GlobalKey<RefrenceFormState> _key = GlobalKey();
    form.add(_key);
    setState(() {
      form = form;
    });
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add References",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
            // GestureDetector(
            //   onTap: () {
            //     DialogUtils.UploadInsturctionDialog(context);
            //   },
            //   child: Image.asset(
            //     DhanvarshaImages.question,
            //     height: 25,
            //     width: 25,
            //   ),
            // )
          ],
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
      ;
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
      onBoardingDto.modeOfSalaryCdSalaryMode =
          CustomerOnBoarding.modeOfSalaryId;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      onBoardingDto.referenceDetails = CustomerOnBoarding.referenceDetails;

      List<MultipartFile> appFiles = [];

      print(onBoardingDto.toJsonEncode());

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
      });

      boardingBloc.applyForPersonalLoanDynamic(
        formData,
        context,
      );
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) async {
    // print("Is Successful Response");

    Map<String, dynamic> json = jsonDecode(dto.data!);

    if (json['status'] == true) {
      Map<String, dynamic> map = {"id": plFetchBloc.onBoardingDTO!.id};

      String encodedmap = jsonEncode(map);
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(encodedmap),
      });
      boardingBloc.createLoanApplication(formData);
    } else {
      SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }

  @override
  void isSuccessful2(SuccessfulResponseDTO dto) {
    Map<String, dynamic> json = jsonDecode(dto.data!);
    if (json['status']) {
      SuccessfulResponse.showScaffoldMessage(json['message'], context);

      DialogUtils.successfulappdialog(context);
    } else {
      // DialogUtils.successfulappdialog(context);
      SuccessfulResponse.showScaffoldMessage(json['message'], context);
    }
  }
}
