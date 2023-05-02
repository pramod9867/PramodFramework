import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/addp/AddPr.dart';
import 'package:dhanvarsha/ui/goldloan/businessproof/add_businessproof.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class KycDocuments extends StatefulWidget {
  final String? date;
  final String? time;
  const KycDocuments({Key? key, this.date = "", this.time = ""})
      : super(key: key);
  @override
  _KycDocumentsState createState() => _KycDocumentsState();
}

class _KycDocumentsState extends State<KycDocuments> {
  TextEditingController dateController = new TextEditingController();
  late List<DropdownMenuItem<MasterDataDTO>> buisinessFirmTypeList;
  MasterDataDTO _buisinessDropdownmodel =
      MasterDataDTO("Select entity type", 0);

  bool isDocsUploaded = false;

  @override
  void initState() {
    super.initState();
    buisinessFirmTypeList = [];
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: SingleChildScrollView(
        child: _getNewBLBody(),
      ),
      context: context,
      isheaderShown: true,
      isBackPressed: true,
      type: false,
      isBurgerVisble: true,
    );
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
            "KYC Documents",
            style: CustomTextStyles.boldVeryLargerFont2Gotham,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              "Kindly upload the following\ndocuments",
              style: CustomTextStyles.regularMediumGreyFontGotham,
            ),
          ),

          /*Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  DhanvarshaImages.activeLoan,
                  height: 35,
                  width: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Identity Proof",style: CustomTextStyles.boldLargeFonts,),
                    Text("Mandatory for KYC",style: CustomTextStyles.regularLightBoxsmalleFonts,),
                    Text("verification",style: CustomTextStyles.regularLightBoxsmalleFonts,),


                  ],
                ),
                Image.asset(
                  DhanvarshaImages.drop6,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),*/
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => CommonScreen(),
                    builder: (context) => AddPr(
                      time: widget.time,
                      date: widget.date,
                    ),
                    //builder: (context) => ApplicationRec(),
                  ));

              setState(() {
                isDocsUploaded = result;
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              //height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isDocsUploaded
                      ? Image.asset(
                          DhanvarshaImages.tickmrk,
                          height: 45,
                          width: 45,
                        )
                      : Image.asset(
                          DhanvarshaImages.ap,
                          height: 45,
                          width: 45,
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          "Address Proof",
                          style: CustomTextStyles.boldLargeFonts,
                        ),
                      ),
                      Text(
                        "Mandatory for KYC",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                      Text(
                        "verification",
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
          ),
          !(CustomerOnBoarding.ModeOfSalary.toUpperCase() == "SALARIED")
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          //builder: (context) => CommonScreen(),
                          builder: (context) => AddBusinessProof(
                            time: widget.time!,
                            date: widget.date!,
                          ),
                          //builder: (context) => ApplicationRec(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    //height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          DhanvarshaImages.ap,
                          height: 45,
                          width: 45,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                "Business Proof",
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                            ),
                            Text(
                              "Mandatory for KYC",
                              style:
                                  CustomTextStyles.regularLightBoxsmalleFonts,
                            ),
                            Text(
                              "verification",
                              style:
                                  CustomTextStyles.regularLightBoxsmalleFonts,
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
                )
              : Container(),
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
                        builder: (context) => KycDocuments(),
                      ));
                  */ /* setState(() {
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
