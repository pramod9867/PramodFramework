import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class CustomDropdownMaster<T extends MasterDataDTO> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;
  final String errorText;
  final bool isEnabled;
  final bool isValidate;
  final String title;
  final bool isTitleVisible;
  CustomDropdownMaster({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
    this.title = "Gender",
    this.isTitleVisible = true,
    this.isValidate = false, this.errorText="",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Value is");
    print(this.value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          
            width: SizeConfig.screenWidth,
            decoration: (!this.isValidate||this.value.value!=0)
                ? BoxDecorationStyles.outTextFieldBoxDecoration
                : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 10, vertical: this.isTitleVisible ? 5 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (this.isTitleVisible && this.value.value != 0)
                      ? Text(
                    this.title,
                    style: CustomTextStyles.regularSmallGreyFontGotham,
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
                        hint: Text(this.title),
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
                  ),

                ],
              ),
            )),
        (!isValidate || this.value.value!=0)
        ? Container()
            : _getErrorText()
      ],
    );
  }

  _getErrorText() {
    if (true) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          this.errorText,
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}
