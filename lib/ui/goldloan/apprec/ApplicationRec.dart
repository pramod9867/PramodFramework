import 'dart:convert';

import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/versionbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/common_screen.dart';
import 'package:dhanvarsha/ui/dashboard/dvdashboard.dart';
import 'package:dhanvarsha/ui/goldloan/gold_adddetails/Gold_AddDetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:flutter/material.dart';

class ApplicationRec extends StatefulWidget {
  const  ApplicationRec({Key? key}) : super(key: key);

  @override
  _ApplicationRecState createState() => _ApplicationRecState();
}

class _ApplicationRecState extends State<ApplicationRec> {
  MasterBloc? bloc;

  // VersionBloc? versionBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
      Container(
        alignment: Alignment.center,
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
         color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              DhanvarshaImages.glappreceived,
              fit: BoxFit.contain,
            ),
            // Text("MGENIUS TOKENIZATION BUILD WITH DHANSETU KEYSTORE V1.0",style: CustomTextStyles.LargeBoldLightFont,),
            SizedBox(
              height: 5,
            ),

            // Text(
            //   "Mgenius Drop Out",
            //   style: CustomTextStyles.VeryLargeBoldBoldFont,
            // )
          ],
        ),
      );

  }
}
