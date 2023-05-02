import 'package:dhanvarsha/bloc/customerdetailsbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef onChangedText(String text);

class DVTextField extends StatefulWidget {
  final BoxDecoration outTextFieldDecoration;
  final CustomerDetailsBloc? genericbloc;
  final bool? obsureText;
  final String title;
  final ValueChanged<String>? onFieldSubmit;
  final ValueChanged<String>? onChangedText;
  final bool? isApiDropdown;
  final bool? isEnable;
  final int? maxLine;
  final bool isFlag;
  final VoidCallback? onSearchPressed;
  final InputDecoration inputDecoration;
  final String errorText;
  final String image;
  final bool isCalendarIcon;
  final String hintText;
  final TextEditingController controller;
  final Validation type;
  final TextInputType textInputType;
  final bool isValidatePressed;
  final List<TextInputFormatter>? textInpuFormatter;
  final bool isTitleVisible;
  final bool is91;
  final bool isSearchIcon;
  final bool onEnterPressRequired;

  const DVTextField({
    Key? key,
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
    this.textInpuFormatter,
    this.genericbloc,
    this.isTitleVisible = true,
    this.isFlag = false,
    this.image = DhanvarshaImages.flag,
    this.is91 = false,
    this.isSearchIcon = false,
    this.onSearchPressed,
    this.onFieldSubmit,
    this.onEnterPressRequired = false,
    this.onChangedText,
    this.isApiDropdown = false,
    this.isEnable = true,
    this.obsureText = false,
    this.isCalendarIcon = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DVTextField();
}

class _DVTextField extends State<DVTextField> {
  var isValidate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("INIT CALLED");
    isValidate =
        CustomValidator(widget.controller.value.text).validate(widget.type);
  }

  // @override
  // void didUpdateWidget(covariant DVTextField oldWidget) {
  //   print("DID UPDATE WIDGET CALLED");
  //   if (oldWidget.controller.value.text != widget.controller.value.text) {
  //     isValidate =
  //         CustomValidator(widget.controller.value.text).validate(widget.type);
  //   }
  //
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, snackBarBuilder, _) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: (widget.isTitleVisible &&
                                  widget.controller.text.length > 0)
                              ? 2
                              : 11),
                      decoration: (CustomValidator(widget.controller.value.text)
                                  .validate(widget.type) ||
                              !widget.isValidatePressed)
                          ? widget.outTextFieldDecoration
                          : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (widget.isTitleVisible &&
                                  widget.controller.text.length > 0)
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    widget.title,
                                    style:
                                        CustomTextStyles.regularSmallGreyFontGotham,
                                  ),
                                )
                              : Container(),
                          Row(
                            children: [
                              widget.isFlag
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            child: Image.asset(
                                              widget.image,
                                              height: !widget.is91 ? 10 : 15,
                                              width: !widget.is91 ? 10 : 15,
                                            ),
                                          ),
                                          !widget.is91
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Text(
                                                    "|",
                                                    style: CustomTextStyles
                                                        .regularMediumFontGothamTextField,
                                                  ),
                                                )
                                              : Text(""),
                                        ],
                                      ))
                                  : Container(),
                              widget.is91
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "+91 |",
                                        style:
                                            CustomTextStyles.regularMediumFontGothamTextField,
                                      ))
                                  : Container(),
                              // widget.isFlag?Container(
                              //     margin: EdgeInsets.symmetric(horizontal: 0),
                              //     child:
                              //     Text("| ",style: CustomTextStyles.regularMediumFont,)
                              // ):Container(),
                              widget.onEnterPressRequired
                                  ? Flexible(
                                      child: TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            isValidate = CustomValidator(widget
                                                    .controller.value.text)
                                                .validate(widget.type);
                                          });
                                          widget.onChangedText!(text);
                                        },
                                        obscureText: widget.obsureText!,
                                        enabled: widget.isEnable,
                                        keyboardType: widget.textInputType,
                                        // enableInteractiveSelection: false,
                                        inputFormatters:
                                            widget.textInpuFormatter,
                                        maxLines: widget.maxLine,
                                        controller: widget.controller,
                                        style:
                                            CustomTextStyles.regularMediumFontGothamTextField,
                                        cursorColor: AppColors.black,
                                        onSubmitted: widget.onFieldSubmit,
                                        decoration: InputDecoration(
                                          isDense:
                                              true, // this will remove the default content padding
                                          hintText: widget.hintText,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 3),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.lightGrey3),
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: TextField(
                                        // enableInteractiveSelection: false,
                                        enabled: widget.isEnable,
                                        keyboardType: widget.textInputType,
                                        onChanged: (text) {
                                          setState(() {
                                            isValidate = CustomValidator(widget
                                                    .controller.value.text)
                                                .validate(widget.type);
                                          });
                                        },
                                        inputFormatters:
                                            widget.textInpuFormatter,
                                        maxLines: widget.maxLine,
                                        controller: widget.controller,
                                        style:
                                            CustomTextStyles.regularMediumFontGothamTextField,
                                        cursorColor: AppColors.black,
                                        obscureText: widget.obsureText!,
                                        decoration: InputDecoration(
                                          isDense:
                                              true, // this will remove the default content padding
                                          hintText: widget.hintText,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 5),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: AppColors.lightGrey3),
                                        ),
                                      ),
                                    ),

                              widget.isSearchIcon
                                  ? GestureDetector(
                                      onTap: widget.onSearchPressed,
                                      child: Image.asset(
                                        widget.image,
                                        height: 25,
                                        width: 25,
                                      ),
                                    )
                                  : Container(),
                              widget.isCalendarIcon
                                  ? GestureDetector(
                                      onTap: widget.onSearchPressed,
                                      child: Image.asset(
                                        widget.image,
                                        height: 22,
                                        width: 22,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ],
                      ),
                    ),
                    (!widget.isValidatePressed ||
                            CustomValidator(widget.controller.value.text)
                                .validate(widget.type))
                        ? Container()
                        : _getErrorText()
                  ],
                ),
              );
            }));
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
