import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum ImagePickerStatus { Uploaded, IsNewUploaded }

class MultipleFileUploader extends StatefulWidget {
  final String title;
  final String descr;
  final String imageaddText;
  final bool isPasswordProtected;
  final bool isDropdownShow;
  final Widget? dropdown;
  final bool? isBankStatements;

  const MultipleFileUploader({
    Key? key,
    this.title = "Add Bank Statement",
    this.descr =
        "Provide e-statement in PDF format.scanned bank statements are not valid.",
    this.imageaddText = "Bank Statement Added",
    this.isPasswordProtected = true,
    this.isDropdownShow = false,
    this.dropdown, this.isBankStatements=false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MultipleFilerUploaderState();
}

class MultipleFilerUploaderState extends State<MultipleFileUploader> {
  int count = 1;
  TextEditingController pdfPassword = TextEditingController();
  ValueNotifier<List<String>> imagepicked = ValueNotifier([]);
  bool isSwitchPressed = false;
  List<String>? originalImages = [];

//  final List<FavouriteFoodModel> _favouriteFoodModelList = [
//    FavouriteFoodModel(foodName: "Retail and Wholesale", calories: 110),
//    FavouriteFoodModel(foodName: "Retail", calories: 110),
//  ];

//  FavouriteFoodModel _favouriteFoodModel = FavouriteFoodModel();
//  late List<DropdownMenuItem<FavouriteFoodModel>>
//      _favouriteFoodModelDropdownList;

//  List<DropdownMenuItem<FavouriteFoodModel>> _buildFavouriteFoodModelDropdown(
//      List favouriteFoodModelList) {
//    List<DropdownMenuItem<FavouriteFoodModel>> items = [];
//    for (FavouriteFoodModel favouriteFoodModel in favouriteFoodModelList) {
//      items.add(DropdownMenuItem(
//        value: favouriteFoodModel,
//        child: Text(
//          favouriteFoodModel.foodName!!,
//          style: CustomTextStyles.regularMediumFont,
//        ),
//      ));
//    }
//    return items;
//  }

//  onChangeFavouriteFoodModelDropdown(FavouriteFoodModel? favouriteFoodModel) {
//    setState(() {
//      _favouriteFoodModel = favouriteFoodModel!;
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _favouriteFoodModelDropdownList =
//        _buildFavouriteFoodModelDropdown(_favouriteFoodModelList!);
//    _favouriteFoodModel = _favouriteFoodModelList![0];
//  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, List<String> hasError, child) {
          if (imagepicked.value.length <= 0) {
            return _getHoirzontalImageUpload();
          } else {
            return _getUploadedUI();
          }
        });
  }

  List<String> _getMultipleFiles() {
    List<String> myWidgets = [];
    for (int i = 0; i < imagepicked.value.length; i++) {
      myWidgets.add(imagepicked.value[i]);
    }

    return myWidgets;
  }

  Widget _getUploadedCard() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            DhanvarshaImages.tickmrk,
            fit: BoxFit.contain,
            height: 35,
            width: 35,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    );
  }

  Widget _getUploadedUI() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
          width: SizeConfig.screenWidth - 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.imageaddText,
                  style: CustomTextStyles.boldMediumFont,
                ),
              ),

              widget.isDropdownShow ? widget.dropdown! : Container(),
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: imagepicked.value.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return _getUploadedCard();
                  }),

//              widget.isDropdownShow?Container(
//                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
//                  child: CustomDropdown(
//                    dropdownMenuItemList: _favouriteFoodModelDropdownList,
//                    onChanged: onChangeFavouriteFoodModelDropdown,
//                    value: _favouriteFoodModel,
//                    isEnabled: true,
//                    title: "Select Document",
//                  )):Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(DhanvarshaImages.uploadnew),
                  GestureDetector(
                    onTap: () {
                      ImagePickerUtils.openMultipleFilePicker(
                          context,
                          (result) => {
                                if (imagepicked.value.length == 0)
                                  {
                                    imagepicked.value =
                                        result.paths.cast<String>(),
                                    imagepicked.notifyListeners()
                                  }
                                else
                                  {
                                    imagepicked.value
                                        .addAll(result.paths.cast<String>()),
                                    imagepicked.notifyListeners()
                                  }
                              },
                      isBankStatements: widget.isBankStatements!,
                      );
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "UPLOAD",
                        style: CustomTextStyles.boldMediumRedFont,
                      ),
                    ),
                  )
                ],
              ),
              widget.isPasswordProtected
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(),
                    )
                  : Container(),
              widget.isPasswordProtected
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Password Protected",
                                style: CustomTextStyles.boldLargeFonts,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Is the pdf password protected?",
                                      style: CustomTextStyles
                                          .regularMedium2GreyFont1,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlutterSwitch(
                                  width: 55,
                                  height: 35,
                                  activeColor: AppColors.buttonRed,
                                  value: isSwitchPressed,
                                  onToggle: (value) {
                                    setState(() {
                                      isSwitchPressed = value;
                                    });
                                    print(value);
                                  },
                                ),
                              ])
                        ],
                      ),
                    )
                  : Container(),
              _getTextField()
            ],
          )),
    );
  }

  Widget _getTextField() {
    bool getValue = isSwitchPressed;
    return getValue
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DVTextField(
              controller: pdfPassword,
              outTextFieldDecoration:
                  BoxDecorationStyles.outTextFieldBoxDecorationWithBlack,
              inputDecoration: InputDecorationStyles.inputDecorationTextField,
              title: "Password",
              hintText: "Please Enter PDF Password",
              errorText: "Please Enter Valid PDF Password",
              maxLine: 1,
              isValidatePressed: true,
            ),
          )
        : Container();
  }

  Widget _getHoirzontalImageUpload() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
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
                child: Image.asset(DhanvarshaImages.poa),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),
            ),
            Text(
              widget.title,
              style: CustomTextStyles.boldLargeFonts,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Text(
                widget.descr,
                style: CustomTextStyles.regularMediumGreyFont1,
                textAlign: TextAlign.center,
              ),
            ),
            widget.isDropdownShow ? widget.dropdown! : Container(),
//            widget.isDropdownShow
//                ? Container(
//                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                    child: CustomDropdown(
//                      dropdownMenuItemList: _favouriteFoodModelDropdownList,
//                      onChanged: onChangeFavouriteFoodModelDropdown,
//                      value: _favouriteFoodModel,
//                      isEnabled: true,
//                      title: "Select Document",
//                    ))
//                : Container(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(DhanvarshaImages.uploadnew),
                GestureDetector(
                  onTap: () {
                    ImagePickerUtils.openMultipleFilePicker(
                        context,
                        (result) => {
                              if (imagepicked.value.length == 0)
                                {
                                  imagepicked.value =
                                      result.paths.cast<String>(),
                                }
                              else
                                {
                                  imagepicked.value
                                      .addAll(result.paths.cast<String>())
                                }
                            },
                    isBankStatements: widget.isBankStatements!,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "UPLOAD",
                      style: CustomTextStyles.boldMediumRedFont,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
