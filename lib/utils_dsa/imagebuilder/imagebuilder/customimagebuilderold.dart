import 'dart:io';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/imagepicker.dart';
import 'package:dhanvarsha/utils_dsa/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageBuilder extends StatefulWidget {
  final String value;
  final String image;
  const CustomImageBuilder(
      {Key? key, this.value = "Front View", this.image = DhanvarshaImages.pan})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomImageBuilderState();
}

class CustomImageBuilderState extends State<CustomImageBuilder> {
  ValueNotifier<String> imagepicked = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imagepicked,
        builder: (BuildContext context, String hasError, child) {
          if (imagepicked.value == '') {
            return Container(
              child: _getHoirzontalImageUpload(),
            );
          } else {
            return Container(child: _getFilemageUpload());
          }
          ;
        });
  }

  Widget _getHoirzontalImageUpload() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ImagePickerUtils.showDialogUtil(context,
                  (imageFile) => {imagepicked.value = imageFile!.path});
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.buttonRed),
              ),
              child: Image.asset(widget.image),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          Text(
            widget.value,
            style: CustomTextStyles.regularMediumFont,
          )
        ],
      ),
    );
  }

  Widget _getFilemageUpload() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ImagePickerUtils.showDialogUtil(context,
                  (imageFile) => {imagepicked.value = imageFile!.path});
            },
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.buttonRed),
              ),
              child: Image.file(
                File(imagepicked.value),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
          Text(
            "Front View",
            style: CustomTextStyles.regularsmalleFonts,
          )
        ],
      ),
    );
  }
}
