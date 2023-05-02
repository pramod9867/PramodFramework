import 'package:dhanvarsha/bloc_dsa/PartialFormBloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/model_dsa/response/dropdownresponse.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/dropdown/customdropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProofofAddress extends StatefulWidget {
  final BuildContext context;

  const ProofofAddress({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProofofAddressState();
}

class _ProofofAddressState extends State<ProofofAddress> {
  GlobalKey<CustomImageBuilderState> _BillingKey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _RentKey = GlobalKey();
  var isValidatePressed = false;
  TextEditingController gstnumberedittext = new TextEditingController();
  bool isSwitched = false;
  TextEditingController billingTextEditController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.RentalBillName ??
          '');

  Color buttoncolor =AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;
  PartialFormBloc p1 = new PartialFormBloc();

  AddressProof addressProof = new AddressProof();
  late List<DropdownMenuItem<AddressProof>> _AddressProofModelDropdownList;

  String proofofaddimagePath = '';
  String rentalimagePath = '';

  bool isPOAUpload = false;
  bool isRentalUpload = false;

  List<DropdownMenuItem<AddressProof>> _buildAddressProofModelDropdown(
      List AddressProofModelList) {
    List<DropdownMenuItem<AddressProof>> items = [];
    for (AddressProof businesstypeModel in AddressProofModelList) {
      items.add(DropdownMenuItem(
        value: businesstypeModel,
        child: Text(
          businesstypeModel.name!!,
          style: CustomTextStyles.regularMediumFont,
        ),
      ));
    }
    return items;
  }

  onChangeFavouriteFoodModelDropdown(AddressProof? aProof) {
    setState(() {
      addressProof = aProof!;
    });
  }

  @override
  void initState() {
    super.initState();

    //Select Proof

    print('rental bill name type');
    print(BasicData.otpres?.distributorDetails?.distributor?.RentalBillName);
    print('addressProof type');
    print(
        BasicData.otpres?.distributorDetails?.distributor?.addressProofDocType);
    print(BasicData.dd!.addressProof![2].name);
    print('length');
    print(BasicData.dd!.addressProof!.length);

    if (BasicData.dd!.addressProof![0].name != 'Select Proof') {
      AddressProof b1 =
      new AddressProof(name: 'Select Proof', value: 1001);
      BasicData.dd!.addressProof!.insert(0, b1);
      print('1st value');
      print(BasicData.dd!.addressProof![0].name);
      print('2nd value');
      print(BasicData.dd!.addressProof![1].name);
    }else{

      print('in Else');
      print('1st value');
      print(BasicData.dd!.addressProof![0].name);
      print('2nd value');
      print(BasicData.dd!.addressProof![1].name);
    }

    _AddressProofModelDropdownList =
        _buildAddressProofModelDropdown(BasicData.dd!.addressProof!);
    addressProof = BasicData.dd!.addressProof![0];

    for (int i = 0; i < BasicData.dd!.addressProof!.length; i++) {
      if (BasicData
              .otpres?.distributorDetails?.distributor?.addressProofDocType!
              .replaceAll(' ', '') ==
          BasicData.dd!.addressProof![i].name!.replaceAll(' ', '')) {
        addressProof = BasicData.dd!.addressProof![i];
        print('in if');
      }
    }

    //addressProof = BasicData.dd!.addressProof![0];

    if (BasicData.otpres?.distributorDetails?.distributor
            ?.addressProofDocTypeImageUrl !=
        '') {
      setState(() {
        buttoncolor =AppColors.buttonRed;
        buttontextcolor = Colors.white;
      });
    }

    if (BasicData
            .otpres?.distributorDetails?.distributor?.rentalAgreementImageUrl !=
        '') {
      setState(() {
        isSwitched = true;
        isRentalUpload = true;
      });
    }

    if (BasicData.otpres?.distributorDetails?.distributor
            ?.addressProofDocTypeImageUrl !=
        '') {
      setState(() {
        isPOAUpload = true;
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
        stepArray: [4, 5],
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
                        _AddressProofContainer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CustomButton(
                        onButtonPressed: () {
                          if (isSwitched) {
                            if (BasicData.proofaddimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please upload Proof of Address Image")));
                            } else if (addressProof.name == 'Select Proof') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please Select Proof Type")));
                            } else if (billingTextEditController
                                .value.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Please Enter Name")));
                            } else if (BasicData
                                .rentalagreementimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please upload Rental Agreement Image")));
                            } else {
                              BasicData.addproofdoctype = addressProof.name!;

                              print('BasicData.addproofdoctype' +
                                  BasicData.addproofdoctype);
                              print('BasicData.isElectricityBillOnMyName' +
                                  BasicData.isElectricityBillOnMyName
                                      .toString());

                              BasicData.isRentalBillOnName = isSwitched;
                              print('rental name');
                              print(BasicData.RentalBillName);
                              BasicData.RentalBillName =
                                  billingTextEditController.text;

                              p1.submitform('d', context);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => BankDetails(
                              //             context: context,
                              //           )),
                              // );
                            }
                          } else {
                            if (BasicData.proofaddimagepath.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please upload Proof of Address Image")));
                            } else {
                              if (addressProof.name! != "Select Proof") {
                                BasicData.addproofdoctype = addressProof.name!;
                                BasicData.isElectricityBillOnMyName =
                                    isSwitched;
                                print('BasicData.addproofdoctype' +
                                    BasicData.addproofdoctype);
                                print('BasicData.isElectricityBillOnMyName' +
                                    BasicData.isElectricityBillOnMyName
                                        .toString());
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => BankDetails(
                                //             context: context,
                                //           )),
                                // );

                                p1.submitform('d', context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please select type of proof")));
                              }
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
                color: AppColors.white,
              ),
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageBuilder(
                key: _BillingKey,
                image: DhanvarshaImages.poa,
                value: "",
                url: BasicData.otpres?.distributorDetails?.distributor
                        ?.addressProofDocTypeImageUrl ??
                    '',
                isimageupload: () {
                  setState(() {
                    proofofaddimagePath =
                        _BillingKey.currentState!.imagepicked.value;
                    print('file name gstimagePath$proofofaddimagePath');
                    BasicData.proofaddimagepath = proofofaddimagePath;

                    buttoncolor = AppColors.buttonRed;
                    buttontextcolor = Colors.white;
                    isPOAUpload = true;
                  });
                },
              ),
              _getTitleBusiness(),
              _getTextBusiness(),
              !isPOAUpload
                  ? Container(
                      child: Column(
                        children: [
                          _UploadAddressProofButton(),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          _UploadAddressProofButton(),
                        ],
                      ),
                    )
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
            "Proof of Address",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'GothamMedium',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              DialogUtils.POAUploadInsturctionDialog(context);
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
        "Upload Address Proof",
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'GothamMedium',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _AddressProofContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        // color: AppColors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.white,
              ),
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getBillHeading(),
              if (isSwitched) _getBillTextDigit(name: "Document is on my or my family member's name"),
              if (!isSwitched)
                _getBillTextDigit(name: "Document is on my or my family member's name"),
              Visibility(visible: isSwitched, child: _billNumberEditText()),
              Visibility(
                  visible: isSwitched,
                  child: CustomImageBuilder(
                    key: _RentKey,
                    image: DhanvarshaImages.rena,
                    value: "",
                    url: BasicData.otpres?.distributorDetails?.distributor
                            ?.rentalAgreementImageUrl ??
                        '',
                    isimageupload: () {
                      setState(() {
                        rentalimagePath =
                            _RentKey.currentState!.imagepicked.value;
                        print('file name gstimagePath$rentalimagePath');
                        BasicData.rentalagreementimagepath = rentalimagePath;
                        isRentalUpload = true;
                      });
                    },
                  )),
              Visibility(
                visible: isSwitched,
                child: _getCertificateText(),
              ),
              !isRentalUpload
                  ? Container(
                      child: Column(
                        children: [
                          Visibility(
                              visible: isSwitched, child: _getTextRent()),
                          Visibility(
                              visible: isSwitched,
                              child: _UploadAddressProofButton(type: "Rent"))
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          /*Visibility(
                              visible: isSwitched, child: _getTextRent()),*/
                          Visibility(
                              visible: isSwitched,
                              child: _UploadAddressProofButton(type: "Rent"))
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBillHeading() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Name on bill",
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
                // print(isSwitched);
              });
            },
            activeTrackColor: AppColors.buttonRed,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _getBillTextDigit({String name = "Document is on my or my family member's name"}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
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

  Widget _billNumberEditText() {
    return (Container(
      margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
      child: TextField(
        controller: billingTextEditController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
        ],
        decoration: const InputDecoration(
          hintText: 'Enter Name',
        ),
      ),
    ));
  }

  Widget _getTextBusiness() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: CustomDropdown(
          title: "Select Document",
          dropdownMenuItemList: _AddressProofModelDropdownList,
          onChanged: onChangeFavouriteFoodModelDropdown,
          value: addressProof,
          isEnabled: true,
        ));
  }

  Widget _getCertificateText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Upload Rental Agreement",
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getTextRent() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Center(
        child: Text(
          "Ensure your name is mentioned in the agreement.",
          textAlign: TextAlign.center,
          style: CustomTextStyles.regularMediumGreyFont,
        ),
      ),
    );
  }

  Widget _UploadAddressProofButton({String type = "Address"}) {
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
              if (type == "Address") {
                _BillingKey.currentState!.openImagePicker();
              } else {
                _RentKey.currentState!.openImagePicker();
              }
              //Navigator.pushNamed(context, "myRoute");
            },
          ),
        ],
      ),
    );
  }
}

class FavouriteFoodModel {
  final String? foodName;
  final double? calories;

  FavouriteFoodModel({this.foodName, this.calories});
}
