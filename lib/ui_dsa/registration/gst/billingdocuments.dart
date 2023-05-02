import 'package:dhanvarsha/bloc_dsa/PartialFormBloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillingDocuments extends StatefulWidget {
  final BuildContext context;

  const BillingDocuments({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BillingDocumentsState();
}

class _BillingDocumentsState extends State<BillingDocuments> {
  GlobalKey<CustomImageBuilderState> _BillingKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _GSTcertificateKey = GlobalKey();
  var isValidatePressed = false;
  TextEditingController gstnumberedittext = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.gSTNumber ?? '');
  bool isSwitched = false;

  String bPanimagePath = '';
  String gstimagePath = '';
  String gstnumber = '';
  String title = 'Business Documents';
  Color buttoncolor = AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;
  PartialFormBloc p1 = new PartialFormBloc();

  bool isbPanUpload = false;
  bool isGstUpload = false;
  @override
  void initState() {
    super.initState();

    if (BasicData
            .otpres?.distributorDetails?.distributor?.businessPANImageUrl !=
        '') {
      setState(() {
        buttoncolor = AppColors.buttonRed;
        buttontextcolor = Colors.white;
      });
    }

    if (BasicData
            .otpres?.distributorDetails?.distributor?.gSTCertificateImageUrl !=
        '') {
      setState(() {
        isSwitched = true;
        isGstUpload = true;
      });
    }

    if (BasicData
            .otpres?.distributorDetails?.distributor?.businessPANImageUrl !=
        '') {
      setState(() {
        isbPanUpload = true;
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
    //SizeConfig().init(context);
    return BaseView(
        title: "",
        type: false,
        isStepShown: true,
        stepArray: [3, 5],
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
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.bgNew, AppColors.bgNew],
                )),
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _getTitleCompoenent(),
                        _getBillingImageUpload(),
                        _gstContainer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CustomButton(
                        onButtonPressed: () {
                          if (isSwitched) {
                            if (BasicData.buspanimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please upload Business PAN Image")));
                            } else if (gstnumberedittext.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please Enter GST Number")));
                            } else if (!CustomValidator(gstnumberedittext.text)
                                .validate('isGst')) {
                              print('is side true');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please Enter Valid GST Number")));
                            } else if (BasicData.gstimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please upload GST Image")));
                            } else {
                              BasicData.isElectricityBillOnMyName = isSwitched;
                              BasicData.gstNumber = gstnumberedittext.text;
                              print('this is gst number' + BasicData.gstNumber);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProofofAddress(
                              //             context: context,
                              //           )),
                              // );
                              p1.submitform('c', context);
                            }
                          } else {
                            if (BasicData.buspanimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please upload Business PAN Image")));
                            } else {
                              BasicData.gstNumber = gstnumberedittext.text;
                              print('this is gst number' + BasicData.gstNumber);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProofofAddress(
                              //             context: context,
                              //           )),
                              // );
                              p1.submitform('c', context);
                            }
                          }
                        },
                        title: "CONTINUE",
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

  Widget _getBillingImageUpload() {
    return Container(
      child: Container(
        width: double.infinity,
        //color: AppColors.white,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageBuilder(
                key: _BillingKey,
                image: DhanvarshaImages.npan,
                value: "",
                url: BasicData.otpres?.distributorDetails?.distributor
                        ?.businessPANImageUrl ??
                    '',
                isimageupload: () {
                  setState(() {
                    bPanimagePath = _BillingKey.currentState!.imagepicked.value;
                    print('file name $bPanimagePath');
                    BasicData.buspanimagepath = bPanimagePath;
                    buttoncolor = AppColors.buttonRed;
                    buttontextcolor = Colors.white;
                    isbPanUpload = true;
                  });
                },
              ),
              _getTitleBusiness(),
              !isbPanUpload
                  ? Container(
                      child: Column(
                        children: [
                          _getTextBusiness(),
                          _TakePhotoButton(),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          //_getTextBusiness(),
                          _TakePhotoButton(),
                        ],
                      ),
                    )
              // !isbPanUpload ?
              // _getTextBusiness(),
              // _TakePhotoButton(),
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
            title,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'GothamMedium',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              if(isSwitched){
                DialogUtils.BDUploadInsturctionDialog(context,"Upload correct Business PAN GST.Any discrepancy can lead to rejection of loans");
              }else{
                DialogUtils.BDUploadInsturctionDialog(context,"Upload correct Business PAN.Any discrepancy can lead to rejection of loans");

              }
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

  Widget _getTitleBusiness() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Your Business PAN",
        style: TextStyle(
            fontSize: 18,
            height: 1.25,
            fontFamily: 'GothamMedium',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _gstContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        // color: AppColors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.white,
              ),
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getGSTHeading(),
              if (isSwitched) _getGSTTextDigit(name: "15-digit GST number is required"),
              if (!isSwitched)
                _getGSTTextDigit(name: "15-digit GST number is required"),
              Visibility(
                visible: isSwitched,
                child: _gstNumberEditText(),
              ),
              Visibility(
                visible: isSwitched,
                child: CustomImageBuilder(
                  key: _GSTcertificateKey,
                  image: DhanvarshaImages.poa,
                  value: "",
                  url: BasicData.otpres?.distributorDetails?.distributor
                          ?.gSTCertificateImageUrl ??
                      '',
                  isimageupload: () {
                    setState(() {
                      gstimagePath =
                          _GSTcertificateKey.currentState!.imagepicked.value;
                      print('file name gstimagePath$gstimagePath');
                      BasicData.gstimagepath = gstimagePath;
                      isGstUpload = true;
                    });
                  },
                ),
              ),
              !isGstUpload
                  ? Container(
                      child: Column(
                        children: [
                          Visibility(
                            visible: isSwitched,
                            child: _getCertificateText(),
                          ),
                          Visibility(
                            visible: isSwitched,
                            child: _getTextBusiness(),
                          ),
                          Visibility(
                            visible: isSwitched,
                            child: _UploadGSTCertificateBUtton(),
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Visibility(
                            visible: isSwitched,
                            child: _getCertificateText(),
                          ),
                          Visibility(
                            visible: isSwitched,
                            child: _UploadGSTCertificateBUtton(),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getGSTHeading() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My business has GST",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'GothamMedium',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                if(isSwitched){
                  setState(() {
                    title = "Billing Documents";
                  });
                }else{
                  title = 'Business Documents';
                }
                // print(isSwitched);
              });
            },
            activeTrackColor:AppColors.buttonRed,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _getGSTTextDigit({String name = "15-digit GST number is required"}) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'Gotham',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _gstNumberEditText() {
    return (Container(
      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
      child: TextField(
        controller: gstnumberedittext,
        decoration: const InputDecoration(
          hintText: 'Enter Your GSTIN Number',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    ));
  }

  Widget _getTextBusiness() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Center(
        child: Text(
          "Mandatory for KYC verification",
          textAlign: TextAlign.center,
          style: CustomTextStyles.regularMediumGreyFont,
        ),
      ),
    );
  }

  Widget _getCertificateText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Your GST Certificate",
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _UploadGSTCertificateBUtton() {
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
              print("tapped on container");
              _GSTcertificateKey.currentState!.openImagePicker();
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
              _BillingKey.currentState?.openImagePicker();
              print("tapped on container");
              // CustomImageBuilder(
              //   key: _BillingKey,
              //   value: "",
              // );
              //Navigator.pushNamed(context, "myRoute");
            },
          ),
        ],
      ),
    );
  }
}
