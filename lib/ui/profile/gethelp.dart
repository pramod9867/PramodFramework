import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class GetHelp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GetHelp();
}

class _GetHelp extends State<GetHelp> {
  var isValidatePressed = false;
  TextEditingController queryEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();

  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select problem", 0);

  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;
  List<MasterDataDTO>? genderOptions = [
    new MasterDataDTO("Unable to add applicant", 1),
    new MasterDataDTO("Unable to edit details", 2),
    new MasterDataDTO("Unable to check application status", 3),
    new MasterDataDTO("Unable to check my earnings", 4),
    new MasterDataDTO("Application not uploading", 5),
    new MasterDataDTO("Others", 6),
  ];

  //setting dropdown values
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select problem"}) {
    dropdownMenuItems.add(DropdownMenuItem(
      value: MasterDataDTO(initialType, 0),
      child: Text(
        initialType!,
        style: CustomTextStyles.regularMediumGreyFont1,
      ),
    ));
    for (MasterDataDTO favouriteFoodModel in favouriteFoodModelList) {
      dropdownMenuItems.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(favouriteFoodModel.name!,
            style: model.value == favouriteFoodModel.value
                ? CustomTextStyles.regularMediumFont
                : CustomTextStyles.boldMediumFont),
      ));
    }
    return dropdownMenuItems;
  }

  late List<DropdownMenuItem<MasterDataDTO>> genderList;

  @override
  void initState() {
    genderList = [];
    _genderDropdownlist = _buildFavouriteFoodModelDropdown(
        genderOptions!, genderList, _genderDropdownModel);
    _genderDropdownModel = genderList.elementAt(0).value!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    60 -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          "Need Help?",
                          style: CustomTextStyles.BoldTitileFont,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CustomDropdownMaster<MasterDataDTO>(
                          dropdownMenuItemList: _genderDropdownlist,
                          onChanged: onChangeFavouriteFoodModelDropdown,
                          value: _genderDropdownModel,
                          isEnabled: true,
                          title: "Problem",
                          isTitleVisible: true,
                          errorText: "Please select problem",
                          isValidate: isValidatePressed,
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //   child: DVTextField(
                      //     controller: nameEditingController,
                      //     outTextFieldDecoration:
                      //     BoxDecorationStyles.outTextFieldBoxDecoration,
                      //     inputDecoration:
                      //     InputDecorationStyles.inputDecorationTextField,
                      //     title: "Query",
                      //     hintText: "Please Enter Your Problem",
                      //     errorText: "Type Your Problem Here",
                      //     maxLine: 1,
                      //     isValidatePressed: isValidatePressed,
                      //   ),
                      // )
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //   child: DVTextField(
                //     controller: queryEditingController,
                //     outTextFieldDecoration:
                //         BoxDecorationStyles.outTextFieldBoxDecoration,
                //     inputDecoration:
                //         InputDecorationStyles.inputDecorationTextField,
                //     title: "Query",
                //     hintText: "Describe your issues here ..",
                //     errorText: "Type Your Query Here",
                //     maxLine: 5,
                //     isValidatePressed: isValidatePressed,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: CustomButton(
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });
                      if (_genderDropdownModel.value != 0) {
                        launchMailto(_genderDropdownModel.name!);
                      }
                    },
                    title: "Raise Request",
                    widthScale: 0.9,
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  launchMailto(String message) async {

    final Uri params = Uri(
      scheme: 'mailto',
      path: 'customerqueries@dfltech.co',
      query: 'subject=DhanVarsha B2B App :- ${message}', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      SuccessfulResponse.showScaffoldMessage("Not able to open", context);
      throw 'Could not launch $url';
    }

    // final mailtoLink = Mailto(
    //   to: ['customerqueries@dfltech.co'],
    //   subject:"DFL B2B App: " +message,
    //   body: '',
    // );
    // // Convert the Mailto instance into a string.
    // // Use either Dart's string interpolation
    // // or the toString() method.
    // await launch('$mailtoLink');
  }

  onChangeFavouriteFoodModelDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _genderDropdownModel = favouriteFoodModel!;
        genderList = [];
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            genderOptions!, genderList, _genderDropdownModel);
      });
    }
  }
}
