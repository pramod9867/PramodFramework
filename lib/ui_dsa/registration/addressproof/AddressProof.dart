import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/registration/bankdetail/BankDetails.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/buttonstyles.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widget_dsa/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressProof extends StatefulWidget {
  const AddressProof({Key? key, required BuildContext context})
      : super(key: key);

  @override
  _AddressProofState createState() => _AddressProofState();
}

class _AddressProofState extends State<AddressProof> {
  TextEditingController typeofDEditingController = new TextEditingController();
  GlobalKey<CustomImageBuilderState> _key1 = GlobalKey();
  GlobalKey<CustomImageBuilderState> _key2 = GlobalKey();

  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Electricity Bill", calories: 110),
    FavouriteFoodModel(foodName: "Phone Bill", calories: 110),
    FavouriteFoodModel(foodName: "Gas Bill", calories: 110),
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
  }

  var isValidatePressed = false;

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        DhanvarshaImages.bck,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth / 4,
                      ),
                      Text(
                        'PROOF OF ADDRESS',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Your Business Proof of Address',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //   child: DVTextField(
                //     controller: typeofDEditingController,
                //     outTextFieldDecoration:
                //         BoxDecorationStyles.outTextFieldBoxDecoration,
                //     inputDecoration:
                //         InputDecorationStyles.inputDecorationTextField,
                //     title: "Type of Document",
                //     hintText: "Electricity Bill",
                //     errorText: "Type Your Query Here",
                //     maxLine: 1,
                //     isValidatePressed: isValidatePressed,
                //   ),
                // ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: CustomDropdown(
                      dropdownMenuItemList: _favouriteFoodModelDropdownList,
                      onChanged: onChangeFavouriteFoodModelDropdown,
                      value: _favouriteFoodModel,
                      isEnabled: true,
                      title: "Type of Document",
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Document',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _getHoirzontalImageUpload(
                        _key1,
                        DhanvarshaImages.pin,
                        '',
                      ),
                      // Container(
                      //   height: SizeConfig.screenHeight * 0.100,
                      //   width: SizeConfig.screenWidth / 3,
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.rectangle,
                      //       border:
                      //           Border.all(width: 2, color: Colors.red.shade800),
                      //       borderRadius: BorderRadius.all(Radius.circular(0))),
                      //   child: Center(
                      //     child: Image.asset(
                      //       DhanvarshaImages.pin,
                      //       fit: BoxFit.fill,
                      //       width: SizeConfig.screenWidth,
                      //     ),
                      //   ),
                      // ),
                      // Text(
                      //   '',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Divider(color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        DhanvarshaImages.tick,
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'Electricity bill is not on my name',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Image.asset(
                        DhanvarshaImages.question,
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Rental Agreement',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Document',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _getHoirzontalImageUpload(
                            _key2,
                            DhanvarshaImages.pin,
                            '',
                          ),
                          // Container(
                          //   height: SizeConfig.screenHeight * 0.100,
                          //   width: SizeConfig.screenWidth / 3,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.rectangle,
                          //       border: Border.all(
                          //           width: 2, color: Colors.red.shade800),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(0))),
                          //   child: Center(
                          //     child: Image.asset(
                          //       DhanvarshaImages.pin,
                          //       fit: BoxFit.fill,
                          //       width: SizeConfig.screenWidth,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: CustomButton(
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BankDetails(
                                  context: context,
                                )),
                      );
                    },
                    title: "CONTINUE",
                    boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHoirzontalImageUpload(Key key, String card1, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageBuilder(
          key: key,
          image: card1,
          value: value,
        ),
      ],
    );
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
