
import 'package:dhanvarsha/bloc_dsa/PartialFormBloc.dart';
import 'package:dhanvarsha/bloc_dsa/adharbloc.dart';
import 'package:dhanvarsha/bloc_dsa/panbloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/ui_dsa/registration/adhaarform/Adharf.dart';
import 'package:dhanvarsha/ui_dsa/registration/panform/Panf.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils_dsa/size_config.dart';
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
  bool isAAdhaarBackViewShown = false;
  PanDetailsBloc pan1 = new PanDetailsBloc();
  AdharBlock adhar1 = new AdharBlock();

  String panstring = '';
  String imagePath = '';
  String filename = '';

  String fAimagePath = '';
  String fAfilename = '';
  String bAimagePath = '';
  String bAfilename = '';
  PartialFormBloc p1 = new PartialFormBloc();

  Color buttoncolor = AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;

  bool isbackadharimageuploaded = false;

  @override
  void initState() {
    super.initState();

    if (BasicData.otpres?.distributorDetails?.distributor?.pANImageUrl != '') {
      setState(() {
        buttoncolor = AppColors.buttonRed;
        buttontextcolor = Colors.white;
        //isPanViewShown = true;
      });
    }
    if (BasicData.otpres?.distributorDetails?.distributor?.aadharImageBackUrl !=
        '') {
      setState(() {
        isAAdhaarViewShown = true;
        isbackadharimageuploaded = true;
        isPanViewShown = true;
        print('pan number');
        print(BasicData.otpres?.distributorDetails?.panDetails?.panNumber);
        print(BasicData.otpres?.distributorDetails?.distributor?.pANNumber);

        print('aadhaar number');
        print(
            BasicData.otpres?.distributorDetails?.aadharDetails?.aadharNumber);
        print(BasicData.otpres?.distributorDetails?.distributor?.aadharNumber);

        BasicData.panres?.PanNumber =
            BasicData.otpres?.distributorDetails?.distributor?.pANNumber!!;
        BasicData.adharres?.AadharNumber =
            BasicData.otpres?.distributorDetails?.distributor?.aadharNumber;
      });
    }
  }

  @override
  void dispose() {
    // dateController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        stepArray: [2, 5],
        type: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight -
                      MediaQuery.of(context).viewInsets.top -
                      MediaQuery.of(context).viewInsets.bottom -
                      45-24,
                ),
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _getTitleCompoenent(),
                        _getPanImageUpload(),
                        _gstContainer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CustomButton(
                        onButtonPressed: () {
                          if (BasicData.panImagepath.isEmpty ||
                              BasicData.panImagepath == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please upload PAN Image")));
                          } else if (BasicData.adharfrontImagepath.isEmpty ||
                              BasicData.adharfrontImagepath == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Please upload both Aadhaar Image")));
                          } else if (BasicData.adharbackImagepath.isEmpty ||
                              BasicData.adharbackImagepath == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Please upload both Aadhaar Image")));
                          } else {
                            p1.submitform('b', context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => BillingDocuments(
                            //             context: context,
                            //           )),
                            // );
                          }
                        },
                        title: "VERIFY",
                        boxDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: buttoncolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        textColor: buttontextcolor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DhanvarshaLoader(),
          ],
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
                isPan: true,
                image: DhanvarshaImages.npan,
                value: "",
                url: BasicData
                        .otpres?.distributorDetails?.distributor?.pANImageUrl ??
                    '',
                isimageupload: () async {
                  setState(() {
                    isPanViewShown = true;
                    filename = _PanKey.currentState!.filename;
                    print('file name $filename');
                    imagePath = _PanKey.currentState!.imagepicked.value;
                    print('imagePath $imagePath');
                  });

                  var a = await pan1.getPanDetails(panstring, imagePath,
                      _PanKey.currentState!.filename, context);

                  if (a) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Panf(
                                context: context,
                              )),
                    ).then((_) => setState(() {}));
                  }
                },
              ),
              isPanViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getPanNumber(),
                          _TakePhotoButton('pan'),
                        ],
                      ),
                    )
                  : Container(),
              !isPanViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleBusiness(),
                          _getTextAadhar(),
                          _TakePhotoButton('pan'),
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
                fontFamily: 'GothamMedium',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              DialogUtils.UploadInsturctionDialog(context);
            },
            child: Image.asset(
              DhanvarshaImages.question,
              height: 20,
              width: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _getTitleBusiness({String name = "Upload Your PAN card"}) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'GothamMedium',
            height: 1.2,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageBuilder(
                    key: _AadharFrontKey,
                    value: "",
                    isPan: true,
                    // isAadhaarOrPan: true,
                    image: DhanvarshaImages.nadhar,
                    url: BasicData.otpres?.distributorDetails?.distributor
                            ?.aadharImageFrontUrl ??
                        '',
                    isimageupload: () async {
                      setState(() {
                        isBackImageVisible = true;
                        isAAdhaarViewShown = true;
                        fAfilename = _AadharFrontKey.currentState!.filename;
                        print('file name $fAfilename');
                        fAimagePath =
                            _AadharFrontKey.currentState!.imagepicked.value;
                        print('imagePath $fAimagePath');
                      });

                      print(_AadharBackKey.currentState?.imagepicked.value);
                      print(_AadharBackKey.currentState?.imagepicked.value);
                      if (_AadharBackKey.currentState?.imagepicked.value !=
                              null &&
                          _AadharBackKey.currentState?.imagepicked.value !=
                              "" &&
                          _AadharFrontKey.currentState?.imagepicked.value !=
                              null &&
                          _AadharFrontKey.currentState?.imagepicked.value !=
                              "") {
                        print("Api Called");
                        /*adhar1.getAdharDetails(
                            panstring, fAimagePath, bAimagePath, context);*/

                        /* var a = await adhar1.getAdharDetails(
                            panstring, fAimagePath, bAimagePath, context);

                        if(a){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Adharf(
                                  context: context,
                                )),
                          ).then((_) => setState(() {}));
                        }*/
                      }
                    },
                  ),
                  isAAdhaarViewShown
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomImageBuilder(
                            key: _AadharBackKey,
                            value: "",
                            isPan: true,
                            image: DhanvarshaImages.nadhar,
                            url: BasicData.otpres?.distributorDetails
                                    ?.distributor?.aadharImageBackUrl ??
                                '',
                            isimageupload: () async {
                              setState(() {
                                isAAdhaarBackViewShown = false;
                                isbackadharimageuploaded = true;
                                bAfilename =
                                    _AadharBackKey.currentState!.filename;
                                print('file name $bAfilename');
                                bAimagePath = _AadharBackKey
                                    .currentState!.imagepicked.value;
                                print('imagePath $bAimagePath');
                                buttoncolor = AppColors.buttonRed;
                                buttontextcolor = Colors.white;
                              });
                              print("Back Image Uploaded");
                              // adhar1.getAdharDetails(
                              //     panstring, fAimagePath, bAimagePath, context);

                              var a = await adhar1.getAdharDetails(
                                  panstring, fAimagePath, bAimagePath, context);

                              if (a) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Adharf(
                                            context: context,
                                          )),
                                ).then((_) => setState(() {}));
                              }
                            },
                          ),
                        )
                      : Container()
                ],
              ),
              isbackadharimageuploaded ? _getAadharNumber() : Container(),
              !isAAdhaarViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleBusiness(name: "Upload Your Aadhaar card"),
                          _getTextAadhar(),
                          // _TakePhotoButton(),
                        ],
                      ),
                    )
                  : Container(),
              !isbackadharimageuploaded
                  ? Container(
                      child: Column(
                        children: [
                          //_getTitleBusiness(name: "Your Aadhar"),
                          // _getTextAadhar(),
                          _TakePhotoButton('adhaar'),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          //_getTitleBusiness(name: "Your Aadhar"),
                          // _getTextAadhar(),
                          _TakePhotoButton('adhaar'),
                        ],
                      ),
                    )
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
          "Mandatory for KYC verification",
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
            color: AppColors.buttonRed,
          ),
          GestureDetector(
            child: Container(
              child: Text(
                " TAKA A PHOTO",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: AppColors.buttonRed,
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

  Widget _TakePhotoButton(String s) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            DhanvarshaImages.uplo,
            height: 20,
            width: 20,
          ),
          GestureDetector(
            child: Container(
              child: Text(
                " UPLOAD",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    color: AppColors.buttonRed,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              if (s == 'pan') {
                _PanKey.currentState?.openImagePicker();
              } else {
                // adhar1.getAdharDetails(
                //     panstring, fAimagePath, bAimagePath, context);
                // pan1.getPanDetails(panstring, imagePath, _PanKey.currentState!.filename, context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => Adharf(
                //             context: context,
                //           )),
                // );
                if (_AadharFrontKey.currentState?.imagepicked.value == "") {
                  _AadharFrontKey.currentState?.openImagePicker();
                } else {
                  _AadharBackKey.currentState?.openImagePicker();
                }
              }
              print("tapped on container");
              //Navigator.pushNamed(context, "myRoute");
            },
          ),
        ],
      ),
    );
  }

  // Widget _getPanNumber() {
  //   return ValueListenableBuilder(
  //       valueListenable: pan1.connectionStatusOfPanDetails,
  //       builder: (_, status, Widget? child) {
  //         String pannumber = BasicData.panres?.panNumber ?? "";
  //     child: Container(
  //       alignment: Alignment.center,
  //       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
  //       child: Text(
  //         "PAN : xxxxxx987H",
  //         style: TextStyle(
  //           fontSize: 15,
  //           fontFamily: 'Poppins',
  //           color: Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _getPanNumber() {
    return ValueListenableBuilder(
        valueListenable: pan1.connectionStatusOfPanDetails,
        builder: (_, status, Widget? child) {
          print('in value listneable');
          print(BasicData.panres?.PanNumber);
          String pannumber = BasicData.panres?.PanNumber ?? "";
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "PAN : " + pannumber,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'GothamMedium',
                color: Colors.black,
              ),
            ),
          );
        });
  }

  Widget _getAadharNumber() {
    return ValueListenableBuilder(
        valueListenable: adhar1.connectionStatusOfPanDetails,
        builder: (_, status, Widget? child) {
          String adharnumber = BasicData.adharres?.AadharNumber ?? "";
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "Aadhaar : " + adharnumber,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'GothamMedium',
                color: Colors.black,
              ),
            ),
          );
        });
  }
}
