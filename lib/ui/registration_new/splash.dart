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
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/registration_new/login_new.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> implements AddRefLoading {
  MasterBloc? bloc;

  // VersionBloc? versionBloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = MasterBloc(this);
    BlocProvider.setBloc<MasterBloc>(bloc);


    bloc!.getMasterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView(
      body: Container(
        alignment: Alignment.center,
        // color: AppColors.buttonRed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              DhanvarshaImages.dhanSetu,
              height: SizeConfig.blockSizeHorizontal * 60,
              width: SizeConfig.blockSizeHorizontal * 60,
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
      ),
      context: context,
      isheaderShown: false,
    );
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) async {
    // print(bloc!.countryDTO);
    // print("Distric");
    // print(bloc!.districtDTO);
    // print("State");
    // print(bloc!.stateDTO);
    // print("Taluka");
    // print(bloc!.talukaDTO);
    String data =
        await SharedPreferenceUtils.sharedPreferenceUtils.getLoginData();

    if (data != "") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(

            builder: (context) => CommonScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CommonScreen(),
          ));
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void isSuccessful2(SuccessfulResponseDTO dto) {
    // TODO: implement isSuccessful2
  }
}
