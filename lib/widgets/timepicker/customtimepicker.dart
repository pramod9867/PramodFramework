import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
// import 'package:dhanvarsha/ui/goldloan/salaried/book_appointment_page.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dateutils/dateutils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isValidateUser;
  final String selectedDate;
  final bool isTitleVisible;
  final String calIcon;

  const CustomTimePicker(
      {Key? key,
      required this.controller,
      this.title = "Please Select Date",
      this.calIcon = DhanvarshaImages.cal,
      required this.isValidateUser,
      this.selectedDate = "",
      this.isTitleVisible = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  //late String selectedDate;
  //late double _height;
  //late double _width;

  //late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

//  DateTime selectedDate = DateTime.now();

  String selectedTime = "";
  //TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null)
      setState(() {
        selectedTime = picked.format(context);
        // _hour = selectedTime.hour.toString();
        // _minute = selectedTime.minute.toString();
        //  _time = _hour + ' : ' + _minute;
        widget.controller.text = selectedTime;
        //_time=DateFormat("h:mm:a") as String;
        //DateFormat("h:mma").format(date);
        // print(DateTime.parse(widget.controller.text));
        //widget.controller.text = getFormattedDate(
        // DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
        //[hh, ':', nn, " ", am]).toString();
      });
  }

  /*Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1988, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        // selectedDate = DateUtilsGeneric.convertToMMMdyyyyFormat(picked);
        selectedDate = DateUtilsGeneric.convertToMMddyyyyFormat(picked);
      });
    widget.controller.text = selectedDate;
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedTime =
        widget.selectedDate == "" ? widget.title : widget.selectedDate;
  }

  /* String getCurrectDate(DateTime time) {
    if (selectedDate == "") {
      return widget.title;
    } else {
      return selectedDate;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _selectTime(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical:
                  widget.isTitleVisible && (widget.title != selectedTime)
                      ? 0
                      : 10),
              decoration:
                  (widget.title == selectedTime && widget.isValidateUser)
                      ? BoxDecorationStyles.outTextFieldBoxErrorDecoration
                      : BoxDecorationStyles.outTextFieldBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isTitleVisible && (widget.title != selectedTime)
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              vertical: widget.title != selectedTime ? 5 : 10),
                          child: Text(
                            widget.title,
                            style: CustomTextStyles.regularSmallGreyFont,
                          ),
                        )
                      : Container(),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: widget.isTitleVisible ? 2 : 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              selectedTime,
                              style: !(widget.title != selectedTime)
                                  ? CustomTextStyles.regularMediumGreyFont1
                                  : CustomTextStyles.regularMediumFont,
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              widget.calIcon,
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            _getErrorMessage()
          ],
        ));
  }

  Widget _getErrorMessage() {
    if ((widget.title == selectedTime && widget.isValidateUser)) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          "Please Select Valid Time",
          style: CustomTextStyles.boldsmallRedFontGotham,
        ),
      );
    } else {
      return Container();
    }
  }
}
