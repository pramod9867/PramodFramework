import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DVappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBurgerVisible;
  final bool isMain;
  final VoidCallback? onPhoneTap;
  final bool isStepsshow;
  final bool isCallIconShow;
  final List<int> arrayofsteps;
  final BuildContext context;
  final VoidCallback onDrawerPressed;
  final bool headerColor;
  final bool isDialogBackPressed;
  @override
  final Size preferredSize;
  final bool isDhanvarshalogshow;
  final bool isBackPressed;
  DVappBar(
      {required this.title,
      this.isMain = true,
      required this.context,
      required this.onDrawerPressed,
      this.isStepsshow = false,
      this.arrayofsteps = const [1, 3],
      this.isDhanvarshalogshow = false,
      this.isBurgerVisible = true,
      this.headerColor = true,
      this.isBackPressed = true,
      this.isCallIconShow = false,
      this.onPhoneTap, this.isDialogBackPressed=false})
      : preferredSize = Size.fromHeight(45.0);

  // Image.asset(
  // DhanvarshaImages.burger,
  // width: 20,
  // height: 20,
  // )
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: this.headerColor ? AppColors.newBg : AppColors.white,
          ),
          height: this.preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: (this.isMain && this.isBurgerVisible)
                    ? GestureDetector(
                        onTap: this.onDrawerPressed,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(10),
                          child: Container(
                            child: Image.asset(
                              DhanvarshaImages.burger,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (this.isBackPressed) {
                            if(this.isDialogBackPressed){
                              DialogUtils.previousDataLogOut(context, DhanvarshaImages.cl);
                              print("Will Pop Scope Called");
                              // return true;
                            }else{

                              Navigator.of(this.context).pop();
                              // return true;
                            }

                            // Navigator.of(this.context).pop();
                          } else {
                            // Navigator.of(context).popUntil((route) => route.isFirst);

                            DialogUtils.existfromapplications(context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            DhanvarshaImages.bck,
                            width: 20,
                            height: 20,
                            color: AppColors.black,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: this.isMain
                    ? Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          DhanvarshaImages.dhanSetu,
                          width: 100,
                          height: 50,
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          this.title,
                          style: CustomTextStyles.boldsmalleFonts,
                        ),
                      ),
              ),
              Expanded(
                  flex: 1,
                  child: this.isStepsshow
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white),
                          alignment: Alignment.center,
                          child: Text(
                            "Step ${this.arrayofsteps[0]} of ${this.arrayofsteps[1]}",
                            style: CustomTextStyles.boldsmalleFonts,
                          ),
                        )
                      : this.isDhanvarshalogshow
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child:
                                  Image.asset(DhanvarshaImages.dhanvarshalogo),
                            )
                          : Container()),
              this.isCallIconShow
                  ? Expanded(
                      child: GestureDetector(
                      onTap: this.onPhoneTap,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerRight,
                        child: Image.asset(DhanvarshaImages.callIcon),
                      ),
                    ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
