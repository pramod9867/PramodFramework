import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DVTextField extends StatefulWidget {
  final BoxDecoration outTextFieldDecoration;
  final String title;
  final int maxLine;
  final InputDecoration inputDecoration;
  final String errorText;
  final String hintText;
  final TextEditingController controller;
  final String type;
  final String value;
  final bool isValidatePressed;
  final TextInputType ktype;
  final List<TextInputFormatter>? formatters;
  final List<TextInputFormatter>? textInpuFormatter;
  final bool isInfoVisible;
  final bool isRsIconVisible;
  final VoidCallback? onInfoPressed;


  const DVTextField(
      {Key? key,
      required this.outTextFieldDecoration,
      this.title = "",
      this.maxLine = 1,
      required this.inputDecoration,
      this.errorText = "",
      this.hintText = "",
      required this.controller,
      this.type = "isEmpty",
      this.isValidatePressed = false,
      this.ktype = TextInputType.text,
        this.textInpuFormatter, this.isInfoVisible=false, this.onInfoPressed, this.isRsIconVisible=false,
  this.value = '', this.formatters})

      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DVTextField();
}

class _DVTextField extends State<DVTextField> {
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: (isValidate || !widget.isValidatePressed)
                  ? widget.outTextFieldDecoration
                  : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.title,
                      style: CustomTextStyles.regularSmallGreyFont,
                    ),
                  ),
                  TextFormField(
                    onChanged: (text) {
                      print("on Change Text Called");
                      setState(() {
                        isValidate =
                            CustomValidator(widget.controller.value.text)
                                .validate(widget.type);
                      });
                    },
                    //inputFormatters: widget.formatters,
                    //initialValue: widget.value != null ? widget.value:"xyz",
                    inputFormatters: widget.textInpuFormatter,

                    maxLines: widget.maxLine,
                    controller: widget.controller,
                    keyboardType: widget.ktype,
                    style: CustomTextStyles.regularMediumFont,
                    cursorColor: AppColors.black,
                    decoration: InputDecoration(
                      isDense:
                          true, // this will remove the default content padding
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            (isValidate || !widget.isValidatePressed)
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
          style: CustomTextStyles.boldsmallRedFont,
        ),
      );
    } else {
      return Container();
    }
  }
}
