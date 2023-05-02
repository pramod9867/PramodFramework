import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/dateutils/dateutils.dart';
import 'package:dhanvarsha/utils_dsa/index.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isValidateUser;
  final String selectedDate;

  const CustomDatePicker(
      {Key? key,
        required this.controller,
        this.title = "Please Select Date",
        required this.isValidateUser,
        this.selectedDate = ""})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late String selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate:   DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateUtilsGeneric.convertToMMMdyyyyFormat(picked);
      });
    widget.controller.text = selectedDate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.selectedDate == ""
        ? DateUtilsGeneric.dateMessage
        : widget.selectedDate;
  }

  String getCurrectDate(DateTime time) {
    if (selectedDate == "") {
      return DateUtilsGeneric.dateMessage;
    } else {
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: (DateUtilsGeneric.dateMessage == selectedDate &&
                  widget.isValidateUser)
                  ? BoxDecorationStyles.outTextFieldBoxErrorDecoration
                  : BoxDecorationStyles.outTextFieldBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical:6,),
                    child: Text(
                      widget.title,
                      style: CustomTextStyles.regularSmallGreyFont,
                    ),
                  ),
                 Container(
                   margin: EdgeInsets.symmetric(vertical: 2),
                   child:  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         child: Text(
                           selectedDate,
                           style: selectedDate==DateUtilsGeneric.dateMessage?CustomTextStyles.regularMediumGreyFont1:CustomTextStyles.regularMediumFont,
                         ),
                       ),
                       Container(
                         child: Image.asset(DhanvarshaImages.calendar,height: 20,width: 20,),
                       )
                     ],
                   ),
                 ),
                ],
              ),
            ),
            _getErrorMessage()
          ],
        ));
  }

  Widget _getErrorMessage() {
    if ((DateUtilsGeneric.dateMessage == selectedDate &&
        widget.isValidateUser)) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          "Please Select Valid Date",
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}
