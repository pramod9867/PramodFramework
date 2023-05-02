import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/businessgstdetailsbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/clientverify.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/fetchblrequestdto.dart';
import 'package:dhanvarsha/model/response/fetchglresponsedto.dart';
import 'package:dhanvarsha/model/response/preequalresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/addcoapplicant.dart';
import 'package:dhanvarsha/ui/bussinessloan/additionaldetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessdetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/incorporationdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/itrdocs.dart';
import 'package:dhanvarsha/ui/bussinessloan/proprietorcoapplicant.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/goldloan/gold_adddetails/Gold_AddDetails.dart';
import 'package:dhanvarsha/ui/loanreward/bankstatement.dart';
import 'package:dhanvarsha/ui/loanreward/customerloanreward.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/commonloansteps.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SelectLoanType extends StatefulWidget {
  final String mobileNumber;
  final int count;
  final int refId;

  const SelectLoanType(
      {Key? key,
      this.mobileNumber = "9664503167",
      this.count = 1,
      this.refId = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectLoanTypeState();
}

class _SelectLoanTypeState extends State<SelectLoanType>
    implements AppLoading, AppLoadingGeneric {
  PLFetchBloc? plFetchBloc;
  BLFetchBloc? blFetchBloc;
  GLFetchBloc? glFetchBloc;
  CustomerBoardingBloc? boardingBloc;
  ClientVerifyBloc? clientVerifyBloc;
  @override
  void initState() {
    plFetchBloc = PLFetchBloc.appLoadingMultiple(this);
    blFetchBloc = BLFetchBloc(this);
    glFetchBloc = GLFetchBloc.appLoadingGeneric(this);
    BlocProvider.setBloc<PLFetchBloc>(plFetchBloc);
    BlocProvider.setBloc<BLFetchBloc>(blFetchBloc);
    BlocProvider.setBloc<GLFetchBloc>(glFetchBloc);
    clientVerifyBloc =
        BlocProvider.getBloc<ClientVerifyBloc>(identifier: "PANCOMMON");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(DhanvarshaImages.bgNew1),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _getBackImage(),
                  _getTitleCompoenent(),
                  widget.count == 1
                      ? Expanded(child: _getPersonalLoan())
                      : Expanded(child: _getBusinessLoan()),
                  SizedBox(
                    height: 15,
                  ),
                  _getGoldLoan(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        DhanvarshaLoader()
      ],
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConstants.loanProduct,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBackImage() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Image.asset(
          DhanvarshaImages.whitebck,
          height: 20,
          width: 20,
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }

  Widget _getPersonalLoan() {
    return GestureDetector(
      onTap: () {
        updateLoanType();
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: AppColors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.35,
                height: SizeConfig.screenHeight * 0.15,
                child: Image.asset(DhanvarshaImages.plpic),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              Text(
                "Personal Loan",
                style: CustomTextStyles.boldLargeFonts,
              ),
              Text(
                "Get loans up to Rs.5 lakhs within 2-3 working days",
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBusinessLoan() {
    return GestureDetector(
      onTap: () async {
        // FormData formData = FormData.fromMap({
        //   "json": await EncryptionUtils.getEncryptedText({
        //     "MobiliNumber": "9892756377",
        //   }.toString())
        // });
        //
        // blFetchBloc!.fetchBLDetails(formData);

        updateLoanType(typeOfLoan: "BL", index: 1);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BusinessDetails(
        //       context: context,
        //     ),
        //   ),
        // )
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: AppColors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.15,
                child: Image.asset(DhanvarshaImages.plpic),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              Text(
                "Business Loan",
                style: CustomTextStyles.boldLargeFonts,
              ),
              Text(
                "Get loans up to Rs.20 lakhs within 2-4 working days",
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGoldLoan() {
    return Expanded(
        child: GestureDetector(
      onTap: () => {
        updateLoanType(typeOfLoan: "GL", index: 2),
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: AppColors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.35,
                height: SizeConfig.screenHeight * 0.15,
                child: Image.asset(DhanvarshaImages.glpic),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
              Text(
                "Gold Loan",
                style: CustomTextStyles.boldLargeFonts,
              ),
              Text(
                "Upto 20 Lakhs within 24 hours",
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void hideProgress() {
    print("HIDE LOADER CALLED");
    CustomLoaderBuilder.builder.hideLoader();
  }

  updateLoanType({String typeOfLoan = "PL", int index = 0}) async {
    Map<String, dynamic> updateLoanType = {
      "RefID": widget.refId,
      "TypeOfLoan": typeOfLoan,
      "CommmonPanId": (clientVerifyBloc!.panResponseDTO != null &&
              clientVerifyBloc!.panResponseDTO!.CommmonPanId != null)
          ? clientVerifyBloc!.panResponseDTO!.CommmonPanId
          : 1,
    };

    print(
        "UPDATE LOAN TYPE REQUEST ------------------------------------------->");
    print(jsonEncode(updateLoanType));
    FormData formData = FormData.fromMap({
      'json':
          await EncryptionUtils.getEncryptedText(jsonEncode(updateLoanType)),
    });

    //
    // formData=FormData.fromMap({
    //   'json':encodedString,
    //   "myFiles":"test",
    // });
    // print("Encrypted JSON");
    // print(encodedString);
    // print("FORM DATA IS");
    // formData!.fields.add(MapEntry("encryptedkey", "123456"));
    // print(formData!.fields);

    // print("FORM DATA IS");
    // formData.fields[0][];
    // print( formData.fields);

    // formData.fields.add({
    //   "key":"value"
    // });

    plFetchBloc!.selectLoanType(formData, index: index);
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {}

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    print("Show Progressed Called");
    CustomLoaderBuilder.builder.showLoader();
  }

  @override
  void isAllSuccessResponse(SuccessfulResponseDTO dto, int type) {
    print("Successful Status");

    if (type == 0) {
      plFetchBloc!.onBoardingDTO =
          CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!));
      CustomerOnBoardingDTO onBoardingDTO =
          CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!));
      //
      // print("CB STATUS");
      // print(onBoardingDTO.cbStatus);

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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AadharDetails(),
        //   ),
        // );
      } else {
        if (onBoardingDTO.softOfferDueDays == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AadharDetails(),
            ),
          );
        } else {
          try {
            boardingBloc = CustomerBoardingBloc();

            boardingBloc!.preEqualResponse = PreEqualResponse(
                eligibleAmount: plFetchBloc!.onBoardingDTO!.softOfferAmount!,
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
                  noOfDays: plFetchBloc!.onBoardingDTO!.softOfferDueDays!,
                ),
              ),
            );
          } catch (err) {
            print(err);
          }
        }

        // print(onBoardingDTO.cbStatus);

      }
      CustomLoaderBuilder.builder.hideLoader();
    } else if (type == 1) {
      blFetchBloc!.fetchBLResponseDTO =
          FetchBLResponseDTO.fromJson(jsonDecode(dto.data!));

      // print("CB STATUS");
      // print(blFetchBloc!.fetchBLResponseDTO.CBStatus);

      // print("Response OF BL TYPE");
      // print(blFetchBloc!.fetchBLResponseDTO.refBlId);

      if (blFetchBloc!.fetchBLResponseDTO.refBlId != null) {
        //
        // blFetchBloc!.fetchBLResponseDTO.isSoftOfferAccepted! &&
        //     blFetchBloc!.fetchBLResponseDTO.CBStatus == "SUCCESS"

        if (blFetchBloc!.fetchBLResponseDTO.isSoftOfferAccepted! &&
            blFetchBloc!.fetchBLResponseDTO.CBStatus == "SUCCESS") {
          CustomerBLOnboarding.softOfferAmount =
              double.parse(blFetchBloc!.fetchBLResponseDTO.SoftOfferAmount!)
                  .toInt();

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
          if (blFetchBloc!.fetchBLResponseDTO.softOfferDueDays == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessDetails(
                  context: context,
                ),
              ),
            );
          } else {
            if (blFetchBloc!.fetchBLResponseDTO.isProprietor!) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SoftLoanOffer(
                          flag: "",
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

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BusinessDetails(
        //       context: context,
        //     ),
        //   ),
        // );

      } else {
        SuccessfulResponse.showScaffoldMessage(
            AppConstants.errorMessage, context);
      }
    } else if (type == 2) {
      print("Gold Details Are -------------------->");
      print(jsonEncode(dto.data));

      try {
        FetchGLResponseDTO fetchGLResponseDTO =
            FetchGLResponseDTO.fromJson(jsonDecode(dto.data!));

        glFetchBloc!.fetchGLResponseDTO = fetchGLResponseDTO;

        if (glFetchBloc!.fetchGLResponseDTO!.refGLId! > 0) {
          if (!(CustomerOnBoarding.employementType.toUpperCase() ==
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
                    time:glFetchBloc!.fetchGLResponseDTO!
                        .appointmentTime,
                    day: glFetchBloc!.fetchGLResponseDTO!
                        .appointmentDate,
                    branchAddress: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.addressLine1),
              ),
            );
          } else if (!(CustomerOnBoarding.employementType.toUpperCase() ==
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
                    time: glFetchBloc!.fetchGLResponseDTO!.appointmentDate,
                    day: glFetchBloc!.fetchGLResponseDTO!.appointmentTime,
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
                    branchName: glFetchBloc!.fetchGLResponseDTO!
                        .nearestBrachDetailsResponseDTO!.branchName,
                    time:glFetchBloc!.fetchGLResponseDTO!
                        .appointmentTime,
                    day: glFetchBloc!.fetchGLResponseDTO!
                        .appointmentDate,
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
}
