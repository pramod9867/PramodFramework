import 'package:dhanvarsha/constant_dsa/index.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/appbar/custom_top_bar.dart';
import 'package:dhanvarsha/ui/appbar/dv_app_bar.dart';
import 'package:dhanvarsha/ui/drawer/dbdrawer.dart';
import 'package:dhanvarsha/ui/drawer/menu_screen.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Widget body;
  final bool type;
  final bool isStepShown;
  final List<int> stepArray;
  final String title;
  final VoidCallback? onPhoneTap;
  final BuildContext context;
  final BoxDecoration? decoration;
  final bool isheaderShown;
  final bool isBackPressed;
  final bool isdhavarshalogovisible;
  final bool isBurgerVisble;
  final bool isBackDialogRequired;
  final bool isCallIcon;
  final bool isHeaderColor;
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
      this.title = "",
      this.isStepShown = false,
      this.stepArray = const [1, 2],
      this.isheaderShown = true,
      this.isdhavarshalogovisible = false,
      this.isBurgerVisble = true,
      this.isHeaderColor = true,
      this.isBackPressed = true,
      this.decoration = const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppColors.newBg,
              AppColors.newBg,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.clamp),
      ),
      this.isCallIcon = false,
      this.onPhoneTap, this.isBackDialogRequired=false});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        key: _key,
        appBar: this.isheaderShown
            ? DVappBar(
                isStepsshow: this.isStepShown,
                arrayofsteps: this.stepArray,
                context: this.context,
                onPhoneTap: this.onPhoneTap,
                title: this.title,
                isMain: this.type,
                isCallIconShow: this.isCallIcon,
                isBurgerVisible: this.isBurgerVisble,
                headerColor: this.isHeaderColor,
                isBackPressed: this.isBackPressed,
                isDialogBackPressed: this.isBackDialogRequired,
                onDrawerPressed: () {
                  // this.openDrawer();

                  // SuccessfulResponse.showScaffoldMessage("Coming Soon", context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(),
                    ),
                  );
                },
              )
            : null,
        body: WillPopScope(
          onWillPop: ()async{
            // DialogUtils.showLogOut(context, DhanvarshaImages.aadhar);
            if(this.isBackDialogRequired){
              DialogUtils.previousDataLogOut(context, DhanvarshaImages.cl);
              print("Will Pop Scope Called");
              return true;
            }else{
              return true;
            }
          },
          child: Container(
            decoration: this.decoration,
            child: Stack(
              children: [this.body, DhanvarshaLoader()],
            ),
          ),
        ),
      ),
    );
  }
}
