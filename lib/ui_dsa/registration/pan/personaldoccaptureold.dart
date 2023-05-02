import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/utils_dsa/buttonstyles.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:flutter/material.dart';

class PersonalDocCapture extends StatefulWidget {
  final BuildContext context;

  const PersonalDocCapture({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PersonalDocCaptureState();
}

class _PersonalDocCaptureState extends State<PersonalDocCapture> {
  GlobalKey<CustomImageBuilderState> _PanKey = GlobalKey();

  GlobalKey<CustomImageBuilderState> _AadharFrontKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _AadharBackKey = GlobalKey();
  var isValidatePressed = false;
  bool isBackImageVisible = false;
  bool isPanViewShown = false;
  bool isAAdhaarViewShown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return BaseView(
        title: "",
        type: false,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getTitleCompoenent(),
                _getPanImageUpload(),
                _gstContainer(),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: CustomButton(
                    onButtonPressed: () {},
                    title: "CONTINUE",
                    boxDecoration: ButtonStyles.greyButtonWithCircularBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getPanImageUpload() {
    return Container(
      child: Container(
        width: double.infinity,
        //color: AppColors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.white,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageBuilder(
                key: _PanKey,
                value: "",
                isimageupload: () {
                  setState(() {
                    isPanViewShown = true;
                  });
                },
              ),
              isPanViewShown ? _getPanNumber() : Container(),
              !isPanViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleBusiness(),
                          _getTextAadhar(),
                          _TakePhotoButton(),
                        ],
                      ),
                    )
                  : Container()
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

  Widget _getTitleBusiness({String name = "Your PAN"}) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _gstContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        // color: AppColors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.white,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageBuilder(
                    key: _AadharFrontKey,
                    value: "",
                    image: DhanvarshaImages.aadhar,
                    isimageupload: () {
                      setState(() {
                        isBackImageVisible = true;
                        isAAdhaarViewShown = true;
                      });
                    },
                  ),
                  isAAdhaarViewShown
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomImageBuilder(
                            key: _AadharBackKey,
                            value: "",
                            image: DhanvarshaImages.nadhar,
                            isimageupload: () {},
                          ),
                        )
                      : Container()
                ],
              ),
              isAAdhaarViewShown ? _getAadharNumber() : Container(),
              !isAAdhaarViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleBusiness(name: "Your Aadhaar"),
                          _getTextAadhar(),
                          _TakePhotoButton(),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextAadhar() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Center(
        child: Text(
          "it's required by law to verify your identity as new user.",
          textAlign: TextAlign.center,
          style: CustomTextStyles.regularMediumGreyFont,
        ),
      ),
    );
  }

  Widget _TakePhotoAadharButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_camera,
            color: Colors.red,
          ),
          GestureDetector(
            child: Container(
              child: Text(
                " TAKA A PHOTO",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              print("tapped on container");
              //Navigator.pushNamed(context, "myRoute");
            },
          ),
        ],
      ),
    );
  }

  Widget _TakePhotoButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_camera,
            color: Colors.red,
          ),
          GestureDetector(
            child: Container(
              child: Text(
                " TAKE A PHOTO",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              print("tapped on container");
              //Navigator.pushNamed(context, "myRoute");
            },
          ),
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
        "Aadhaar : xxxxxxxx9875",
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
      ),
    );
  }
}
