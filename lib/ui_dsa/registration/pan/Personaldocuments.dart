import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/registration/gst/BillingDocuments.dart';
import 'package:dhanvarsha/utils_dsa/buttonstyles.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersonalDocuments extends StatefulWidget {
  final BuildContext context;

  const PersonalDocuments({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PersonalDocumentsState();
}

class _PersonalDocumentsState extends State<PersonalDocuments> {
  var isValidatePressed = false;
  bool isSwitched = false;
  GlobalKey<CustomImageBuilderState> _PanKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _AadharFrontKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _AadharBackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.bgNew, AppColors.bgNew],
            )),
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: SizeConfig.screenHeight - 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getTitleCompoenent(),
                _getPANCARDImageUpload(),
                _AadharCardContainer(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onButtonPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BillingDocuments(
                                    context: context,
                                  )),
                        );
                      },
                      title: "CONTINUE",
                      boxDecoration: ButtonStyles.redButtonWithCircularBorder,
                    ),
                  ),
                ),
                /*Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CustomButton(
                    onButtonPressed: () {},
                    title: "CONTINUE",
                    boxDecoration: ButtonStyles.redButtonWithCircularBorder,
                  ),
                ),*/
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getPANCARDImageUpload() {
    return Container(
      child: Container(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.lighBox,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageBuilder(
                key: _PanKey,
                image: DhanvarshaImages.npan,
                value: "Front View",
                isPan: true,
              ),
              _getPanNumber(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Personal Documents",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            DhanvarshaImages.question,
            height: 20,
            width: 20,
          )
        ],
      ),
    );
  }

  Widget _getPanNumber() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(
        "PAN : xxxxxx987H",
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _getAadharNumber() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(
        "Aadhar : xxxxxxxx9875",
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _AadharCardContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        // color: AppColors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.lighBox,
              ),
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            children: [_getAadharImageUpload(), _getAadharNumber()],
          ),
        ),
      ),
    );
  }

  Widget _getAadharImageUpload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageBuilder(
          key: _AadharFrontKey,
          value: "Front View",
          image: DhanvarshaImages.nadhar,
          isPan: true,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: CustomImageBuilder(
            key: _AadharBackKey,
            value: "Back View",
            image: DhanvarshaImages.nadhar,
            isPan: true,
          ),
        )
      ],
    );
  }
}
