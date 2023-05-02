import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/model/CoApplicantModel.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantbuilder.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantdetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/tooltip_final/dvtooltip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bankstatement.dart';

class ProprietorCoApplicant extends StatefulWidget {
  final String flag;

  const ProprietorCoApplicant({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProprietorCoApplicantState();
}

class _ProprietorCoApplicantState extends State<ProprietorCoApplicant> {
  GlobalKey<_ProprietorCoApplicantState> _scrollViewKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState

    BLFetchBloc blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    if (blFetchBloc != null) {
      if (blFetchBloc.fetchBLResponseDTO.coApplicants!.length > 0) {
        print("Co-Applicants Are");
        print(jsonEncode(blFetchBloc.fetchBLResponseDTO.coApplicants!));

        List<CoApplicantModel> listOfCoapplicantFromServer = [];

        for (int i = 0;
            i < blFetchBloc.fetchBLResponseDTO.coApplicants!.length;
            i++) {
          listOfCoapplicantFromServer.add(new CoApplicantModel(
              name: blFetchBloc.fetchBLResponseDTO.coApplicants![i].firstName,
              middleName:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].middleName,
              lastName:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].lastName,
              Id: blFetchBloc.fetchBLResponseDTO.coApplicants![i].id.toString(),
              mobileNumber:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].mobileNumber,
              houseNo: blFetchBloc.fetchBLResponseDTO.coApplicants![i].houseNo,
              addressProofPath: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                  .coApplicantProofOfAddressDocumentImage,
              percentageShareHolding: blFetchBloc
                  .fetchBLResponseDTO.coApplicants![i].shareHolderPercentage,
              genderId:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].genderId!,
              emailId: blFetchBloc.fetchBLResponseDTO.coApplicants![i].emailId,
              address:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].addressLine1,
              coApplicantPan: blFetchBloc
                  .fetchBLResponseDTO.coApplicants![i].coApplicantPanImage,
              customerAadhaarBack: blFetchBloc.fetchBLResponseDTO
                  .coApplicants![i].coApplicantAadharBackImage,
              customerAadhaar: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                  .coApplicantAadharFrontImage,
              proofOfAddress: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                  .coApplicantProofOfAddressDocumentImage,
              count: blFetchBloc.fetchBLResponseDTO.coApplicants![i].middleName !=
                      ""
                  ? blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                          .isCurrentAddresSameAsAadhar!
                      ? 14
                      : 16
                  : blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                          .isCurrentAddresSameAsAadhar!
                      ? 14
                      : 15,
              coApplicantAadhaarNumber: blFetchBloc
                  .fetchBLResponseDTO.coApplicants![i].coApplicantAadharNumber,
              coApplicantPanNumber: blFetchBloc
                  .fetchBLResponseDTO.coApplicants![i].coApplicantPanNumber,
              cityDTO: MasterDocumentId.builder.getMasterObjectDistrict(
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].districtId ??
                      0),
              stateDTO: MasterDocumentId.builder.getMasterObjectState(
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].stateId ?? 0),
              countryDTO: MasterDocumentId.builder.getMasterObjectCountry(
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].countryId ??
                      0),
              dobOfUser: blFetchBloc.fetchBLResponseDTO.coApplicants![i].dob,
              isCurrentAddresSameAsAadhar:
                  blFetchBloc.fetchBLResponseDTO.coApplicants![i].isCurrentAddresSameAsAadhar,
              pinCode: blFetchBloc.fetchBLResponseDTO.coApplicants![i].pincode));
        }
        CoApplicantBuilder.builder.notifier.value = listOfCoapplicantFromServer;
      } else {
        CoApplicantBuilder.builder.notifier.value = [];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseView(
        isBackPressed: false,
        type: false,
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: _getBody(),
        ),
        // body: _getBody(),
        context: context,
        isStepShown: true,
        stepArray: widget.flag == "" ? const [1, 7] : const [1, 8],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    DialogUtils.existfromapplications(context);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  Widget _getBody() {
    return Container(
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight -
              45 -
              MediaQuery.of(context).viewInsets.top -
              MediaQuery.of(context).viewInsets.bottom),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _getTitleCompoenentNEW(),
                      Container(
                          //height: 500,
                          child: ValueListenableBuilder(
                              valueListenable:
                                  CoApplicantBuilder.builder.notifier,
                              builder: (BuildContext context,
                                  List<CoApplicantModel> data, child) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: CoApplicantBuilder
                                      .builder.notifier.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: _getApplicanTDetails(
                                            CoApplicantBuilder
                                                .builder.notifier.value
                                                .elementAt(index)
                                                .name!,
                                            index,
                                            CoApplicantBuilder
                                                .builder.notifier.value
                                                .elementAt(index)));
                                    // child: Text("Hello"));
                                  },
                                );
                              })),
                      _getCardDetails()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: CustomButton(
              onButtonPressed: () {
                if (CoApplicantBuilder.builder.notifier.value.length >= 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusinessBankStatement(
                        flag: widget.flag,
                      ),
                    ),
                  );
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      "Please add atleast one co-applicants", context);
                }
              },
              title: "CONTINUE",
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTitleCompoenentNEW() {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              "Co-Applicants Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            )),
            MyTooltip(
                message: "All co-applicants should be part of loan structure.",
                child: Image.asset(
                  DhanvarshaImages.question,
                  height: 25,
                  width: 25,
                ))
          ],
        ),
      ),
    );
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoApplicantDetails(
                flag: widget.flag,
              ),
            ),
          );
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: SizeConfig.screenHeight * 0.12,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            DhanvarshaImages.uploadnew,
                            height: 25,
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Co-applicants",
                                  style: CustomTextStyles.boldMediumFontGotham,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ])
              ],
            ),
          ),
          // color: AppColors.white,
        ),
      ),
    );
  }

  Widget _getApplicanTDetails(String data, int index, CoApplicantModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoApplicantDetails(
              flag: widget.flag,
              model: model,
              isUpdate: true,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              DhanvarshaImages.usernewpicprofile,
                              height: 50,
                              width: 50,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) => CoApplicantDetails(
//                                          flag: widget.flag,
//                                        ),
//                                      ),
//                                    );
                                    },
                                    child: Text(
                                      data,
                                      style: CustomTextStyles.regularMediumFont,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "${CoApplicantBuilder.builder.notifier.value[index].count} of ${CoApplicantBuilder.builder.notifier.value[index].count} details added",
                                      style: CustomTextStyles
                                          .regularMediumGreyFontGotham,
                                    ),
                                  ),
                                  CoApplicantBuilder.builder.notifier
                                              .value[index].count! >=
                                          13
                                      ? Text(
                                          'Details Added',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: 'Poppins',
                                              fontSize: 14),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.buttonRed,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          child: Text(
                                            'Compulsory',
                                            style: CustomTextStyles
                                                .regularWhiteSmallFont,
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ])
                ],
              ),
            ),
            // color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
