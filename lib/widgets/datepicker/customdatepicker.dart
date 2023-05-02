import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/dateutils/dateutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isValidateUser;
  final String selectedDate;
  final bool isTitleVisible;
  final String calIcon;
  final DateTime? dateTime;
  final VoidCallback? onTimeUpdate;
  final bool? isSpecificDateRequired;
  final bool? isCurrentDateVisible;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    this.title = "Please Select Date",
    this.calIcon = DhanvarshaImages.calendar,
    required this.isValidateUser,
    this.selectedDate = "",
    this.isTitleVisible = false,
    this.dateTime,
    this.onTimeUpdate,
    this.isSpecificDateRequired = false,
    this.isCurrentDateVisible = false,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late String selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.dateTime != null ? widget.dateTime! : DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      firstDate:
          widget.isCurrentDateVisible! ? DateTime.now() : DateTime(1900, 8),
      lastDate: widget.isCurrentDateVisible!
          ? DateTime.now().add(Duration(days: 4))
          : DateTime.now(),
      selectableDayPredicate: (DateTime val) => widget.isSpecificDateRequired!
          ? val.weekday == 7
              ? false
              : true
          : true,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        // selectedDate = DateUtilsGeneric.convertToMMMdyyyyFormat(picked);
        selectedDate = DateUtilsGeneric.converToStandardDate(picked);
      });
    widget.controller.text = selectedDate;

    if (widget.onTimeUpdate != null) {
      widget.onTimeUpdate!();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print("Selected date called");
    // print(selectedDate);
    selectedDate =
        widget.selectedDate == "" ? widget.title : widget.selectedDate;
  }

  String getCurrectDate(DateTime time) {
    if (selectedDate == "") {
      return widget.title;
    } else {
      return selectedDate;
    }
  }

  @override
  void didUpdateWidget(covariant CustomDatePicker oldWidget) {
    if (widget.selectedDate != oldWidget.selectedDate) {
      selectedDate =
          widget.selectedDate == "" ? widget.title : widget.selectedDate;
      if (widget.onTimeUpdate != null) {
        widget.onTimeUpdate!();
      }
    }

    super.didUpdateWidget(oldWidget);
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical:
                      widget.isTitleVisible && (widget.title != selectedDate)
                          ? 0
                          : 10),
              decoration:
                  (widget.title == selectedDate && widget.isValidateUser)
                      ? BoxDecorationStyles.outTextFieldBoxErrorDecoration
                      : BoxDecorationStyles.outTextFieldBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isTitleVisible && (widget.title != selectedDate)
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              vertical: widget.title != selectedDate ? 5 : 10),
                          child: Text(
                            widget.title,
                            style: CustomTextStyles.regularSmallGreyFontGotham,
                          ),
                        )
                      : Container(),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: widget.isTitleVisible ? 4 : 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              selectedDate,
                              style: !(widget.title != selectedDate)
                                  ? CustomTextStyles.regularMediumFontGothamTextFieldGreyCalendar
                                  : CustomTextStyles.regularMediumFontGothamTextField,
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
    if ((widget.title == selectedDate && widget.isValidateUser)) {
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
