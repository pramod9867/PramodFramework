import 'dart:convert';

import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/empsearchbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/customerdetails.dart';
import 'package:dhanvarsha/model/request/clientinitiaterequest.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/empsearchrequestdto.dart';
import 'package:dhanvarsha/model/request/prequal_request_dto.dart';
import 'package:dhanvarsha/model/request/prequalrequestnew.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/preequalresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/application_rejected.dart';
import 'package:dhanvarsha/ui/loanreward/customerloanreward.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/formatters/currencyformatter.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/autocomplete/autocomplete.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_dropdown_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmployeeDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails>
    implements AppLoading {
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;
  late CustomerBoardingBloc boardingBlocClientInitiate;
  MasterDataDTO _favouriteFoodModel =
      MasterDataDTO("Select mode of payment", 0);
  late List<DropdownMenuItem<MasterDataDTO>> _favouriteFoodModelDropdownList;
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Select Gender"}) {
    dropdownMenuItems.add(DropdownMenuItem(
      value: MasterDataDTO(initialType, 0),
      child: Text(
        initialType!,
        style: CustomTextStyles.regularMediumGreyFont1,
      ),
    ));

    print(model.value);
    for (MasterDataDTO favouriteFoodModel in favouriteFoodModelList) {
      print("Into the array");
      print(model.value);
      print(favouriteFoodModel.value);
      dropdownMenuItems.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(favouriteFoodModel.name!,
            style: model.value == favouriteFoodModel.value
                ? CustomTextStyles.regularMediumFont
                : CustomTextStyles.boldMediumFont),
      ));
    }
    return dropdownMenuItems;
  }

  bool isSwitchPressed = false;
  bool isCurrentSwitchPressed = false;
  onChangeFavouriteFoodModelDropdown(MasterDataDTO? favouriteFoodModel) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _favouriteFoodModel = favouriteFoodModel!;
        _favouriteFoodModelDropdownList = [];
        _favouriteFoodModelDropdownList = _buildFavouriteFoodModelDropdown(
            masterBloc?.masterSuperDTO?.modeOfSalary ?? [],
            _favouriteFoodModelDropdownList,
            _favouriteFoodModel);
      });
    }
  }

  var isValidatePressed = false;
  late MasterBloc? masterBloc;
  int count = -1;

  TextEditingController officialEmailid = new TextEditingController();
  TextEditingController netSalaryInBank = new TextEditingController();
  TextEditingController monthlyEMI = new TextEditingController();
  TextEditingController employeename = new TextEditingController();
  TextEditingController employername = new TextEditingController();

  late EmpSearchBloc empSearchBloc;
  late MenueBuilder employeeTypeBuilder;
  late MenueBuilder entityTypeBuilder;
  late MenueBuilder employementEngBuilder;
  @override
  void initState() {
    super.initState();
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();

    boardingBloc = CustomerBoardingBloc();

    boardingBlocClientInitiate = CustomerBoardingBloc.appLoadingClient(this);
    BlocProvider.setBloc<CustomerBoardingBloc>(boardingBloc);
    empSearchBloc = EmpSearchBloc();
    BlocProvider.setBloc<EmpSearchBloc>(empSearchBloc);

    _favouriteFoodModelDropdownList = [];
    _favouriteFoodModelDropdownList = _buildFavouriteFoodModelDropdown(
        masterBloc?.masterSuperDTO.modeOfSalary ?? [],
        _favouriteFoodModelDropdownList,
        _favouriteFoodModel,
        initialType: "Mode Of Payment");
    int index = MasterDocumentId.builder.getModeOfSalaryIndex(
        plFetchBloc?.onBoardingDTO?.modeOfSalaryCdSalaryMode ?? 0);

    if (index == 0) {
      _favouriteFoodModel = _favouriteFoodModelDropdownList.elementAt(0).value!;
    } else {
      _favouriteFoodModel = masterBloc!.masterSuperDTO!.modeOfSalary![index];

      _favouriteFoodModelDropdownList = [];
      _favouriteFoodModelDropdownList = _buildFavouriteFoodModelDropdown(
          masterBloc?.masterSuperDTO.modeOfSalary ?? [],
          _favouriteFoodModelDropdownList,
          _favouriteFoodModel,
          initialType: "Mode Of Payment");
    }
    employeeTypeBuilder = MenueBuilder();
    employeeTypeBuilder
        .setInitialValue(MasterDocumentId.builder.getMasterObjectCompany(0));
    entityTypeBuilder = MenueBuilder();
    entityTypeBuilder.setInitialValue(MasterDocumentId.builder
        .getMasterObjectCompany(
            plFetchBloc.onBoardingDTO?.companyTypeCdCompanyTypeId ?? 0));
    employementEngBuilder = MenueBuilder();
    employementEngBuilder.setInitialValue(MasterDocumentId.builder
        .getMasterObjectEmpEng(
            plFetchBloc.onBoardingDTO?.employmentTypeCdEmploymentType ?? 0));
    officialEmailid.text = plFetchBloc.onBoardingDTO!.emailID!;
    netSalaryInBank.text =
        plFetchBloc.onBoardingDTO!.netSalary!.toInt().toString() == "0"
            ? ""
            : plFetchBloc.onBoardingDTO!.netSalary!.toInt().toString();
    monthlyEMI.text =
        plFetchBloc.onBoardingDTO!.presentMonthlyEMI!.toInt().toString() == "0"
            ? ""
            : plFetchBloc.onBoardingDTO!.presentMonthlyEMI!.toInt().toString();
  }

  GlobalKey<_EmployeeDetailsState> _scrollViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        isBackDialogRequired: true,
        isStepShown: true,
        stepArray: [2, 2],
        body: SingleChildScrollView(
          key: _scrollViewKey,
          child: _getBody(),
        ),
        context: context);
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Customer's Employment Details",
          style: CustomTextStyles.boldSubtitleLargeFonts,
        ),
      ),
    );
  }

  Widget _getBody() {
    return Container(
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight -
              45 -
              MediaQuery.of(context).viewInsets.top -
              MediaQuery.of(context).viewInsets.bottom -
              30),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _getTitleCompoenentNEW(),
              MenuDropDownApi(
                onChangedText: (text) async {
                  EmployerRequestDTO requestDTO = EmployerRequestDTO();
                  requestDTO.companyName = text;

                  if (text.length >= 1) {
                    FormData formData = FormData.fromMap({
                      'json': await EncryptionUtils.getEncryptedText(
                          requestDTO.toEncodedJson()),
                    });

                    empSearchBloc.getEmpSearchOptions(formData);
                  } else {
                    // SuccessfulResponse.showScaffoldMessage(
                    //     "Please enter something", context);
                  }
                },
                // onFieldSubmit: (text) async {
                //   EmployerRequestDTO requestDTO = EmployerRequestDTO();
                //   requestDTO.companyName = text;
                //
                //   if (text.length > 0) {
                //     FormData formData = FormData.fromMap({
                //       'json': await EncryptionUtils.getEncryptedText(
                //           requestDTO.toEncodedJson()),
                //     });
                //
                //     empSearchBloc.getEmpSearchOptions(formData);
                //   } else {
                //     SuccessfulResponse.showScaffoldMessage(
                //         "Please enter something", context);
                //   }
                // },
                bloc: empSearchBloc,
                masterDto: masterBloc?.masterSuperDTO.companyType,
                builder: employeeTypeBuilder,
                isValidatePressed: isValidatePressed,
                hintText: "Select employer name",
                errorText: "Select employer name",
                title: "Select employer name",
                description: "Select employer name",
                isTitleVisible: true,
                headerTitle: "Select employer name",
                onSearchField: (text) async {
                  EmployerRequestDTO requestDTO = EmployerRequestDTO();
                  requestDTO.companyName = text;

                  if (text.length >= 1) {
                    FormData formData = FormData.fromMap({
                      'json': await EncryptionUtils.getEncryptedText(
                          requestDTO.toEncodedJson()),
                    });

                    empSearchBloc.getEmpSearchOptions(formData);
                  } else {
                    SuccessfulResponse.showScaffoldMessage(
                        "Please enter something", context);
                  }
                },
              ),
              MenuDropDown(
                masterDto: masterBloc?.masterSuperDTO.companyType,
                builder: entityTypeBuilder,
                isValidatePressed: isValidatePressed,
                hintText: "Entity type of the employer",
                errorText: "Select entity type of employer",
                title: "Select entity type of employer",
                description: "Select entity type of the employer",
                isTitleVisible: true,
                headerTitle: "Select entity type of the employer",
              ),
              MenuDropDown(
                masterDto: masterBloc?.masterSuperDTO.empType,
                builder: employementEngBuilder,
                isValidatePressed: isValidatePressed,
                hintText: "Select employee type",
                errorText: "Select employee type",
                title: "Select employee type",
                description: "Select employee type",
                isTitleVisible: true,
                headerTitle: "Select employee type",
              ),
              // MulitpleButton(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: DVTextField(
                  textInputType: TextInputType.text,
                  controller: officialEmailid,
                  outTextFieldDecoration:
                      BoxDecorationStyles.outTextFieldBoxDecoration,
                  inputDecoration:
                      InputDecorationStyles.inputDecorationTextField,
                  title: "Official email id of the customer",
                  hintText: "Customer's official email id",
                  errorText: "Please enter valid email id",
                  maxLine: 1,
                  isValidatePressed: isValidatePressed,
                  type: Validation.isEmail,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: DVTextField(
                  textInputType: TextInputType.number,
                  controller: netSalaryInBank,
                  outTextFieldDecoration:
                      BoxDecorationStyles.outTextFieldBoxDecoration,
                  inputDecoration:
                      InputDecorationStyles.inputDecorationTextField,
                  title: "Net salary",
                  hintText: "Net salary",
                  errorText: "Please enter valid net salary",
                  isFlag: true,
                  image: DhanvarshaImages.ruppeeNew,
                  textInpuFormatter: [
                    CurrencyInputFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                  ],
                  maxLine: 1,
                  isValidatePressed: isValidatePressed,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDropdownMaster(
                    dropdownMenuItemList: _favouriteFoodModelDropdownList,
                    onChanged: onChangeFavouriteFoodModelDropdown,
                    value: _favouriteFoodModel,
                    isEnabled: true,
                    title: "Mode of salary payment",
                    isTitleVisible: true,
                    errorText: "Please select mode of payment",
                    isValidate: isValidatePressed,
                  )),
              Divider(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: DVTextField(
                  image: DhanvarshaImages.ruppeeNew,
                  textInputType: TextInputType.number,
                  controller: monthlyEMI,
                  isFlag: true,
                  outTextFieldDecoration:
                      BoxDecorationStyles.outTextFieldBoxDecoration,
                  inputDecoration:
                      InputDecorationStyles.inputDecorationTextField,
                  title: "Present monthly EMI",
                  hintText: "Enter current monthly EMI",
                  errorText: "Please enter valid present monthly emi",
                  maxLine: 1,
                  textInpuFormatter: [
                    CurrencyInputFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                  ],
                  isValidatePressed: isValidatePressed,
                ),
              ),
            ],
          ),
          // _getHoirzontalImageUpload(),
          CustomButton(
              onButtonPressed: () {
                setState(() {
                  isValidatePressed = true;
                });

                print("Here it is !");

                if (entityTypeBuilder.menuNotifier.value.length > 0 &&
                    employeeTypeBuilder.menuNotifier.value.length > 0 &&
                    employementEngBuilder.menuNotifier.value.length > 0 &&
                    CustomValidator(officialEmailid.value.text)
                        .validate(Validation.isEmail) &&
                    CustomValidator(netSalaryInBank.value.text)
                        .validate(Validation.isEmpty) &&
                    CustomValidator(monthlyEMI.value.text)
                        .validate(Validation.isEmpty) &&
                    _favouriteFoodModel.value != 0) {
                  if (true) {
                    CustomerOnBoarding.NetSalary = netSalaryInBank.text;
                    CustomerOnBoarding.EmployerName =
                        employeeTypeBuilder.menuNotifier.value[0].name ?? "";
                    CustomerOnBoarding.EntityTypeEmployer =
                        entityTypeBuilder.menuNotifier.value[0].name ?? "";
                    CustomerOnBoarding.EmailID = officialEmailid.text;
                    CustomerOnBoarding.PresentMonthlyEMI =
                        double.parse(monthlyEMI.text.replaceAll(",", ""));

                    print(employeeTypeBuilder.menuNotifier.value[0].name);
                    CustomerOnBoarding.empId =
                        entityTypeBuilder.menuNotifier.value[0].value ?? 0;
                    CustomerOnBoarding.entityId =
                        employementEngBuilder.menuNotifier.value[0].value ?? 0;
                    CustomerOnBoarding.employementType =
                        employementEngBuilder.menuNotifier.value[0].name ?? "";
                    CustomerOnBoarding.empEngagementId =
                        employementEngBuilder.menuNotifier.value[0].value ?? 0;

                    CustomerOnBoarding.isAadhaarLinkedToMobileNumber =
                        isSwitchPressed;

                    CustomerOnBoarding.modeOfSalaryId =
                        _favouriteFoodModel.value ?? 0;

                    pusDataToServer();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Select Employment Type")));
                  }
                } else {
                  SuccessfulResponse.showScaffoldMessage(
                      AppConstants.fillAllDetails, context);
                }
              },
              title: "CONTINUE")
        ],
      ),
    );
  }

  Widget MulitpleButton() {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "Select Employment Engagement",
            style: CustomTextStyles.regularSmallGreyFont,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 1;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: count == 1
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    alignment: Alignment.center,
                    child: Text(
                      "Permanent",
                      style: count != 1
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      count = 2;
                    });
                  },
                  child: Container(
                    decoration: count == 2
                        ? BoxDecorationStyles.outButtonOfBoxRed
                        : BoxDecorationStyles.outButtonOfBox,
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Contractual",
                      style: count != 2
                          ? CustomTextStyles.regularsmalleFonts
                          : CustomTextStyles.regularWhiteSmallFont,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  pusDataToServer() async {
    CustomerOnBoardingDTO onBoardingDto = CustomerOnBoardingDTO();
    if (onBoardingDto != null) {
      onBoardingDto.firstName = CustomerOnBoarding.FirstName; // changine
      onBoardingDto.gender = plFetchBloc.onBoardingDTO!.gender != ""
          ? plFetchBloc.onBoardingDTO!.gender
          : CustomerOnBoarding.Gender;
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      onBoardingDto.bankStatement = plFetchBloc.onBoardingDTO!.bankStatement;
      onBoardingDto.bankStatements = [];
      onBoardingDto.salarySlips = [];
      onBoardingDto.aadharNumber = CustomerOnBoarding.AadharNumber;
      onBoardingDto.middleName = CustomerOnBoarding.FatherName; // changine
      onBoardingDto.lastName = CustomerOnBoarding.LastName; // changine
      onBoardingDto.mobileNumber = CustomerOnBoarding.MobileNumber;
      onBoardingDto.pANNumber = CustomerOnBoarding.PANNumber;
      onBoardingDto.pANImage = "";
      onBoardingDto.isAadharLinkedToMobile =
          plFetchBloc.onBoardingDTO!.isAadharLinkedToMobile;
      onBoardingDto.customerImage = "";
      onBoardingDto.emailID = CustomerOnBoarding.EmailID;
      onBoardingDto.presentMonthlyEMI =
          plFetchBloc.onBoardingDTO!.presentMonthlyEMI;
      onBoardingDto.requestID = plFetchBloc.onBoardingDTO!.requestID;
      onBoardingDto.allFormFlag = "N";
      onBoardingDto.dOB = CustomerOnBoarding.DOB;
      onBoardingDto.pincode = CustomerOnBoarding.Pincode; // changine
      onBoardingDto.currentAddress1 = CustomerOnBoarding.CurrentAddress1;
      ;
      onBoardingDto.currentAddress2 = CustomerOnBoarding.CurrentAddress2;
      onBoardingDto.currentAddress3 = CustomerOnBoarding.CurrentAddress3;
      onBoardingDto.permanentAddress1 = CustomerOnBoarding.PermanentAddress1;
      onBoardingDto.permanentAddress2 = CustomerOnBoarding.PermanentAddress2;
      onBoardingDto.permanentAddress3 = CustomerOnBoarding.PermanentAddress3;

      print("Front iMage is" + CustomerOnBoarding.AadhaarFromImage);
      onBoardingDto.aadharFrontImage = "";
      onBoardingDto.aadharBackImage = "";
      onBoardingDto.employmentProofPhoto = "";
      onBoardingDto.employmentIDPhoto = "";
      onBoardingDto.oKYCDocument = "";
      onBoardingDto.loanAmount =
          CustomerOnBoarding.LoanAmount.toDouble(); // changinef
      onBoardingDto.fatherName = plFetchBloc.onBoardingDTO!.fatherName;
      onBoardingDto.employerName = CustomerOnBoarding.EmployerName;
      onBoardingDto.entityTypeEmployer = CustomerOnBoarding.EntityTypeEmployer;
      onBoardingDto.modeOfSalary = CustomerOnBoarding.ModeOfSalary;
      onBoardingDto.netSalary =
          double.parse(CustomerOnBoarding.NetSalary.replaceAll(",", ""));
      onBoardingDto.presentMonthlyEMI = CustomerOnBoarding.PresentMonthlyEMI;
      onBoardingDto.employmentType = CustomerOnBoarding.employementType;
      onBoardingDto.id = plFetchBloc.onBoardingDTO!.id;
      onBoardingDto.addressProof = plFetchBloc.onBoardingDTO!.addressProof;
      onBoardingDto.addressProofPhoto = "";
      onBoardingDto.companyTypeCdCompanyTypeId = CustomerOnBoarding.empId;
      onBoardingDto.employmentTypeCdEmploymentType =
          CustomerOnBoarding.entityId;
      onBoardingDto.countryId = CustomerOnBoarding.empEngagementId;
      onBoardingDto.modeOfSalaryCdSalaryMode =
          CustomerOnBoarding.modeOfSalaryId;
      // onBoardingDto.countryId=CustomerOnBoarding.entityId;
      onBoardingDto.rentalAgreementImage = "";
      onBoardingDto.genderId = CustomerOnBoarding.genderId;
      // List<MultipartFile> appFiles = [];
      // //
      // // print(plFetchBloc.onBoardingDTO!.aadharFrontImage);
      // // print(CustomerOnBoarding.AadhaarFronPath);
      // if (CustomerOnBoarding.panImagePath != "" &&
      //     plFetchBloc.onBoardingDTO!.pANImage !=
      //         CustomerOnBoarding.panImagePath) {
      //   print("Pan Updated");
      //   appFiles.add(MultipartFile.fromFileSync(CustomerOnBoarding.panImagePath,
      //       filename: CustomerOnBoarding.PANImage));
      // }
      //
      // if (CustomerOnBoarding.ProfilePhoto != "" &&
      //     plFetchBloc.onBoardingDTO!.aadharBackImage !=
      //         CustomerOnBoarding.profileImagePath) {
      //   print("Profile Updated");
      //   appFiles.add(MultipartFile.fromFileSync(
      //       CustomerOnBoarding.profileImagePath,
      //       filename: CustomerOnBoarding.ProfilePhoto));
      // }

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            await onBoardingDto.toJsonEncode()),
      });

      PreEqualRequestNewDto preEqualRequest = PreEqualRequestNewDto();

      // preEqualRequest.declaredObligation = CustomerOnBoarding.LoanAmount;
      preEqualRequest.employerName =
          employeeTypeBuilder.menuNotifier.value[0].name;
      preEqualRequest.employmentType =
          employementEngBuilder.menuNotifier.value[0].name;
      preEqualRequest.isPincodeServicible = 1;
      preEqualRequest.modeOfsalary = _favouriteFoodModel.name;
      preEqualRequest.declaredSalary =
          int.parse(netSalaryInBank.value.text.replaceAll(",", ""));
      preEqualRequest.age = CustomerOnBoarding.ageInNumber;
      preEqualRequest.refPlId = plFetchBloc.onBoardingDTO!.id;
      preEqualRequest.declaredObligation =
          int.parse(monthlyEMI.value.text.replaceAll(",", ""));
      preEqualRequest.pincode = int.parse(CustomerOnBoarding.Pincode);

      print("Age is");
      print(preEqualRequest.age);

      // onBoardingDto.isCurrentAndPermanentAddressSame =
      //     CustomerOnBoarding.currentAddressSameAsPermanant;

      print("Employee CD ID");
      print(onBoardingDto.companyTypeCdCompanyTypeId);

      FormData prequalFormData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(
            preEqualRequest.toEncodedJson()),
      });

      print(preEqualRequest.toEncodedJson());

      boardingBloc.applyForPersonalLoan(
          formData,
          context,
          (dto) async => {
                if (dto!.status!)
                  {
                    // SuccessfulResponse.showScaffoldMessage(
                    //     dto.message!, context),
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CustomerLoanReward(),
                    //   ),
                    // )
                  }
                else
                  {
                    SuccessfulResponse.showScaffoldMessage(
                        dto.message!, context),
                  }
              },
          isLoaderHide: true,
          prequalFormData: prequalFormData,
          onPrequalSuccessCallBack: (dto) async {
        if (dto!.status != null) {
          if (dto.status == "Approve") {
            RefClientRequest refClientRequest = RefClientRequest();
            refClientRequest.refId = plFetchBloc.onBoardingDTO!.id;

            FormData formData = FormData.fromMap({
              'json': await EncryptionUtils.getEncryptedText(
                  await refClientRequest.toEncodedJson()),
            });

            // print("BOarding Client");
            // print(boardingBlocClientInitiate.appLoadingClient);

            boardingBlocClientInitiate.createClientInitiate(formData);
          } else {
            CustomLoaderBuilder.builder.hideLoaderUIDiff();
            SuccessfulResponse.showScaffoldMessage(
                "Application Rejected", context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicationRejected(
                  message: "Eligibility Norms Not Met",
                ),
              ),
            );
          }
        } else {
          SuccessfulResponse.showScaffoldMessage(
              "Something went wrong", context);
        }
      });
    }
    // print(onBoardingDto.toJsonEncode());
  }

  Widget _getHoirzontalImageUpload() {
    return Column(
      children: [
        CustomImageBuilder(
          key: _key,
          value: "Income Proof",
          image: DhanvarshaImages.pinNew,
          type: "pan",
        ),
      ],
    );
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoaderUIDiff();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    PreEqualResponse preEqualResponse =
        PreEqualResponse.fromJson(jsonDecode(dto.data!));

    if (preEqualResponse.status == "Approve") {
      if (preEqualResponse.ClientId != 0) {
        if (!preEqualResponse.CBStatus!) {
          SuccessfulResponse.showScaffoldMessage("CB Rejected", context);
          DialogUtils.clientIdDialog(
              context,
              preEqualResponse.ClientId.toString(),
              () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationRejected(
                          message: "Credit Bureau Norms Not Met",
                        ),
                      ),
                    )
                  });
        } else {
          SuccessfulResponse.showScaffoldMessage(
              preEqualResponse.status!, context);
          SuccessfulResponse.showScaffoldMessage(
              "Application Accepted", context);
          DialogUtils.clientIdDialog(
              context,
              preEqualResponse.ClientId.toString(),
              () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerLoanReward(
                          id: preEqualResponse.ClientId!,
                        ),
                      ),
                    )
                  });
        }
      } else {
        SuccessfulResponse.showScaffoldMessage(
            preEqualResponse.message!, context);
        Navigator.of(context)
            .popUntil((route) => route.isFirst);
      }
    } else {
      // SuccessfulResponse.showScaffoldMessage("Prequal Failed", context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApplicationRejected(
            message: "Eligibility Norms Not Met",
          ),
        ),
      );
      // DialogUtils.offerrejectedByLoan(context,
      //     message: preEqualResponse.message!);
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage("Something went wrong", context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoaderUIDiff();
  }
}

class EntityEmployeeDropDown extends ListOfObject {
  final String entityOfEmployee;
  final String id;

  EntityEmployeeDropDown(this.entityOfEmployee, this.id)
      : super(entityOfEmployee, id);
}

class EmployeeDetailsDropDown extends ListOfObject {
  final String employeeDetailsType;
  final String id;

  EmployeeDetailsDropDown(this.employeeDetailsType, this.id)
      : super(employeeDetailsType, id);
}

class Movie extends ListOfObject {
  final String name;
  final String id;

  Movie(this.name, this.id) : super(name, id);
}
