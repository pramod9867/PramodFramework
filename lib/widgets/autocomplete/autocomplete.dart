import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfieldwithfocusnode.dart';
import 'package:flutter/material.dart';

typedef OnSelectCallBack = Function(String object);

class AutoCompleteExample<T extends ListOfObject> extends StatelessWidget {
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final AutocompleteOptionToString<T> optionsToString;
  final double scalingFactor;
  final String error;
  final bool isValidatePressed;
  final OnSelectCallBack onSelectCallBack;
  final OnSelectCallBack onSelectMenue;
  final TextEditingController controller;

  GlobalKey<DVTextFieldFocusNodeState> _key = GlobalKey();

  final String textFieldTitle;

  final String hintText;

  AutoCompleteExample(
      {Key? key,
      required this.optionsBuilder,
      required this.optionsToString,
      this.scalingFactor = 0,
      this.textFieldTitle = "",
      this.error = "",
      required this.isValidatePressed,
      this.hintText = "",
      required this.onSelectCallBack,
      required this.controller,required this.onSelectMenue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete(
      key: key,
      displayStringForOption: this.optionsToString,
      optionsBuilder: this.optionsBuilder,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return DVTextFieldFocusNode(
            univerSalController: controller,
            onSelectCallBack: this.onSelectCallBack,
            key: _key,
            errorText: this.error,
            hintText: this.hintText,
            isValidatePressed: this.isValidatePressed,
            title: this.textFieldTitle,
            focusNode: fieldFocusNode,
            outTextFieldDecoration:
                BoxDecorationStyles.outTextFieldBoxDecoration,
            inputDecoration: InputDecorationStyles.inputDecorationTextField,
            controller: fieldTextEditingController);
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: AppColors.white,
            elevation: 5,
            child: Container(
              width: SizeConfig.screenWidth - this.scalingFactor,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                width: 1,
                color: AppColors.white,
              )),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final T option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                      _key.currentState?.widget.controller.text = option.name;
                      this.onSelectMenue(option.name);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(option.name,
                          style: CustomTextStyles.regularMediumFont),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _getErrorText() {
    if (true) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          this.error,
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}

class ListOfObject extends Object {
  final String name;
  final String id;

  ListOfObject(this.name, this.id);
}
