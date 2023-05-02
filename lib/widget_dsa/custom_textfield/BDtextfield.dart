import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/registration/basicdetails/BasicDetails.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BDtextfield extends StatefulWidget {
  final BoxDecoration outTextFieldDecoration;
  final String title;
  final int maxLine;
  final InputDecoration inputDecoration;
  final String errorText;
  final String hintText;
  final TextEditingController controller;
  final String type;
  final bool isValidatePressed;
  final List<TextInputFormatter>? textInpuFormatter;
  final TextInputType keyboardtype;
  final bool isInfoVisible;
  final bool isRsIconVisible;
  final VoidCallback? onInfoPressed;
   const BDtextfield(
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
      this.keyboardtype = TextInputType.text,
      this.textInpuFormatter, this.isInfoVisible=false, this.onInfoPressed, this.isRsIconVisible=false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BDtextfield();
}

class _BDtextfield extends State<BDtextfield> {
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
              padding: EdgeInsets.symmetric(horizontal: 0),
              decoration: (isValidate || !widget.isValidatePressed)
                  ? widget.outTextFieldDecoration
                  : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        widget.isRsIconVisible?Image.asset(DhanvarshaImages.rupee,height: 15,width: 15,):Container(),
                        Flexible(
                          child: TextFormField(
                            onChanged: (text) {
                              print("on Change Text Called");
                              setState(() {
                                isValidate = CustomValidator(
                                        widget.controller.value.text)
                                    .validate(widget.type);

                              });
                            },
                            inputFormatters: widget.textInpuFormatter,
                            maxLines: widget.maxLine,
                            controller: widget.controller,
                            style: CustomTextStyles.regularMediumFont,
                            cursorColor: AppColors.black,
                            keyboardType: widget.keyboardtype,
                            decoration: InputDecoration(
                              isDense:
                                  true, // this will remove the default content padding
                              hintText: widget.hintText,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 3),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        widget.isInfoVisible?GestureDetector(
                          onTap: widget.onInfoPressed,
                          child: Image.asset(DhanvarshaImages.i,height: 20,width: 20,),
                        ):Container()
                      ],
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
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
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
