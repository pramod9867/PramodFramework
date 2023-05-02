import 'package:dhanvarsha/constant_dsa/DhanvarshaImages.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/utils_dsa/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DVappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMain;
  final BuildContext context;
  final VoidCallback onDrawerPressed;
  final bool isStepsshow;
  final List<int> arrayofsteps;
  @override
  final Size preferredSize;

  DVappBar(
      {required this.title,
      this.isMain = true,
      required this.context,
      required this.onDrawerPressed,
      this.isStepsshow = false,
      this.arrayofsteps = const [1, 3]})
      : preferredSize = Size.fromHeight(45.0);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        height: this.preferredSize.height,
        color: AppColors.bgNew,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: this.isMain
                  ? GestureDetector(
                      onTap: this.onDrawerPressed,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          DhanvarshaImages.burger,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(this.context).pop();
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(10),
                        child: Image.asset(
                          DhanvarshaImages.bck,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: this.isMain
                  ? Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        DhanvarshaImages.dhanvarshalogo,
                        width: 100,
                        height: 50,
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(this.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
            ),
            Expanded(
              flex: 1,
              child: this.isStepsshow
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white),
                      alignment: Alignment.center,
                      child: Text(
                        "Steps ${this.arrayofsteps[0]} of ${this.arrayofsteps[1]}",
                        style: CustomTextStyles.boldsmalleFonts,
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
