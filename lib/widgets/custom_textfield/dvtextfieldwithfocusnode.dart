import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/widgets/autocomplete/autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DVTextFieldFocusNode extends StatefulWidget {
  final BoxDecoration outTextFieldDecoration;
  final String title;
  final OnSelectCallBack onSelectCallBack;
  final int maxLine;
  final InputDecoration inputDecoration;
  final String errorText;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Validation type;
  final TextInputType textInputType;
  final bool isValidatePressed;
  final TextEditingController univerSalController;
  const DVTextFieldFocusNode(
      {Key? key,
      required this.outTextFieldDecoration,
      this.title = "",
      this.maxLine = 1,
      required this.inputDecoration,
      this.errorText = "",
      this.hintText = "",
      required this.controller,
      this.type = Validation.isEmpty,
      this.isValidatePressed = false,
      this.textInputType = TextInputType.text,
      required this.focusNode,
      required this.onSelectCallBack,
      required this.univerSalController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => DVTextFieldFocusNodeState();
}

class DVTextFieldFocusNodeState extends State<DVTextFieldFocusNode> {
  var isValidate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isValidate =
        CustomValidator(widget.controller.value.text).validate(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("BUild is Calling");
    return Container(
      width: double.infinity,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: (isValidate || !widget.isValidatePressed)
                  ? widget.outTextFieldDecoration
                  : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                          child: TextField(
                        // enableInteractiveSelection: false,
                        focusNode: widget.focusNode,
                        keyboardType: widget.textInputType,
                        onChanged: (text) {
                          print("on Change Text Called");
                          setState(() {
                            isValidate =
                                CustomValidator(widget.controller.value.text)
                                    .validate(widget.type);
                          });
                          widget.onSelectCallBack(widget.controller.value.text);
                        },
                        maxLines: widget.maxLine,
                        controller: widget.controller,
                        style: CustomTextStyles.regularMediumFont,
                        cursorColor: AppColors.black,
                        decoration: InputDecoration(
                            isDense:
                                true, // this will remove the default content padding
                            hintText: widget.hintText,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 3),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.lightGrey3)),
                      )),
                      Image.asset(
                        DhanvarshaImages.drop6,
                        height: 15,
                        width: 15,
                        color: AppColors.buttonRed,
                      )
                    ],
                  ),
                ],
              ),
            ),
            (isValidate ||
                    !widget.isValidatePressed ||
                    widget.controller.text == null)
                ? Container()
                : _getErrorText()
          ],
        ),
      ),
    );
  }

  _getErrorText() {
    if (true) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          widget.errorText,
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}
