import 'dart:convert';

import 'package:dhanvarsha/bloc/clientverify.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/customerdetailsbloc.dart';
import 'package:dhanvarsha/bloc/logindatabloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/clientverifydto.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/model/response/clientresponsedto.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/mastdto/master_image_dto.dart';
import 'package:dhanvarsha/model/response/panresponsedto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/numberverification.dart';
import 'package:dhanvarsha/ui/customerdetails/verifycustomernumber.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/commonloansteps.dart';
import 'package:dhanvarsha/ui/loantype/pandetails.dart';
import 'package:dhanvarsha/ui/loantype/selectloantype.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/constants/values/app_amounts.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/currencyformatter.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/utils/formatters/indianformatter.dart';
import 'package:dhanvarsha/utils/formatters/uppercaseformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvapitextfield.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomerDetails extends StatefulWidget {
  final BuildContext context;
  final String panFileName;
  final String panFilePath;

  const CustomerDetails(
      {Key? key,
      required this.context,
      required this.panFileName,
      required this.panFilePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails>
    implements AppLoadingMultiple {
  GlobalKey<_CustomerDetailsState> _scrollViewKey = GlobalKey();
  MenueBuilder? empTypBuilder;
  CustomerDetailsBloc? detailsBloc;
  int count = -1;
  PanDetailsBloc? panDetailsBloc;
  var isValidatePressed = false;
  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  late TextEditingController firstEditingController;
  late TextEditingController middleEditingController;
  late TextEditingController lastEditingController;
  late TextEditingController mobilenumberEditingController;
  late TextEditingController loanamountEditingController;
  late TextEditingController panNumberEditingController;
  late CustomerBoardingBloc boardingBloc;
  TextEditingController pinEditingController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  // TextEditingController dateController = new TextEditingController();
  late bool isFetchCalled;
  MasterBloc? masterBloc;
  DSALoginResponseDTO? loginResponseDTO;
  late ClientVerifyBloc clientVerifyBloc;
  @override
  void initState() {
    detailsBloc = CustomerDetailsBloc();
    panDetailsBloc = PanDetailsBloc();
    BlocProvider.setBloc<PanDetailsBloc>(panDetailsBloc);
    plFetchBloc = PLFetchBloc();
    firstEditingController = new TextEditingController();
    middleEditingController = new TextEditingController();
    lastEditingController = new TextEditingController();
    mobilenumberEditingController = new TextEditingController();
    loanamountEditingController = new TextEditingController();
    panNumberEditingController = new TextEditingController();

    BlocProvider.setBloc<PLFetchBloc>(plFetchBloc);

    ClientVerifyBloc clientVerifyBlocPan =
        BlocProvider.getBloc<ClientVerifyBloc>(identifier: "PANCOMMON");
    clientVerifyBloc = ClientVerifyBloc(this);
    // BlocProvider.setBloc<ClientVerifyBloc>(clientVerifyBloc);

    if (clientVerifyBlocPan.panResponseDTO != null) {
      if (clientVerifyBlocPan.panResponseDTO!.panNumber != null) {
        panNumberEditingController.text =
            clientVerifyBlocPan!.panResponseDTO!.panNumber!;

        firstEditingController.text =
            clientVerifyBlocPan!.panResponseDTO!.firstName!;

        middleEditingController.text =
            clientVerifyBlocPan!.panResponseDTO!.middleName!;

        lastEditingController.text =
            clientVerifyBlocPan!.panResponseDTO!.lastName!;

        dateController.text = clientVerifyBlocPan!.panResponseDTO!.dateOfBirth!;

        // firstEditingController.text = clientVerifyBloc!.panResponseDTO!.firstName!;
      }
    }

    // mobilenumberEditingController.addListener(_printLatestValue);
    boardingBloc = CustomerBoardingBloc();
    isFetchCalled = true;
    empTypBuilder = MenueBuilder();
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    super.initState();
  }

  late PLFetchBloc plFetchBloc;

  List<MasterImageDTO> empType = [
    new MasterImageDTO(
        "Salaried", 1, DhanvarshaImages.salariedpic, "Employed with a company"),
    new MasterImageDTO("Self Employed", 2, DhanvarshaImages.nonsalariedpic,
        "Runs own business "),
  ];

  @override
  void dispose() {
    // mobilenumberEditingController.removeListener(_printLatestValue);
    firstEditingController.dispose();
    middleEditingController.dispose();
    lastEditingController.dispose();
    mobilenumberEditingController.dispose();
    loanamountEditingController.dispose();
    pinEditingController.dispose();
    panNumberEditingController.dispose();
    dateController.dispose();
    // dateController.dispose();
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isBackDialogRequired: true,
        type: false,
        body: ValueListenableBuilder(
            valueListenable: panDetailsBloc!.connectionStatusOfPanDetails,
            builder: (_, status, Widget? child) {
              print("Widget Updated.............->");
              return SingleChildScrollView(
                key: _scrollViewKey,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        50,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _getTitleCompoenent(),
                          Visibility(
                              visible: false,
                              child: _getHoirzontalImageUpload()),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: firstEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "First name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter first name (as on PAN)",
                              errorText: "Please enter first name",
                              maxLine: 1,
                              isTitleVisible: true,
                              isValidatePressed: isValidatePressed,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: middleEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Middle name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter middle name (Optional)",
                              errorText: "Please enter middle name",
                              maxLine: 1,
                              isValidatePressed: false,
                              isTitleVisible: true,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: lastEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Last name",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z_ ]"))
                              ],
                              hintText: "Enter last name (as on PAN)",
                              errorText: "Please enter last name",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              isTitleVisible: true,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.text,
                              controller: panNumberEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Pan number",
                              textInpuFormatter: [
                                UpperCaseTextFormatter(),
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Za-z0-9]')),
                              ],
                              hintText: "Enter pan number (as on PAN)",
                              errorText: "Please enter valid pan number",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              isTitleVisible: true,
                              type: Validation.isPan,
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: dateController,
                              builder: (context, snackBarBuilder, _) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDatePicker(
                                    controller: dateController,
                                    isValidateUser: isValidatePressed,
                                    selectedDate: dateController.text,
                                    isTitleVisible: true,
                                    title: 'Select Date of birth',
                                  ),
                                );
                              }),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              textInputType: TextInputType.number,
                              controller: mobilenumberEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Customer's Mobile number",
                              textInpuFormatter: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              hintText: "Customer's mobile no",
                              is91: true,
                              isFlag: true,
                              errorText: "Please enter valid mobile number",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              type: Validation.mobileNumber,
                              isTitleVisible: true,
                            ),
                          ),
                          MenuDropDown(
                            headerTitle: "Employement type",
                            builder: empTypBuilder!,
                            isValidatePressed: isValidatePressed,
                            masterDto: empType,
                            hintText: "Select employment Type",
                            errorText: "Select employment type",
                            title: "Customer's employment type?",
                            isEmpPressed: true,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: DVTextField(
                              controller: loanamountEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Loan Amount",
                              textInpuFormatter: [
                                // IndianFormatter(),
                                CurrencyInputFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9,]')),
                              ],
                              hintText: "Loan amount",
                              errorText: "Please enter loan amount",
                              maxLine: 1,
                              isFlag: true,
                              image: DhanvarshaImages.ruppeeNew,
                              isValidatePressed: isValidatePressed,
                              textInputType: TextInputType.number,
                              isTitleVisible: true,
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(vertical: 10),
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     "Select Employment Type",
                          //     style: CustomTextStyles.regularMediumFont,
                          //   ),
                          // ),

                          // _getEmployementType(),

                          // MenuDropDown(
                          //   masterDto: masterBloc!.masterSuperDTO.empType,
                          //   builder: salaryType!,
                          //   isValidatePressed: isValidatePressed,
                          //   hintText: "Please enter employement type",
                          //   errorText: "Please enter customer employment type",
                          //   title: "Customer's employement type ?",
                          //   description: "Please select employement type",
                          // ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: DVApiTextField(
                              genericbloc: detailsBloc,
                              textInputType: TextInputType.number,
                              controller: pinEditingController,
                              outTextFieldDecoration:
                                  BoxDecorationStyles.outTextFieldBoxDecoration,
                              textInpuFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              inputDecoration: InputDecorationStyles
                                  .inputDecorationTextField,
                              title: "Pincode of residence",
                              hintText: "Current address pincode",
                              errorText: "Please enter valid pincode",
                              maxLine: 1,
                              isValidatePressed: isValidatePressed,
                              type: Validation.isValidPinCode,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        child: CustomButton(
                          onButtonPressed: () async {
                            setState(() {
                              isValidatePressed = true;
                            });

                            String data = await SharedPreferenceUtils
                                .sharedPreferenceUtils
                                .getLoginData();

                            loginResponseDTO =
                                DSALoginResponseDTO.fromJson(jsonDecode(data));

                            if (loginResponseDTO!.mobileNumber ==
                                mobilenumberEditingController!.text) {
                              SuccessfulResponse.showScaffoldMessage(
                                  "DSA Number should not be same as Customer Number",
                                  context);
                              return;
                            }

                            if (CustomValidator(mobilenumberEditingController
                                        .value.text)
                                    .validate(Validation.mobileNumber) &&
                                CustomValidator(pinEditingController.value.text)
                                    .validate(Validation.minLength) &&
                                CustomValidator(firstEditingController.value.text)
                                    .validate(Validation.isEmpty) &&
                                CustomValidator(lastEditingController.value.text)
                                    .validate(Validation.isEmpty) &&
                                CustomValidator(
                                        loanamountEditingController.value.text)
                                    .validate(Validation.isEmpty) &&
                                CustomValidator(panNumberEditingController.value.text)
                                    .validate(Validation.isPan) &&
                                detailsBloc?.pinverificationresponse?.message ==
                                    "Pincode exist" &&
                                empTypBuilder!.menuNotifier.value.length > 0 &&
                                CustomValidator(dateController.value.text)
                                    .validate(Validation.isEmpty)) {
                              if (empTypBuilder!.menuNotifier.value
                                      .elementAt(0)
                                      .value ==
                                  1) {
                                if (!(int.parse(loanamountEditingController.text
                                            .replaceAll(",", "")) >=
                                        AppAmounts.lowerPLAmount &&
                                    int.parse(loanamountEditingController.text
                                            .replaceAll(",", "")) <=
                                        AppAmounts.upperPLAmount)) {
                                  SuccessfulResponse.showScaffoldMessage(
                                      "Loan Amount should be in range between 1L to 5L",
                                      context);
                                  return;
                                }
                              } else if (empTypBuilder!.menuNotifier.value
                                      .elementAt(0)
                                      .value ==
                                  2) {
                                if (!(int.parse(loanamountEditingController.text
                                            .replaceAll(",", "")) >=
                                        AppAmounts.lowerBLAmount &&
                                    int.parse(loanamountEditingController.text
                                            .replaceAll(",", "")) <=
                                        AppAmounts.upperBLAmount)) {
                                  SuccessfulResponse.showScaffoldMessage(
                                      "Loan Amount should be in range between 1L to 20L",
                                      context);
                                  return;
                                }
                              }

                              CustomerDetailsDTO.mobileNumber =
                                  mobilenumberEditingController.text;
                              CustomerDetailsDTO.empName =
                                  firstEditingController.text + " ";

                              CustomerOnBoarding.FirstName =
                                  firstEditingController.text;
                              CustomerOnBoarding.MobileNumber =
                                  mobilenumberEditingController.text;
                              CustomerOnBoarding.LastName =
                                  lastEditingController.text;
                              CustomerOnBoarding.FatherName =
                                  middleEditingController.text;
                              CustomerOnBoarding.LoanAmount = int.parse(
                                  loanamountEditingController.text
                                      .replaceAll(",", ""));
                              CustomerOnBoarding.Pincode =
                                  pinEditingController.text;
                              CustomerOnBoarding.ModeOfSalary =
                                  empTypBuilder!.menuNotifier.value[0].name!;

                              CustomerOnBoarding.PANNumber =
                                  panNumberEditingController.text;

                              await verifyClient();
                              // await pusDataToServer();
                              CustomerOnBoarding.printAll();
                            } else {
                              SuccessfulResponse.showScaffoldMessage(
                                  AppConstants.fillAllDetails, context);
                            }
                          },
                          title: "CREATE APPLICATION",
                          boxDecoration:
                              ButtonStyles.redButtonWithCircularBorder,
                        ),
                      ),
                      // Text(jsonEncode(plFetchBloc.onBoardingDTO))
                    ],
                  ),
                ),
              );
            }),
        context: context);
  }

  verifyClient() async {
    ClientVerifyDTO clientVerifyDTO = ClientVerifyDTO();
    clientVerifyDTO.pincode = pinEditingController.text;
    clientVerifyDTO.loanAmount =
        int.parse(loanamountEditingController.text.replaceAll(",", ""));
    clientVerifyDTO.mobileNo = mobilenumberEditingController.text;
    clientVerifyDTO.fullName = firstEditingController.text +
        " " +
        middleEditingController.text +
        " " +
        lastEditingController.text;
    clientVerifyDTO.pAN = panNumberEditingController.text;
    clientVerifyDTO.PanFileName = widget.panFileName;
    clientVerifyDTO.DOB = dateController.text;

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          clientVerifyDTO.toEncodedJson()),
      "Myfiles": [
        await MultipartFile.fromFileSync(widget.panFilePath,
            filename: widget.panFileName)
      ],
    });

    clientVerifyBloc.verifyClient(formData);
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      child: Column(
        children: [
          CustomImageBuilder(
              isAadhaarORPan: false,
              isPan: true,
              initialImage: "",
              key: _panPickey,
              image: DhanvarshaImages.npan,
              value: "Upload Customer's PAN",
              description: AppConstants.aadharUploadDescription,
              no: (clientVerifyBloc?.panResponseDTO?.panNumber != null &&
                      clientVerifyBloc?.panResponseDTO?.panNumber != "")
                  ? "PAN :- ${clientVerifyBloc?.panResponseDTO?.panNumber}"
                  : "",
              firstImageUploaded: () {
                uploadPanToServer();
                // if (_profilePickey.currentState!.imagepicked.value != "" &&
                //     _panPickey.currentState!.imagepicked.value != "" &&
                //     !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                //         .isAbsolute &&
                //     !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                //         .isAbsolute) {
                //   faceMatch();
              }),
        ],
      ),
    );
  }

  uploadPanToServer() async {
    PanUpload panUpload = PanUpload(
        fileName: _panPickey.currentState!.fileName, id: 0, type: "Common");
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(jsonEncode(panUpload)),
      "Myfiles": await MultipartFile.fromFileSync(
          _panPickey.currentState!.imagepicked.value,
          filename: _panPickey.currentState!.fileName),
    });

    clientVerifyBloc.getPanOcrDetails(formData);
    // panDetailsBloc!.getPanDetails(
    //     jsonEncode(panUpload!.toJson()),
    //     _panPickey.currentState!.imagepicked!.value!,
    //     _panPickey.currentState!.fileName,
    //     context);
  }
  // pusDataToServer() async {
  //   CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
  //   if (onBoardingDto != null) {
  //     onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
  //     onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender;
  //     onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
  //     onBoardingDto.bankStatements = [];
  //     onBoardingDto.salarySlips = [];
  //     onBoardingDto.aadharNumber = plFetchBloc.onBoardingDTO!.aadharNumber;
  //     onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
  //     onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
  //     onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
  //     onBoardingDto.pANNumber = plFetchBloc.onBoardingDTO!.pANNumber;
  //     onBoardingDto.pANImage = "";
  //     onBoardingDto.isAadharLinkedToMobile =
  //         plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
  //     onBoardingDto.aadharNumber = plFetchBloc.onBoardingDTO!.aadharNumber;
  //     onBoardingDto.customerImage = "";
  //     onBoardingDto.emailID = plFetchBloc.onBoardingDTO!.emailID;
  //     onBoardingDto.presentMonthlyEMI =
  //         plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
  //     onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
  //     onBoardingDto.allFormFlag = "N";
  //     onBoardingDto.dOB = plFetchBloc.onBoardingDTO!.dOB;
  //     ;
  //     onBoardingDto.pincode = plFetchBloc.onBoardingDTO!.pincode; // changine
  //     onBoardingDto.currentAddress1 =
  //         plFetchBloc.onBoardingDTO!.currentAddress1;
  //     ;
  //     onBoardingDto.currentAddress2 =
  //         plFetchBloc.onBoardingDTO!.currentAddress2;
  //     ;
  //     onBoardingDto.currentAddress3 =
  //         plFetchBloc.onBoardingDTO!.currentAddress3;
  //     onBoardingDto.permanentAddress1 =
  //         plFetchBloc.onBoardingDTO!.permanentAddress1;
  //     onBoardingDto.permanentAddress2 =
  //         plFetchBloc.onBoardingDTO!.permanentAddress2;
  //     onBoardingDto.permanentAddress3 =
  //         plFetchBloc.onBoardingDTO!.permanentAddress3;
  //     onBoardingDto.aadharFrontImage = "";
  //     onBoardingDto.aadharBackImage = "";
  //     onBoardingDto.employmentProofPhoto = "";
  //     onBoardingDto.employmentIDPhoto = "";
  //     onBoardingDto.oKYCDocument = "";
  //     onBoardingDto.loanAmount =
  //         CustomerOnBoarding.LoanAmount.toDouble(); // changinef
  //     onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
  //     onBoardingDto.employerName = plFetchBloc.onBoardingDTO!.employerName;
  //     onBoardingDto.entityTypeEmployer =
  //         plFetchBloc.onBoardingDTO!.entityTypeEmployer;
  //     onBoardingDto.modeOfSalary = plFetchBloc.onBoardingDTO!.modeOfSalary;
  //     onBoardingDto.netSalary = plFetchBloc.onBoardingDTO!.netSalary;
  //     onBoardingDto.employmentType = plFetchBloc.onBoardingDTO!.employmentType;
  //     onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
  //     onBoardingDto.addressProof = plFetchBloc.onBoardingDTO!.addressProof;
  //     onBoardingDto.addressProofPhoto = "";
  //     onBoardingDto.rentalAgreementImage = "";
  //
  //     FormData formData = FormData.fromMap({
  //       'json': await EncryptionUtils.getEncryptedText(
  //           onBoardingDto.toJsonEncode()),
  //       // "Myfiles": appFiles,
  //     });
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => NumberVerification(
  //           context: context,
  //           count: empTypBuilder!.menuNotifier.value[0].value!,
  //         ),
  //       ),
  //     );
  //     // print(formData.files[0].value);
  //     // boardingBloc.applyForPersonalLoan(
  //     //     formData,
  //     //     context,
  //     //     (dto) => {
  //     //           if (dto!.status!)
  //     //             {
  //     //               SuccessfulResponse.showScaffoldMessage(
  //     //                   dto.message!, context),
  //     //               Navigator.push(
  //     //                 context,
  //     //                 MaterialPageRoute(
  //     //                   builder: (context) => NumberVerification(
  //     //                     context: context,
  //     //                     count: empTypBuilder!.menuNotifier.value[0].value!,
  //     //                   ),
  //     //                 ),
  //     //               )
  //     //             }
  //     //           else
  //     //             {
  //     //               SuccessfulResponse.showScaffoldMessage(
  //     //                   dto.message!, context),
  //     //             }
  //     //         });
  //   }
  //   // print(onBoardingDto.toJsonEncode());
  // }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    if (index == 0) {
      // print("INTO THE SUCCESSFUL RESPONSE ADD CLIENT");
      ClientVerifyResponseDTO clientVerifyResponseDTO =
          ClientVerifyResponseDTO.fromJson(jsonDecode(dto.data!));

      if (clientVerifyResponseDTO.statusFlag == "R") {
        DialogUtils.offerrejectedByLoan1(context,
            message: "You can re-apply for the customer\nafter",
            days: clientVerifyResponseDTO.noDays!);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberVerification(
              context: context,
              isChangeNumber: false,
              count: empTypBuilder!.menuNotifier.value[0].value!,
              mobileNumber: mobilenumberEditingController.text,
              otp: clientVerifyResponseDTO.oTP.toString(),
              refId: clientVerifyResponseDTO.refID!,
              clientID: clientVerifyResponseDTO.clientId!,
              loanID: clientVerifyResponseDTO.loanId!,
              statusFlag: clientVerifyResponseDTO!.statusFlag!,
              name: firstEditingController.text +
                  " " +
                  lastEditingController.text,
            ),
          ),
        );
      }
    } else {
      print("PAN RESPONSE IS ------------------------------------->");
      print(jsonEncode(dto.data!));
      PanResponseDTO panResponseDTO =
          PanResponseDTO.fromJson(jsonDecode(dto.data!));

      firstEditingController.text = panResponseDTO.firstName!;
      middleEditingController.text = panResponseDTO.middleName!;
      lastEditingController.text = panResponseDTO.lastName!;
      panNumberEditingController.text = panResponseDTO.panNumber!;
      dateController.text = panResponseDTO.dateOfBirth!;

      dateController.notifyListeners();
      panDetailsBloc!.connectionStatusOfPanDetails.notifyListeners();
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}

Widget _getTitleCompoenent() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    alignment: Alignment.topLeft,
    child: Text(
      "Add Customer Details",
      style: CustomTextStyles.boldLargeFontsGotham,
    ),
  );
}
