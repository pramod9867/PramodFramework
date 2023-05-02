import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/fetchblrequestdto.dart';
import 'package:dhanvarsha/model/request/loanapplicationdto.dart';
import 'package:dhanvarsha/model/response/fetchglresponsedto.dart';
import 'package:dhanvarsha/model/response/preequalresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/addcoapplicant.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessdetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/proprietorcoapplicant.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/goldloan/gold_adddetails/Gold_AddDetails.dart';
import 'package:dhanvarsha/ui/loanreward/bankstatement.dart';
import 'package:dhanvarsha/ui/loanreward/customerloanreward.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/loanidcreator.dart';
import 'package:dhanvarsha/utils/product_id/product_id_fetcher.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationDetails extends StatefulWidget {
  final ListOfLoanApplicationDTO? loanApplicationDTO;
  final int? typeOfData;

  const ApplicationDetails(
      {Key? key, this.loanApplicationDTO, this.typeOfData = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationDetails>
    implements AppLoading {
  PLFetchBloc? plFetchBloc;
  BLFetchBloc? blFetchBloc;
  GLFetchBloc? glFetchBloc;
  CustomerBoardingBloc? boardingBloc;
  @override
  void initState() {
    plFetchBloc = PLFetchBloc.appLoading(this);
    blFetchBloc = BLFetchBloc(this);
    glFetchBloc = GLFetchBloc.init();
    BlocProvider.setBloc<PLFetchBloc>(plFetchBloc);
    BlocProvider.setBloc<BLFetchBloc>(blFetchBloc);
    BlocProvider.setBloc<GLFetchBloc>(glFetchBloc);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        onPhoneTap: () {
          launch("tel://${widget.loanApplicationDTO!.mobileNumber}");
        },
        isCallIcon: true,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getNames(),
              _getCard(),
              Spacer(),
              widget.loanApplicationDTO != null &&
                      widget.loanApplicationDTO!.loanStatus == "Pending" &&
                      widget.loanApplicationDTO!.RefId != 0 &&
                      widget.typeOfData != 0
                  ? _getCustomButtom()
                  : Container()
            ],
          ),
        ),
        context: context);
  }

  Widget _getNames() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.loanApplicationDTO!.clientName!,
          style: CustomTextStyles.boldLargeFonts,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.loanApplicationDTO!.mobileNumber!,
          style: CustomTextStyles.SmallBoldLightFont,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.loanApplicationDTO!.emailID!,
          style: CustomTextStyles.SmallBoldLightFont,
        )
      ],
    );
  }

  Widget _getCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.36,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Text(
                "Start date - ${widget.loanApplicationDTO!.dateOfApplicationCreated!}",
                style: CustomTextStyles.boldsmalleFonts,
              )),
              Expanded(
                  child: Text(
                "Last Updated - ${widget.loanApplicationDTO!.applicationLastModifiedDate!}",
                style: CustomTextStyles.boldsmalleFonts,
              )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type :",
                    style: CustomTextStyles.regularsmalleFonts,
                  ),
                  Text(
                    ProductIdFetcher.getPorductName(
                        int.parse(widget.loanApplicationDTO!.productId!)),
                    style: CustomTextStyles.boldsmalleFonts,
                  )
                ],
              )),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Stages :",
                    style: CustomTextStyles.regularsmalleFonts,
                  ),
                  Text(
                    "Application",
                    style: CustomTextStyles.boldsmalleFonts,
                  )
                ],
              )),
              SizedBox(height: 5),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status :",
                    style: CustomTextStyles.regularsmalleFonts,
                  ),
                  Text(
                    widget.loanApplicationDTO!.loanStatus!,
                    style: CustomTextStyles.boldsmalleFonts,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNameText() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Proceed with providing",
            style: CustomTextStyles.VerySmallBoldLightFont,
            textAlign: TextAlign.center,
          ),
          Text(
            "customer's property details",
            style: CustomTextStyles.VerySmallBoldLightFont,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _getCustomButtom() {
    return CustomButton(
      onButtonPressed: () {
        print("PRODUCT ID");

        print(widget.loanApplicationDTO!.productId);
        if (widget.loanApplicationDTO!.productId ==
            LoanIdFinderGeneric.plLoanId) {
          updateLoanType(typeOfLoan: "PL");
        } else if (widget.loanApplicationDTO!.productId ==
            LoanIdFinderGeneric.blLoanId) {
          updateLoanType(typeOfLoan: "BL");
        } else if (widget.loanApplicationDTO!.productId ==
            LoanIdFinderGeneric.glLoanId) {
          updateLoanType(typeOfLoan: "GL");
        }
      },
      title: "CONTINUE APPLICATION",
    );
  }

  updateLoanType({String typeOfLoan = "PL"}) async {
    // print("Generated Loan Id");
    // print(LoanIdFinderGeneric.plLoanId);

    Map<String, dynamic> updateLoanType = {
      "RefID": widget.loanApplicationDTO!.RefId,
      "TypeOfLoan": typeOfLoan,
    };

    FormData formData = FormData.fromMap({
      'json':
          await EncryptionUtils.getEncryptedText(jsonEncode(updateLoanType)),
    });

    plFetchBloc!.fetchDropoutDetails(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    if (widget.loanApplicationDTO!.productId == LoanIdFinderGeneric.plLoanId) {
      plFetchBloc!.onBoardingDTO =
          CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!));
      CustomerOnBoardingDTO onBoardingDTO =
          CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!));

      if (onBoardingDTO.loanId != null && onBoardingDTO.loanId! > 0) {
        DialogUtils.loanAlreadyExist(context, count: 1);
        return;
      }

      CustomerDetailsDTO.mobileNumber = onBoardingDTO.mobileNumber!;
      CustomerDetailsDTO.empName =
          onBoardingDTO.firstName! + " " + onBoardingDTO.lastName!;
      CustomerOnBoarding.FirstName = onBoardingDTO.firstName!;
      CustomerOnBoarding.MobileNumber = onBoardingDTO.mobileNumber!;
      CustomerOnBoarding.LastName = onBoardingDTO.lastName!;

      CustomerOnBoarding.FatherName = onBoardingDTO.middleName!;
      CustomerOnBoarding.LoanAmount = onBoardingDTO.loanAmount!.toInt();
      CustomerOnBoarding.Pincode = onBoardingDTO.pincode!;
      CustomerOnBoarding.ModeOfSalary =
          plFetchBloc!.onBoardingDTO!.modeOfSalary!;
      CustomerOnBoarding.PANNumber = onBoardingDTO.pANNumber!;

      CustomerOnBoarding.currentAddressSameAsPermanant =
          onBoardingDTO.isCurrentAndPermanentAddressSame!;

      // CustomerDetailsDTO.mobileNumber =
      //     plFetchBloc!.onBoardingDTO!.mobileNumber!;
      // CustomerDetailsDTO.empName = plFetchBloc!.onBoardingDTO!.firstName! +
      //     plFetchBloc!.onBoardingDTO!.middleName! +
      //     plFetchBloc!.onBoardingDTO!.lastName!;

      if (onBoardingDTO.isSoftOfferAccepted! &&
          onBoardingDTO.cbStatus == "SUCCESS") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BankStatement(),
          ),
        );
      } else if (onBoardingDTO.cbStatus == "REJECTED") {
        DialogUtils.offerrejectedByLoan(context,
            message: "This application has been rejected due to CB status");
      } else {
        if (onBoardingDTO.softOfferDueDays == 0 ||
            onBoardingDTO.clientId == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AadharDetails(),
            ),
          );
        } else {
          boardingBloc = CustomerBoardingBloc();

          // print("Loan Amount");
          // print(onBoardingDTO.loanAmount!.toInt());
          // print("No Of Days");
          // print(onBoardingDTO.softOfferDueDays);

          boardingBloc!.preEqualResponse = PreEqualResponse(
              eligibleAmount: onBoardingDTO.softOfferAmount,
              refPlId: plFetchBloc!.onBoardingDTO!.id,
              status: "Approved",
              userName: CustomerOnBoarding.FirstName +
                  " " +
                  CustomerOnBoarding.LastName);

          BlocProvider.setBloc<CustomerBoardingBloc>(boardingBloc);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerLoanReward(
                id: plFetchBloc!.onBoardingDTO!.clientId!,
                noOfDays: onBoardingDTO.softOfferDueDays!,
              ),
            ),
          );
        }
      }
      CustomLoaderBuilder.builder.hideLoader();
    } else if (widget.loanApplicationDTO!.productId ==
        LoanIdFinderGeneric.blLoanId) {
      blFetchBloc!.fetchBLResponseDTO =
          FetchBLResponseDTO.fromJson(jsonDecode(dto.data!));

      CustomerOnBoarding.MobileNumber =
          blFetchBloc!.fetchBLResponseDTO.MobileNumber!;

      CustomerBLOnboarding.noOfYearsRegistration =
          int.parse(blFetchBloc!.fetchBLResponseDTO.VintageYears!);

      // CustomerBLOnboarding.isGstActive

      if (blFetchBloc!.fetchBLResponseDTO.refBlId != null) {
        if (blFetchBloc!.fetchBLResponseDTO.loanId != null &&
            blFetchBloc!.fetchBLResponseDTO.loanId! > 0) {
          DialogUtils.loanAlreadyExist(context, count: 2);
          return;
        }

        if (blFetchBloc!.fetchBLResponseDTO.isSoftOfferAccepted! &&
            blFetchBloc!.fetchBLResponseDTO.CBStatus == "SUCCESS") {
          // print("NEW AMOUNT");
          // print(blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!);
          CustomerBLOnboarding.softOfferAmount =
              double.parse(blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!)
                  .toInt();

          CustomerBLOnboarding.addressOfCoApplicant = blFetchBloc!
              .fetchBLResponseDTO!.refAddressRequest![0].addressLineOne!;
          //
          // print("Soft Offer Amount NEW");
          // print(CustomerBLOnboarding.softOfferAmount);
          // CustomerOnBoarding.MobileNumber=

          if (blFetchBloc!.fetchBLResponseDTO.isProprietor!) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProprietorCoApplicant(
                  flag: "",
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCoApplicant(
                  flag: "non-proprietor",
                ),
              ),
            );
          }
        } else if (blFetchBloc!.fetchBLResponseDTO.CBStatus == "REJECTED") {
          DialogUtils.offerrejectedByLoan(context,
              message: "This application has been rejected due to CB status");
        } else {
          if (blFetchBloc!.fetchBLResponseDTO.softOfferDueDays == 0 ||
              blFetchBloc!.fetchBLResponseDTO!.clientId == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessDetails(
                  context: context,
                ),
              ),
            );
          } else {
            // CustomerBLOnboarding.softOfferAmount =
            //     double.parse(blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!)
            //         .toInt();
            //
            // CustomerBLOnboarding.addressOfCoApplicant = blFetchBloc!
            //     .fetchBLResponseDTO!.refAddressRequest![0].addressLineOne!;

            if (blFetchBloc!.fetchBLResponseDTO.isProprietor!) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SoftLoanOffer(
                          flag: "",
                          amount:
                              blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!,
                          userName: blFetchBloc!.fetchBLResponseDTO.firstName! +
                                  "" +
                                  " " +
                                  blFetchBloc!.fetchBLResponseDTO.lastName! ??
                              "",
                          id: blFetchBloc!.fetchBLResponseDTO.clientId!,
                          noOfDays:
                              blFetchBloc!.fetchBLResponseDTO.softOfferDueDays!,
                        )),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SoftLoanOffer(
                          flag: "non-proprietor",
                          amount:
                              blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!,
                          userName: blFetchBloc!.fetchBLResponseDTO.firstName! +
                                  " " +
                                  blFetchBloc!.fetchBLResponseDTO.lastName! ??
                              "",
                          id: blFetchBloc!.fetchBLResponseDTO.clientId!,
                          noOfDays:
                              blFetchBloc!.fetchBLResponseDTO.softOfferDueDays!,
                        )),
              );
            }
          }
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(
            AppConstants.errorMessage, context);
      }
    } else if (widget.loanApplicationDTO!.productId ==
        LoanIdFinderGeneric.glLoanId) {
      try {
        FetchGLResponseDTO fetchGLResponseDTO =
            FetchGLResponseDTO.fromJson(jsonDecode(dto.data!));

        glFetchBloc!.fetchGLResponseDTO = fetchGLResponseDTO;

        CustomerOnBoarding.ModeOfSalary = glFetchBloc!.fetchGLResponseDTO!.employmentType!;

        if (glFetchBloc!.fetchGLResponseDTO!.refGLId! > 0) {
          if ((glFetchBloc!.fetchGLResponseDTO!.employmentType!
                      .toUpperCase() ==
                  "SALARIED") &&
              glFetchBloc!.fetchGLResponseDTO!.addressProofs!.length > 0) {
            glFetchBloc!.selectedBranch = glFetchBloc!
                .fetchGLResponseDTO!.nearestBrachDetailsResponseDTO!;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentSumm(
                    isDocumentUploaded: false,
                    branchName: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.branchName,
                    time: glFetchBloc!.fetchGLResponseDTO!.appointmentTime,
                    day: glFetchBloc!.fetchGLResponseDTO!.appointmentDate,
                    branchAddress: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.addressLine1),
              ),
            );
          } else if (!(glFetchBloc!.fetchGLResponseDTO!.employmentType!
                      .toUpperCase() ==
                  "SALARIED") &&
              glFetchBloc!.fetchGLResponseDTO!.businessProofs!.length > 0) {


            glFetchBloc!.selectedBranch = glFetchBloc!
                .fetchGLResponseDTO!.nearestBrachDetailsResponseDTO!;




            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentSumm(
                    isDocumentUploaded: false,
                    branchName: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.branchName,
                    time: glFetchBloc!.fetchGLResponseDTO!.appointmentTime,
                    day: glFetchBloc!.fetchGLResponseDTO!.appointmentDate,
                    branchAddress: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.addressLine1),
              ),
            );
          } else if (glFetchBloc!.fetchGLResponseDTO!.branchId != 0) {
            glFetchBloc!.selectedBranch = glFetchBloc!
                .fetchGLResponseDTO!.nearestBrachDetailsResponseDTO!;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentSumm(
                    isDocumentUploaded: true,
                    branchName: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.branchName,
                    time: glFetchBloc!.fetchGLResponseDTO!.appointmentTime,
                    day: glFetchBloc!.fetchGLResponseDTO!.appointmentDate,
                    branchAddress: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.addressLine1),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoldAddDetails(),
              ),
            );
          }
        }
      } catch (e) {
        print("Error is------------->");
        print(e);
      }
      print("Gold Loan Details");
      print(jsonEncode(dto.data!));
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
