import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/framework/network/dio_client.dart';
import 'package:dhanvarsha/framework/network/request_canceler.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DhanvarshaLoader extends StatefulWidget {
  final bool? isLoaderChanged;

  const DhanvarshaLoader({Key? key, this.isLoaderChanged = false})
      : super(key: key);

  @override
  _DhanvarshaLoaderState createState() => _DhanvarshaLoaderState();
}

class _DhanvarshaLoaderState extends State<DhanvarshaLoader> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: ValueListenableBuilder(
            valueListenable: CustomLoaderBuilder.builder.isLoaderShow,
            builder: (_, status, __) {
              if (CustomLoaderBuilder.builder.isLoaderShow.value) {
                return Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: Container(
                        child: CustomLoaderBuilder.builder.isDiffLoader.value
                            ? _getPleaseWaitPopUp()
                            : _getWholeScreenCirularProgress(),
                      ),
                    ))
                  ],
                );
              } else {
                return Container();
              }
            }),
        onWillPop: _willPopCallback);
  }

  Future<bool> _willPopCallback() async {
    if (CustomLoaderBuilder.builder.isLoaderShow.value) {
      CustomLoaderBuilder.builder.isLoaderShow.value = false;
      RequestCanceler.canceler.token.cancel("cancelled");
      if (RequestCanceler.canceler.token.isCancelled) {
        RequestCanceler.canceler.token = CancelToken();
      }
      return false;
    } else {
      return true; // return true if the route to be popped
    }
  }

  Widget _getWholeScreenCirularProgress() {
    return GestureDetector(
      onTap: () {
        // CustomLoaderBuilder.builder.isLoaderShow.value=false;
      },
      child: Container(
        decoration: new BoxDecoration(
            border: new Border.all(
                width: 1,
                color: Colors
                    .transparent), //color is transparent so that it does not blend with the actual color specified

            color:
                Colors.black12 // Specifies the background color and the opacity
            ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: AppColors.buttonRed,
        ),
      ),
    );
  }

  Widget _getPleaseWaitPopUp() {
    return Container(
      decoration: new BoxDecoration(
          border: new Border.all(
              width: 1,
              color: Colors
                  .transparent), //color is transparent so that it does not blend with the actual color specified

          color:
              Colors.black12 // Specifies the background color and the opacity
          ),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 10),
        width: SizeConfig.screenWidth - 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(
              color: AppColors.buttonRed,
            ),
            Text(
              "Please wait",
              style: CustomTextStyles.boldLargeFonts,
            ),
            Text(
              CustomLoaderBuilder.builder.changeContent.value
                  ? "The customer's loan application is being reviewed"
                  : "we are fetching customer's \nGST details",
              style: CustomTextStyles.regularMediumFont,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
