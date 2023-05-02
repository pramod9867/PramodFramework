import 'dart:convert';

import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/offeraccepteddto.dart';
import 'package:dhanvarsha/model/request/offeracceptrejectdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/bankstatement.dart';
import 'package:dhanvarsha/ui/loanreward/offerrejected.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/commautils/commatester.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerLoanReward extends StatefulWidget {
  final int id;
  final int noOfDays;

  const CustomerLoanReward({Key? key, this.id = 0, this.noOfDays = 30})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerLoanRewardState();
}

class _CustomerLoanRewardState extends State<CustomerLoanReward>
    implements AppLoadingMultiple {
  int count = -1;

  CustomerBoardingBloc? boardingBloc;
  OfferBloc? offerBloc;
  PLFetchBloc? plFetchBloc;
  int? eligibleAmount;

  @override
  void initState() {
    offerBloc = OfferBloc(this);
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = BlocProvider.getBloc<CustomerBoardingBloc>();

    eligibleAmount = boardingBloc!.preEqualResponse!.eligibleAmount;
    // TODO: implement initState
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
                    "PERSONAL LOAN ELIGIBILITY",
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
                          height: 21,
                          width: 21,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "${(boardingBloc!.preEqualResponse!.eligibleAmount != null && boardingBloc!.preEqualResponse!.eligibleAmount != 0) ? CommaTester.addCommaToString(boardingBloc!.preEqualResponse!.eligibleAmount.toString()) : "0"}",
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
                // Container(
                //  padding: EdgeInsets.symmetric(horizontal: 10),
                //   child: Text(
                //     "Kindly Note : Offer amount is subject to change if discrepancies are found during our due diligence process.",
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                _getFooter()
                // _getFooter()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _getFooter() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.bggradient1,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            "This offer expires in ${widget.noOfDays} days.",
            style: CustomTextStyles.regularMediumFontGotham,
          ),
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${boardingBloc!.preEqualResponse!.userName!}",
            style: CustomTextStyles.boldVeryLargerFont2Gotham,
          ),
        ],
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 1;
                    });
                    acceptOffer(1);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: count == 1
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    alignment: Alignment.center,
                    child: Text(
                      "Accept",
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

                    DialogUtils.rejectOffer(
                        context, offerBloc!, plFetchBloc!.onBoardingDTO!.id!);
                  },
                  child: Container(
                    decoration: count == 2
                        ? ButtonStyles.redButtonWithCircularBorder
                        : ButtonStyles.greyButtonWithCircularBorder,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "Reject",
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
    );
  }

  acceptOffer(int id) async {
    OfferAcceptRejectDTO offerAcceptRejectDTO = OfferAcceptRejectDTO();
    offerAcceptRejectDTO.refPlId = plFetchBloc!.onBoardingDTO!.id;
    offerAcceptRejectDTO.softOfferStatus = id;

    print(offerAcceptRejectDTO.toEncodedJson());
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          offerAcceptRejectDTO.toEncodedJson()),
    });

    offerBloc!.offerAccepted(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    OfferAcceptedStatus acceptedStatus =
        OfferAcceptedStatus.fromJson(jsonDecode(dto.data!));

    print("RESPONSE OF OFFER ACCEPT");
    print(jsonEncode(acceptedStatus));
    if (type == 0) {
      if (acceptedStatus.status!) {
        if (count == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BankStatement(),
            ),
          );
        } else {}
      } else {
        if (acceptedStatus.message != null) {
          DialogUtils.rejectWithReason(
              context, offerBloc!, plFetchBloc!.onBoardingDTO!.id!);
        } else {
          SuccessfulResponse.showScaffoldMessage(
              "Something went wrong !", context);
        }
      }
    } else if (type == 1) {
      if (acceptedStatus.status!) {
        if (count == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BankStatement(),
            ),
          );
        } else {
          // DialogUtils.rejectFinalOfferNew(context);
        }
      } else {
        if (acceptedStatus.message != null) {
          DialogUtils.rejectFinalOfferNew(context);
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
