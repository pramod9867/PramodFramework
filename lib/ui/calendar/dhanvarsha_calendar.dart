import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui/calendar/calendar_builder.dart';
import 'package:dhanvarsha/ui/registration/terms/Terms.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DhanvarshaCalendar {
  static DhanvarshaCalendar calendar = DhanvarshaCalendar();

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static void showDhanvarshaCalendar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ValueListenableBuilder(
                      valueListenable: CalendarBuilder.builder.notifier,
                      builder: (BuildContext context, List<int> value,
                          Widget? child) {
                        return GestureDetector(
                          onTap: () {
                            // CalendarBuilder.builder.showCalendar();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                color: AppColors.white),
                            alignment: Alignment.center,
                            height: SizeConfig.screenHeight * 0.75,
                            width: SizeConfig.screenWidth * 0.90,
                            // color: AppColors.white,
                            margin: EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(

                                  child: Text(
                                    "Select Date Range",
                                    style: CustomTextStyles.BoldTitileFont,
                                  ),
                                ),
                               Container(
                                 margin: EdgeInsets.symmetric(horizontal: 25),
                                 child:  Divider(),
                               ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Specific Duration",
                                        style:
                                            CustomTextStyles.regularMediumFont,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable:
                                              CalendarBuilder.builder.years,
                                          builder: (BuildContext context,
                                              int value, Widget? child) {
                                            return Row(

                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    CalendarBuilder.builder.decrementYear();
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Image.asset(
                                                      DhanvarshaImages.right,
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                ),
                                                Text(CalendarBuilder
                                                    .builder.years.value
                                                    .toString()),
                                                GestureDetector(
                                                  onTap: () {
                                                    CalendarBuilder.builder.incrementYear();
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Image.asset(
                                                      DhanvarshaImages.left,
                                                      height: 25,
                                                      width: 25,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 2.5,
                                        mainAxisSpacing: 15.0,
                                        crossAxisSpacing: 0.0,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: 12,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (CalendarBuilder.builder.notifier
                                                        .value[0] ==
                                                    -1 ||
                                                CalendarBuilder.builder.notifier
                                                        .value[0] ==
                                                    index) {
                                              CalendarBuilder.builder
                                                  .selectFirstMonth(index);
                                            } else if (CalendarBuilder
                                                    .builder.notifier.value[0] <
                                                index) {
                                              CalendarBuilder.builder
                                                  .selectSecondMonth(index);
                                            } else {
                                              print("Month Greater Than Index");
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(1),
                                              color: (CalendarBuilder
                                                              .builder
                                                              .notifier
                                                              .value[0] ==
                                                          index ||
                                                      CalendarBuilder
                                                              .builder
                                                              .notifier
                                                              .value[1] ==
                                                          index)
                                                  ? AppColors.buttonRed
                                                  : (CalendarBuilder
                                                                  .builder
                                                                  .notifier
                                                                  .value[0] <
                                                              index &&
                                                          CalendarBuilder
                                                                  .builder
                                                                  .notifier
                                                                  .value[1] >
                                                              index &&
                                                          CalendarBuilder
                                                                  .builder
                                                                  .notifier
                                                                  .value[1] !=
                                                              -1 &&
                                                          CalendarBuilder
                                                                  .builder
                                                                  .notifier
                                                                  .value[0] !=
                                                              -1)
                                                      ? AppColors.lightPink
                                                      : AppColors.white,
                                            ),
                                            child: Text(
                                              months[index],
                                              textAlign: TextAlign.center,
                                              style: CustomTextStyles
                                                  .regularMediumFont,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                CustomButton(
                                  onButtonPressed: () {},
                                  title: "Save",
                                  widthScale: 0.5,
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          );
        });
  }
}
