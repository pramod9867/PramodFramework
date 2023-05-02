import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/request/offeraccepteddto.dart';
import 'package:dhanvarsha/model/request/offeracceptrejectdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/addcoapplicant.dart';
import 'package:dhanvarsha/ui/bussinessloan/bankstatement.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantdetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/proprietorcoapplicant.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/commautils/commatester.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SoftLoanOffer extends StatefulWidget {
  final String flag;
  final String amount;
  final String userName;
  final int noOfDays;
  final int id;

  const SoftLoanOffer(
      {Key? key,
      this.flag = "proprietor",
      this.amount = "",
      this.userName = "",
      this.id = 0,
      this.noOfDays = 30})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SoftLoanOfferState();
}

class _SoftLoanOfferState extends State<SoftLoanOffer>
    implements AppLoadingMultiple {
  int count = -1;

  BLFetchBloc? blFetchBloc;
  OfferBloc? offerBloc;
  @override
  void initState() {
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    // TODO: implement initState

    offerBloc = OfferBloc(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_getHeader(), _getLoanOfferCard(), MulitpleButton()],
          ),
        ),
        context: context);
    ;
  }

  Widget _getLoanOfferCard() {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          width: SizeConfig.screenWidth - 30,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 3),
                  child: Text(
                    "BUSINESS LOAN ELIGIBILITY",
                    style: CustomTextStyles.boldLargeFonts,
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.green,
                  ),
                  alignment: Alignment.center,
                  height: (SizeConfig.screenHeight - 75) * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          DhanvarshaImages.rupeewhite,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          CommaTester.addCommaToString(widget.amount),
                          style: CustomTextStyles.boldVeryLargeWhiteFont,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text.rich(
                    TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Kindly Note :',
                          style: CustomTextStyles.boldsmalleFonts,
                        ),
                        TextSpan(
                          text:
                              ' Offer amount is subject to change if discrepancies are found during our due diligence process.',
                          style: CustomTextStyles.regularsmalleFonts,
                        ),
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
                ),
                _getFooter()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _getHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.userName,
            style: CustomTextStyles.boldVeryLargerFont,
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10, bottom: 3),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Business income : ",
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
            // Image.asset(
            //   DhanvarshaImages.i,
            //   height: 15,
            //   width: 15,
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "This offer expires in ${widget.noOfDays} days",
                style: CustomTextStyles.regularMediumFont,
              ),
            )
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 2;
                    });

                    acceptOffer(1);
                  },
                  child: Container(
                    decoration: count == 2
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "ACCEPT",
                      style: count != 2
                          ? CustomTextStyles.buttonTextStyleRed
                          : CustomTextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 1;
                    });
                    DialogUtils.rejectOffer(context, offerBloc!,
                        blFetchBloc!.fetchBLResponseDTO.refBlId!,
                        type: "BL");
                    // acceptOffer(0);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: count == 1
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    alignment: Alignment.center,
                    child: Text(
                      "REJECT",
                      style: count != 1
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
    );
  }

  acceptOffer(int id) async {
    OfferAcceptRejectDTO offerAcceptRejectDTO = OfferAcceptRejectDTO();
    offerAcceptRejectDTO.refPlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    offerAcceptRejectDTO.softOfferStatus = id;

    print(offerAcceptRejectDTO.toEncodedJson());
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          offerAcceptRejectDTO.toEncodedJson()),
    });

    offerBloc!.offerAcceptedStatusBL(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    OfferAcceptedStatus acceptedStatus =
        OfferAcceptedStatus.fromJson(jsonDecode(dto.data!));
    if (type == 0) {
      if (acceptedStatus.status!) {

        CustomerBLOnboarding.softOfferAmount =
            double.parse(widget.amount).toInt();

        if (count == 2) {
          if (widget.flag == "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                //builder: (context) => CoApplicantDetails(flag: widget.flag,),
                builder: (context) => ProprietorCoApplicant(
                  flag: widget.flag,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                //builder: (context) => CoApplicantDetails(flag: widget.flag,),
                builder: (context) => AddCoApplicant(
                  flag: widget.flag,
                ),
              ),
            );
          }
        } else {
          DialogUtils.rejectWithReason(
              context, offerBloc!, blFetchBloc!.fetchBLResponseDTO!.refBlId!);
        }
      } else {
        if (acceptedStatus.message != null) {
          DialogUtils.rejectWithReason(
              context, offerBloc!, blFetchBloc!.fetchBLResponseDTO!.refBlId!);
        } else {
          SuccessfulResponse.showScaffoldMessage(
              "Something went wrong !", context);
        }
      }
    } else if (type == 1) {
      if (acceptedStatus.status!) {
        DialogUtils.rejectFinalOfferNew(context);
        // DialogUtils.offerrejectedOffer(
        //     context,
        //     () => {
        //           Navigator.of(context).popUntil((route) => route.isFirst),

      } else {
        if (acceptedStatus.message != null) {
          DialogUtils.rejectFinalOfferNew(context);
          // Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          SuccessfulResponse.showScaffoldMessage(
              "Something went wrong !", context);
        }
      }
    }

    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
