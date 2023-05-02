import 'package:dhanvarsha/bloc/customerdetailsbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/model/Pincodeverification.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DVApiTextField extends StatefulWidget {
  final BoxDecoration outTextFieldDecoration;
  final CustomerDetailsBloc? genericbloc;
  final String title;
  final int maxLine;
  final InputDecoration inputDecoration;
  final String errorText;
  final String hintText;
  final bool isTitleVisible;
  final TextEditingController controller;
  final Validation type;
  final TextInputType textInputType;
  final bool isValidatePressed;
  final List<TextInputFormatter>? textInpuFormatter;
  const DVApiTextField(
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
      this.textInpuFormatter,
      this.genericbloc,
      this.isTitleVisible = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DVApiTextFieldState();
}

class _DVApiTextFieldState extends State<DVApiTextField> {
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
    print("generic bloc is");
    print(widget.genericbloc!.connectionStatusLiveData.value!);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical:
                    (widget.isTitleVisible && widget.controller.text.length > 0)
                        ? 2
                        : 11),
            decoration: (isValidate || !widget.isValidatePressed)
                ? widget.outTextFieldDecoration
                : BoxDecorationStyles.outTextFieldBoxErrorDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (widget.isTitleVisible && widget.controller.text.length > 0)
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.title,
                          style: CustomTextStyles.regularSmallGreyFont,
                        ),
                      )
                    : Container(),
                TextField(
                  // enableInteractiveSelection: false,
                  keyboardType: widget.textInputType,
                  onChanged: (text) {
                    if (text.length == 6) {
                      PinCodeDTO pincodeDTO = PinCodeDTO(pincode: text);
                      widget.genericbloc?.VerifyPinNew(
                          pincodeDTO.toEncodedJsonJson(), context);
                    }
                    setState(() {
                      isValidate = CustomValidator(widget.controller.value.text)
                          .validate(widget.type);
                    });
                  },
                  inputFormatters: widget.textInpuFormatter,
                  maxLines: widget.maxLine,
                  controller: widget.controller,
                  style: CustomTextStyles.regularMediumFontGothamTextField,
                  cursorColor: AppColors.black,
                  decoration: InputDecoration(
                      isDense:
                          true, // this will remove the default content padding
                      hintText: widget.hintText,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: AppColors.lightGrey3)),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: widget.genericbloc!.connectionStatusLiveData,
              builder: (BuildContext context,
                  NetworkCallConnectionStatus hasError, child) {
                if (NetworkCallConnectionStatus.completedSuccessfully ==
                    widget.genericbloc!.connectionStatusLiveData.value) {
                  return (widget
                              .genericbloc!.pinverificationresponse!.message ==
                          "Pincode exist")
                      ? _getErrorText(
                          widget.genericbloc!.pinverificationresponse!.message!,
                          false)
                      : _getErrorText(
                          widget.genericbloc!.pinverificationresponse!.message!,
                          true);
                } else {
                  return (isValidate || !widget.isValidatePressed)
                      ? Container()
                      : Container(
                          child: _getErrorText(widget.errorText, true),
                        );
                }
              })
        ],
      ),
    );
  }

  _getErrorText(String message, bool status) {
    if (status) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          message,
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}
