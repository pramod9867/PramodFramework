import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/pancompletedetails.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagepicker.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/windows/snackbarwindow/snackbarwindowbuilder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PanDetailsState();
}

class _PanDetailsState extends State<PanDetails> {
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  VoidCallback? networkStatusListener;

  PanDetailsBloc? panDetailsBloc ;



  @override
  void initState() {
    // TODO: implement initState
    panDetailsBloc = PanDetailsBloc();
    BlocProvider.setBloc<PanDetailsBloc>(panDetailsBloc);
    BlocProvider.printAllBlocs();
    super.initState();
    // _SetUpNetWorkStatusListner();
  }

  void _SetUpNetWorkStatusListner() {
    // _getTitleView();
    networkStatusListener = () {};
    panDetailsBloc?.connectionStatusOfPanDetails
        ?.addListener(networkStatusListener!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _getTitleView() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Hello world")));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ValueListenableBuilder(
      valueListenable: panDetailsBloc!.connectionStatusOfPanDetails,
      builder: (_, status, Widget? child) {
        if (panDetailsBloc!.connectionStatusOfPanDetails.value ==
            NetworkCallConnectionStatus.inProgress) {
          return Stack(
            alignment: Alignment.center,
            children: [child!, _onLoading()],
          );
        }  else {
          return child!;
        }
      },
      child: _getBody(),
    );
  }

  Widget _onError() {
    return Container(
      alignment: Alignment.center,
      width: SizeConfig.screenWidth * 0.50,
      height: 150,
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(DhanvarshaImages.question),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Something went wrong !!",
              style: CustomTextStyles.regularMediumGreyFontGotham,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _onLoading() {
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 150,
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Loading .....",
              style: CustomTextStyles.regularMediumGreyFontGotham,
            ),
          )
        ],
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PanCompleteDetails(
              isPanDetailsFilled: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConstants.custompanDetails,
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageBuilder(key: _key, image: DhanvarshaImages.card1),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PanCompleteDetails(
                      isPanDetailsFilled: false,
                    ),
                  ),
                );
              },
              child: Text(
                "OR ENTER DETAILS MANUALLY",
                style: CustomTextStyles.boldMediumRedFont,
              ),
            ))
      ],
    );
  }

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTitleCompoenent(),
                _getHoirzontalImageUpload(),
              ],
            ),
          ),
          _getContinueButton()
        ],
      ),
    );
  }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CustomButton(
            onButtonPressed: () {
              print(_key.currentState?.imagepicked.value);
              if (_key.currentState?.imagepicked.value != "") {
                File file = new File(_key.currentState!.imagepicked!.value!);

                PanUpload panUpload =
                    PanUpload(fileName: _key.currentState!.fileName);

                print("Uplaoding Files.......");


                // Map<String,String> jsonMap = new Map();
                // jsonMap.putIfAbsent("FileName", ()=>"Pramod".toString());
                //
                // String json=jsonEncode(jsonMap);
                // print(json);

                panDetailsBloc!.getPanDetails(
                    jsonEncode(panUpload!.toJson()),
                    _key.currentState!.imagepicked!.value!,
                    _key.currentState!.fileName,context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please upload pan card image"),
                ));
              }
            },
            title: "Continue",
            boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
          ),
          Text(
            "I DON'T HAVE PAN CARD",
            style: CustomTextStyles.boldsmallRedFontGotham,
          )
        ],
      ),
    );
  }


}
