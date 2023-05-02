import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/ui_dsa/appbar/custom_top_bar.dart';
import 'package:dhanvarsha/ui_dsa/appbar/dv_app_bar.dart';
import 'package:dhanvarsha/ui_dsa/drawer/dbdrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Widget body;
  final bool type;
  final String title;
  final BuildContext context;
  final bool isStepShown;
  final List<int> stepArray;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  openDrawer() {
    print("Drawer Is Opening");
    _key.currentState?.openDrawer();
  }

  closeDrawer() {}

  BaseView(
      {Key? key,
      required this.body,
      this.type = true,
      required this.context,
        this.isStepShown = false,
        this.stepArray = const [1, 2],
      this.title = "DhanVarsha"});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      key: _key,
      drawer: DVDrawer(
        context: this.context,
      ),
      appBar: DVappBar(
        context: this.context,
        isStepsshow: this.isStepShown,
        arrayofsteps: this.stepArray,
        title: this.title,
        isMain: this.type,
        onDrawerPressed: () {
          this.openDrawer();
        },
      ),
      body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgNew, AppColors.bgNew],
          )),
          child: this.body),
    ));
  }
}
