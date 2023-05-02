import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/kycdocuments/KycDocuments.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/datepicker/custom_datepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:share/share.dart';

class AppointmentSumm extends StatefulWidget {
  final String? branchName;
  final String? time;
  final String? day;
  final bool? isDocumentUploaded;
  final String? branchAddress;
  // final double? lattitude;
  // final double? longitude;

  const AppointmentSumm(
      {Key? key,
      required this.branchName,
      required this.time,
      required this.day,
      required this.branchAddress,
      this.isDocumentUploaded = true})
      : super(key: key);
  @override
  _AppointmentSummState createState() => _AppointmentSummState();
}

class _AppointmentSummState extends State<AppointmentSumm> {
  TextEditingController dateController = new TextEditingController();
  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;
  MasterDataDTO _buisinessDropdownmodel =
      MasterDataDTO("Select entity type", 0);


  GLFetchBloc? glFetchBloc;
  @override
  void initState() {

    glFetchBloc= BlocProvider.getBloc<GLFetchBloc>();

    super.initState();
    buisinessFirmTypeList = [];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseView(
        body: SingleChildScrollView(
          child: _getNewBLBody(),
        ),
        context: context,
        isheaderShown: true,
        isBackPressed: false,
        type: false,
        isBurgerVisble: true,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    DialogUtils.existfromapplications(context);

    // Navigator.of(context).popUntil((route) => route.isFirst);
    return false;
  }

  Widget _getNewBLBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gold Loan",
            style: CustomTextStyles.regularMediumGreyFontGotham,
          ),
          Text(
            "Few Steps Away",
            style: CustomTextStyles.boldVeryLargerFont2Gotham,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "You will need to visit the Dhanvarsha\nbranch with the following",
              style: CustomTextStyles.regularMediumGreyFontGotham,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            constraints: BoxConstraints(minHeight: 85),
            //height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  DhanvarshaImages.yg,
                  height: 35,
                  width: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Gold",
                      style: CustomTextStyles.boldLargeFonts,
                    ),
                    Text(
                      "jewelry to be deposited",
                      style: CustomTextStyles.regularLightBoxsmalleFonts,
                    ),
                    //Text("verification",style: CustomTextStyles.regularLightBoxsmalleFonts,),
                  ],
                ),
                Image.asset(
                  DhanvarshaImages.left,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //height: 80,
               constraints: BoxConstraints(minHeight: 85),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  DhanvarshaImages.kyc,
                  height: 35,
                  width: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "KYC Documents",
                      style: CustomTextStyles.boldLargeFonts,
                    ),
                    Text(
                      "Your proof of address and",
                      style: CustomTextStyles.regularLightBoxsmalleFonts,
                    ),
                    Text(
                      "proof of identity",
                      style: CustomTextStyles.regularLightBoxsmalleFonts,
                    ),
                  ],
                ),
                Image.asset(
                  DhanvarshaImages.left,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
          widget.isDocumentUploaded!
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          //builder: (context) => CommonScreen(),
                          builder: (context) => KycDocuments(
                            date: widget.day,
                            time: widget.time,
                          ),
                          //builder: (context) => ApplicationRec(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    //height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /*Image.asset(
                    DhanvarshaImages.activeLoan,
                    height: 35,
                    width: 35,
                  ),*/
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Save time at the branch",
                              style: CustomTextStyles.boldMediumrWhiteFont,
                            ),
                            Text(
                              "Upload your documents",
                              style:
                                  CustomTextStyles.regularLightBoxsmalleFonts,
                            ),
                            //Text("proof of identity",style: CustomTextStyles.regularLightBoxsmalleFonts,),
                          ],
                        ),
                        Image.asset(
                          DhanvarshaImages.sh,
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
                child: Text(
              "------------- visit -------------",
              style: CustomTextStyles.regularMediumGreyFontGotham,
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
                child: Text(
              widget.branchName!,
              style: CustomTextStyles.boldLargeFonts,
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Center(
                child: Text(
              widget.branchAddress!,
              // "1st Floor, DJ House, Building no 4, Wilson Compound, Old Nagardas Rd, Andheri East, Mumbai, Maharshtra 400069",
              textAlign: TextAlign.center,
              style: CustomTextStyles.regularSmallGreyFont,
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
                child: Text(
              "${DateFormat('EEEE, MMM d, yyyy').format(DateFormat('dd/MM/yyyy').parse(widget.day!))}, ${widget.time}",
              style: CustomTextStyles.boldLargeFonts,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Share.share("Branch Name: " +
                      glFetchBloc!.selectedBranch.branchName! +
                      "\n" +
                      "\n" +
                      "Branch Address: " +
                      glFetchBloc!.selectedBranch.addressLine1! +
                      "\n" +
                      "\n" +
                      "Location: " +
                      "https://www.google.com/maps?q=" +
                      glFetchBloc!.selectedBranch.latitude!+
                      "," +
                      glFetchBloc!.selectedBranch.longitude!);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    DhanvarshaImages.s,
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  MapsLauncher.launchCoordinates(
                      double.parse(
                         glFetchBloc!.selectedBranch.latitude!),
                      double.parse(
                          glFetchBloc!.selectedBranch.longitude!));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    DhanvarshaImages.l,
                    height: 35,
                    width: 35,
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: Text(
            "Loan offer is subject to assesment of\nGold and Documents",
            textAlign: TextAlign.center,
            style: CustomTextStyles.regularSmallGreyFont,
          )),

          /* Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: CustomDatePicker(
              controller: dateController,
              isValidateUser: false,
              selectedDate: dateController.text,
            ),
          ),*/
          /*Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: CustomDropdownMaster<MasterDataDTO>(
              dropdownMenuItemList: buisinessFirmTypeList,
              onChanged:onChangeBusinessDropdown,
              value: _buisinessDropdownmodel,
              isEnabled: true,
              title: "Enter Gold Karat",
              isTitleVisible: true,
              errorText: "Please select Gold Karat",
              isValidate: false,
            ),
          ),*/
          /* Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onButtonPressed: () {

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        //builder: (context) => CommonScreen(),
                        builder: (context) => AppointmentSumm(),
                      ));
                  */ /*
                  setState(() {
                                    isValidatePressed = true;
                                  });

                                  // CustomValidator(pincodeEditingController
                                  //     .value.text)
                                  //     .validate(Validation.isEmpty) &&
                                  //     _buisinessDropdownmodel.value != 0

                                  if (CustomValidator(pincodeEditingController
                                      .value.text)
                                      .validate(
                                      Validation.isValidPinCode) &&
                                      _buisinessDropdownmodel.value != 0) {
                                    addGoldAddDetails();
                                  }*/ /*
                },
                title: "CONTINUE",
                boxDecoration:
                ButtonStyles.redButtonWithCircularBorder,
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  onChangeBusinessDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {}
}
