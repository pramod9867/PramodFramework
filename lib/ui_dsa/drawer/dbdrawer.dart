import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/profile/faqscreen.dart';
import 'package:dhanvarsha/ui/profile/gethelp.dart';
import 'package:dhanvarsha/ui/profile/profilescreen.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DVDrawer extends StatelessWidget {
  final BuildContext context;

  const DVDrawer({Key? key, required this.context}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth * 0.70,
        height: SizeConfig.screenHeight,
        color: AppColors.white,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("My Profile",
                      style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Divider(
                color: AppColors.light,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Application Updates",
                    style: CustomTextStyles.boldMediumFont),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetHelp(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child:
                      Text("Get Help", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Divider(
                color: AppColors.light,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Training", style: CustomTextStyles.boldMediumFont),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FAQScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("FAQ", style: CustomTextStyles.boldMediumFont),
                ),
              ),
              Divider(
                color: AppColors.light,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Log Out", style: CustomTextStyles.boldMediumFont),
              )
            ],
          ),
        ));
  }
}
