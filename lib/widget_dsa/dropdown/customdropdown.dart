import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/index.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;
  final bool isEnabled;
  final String title;
  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
    this.title = "Gender",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecorationStyles.outTextFieldBoxDecoration,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Text(
                  this.title,
                  style: CustomTextStyles.regularSmallGreyFont,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    itemHeight: 48,
                    isExpanded: true,
                    icon: Image.asset(DhanvarshaImages.drop6,height: 15,width: 15,color: AppColors.buttonRed,),
                    isDense: true,
                    style: CustomTextStyles.regularMediumDarkFont,
                    items: dropdownMenuItemList,
                    onChanged: onChanged,
                    value: value,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
