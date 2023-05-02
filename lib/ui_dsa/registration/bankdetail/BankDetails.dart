import 'package:dhanvarsha/bloc_dsa/PartialFormBloc.dart';
import 'package:dhanvarsha/bloc_dsa/completeformbloc.dart';
import 'package:dhanvarsha/constant_dsa/BasicData.dart';
import 'package:dhanvarsha/constant_dsa/colors.dart';
import 'package:dhanvarsha/constant_dsa/dhanvarshaimages.dart';
import 'package:dhanvarsha/model_dsa/response/dropdownresponse.dart';
import 'package:dhanvarsha/ui_dsa/BaseView.dart';
import 'package:dhanvarsha/ui_dsa/loader/dhanvarsha_loader.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/size_config.dart';
import 'package:dhanvarsha/utils_dsa/boxdecoration.dart';
import 'package:dhanvarsha/utils_dsa/customtextstyles.dart';
import 'package:dhanvarsha/utils_dsa/customvalidator.dart';
import 'package:dhanvarsha/utils_dsa/imagebuilder/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dhanvarsha/utils_dsa/mock_handler/data.dart';
import 'package:dhanvarsha/widget_dsa/Buttons/custombutton.dart';
import 'package:dhanvarsha/widget_dsa/custom_textfield/BDtextfield.dart';
import 'package:dhanvarsha/widget_dsa/dropdown/customdropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key, required BuildContext context})
      : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController banknameEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.bankName ?? '');
  TextEditingController ifscEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.iFSCCode ?? '');
  TextEditingController accnumEditingController = new TextEditingController(
      text: BasicData.otpres?.distributorDetails?.distributor?.accountNumber ??
          '');
  TextEditingController fnameEditingController = new TextEditingController(
      text: BasicData
              .otpres?.distributorDetails?.distributor?.nameOfAccountHolder ??
          '');
  TextEditingController mnameEditingController = new TextEditingController();
  TextEditingController lnameEditingController = new TextEditingController();
  GlobalKey<CustomImageBuilderState> _ChequeKey = GlobalKey();

  Color buttoncolor = AppColors.buttonRedWithOpacity;
  Color buttontextcolor = AppColors.white;
  bool isChequeViewShown = false;

  GlobalKey<_BankDetailsState> bankKey = GlobalKey();

  CompleteformBloc com1 = new CompleteformBloc();
  PartialFormBloc p1 = new PartialFormBloc();

  var isValidatePressed = false;

  BankData bankData = new BankData();
  late List<DropdownMenuItem<BankData>> _BankDataModelDropdownList;

  String chequeimagePath = '';

  List<DropdownMenuItem<BankData>> _buildBankDataModelDropdown(
      List BankDataModelList) {
    List<DropdownMenuItem<BankData>> items = [];
    for (BankData businesstypeModel in BankDataModelList) {
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

  onChangeFavouriteFoodModelDropdown(BankData? bd) {
    setState(() {
      bankData = bd!;
    });
  }

  @override
  void initState() {
    super.initState();

    // this._typeAheadController.text=BasicData.bankname;
    //
    // if (BasicData.otpres?.distributorDetails?.distributor?.iFSCCode != '') {
    //   setState(() {
    //     buttoncolor = Colors.red.shade800;
    //     buttontextcolor = Colors.white;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: "",
      type: false,
      isStepShown: true,
      stepArray: [5, 5],
      body: _getBody(),
      context: context,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;
  Widget _getBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          key: bankKey,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //   child: DVTextField(
                    //     controller: banknameEditingController,
                    //     outTextFieldDecoration:
                    //     BoxDecorationStyles.outTextFieldBoxDecoration,
                    //     inputDecoration: InputDecorationStyles.inputDecorationTextField,
                    //     title: "Bank Name",
                    //     hintText: "Select Bank",
                    //     errorText: "Type Your Query Here",
                    //     maxLine: 1,
                    //     isValidatePressed: isValidatePressed,
                    //   ),
                    // ),

                    _getTitleCompoenent(),
                    Form(
                      key: this._formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              errorStyle: CustomTextStyles.boldsmallRedFont,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: AppColors.buttonRed, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: AppColors.buttonRed, width: 1),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "Bank name",
                              labelStyle: TextStyle(
                                  color: AppColors.lightGrey3,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w100),
                              hintStyle: CustomTextStyles.regularMediumFont,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lighterGrey4, width: 0.1),
                              ),
                              filled: true,
                              alignLabelWithHint: true,
                              focusColor: AppColors.lighterGrey4,
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lighterGrey4, width: 0.1),
                              ),
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.lighterGrey4, width: 0.1),
                              ),
                            ),
                            controller: this._typeAheadController,
                          ),
                          suggestionsCallback: (pattern) {
                            return CitiesService.getSuggestions(
                                pattern, BasicData.dd!.bankData!);
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          hideOnEmpty: true,
                          transitionBuilder: (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (String suggestion) {
                            this._typeAheadController.text = suggestion;
                            _formKey.currentState!.validate();
                          },
                          validator: (value) =>
                          value!.isEmpty ? 'Please select bank name' : null,
                          onSaved: (value) => this._selectedCity = value,
                        ),
                      ),
                    ),

                    // Container(
                    //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //     child: CustomDropdown(
                    //       dropdownMenuItemList: _BankDataModelDropdownList,
                    //       onChanged: onChangeFavouriteFoodModelDropdown,
                    //       value: bankData,
                    //       isEnabled: true,
                    //       title: "Select Bank Name",
                    //     )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: BDtextfield(
                        controller: ifscEditingController,
                        outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                        inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                        title: "IFSC Code",
                        hintText: "Enter IFSC Code",
                        errorText: "Please Enter IFSC Code",
                        textInpuFormatter: [
                          UpperCaseTextFormatter()
                        ],
                        maxLine: 1,
                        isValidatePressed: isValidatePressed,
                        type: 'isIFSC',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: BDtextfield(
                        controller: accnumEditingController,
                        outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                        inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                        title: "Account Number",
                        hintText: "Enter Account Number",
                        textInpuFormatter: [
                          UpperCaseTextFormatter()
                        ],
                        errorText: "Please Enter Account Number",
                        maxLine: 1,
                        isValidatePressed: isValidatePressed,
                        type: 'isAccount',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: BDtextfield(
                        controller: fnameEditingController,
                        outTextFieldDecoration:
                        BoxDecorationStyles.outTextFieldBoxDecoration,
                        inputDecoration:
                        InputDecorationStyles.inputDecorationTextField,
                        title: "First Name of Account Holder",
                        hintText: "Enter Full Name of Account holder",
                        errorText: "Please Enter Full Name of Account holder",
                        maxLine: 1,
                        textInpuFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                        ],
                        isValidatePressed: isValidatePressed,
                      ),
                    ),

                    _getChequeImageUpload(),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child: CustomButton(
                    onButtonPressed: () {
                      setState(() {
                        isValidatePressed = true;
                      });

                      _formKey.currentState!.validate();

                      if (bankData.name == 'Select Bank Name' && false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Select Bank Name")));
                      } else {
                        if (CustomValidator(ifscEditingController.value.text)
                                .validate('isIFSC') &&
                            CustomValidator(accnumEditingController.value.text)
                                .validate('isAccount') &&
                            CustomValidator(fnameEditingController.value.text)
                                .validate('isEmpty') &&
                            _formKey.currentState!.validate()) {
                          if (!BasicData.cancelchequeimagepath.isEmpty) {
                            BasicData.bankname =
                                this._typeAheadController.text!;
                            BasicData.ifsc = ifscEditingController.text;
                            BasicData.accnumber = accnumEditingController.text;
                            BasicData.namofaccholder =
                                fnameEditingController.text;


                            p1.submitform('e', context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please upload Cancelled Cheque Image")));
                          }
                        }
                      }

                      ///////
                      //
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => AppReceived(
                      //             context: context,
                      //           )),
                      // );
                    },
                    title: "SUBMIT APPLICATION",
                    boxDecoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: buttoncolor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    textColor: buttontextcolor,
                  ),
                ),
              ],
            ),
          ),
        ),
        DhanvarshaLoader(),
      ],
    );
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bank Details",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'GothamMedium',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _getChequeImageUpload() {
    return Container(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
              isChequeViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleCheque(),
                        ],
                      ),
                    )
                  : Container(),
              CustomImageBuilder(
                key: _ChequeKey,
                value: "",
                image: DhanvarshaImages.chequeImage,
                url: BasicData.otpres?.distributorDetails?.distributor
                        ?.cancelledChequeImageUrl ??
                    '',
                isimageupload: () {
                  setState(() {
                    isChequeViewShown = true;
                    chequeimagePath =
                        _ChequeKey.currentState!.imagepicked.value;
                    print('file name gstimagePath$chequeimagePath');
                    BasicData.cancelchequeimagepath = chequeimagePath;

                    buttoncolor = AppColors.buttonRed;
                    buttontextcolor = Colors.white;
                  });
                },
              ),
              !isChequeViewShown
                  ? Container(
                      child: Column(
                        children: [
                          _getTitleCheque(),
                          _getTextCheque(),
                          _TakeChequeButton(),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          //_getTitleCheque(),
                          //_getTextCheque(),
                          _TakeChequeButton(),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleCheque({String name = "Upload Cancelled Cheque"}) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'GothamMedium',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getTextCheque() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
      child: Center(
        child: Text(
          "Mandatory for verification",
          textAlign: TextAlign.center,
          style: CustomTextStyles.regularMediumGreyFont,
        ),
      ),
    );
  }

  Widget _TakeChequeButton() {
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
              _ChequeKey.currentState!.openImagePicker();
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
