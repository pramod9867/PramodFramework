import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;
  final bool isEnabled;
  final String title;
  final bool isTitleVisible;
  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
    this.title = "Gender",
    this.isTitleVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    print("Value is");
    print(this.value);
    return Container(
        // color: AppColors.blue,
        width: SizeConfig.screenWidth,
        decoration:BoxDecorationStyles.outTextFieldBoxDecoration,
        child: Container(
        
          margin: EdgeInsets.symmetric(
              horizontal: 10, vertical: this.isTitleVisible ? 5 : 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             ( this.isTitleVisible&&this.value!=0)
                  ? Text(
                      this.title,
                      style: CustomTextStyles.regularSmallGreyFont,
                    )
                  : Container(),
              Container(
    
                padding: EdgeInsets.symmetric(vertical: 5),
                child: DropdownButtonHideUnderline(
              
                  child: DropdownButton(
                  
                    onTap: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                        currentFocus.focusedChild!.unfocus();
                      }
                    },
                    iconEnabledColor: AppColors.buttonRed,
                    itemHeight: 48,
                    isExpanded: true,
                    icon: Image.asset(
                      DhanvarshaImages.drop6,
                      height: 15,
                      width: 15,
                      color: AppColors.buttonRed,
                    ),
                  
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
