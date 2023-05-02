import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/model/CoApplicantModel.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/bankstatement.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantbuilder.dart';
import 'package:dhanvarsha/ui/bussinessloan/coapplicantdetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/custpersonalinfo.dart';
import 'package:dhanvarsha/ui/bussinessloan/softloanoffer.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCoApplicant extends StatefulWidget {
  final String flag;

  const AddCoApplicant({Key? key, this.flag = "proprietor"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCoApplicantState();
}

class _AddCoApplicantState extends State<AddCoApplicant> {
  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "1", calories: 110),
    FavouriteFoodModel(foodName: "2", calories: 111),
    FavouriteFoodModel(foodName: "3", calories: 112),
    FavouriteFoodModel(foodName: "4", calories: 113),
    FavouriteFoodModel(foodName: "5", calories: 114),
    FavouriteFoodModel(foodName: "6", calories: 115),
    FavouriteFoodModel(foodName: "7", calories: 116),
    FavouriteFoodModel(foodName: "8", calories: 117),
    FavouriteFoodModel(foodName: "9", calories: 118),
    FavouriteFoodModel(foodName: "10", calories: 119),
  ];
  FavouriteFoodModel _favouriteFoodModel = FavouriteFoodModel();
  late List<DropdownMenuItem<FavouriteFoodModel>>
      _favouriteFoodModelDropdownList;

  List<DropdownMenuItem<FavouriteFoodModel>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList) {
    List<DropdownMenuItem<FavouriteFoodModel>> items = [];
    for (FavouriteFoodModel favouriteFoodModel in favouriteFoodModelList) {
      items.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(
          favouriteFoodModel.foodName!!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  onChangeFavouriteFoodModelDropdown(FavouriteFoodModel? favouriteFoodModel) {
    setState(() {
      _favouriteFoodModel = favouriteFoodModel!;
    });
  }

  @override
  void initState() {
    super.initState();
    _favouriteFoodModelDropdownList =
        _buildFavouriteFoodModelDropdown(_favouriteFoodModelList);
    _favouriteFoodModel = _favouriteFoodModelList[0];

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
            lastName: blFetchBloc.fetchBLResponseDTO.coApplicants![i].lastName,
            Id: blFetchBloc.fetchBLResponseDTO.coApplicants![i].id.toString(),
            mobileNumber:
                blFetchBloc.fetchBLResponseDTO.coApplicants![i].mobileNumber,
            houseNo: blFetchBloc.fetchBLResponseDTO.coApplicants![i].houseNo,
            addressProofPath: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                .coApplicantProofOfAddressDocumentImage,
            percentageShareHolding: blFetchBloc
                .fetchBLResponseDTO.coApplicants![i].shareHolderPercentage,
            genderId: blFetchBloc.fetchBLResponseDTO.coApplicants![i].genderId!,
            emailId: blFetchBloc.fetchBLResponseDTO.coApplicants![i].emailId,
            address:
                blFetchBloc.fetchBLResponseDTO.coApplicants![i].addressLine1,
            coApplicantPan: blFetchBloc
                .fetchBLResponseDTO.coApplicants![i].coApplicantPanImage,
            customerAadhaarBack: blFetchBloc
                .fetchBLResponseDTO.coApplicants![i].coApplicantAadharBackImage,
            customerAadhaar: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                .coApplicantAadharFrontImage,
            proofOfAddress: blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                .coApplicantProofOfAddressDocumentImage,
            count:
                blFetchBloc.fetchBLResponseDTO.coApplicants![i].middleName != ""
                    ? blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                            .isCurrentAddresSameAsAadhar!
                        ? 17
                        : 15
                    : blFetchBloc.fetchBLResponseDTO.coApplicants![i]
                            .isCurrentAddresSameAsAadhar!
                        ? 16
                        : 14,
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
                blFetchBloc.fetchBLResponseDTO.coApplicants![i].countryId ?? 0),
            dobOfUser: blFetchBloc.fetchBLResponseDTO.coApplicants![i].dob,
            isCurrentAddresSameAsAadhar: blFetchBloc.fetchBLResponseDTO
                .coApplicants![i].isCurrentAddresSameAsAadhar,
            pinCode: blFetchBloc.fetchBLResponseDTO
                .coApplicants![i].pincode
          ));
        }
        CoApplicantBuilder.builder.notifier.value = listOfCoapplicantFromServer;
      } else {
        CoApplicantBuilder.builder.notifier.value = [];
      }
    }
  }

  @override
  void dispose() {
    // dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    DialogUtils.existfromapplications(context);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseView(
          title: "",
          type: false,
          isBackPressed: false,
          isStepShown: true,
          stepArray: [1, 8],
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight -
                      45 -
                      MediaQuery.of(context).viewInsets.top -
                      MediaQuery.of(context).viewInsets.bottom -
                      30),
              margin: EdgeInsets.symmetric(horizontal: 13),
              child: Column(
                // mainAxisSize: MainAxisSize.max
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_getTitleCompoenent(),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: CustomDropdown(
                            title: "Total Numbers of Partners in Firm",
                            dropdownMenuItemList: _favouriteFoodModelDropdownList,
                            onChanged: onChangeFavouriteFoodModelDropdown,
                            value: _favouriteFoodModel,
                            isEnabled: true,
                          )),

                      Container(
                          child: ValueListenableBuilder(
                              valueListenable: CoApplicantBuilder.builder.notifier,
                              builder: (BuildContext context,
                                  List<CoApplicantModel> data, child) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: CoApplicantBuilder
                                      .builder.notifier.value.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      child: _getApplicanTDetails(
                                          CoApplicantBuilder.builder.notifier.value
                                              .elementAt(index)
                                              .name!,
                                          index,
                                          CoApplicantBuilder.builder.notifier.value
                                              .elementAt(index)),
                                    );
                                  },
                                );
                              })),
                      Container(
                        child: ValueListenableBuilder(
                          valueListenable: CoApplicantBuilder.builder.notifier,
                          builder: (BuildContext context,
                              List<CoApplicantModel> data, child) {
                            return CoApplicantBuilder
                                .builder.notifier.value.length ==
                                0
                                ? _getHoirzontalImageUpload()
                                : Container(child: _getCardDetails());
                          },
                        ),
                      ),],
                  ),
                  //_addCoApplicant(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    // child: Expanded(
                    //child: Align(
                    // alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onButtonPressed: () {
                        print("Count is");
                        print(_favouriteFoodModel.foodName);

                        if (CoApplicantBuilder.builder.notifier.value.length >=
                            int.parse(_favouriteFoodModel.foodName!)) {
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
                              "Please add ${_favouriteFoodModel.foodName!} partners",
                              context);
                        }
                      },
                      title: "CONTINUE",
                      boxDecoration: ButtonStyles.redButtonWithCircularBorder,
                    ),
                    // ),
                    //),
                  ),
                ],
              ),
            ),
          ),
          context: context),
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      alignment: Alignment.topLeft,
      child: Text(
        "Co-Applicants Details",
        style: CustomTextStyles.boldLargeFonts,
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        //width: SizeConfig.screenWidth - 30,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              child: Image.asset(DhanvarshaImages.blCoApplicant),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                child: Text(
                  "Co-Applicants",
                  style: CustomTextStyles.boldLargeFonts,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Text(
                "It's required by law to verify your identity as new user.",
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(DhanvarshaImages.uploadnew),
                GestureDetector(
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
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "ADD DETAILS",
                      style: CustomTextStyles.boldMediumRedFont,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getCardDetails() {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
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
                        Image.asset(DhanvarshaImages.uploadnew),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
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
                                child: Text(
                                  "Add Co-applicants",
                                  style: CustomTextStyles.boldMediumFont,
                                ),
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
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          height: SizeConfig.safeBlockVertical * 17,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        DhanvarshaImages.usernewpicprofile,
                        height: 45,
                        width: 45,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                "${CoApplicantBuilder.builder.notifier.value[index].count.toString()} of ${CoApplicantBuilder.builder.notifier.value[index].count} Details Added",
                                style: CustomTextStyles.regularSmallGreyFont,
                              ),
                            ),
                            CoApplicantBuilder
                                        .builder.notifier.value[index].count! >=
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
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.buttonRed,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    child: Text(
                                      'Compulsory',
                                      style: CustomTextStyles
                                          .regularWhiteSmallFont,
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    CoApplicantBuilder.builder.notifier.value[index]
                                    .percentageShareHolding !=
                                null &&
                            CoApplicantBuilder.builder.notifier.value[index]
                                    .percentageShareHolding !=
                                ""
                        ? CoApplicantBuilder.builder.notifier.value[index]
                                .percentageShareHolding
                                .toString() +
                            "%"
                        : "",
                    style: CustomTextStyles.VeryLargeBoldBoldFont,
                  ),
                ),
              ],
            ),
          ),
          // color: AppColors.white,
        ),
      ),
    );
  }

  Widget _addCoApplicant() {
    return Container(
      width: SizeConfig.screenWidth - 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // ImagePickerUtils.showDialogUtil(context,
              //     (imageFile) => {imagepicked.value = imageFile!.path});
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              child: Image.asset(DhanvarshaImages.profilepic),
              margin: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
          Text(
            "Co-Applicants Details",
            style: CustomTextStyles.boldLargeFonts,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text(
              "It's required by law to verify your identity as new user.",
              style: CustomTextStyles.regularMediumGreyFont1,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(DhanvarshaImages.uploadnew),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "ADD DETAILS",
                    style: CustomTextStyles.boldMediumRedFont,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
