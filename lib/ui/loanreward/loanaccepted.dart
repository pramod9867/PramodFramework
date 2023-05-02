import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:flutter/material.dart';

class CurrentAddressProof extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrentAddressProofState();
}

class _CurrentAddressProofState extends State<CurrentAddressProof> {
  GlobalKey<CustomImageBuilderState> _Idkey = GlobalKey();
  final List<FavouriteFoodModel> _favouriteFoodModelList = [
    FavouriteFoodModel(foodName: "Electricity Bill", calories: 110),
    FavouriteFoodModel(foodName: "Ration Card", calories: 110),
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
          favouriteFoodModel.foodName!,
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

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "ADDRESS PROOF",
        type: false,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _getTitleCompoenent(),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: CustomDropdown(
                      dropdownMenuItemList: _favouriteFoodModelDropdownList,
                      onChanged: onChangeFavouriteFoodModelDropdown,
                      value: _favouriteFoodModel,
                      isEnabled: true,
                      title: "Addreess Proof",
                    )),
                _getHoirzontalImageUpload1(),
                CustomButton(
                  onButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployementProof(),
                      ),
                    );
                  },
                  title: "Continue",
                )
              ],
            )),
        context: context);
  }

  Widget _getTitleCompoenent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Current Address Proof",
            style: CustomTextStyles.boldLargeFonts,
          ),
        ),
        // Image.asset(
        //   DhanvarshaImages.i,
        //   height: 25,
        //   width: 25,
        // )
      ],
    );
  }

  Widget _getHoirzontalImageUpload1() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Address Proof",
            style: CustomTextStyles.regularMediumFont,
          ),
          Row(
            children: [
              CustomImageBuilder(
                key: _Idkey,
                image: DhanvarshaImages.pinNew,
                value: "Address Proof",
              ),
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
