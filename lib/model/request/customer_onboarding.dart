import 'dart:convert';

import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/referencdto.dart';
import 'package:dhanvarsha/model/response/refuseraddressdto.dart';

class CustomerOnBoardingDTO {
  int? id;
  String? firstName;
  String? BankStatementPassword;
  String? middleName;
  String? lastName;
  String? mobileNumber;
  String? pANNumber;
  String? pANImage;
  bool? isAadharLinkedToMobile;
  String? aadharNumber;
  String? customerImage;
  String? emailID;
  String? employmentType;
  double? netSalary;
  String? modeOfSalary;
  String? entityTypeEmployer;
  String? employerName;
  double? presentMonthlyEMI;
  String? requestID;
  String? allFormFlag;
  String? dOB;
  String? gender;
  String? pincode;
  String? currentAddress1;
  String? currentAddress2;
  String? currentAddress3;
  String? permanentAddress1;
  String? permanentAddress2;
  String? permanentAddress3;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? incomeProof;
  String? bankStatement;
  String? addressProof;
  String? addressProofPhoto;
  String? employmentProofPhoto;
  String? employmentIDPhoto;
  String? oKYCDocument;
  double? loanAmount;
  String? fatherName;
  String? rentalAgreementImage;
  List<String>? salarySlips;
  List<String>? bankStatements;
  int? genderId;
  String? preQualStatus;
  int? softOfferAmount;
  String? CBStatus;
  bool? PanVerificationStatus;
  int? maritalStatusId;
  int? countryId;
  int? stateId;
  int? districtId;
  int? talukaId;
  int? panDocumentTypeId;
  int? aadharFrontDocumentTypeId;
  int? aadharBackDocumentTypeId;
  int? selfieId;
  int? companyTypeCdCompanyTypeId;
  int? employmentTypeCdEmploymentType;
  int? modeOfSalaryCdSalaryMode;
  List<ReferenceDTO>? referenceDetails;
  List<String>? encodedRefDetails;
  PLFetchBloc? plFetchBloc;
  bool? isCurrentAndPermanentAddressSame;
  List<RefUserAddress>? userAddress;
  String? dsaLoginid;
  bool? isSoftOfferAccepted;
  bool? isLoanApplicationExists;
  String? FinalLoanStatus;
  int? FinFluxLoanId;
  String? cbStatus;
  String? aadhaarFirstName;
  String? aadhaarMiddleName;
  String? aadhaarLastName;
  String? panFirstName;
  String? panMiddleName;
  String? panLastName;
  int? loanId;
  int? clientId;
  int? softOfferDueDays;
  bool? isSubDsa;

  CustomerOnBoardingDTO(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobileNumber,
      this.pANNumber,
      this.pANImage,
      this.isAadharLinkedToMobile,
      this.aadharNumber,
      this.customerImage,
      this.emailID,
      this.employmentType,
      this.netSalary,
      this.modeOfSalary,
      this.entityTypeEmployer,
      this.employerName,
      this.presentMonthlyEMI,
      this.requestID,
      this.allFormFlag,
      this.dOB,
      this.gender,
      this.pincode,
      this.currentAddress1,
      this.currentAddress2,
      this.currentAddress3,
      this.permanentAddress1,
      this.permanentAddress2,
      this.permanentAddress3,
      this.aadharFrontImage,
      this.aadharBackImage,
      this.incomeProof,
      this.bankStatement,
      this.addressProof,
      this.addressProofPhoto,
      this.employmentProofPhoto,
      this.employmentIDPhoto,
      this.oKYCDocument,
      this.loanAmount,
      this.fatherName,
      this.rentalAgreementImage,
      this.salarySlips,
      this.bankStatements,
      this.userAddress}) {
    plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
  }

  CustomerOnBoardingDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    pANNumber = json['PANNumber'];
    pANImage = json['PANImage'];
    isAadharLinkedToMobile = json['IsAadharLinkedToMobile'];
    aadharNumber = json['AadharNumber'];
    customerImage = json['CustomerImage'];
    emailID = json['EmailID'];
    employmentType = json['EmploymentType'];
    netSalary = json['NetSalary'];
    modeOfSalary = json['ModeOfSalary'];
    entityTypeEmployer = json['EntityTypeEmployer'];
    employerName = json['EmployerName'];
    presentMonthlyEMI = json['PresentMonthlyEMI'];
    requestID = json['RequestID'];
    allFormFlag = json['AllFormFlag'];
    dOB = json['DOB'];
    gender = json['Gender'];
    pincode = json['Pincode'];
    currentAddress1 = json['CurrentAddress1'];
    currentAddress2 = json['CurrentAddress2'];
    currentAddress3 = json['CurrentAddress3'];
    permanentAddress1 = json['PermanentAddress1'];
    permanentAddress2 = json['PermanentAddress2'];
    permanentAddress3 = json['PermanentAddress3'];
    aadharFrontImage = json['AadharFrontImage'];
    aadharBackImage = json['AadharBackImage'];
    incomeProof = json['IncomeProof'] != null ? incomeProof : "";
    bankStatement = json['BankStatement'];
    addressProof = json['AddressProof'];
    addressProofPhoto = json['AddressProofPhoto'];
    employmentProofPhoto = json['EmploymentProofPhoto'];
    employmentIDPhoto = json['EmploymentIDPhoto'];
    oKYCDocument = json['OKYCDocument'];
    loanAmount = json['LoanAmount'];
    fatherName = json['FatherName'];
    rentalAgreementImage = json['RentalAgreementImage'];
    salarySlips = json['SalarySlips'].cast<String>();
    bankStatements = json['BankStatements'].cast<String>();
    genderId = json['GenderId'];
    maritalStatusId = json['MaritalStatusId'];
    countryId = json['CountryId'];
    stateId = json['StateId'];
    districtId = json['DistrictId'];
    talukaId = json['TalukaId'];
    panDocumentTypeId = json['PanDocumentTypeId'];
    aadharFrontDocumentTypeId = json['AadharFrontDocumentTypeId'];
    aadharBackDocumentTypeId = json['AadharBackDocumentTypeId'];
    selfieId = json['SelfieId'];
    companyTypeCdCompanyTypeId = json['CompanyType_cd_CompanyTypeId'];
    employmentTypeCdEmploymentType = json['EmploymentType_cd_EmploymentType'];
    modeOfSalaryCdSalaryMode = json['ModeOfSalary_cd_salaryMode'];
    referenceDetails = json['RefDetails'] as List != null
        ? (json['RefDetails'] as List).map((i) {
            return ReferenceDTO.fromJson(i);
          }).toList()
        : [];
    userAddress = json['RefAddressRequest'] as List != null
        ? (json['RefAddressRequest'] as List).map((i) {
            return RefUserAddress.fromJson(i);
          }).toList()
        : [];
    isSoftOfferAccepted = json['isSoftOfferAccepted'];
    isLoanApplicationExists = json['isLoanApplicationExists'];
    FinalLoanStatus = json['FinalLoanStatus'];
    FinFluxLoanId = json['FinFluxLoanId'];
    isCurrentAndPermanentAddressSame = json['isCurrentAndPermanentAddressSame'];
    cbStatus = json['CBStatus'];
    aadhaarFirstName = json['AadharFirstName'];
    aadhaarMiddleName = json['AadharMiddleName'];
    aadhaarLastName = json['AadharLastName'];
    panFirstName = json['PanFirstName'];
    panMiddleName = json['PanMiddleName'];
    panLastName = json['PanLastName'];
    loanId = json['LoanId'];
    clientId = json['ClientId'];
    softOfferDueDays =
        json['softOfferDueDays'] != null ? json['softOfferDueDays'] : -1;
    softOfferAmount = json['softOfferAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FirstName'] = this.firstName != null
        ? this.firstName
        : plFetchBloc!.onBoardingDTO!.firstName!;
    data['MiddleName'] = this.middleName != null
        ? this.middleName
        : plFetchBloc!.onBoardingDTO!.middleName!;
    data['LastName'] = this.lastName != null
        ? this.lastName
        : plFetchBloc!.onBoardingDTO!.lastName!;
    data['MobileNumber'] = this.mobileNumber != null
        ? this.mobileNumber
        : plFetchBloc!.onBoardingDTO!.mobileNumber;
    data['PANNumber'] = this.pANNumber != ""
        ? this.pANNumber
        : plFetchBloc!.onBoardingDTO!.pANNumber;
    data['PANImage'] = this.pANImage;
    data['IsAadharLinkedToMobile'] = this.isAadharLinkedToMobile;

    print("Aadhaar Number Is");
    print(this.aadharNumber);

    data['AadharNumber'] = this.aadharNumber != ""
        ? this.aadharNumber
        : plFetchBloc!.onBoardingDTO!.aadharNumber;
    data['CustomerImage'] = this.customerImage;
    data['EmailID'] =
        this.emailID != "" ? this.emailID : plFetchBloc!.onBoardingDTO!.emailID;
    data['EmploymentType'] = this.employmentType != ""
        ? ""
        : this.plFetchBloc!.onBoardingDTO!.employmentType!;
    data['NetSalary'] = this.netSalary != 0.0
        ? this.netSalary
        : plFetchBloc!.onBoardingDTO!.netSalary!;
    data['ModeOfSalary'] = this.modeOfSalary;
    data['EntityTypeEmployer'] = CustomerOnBoarding.EntityTypeEmployer != ""
        ? CustomerOnBoarding.EntityTypeEmployer
        : plFetchBloc!.onBoardingDTO!.entityTypeEmployer!;
    data['EmployerName'] = CustomerOnBoarding.EmployerName != ""
        ? CustomerOnBoarding.EmployerName
        : plFetchBloc!.onBoardingDTO!.employerName;
    data['PresentMonthlyEMI'] = CustomerOnBoarding.PresentMonthlyEMI != 0
        ? CustomerOnBoarding.PresentMonthlyEMI
        : plFetchBloc!.onBoardingDTO!.presentMonthlyEMI;
    data['RequestID'] = this.requestID;
    data['AllFormFlag'] = this.allFormFlag;
    data['DOB'] = CustomerOnBoarding.DOB != ""
        ? CustomerOnBoarding.DOB
        : plFetchBloc!.onBoardingDTO!.dOB!;
    data['Gender'] = this.gender;
    data['Pincode'] = this.pincode != null
        ? this.pincode
        : plFetchBloc!.onBoardingDTO!.pincode!;
    data['CurrentAddress1'] = "";
    data['CurrentAddress2'] = "";
    data['CurrentAddress3'] = "";
    data['PermanentAddress1'] = "";
    data['PermanentAddress2'] = "";
    data['PermanentAddress3'] = "";
    data['AadharFrontImage'] = this.aadharFrontImage;
    data['AadharBackImage'] = this.aadharBackImage;
    data['IncomeProof'] = this.incomeProof != null ? this.incomeProof : "";
    data['BankStatement'] = this.bankStatement;
    data['AddressProof'] = this.addressProof;
    data['AddressProofPhoto'] = this.addressProofPhoto;
    data['EmploymentProofPhoto'] = this.employmentProofPhoto;
    data['EmploymentIDPhoto'] = this.employmentIDPhoto;
    data['OKYCDocument'] = this.oKYCDocument;
    data['LoanAmount'] = this.loanAmount;
    data['FatherName'] = this.fatherName;
    data['RentalAgreementImage'] = this.rentalAgreementImage;
    data['SalarySlips'] = this.salarySlips;
    data['BankStatements'] = this.bankStatements;
    data['GenderId'] = this.genderId != 0
        ? this.genderId
        : plFetchBloc!.onBoardingDTO!.genderId;
    data['MaritalStatusId'] = this.maritalStatusId;
    data['CountryId'] = this.countryId != 0
        ? this.countryId
        : plFetchBloc!.onBoardingDTO!.countryId;
    data['StateId'] = this.stateId;
    data['DistrictId'] = this.districtId;
    data['TalukaId'] = this.talukaId;
    data['PanDocumentTypeId'] = this.panDocumentTypeId;
    data['AadharFrontDocumentTypeId'] = this.aadharFrontDocumentTypeId;
    data['AadharBackDocumentTypeId'] = this.aadharBackDocumentTypeId;
    data['SelfieId'] = this.selfieId;
    data['CompanyType_cd_CompanyTypeId'] =
        this.companyTypeCdCompanyTypeId != null
            ? this.companyTypeCdCompanyTypeId
            : plFetchBloc!.onBoardingDTO!.companyTypeCdCompanyTypeId;
    data['EmploymentType_cd_EmploymentType'] =
        this.employmentTypeCdEmploymentType != 0
            ? this.employmentTypeCdEmploymentType
            : plFetchBloc!.onBoardingDTO!.employmentTypeCdEmploymentType;
    data['ModeOfSalary_cd_salaryMode'] = this.modeOfSalaryCdSalaryMode != 0
        ? this.modeOfSalaryCdSalaryMode
        : plFetchBloc!.onBoardingDTO!.modeOfSalaryCdSalaryMode;
    data['preQualStatus'] = this.preQualStatus;
    data['softOfferAmount'] = this.softOfferAmount;
    data['CBStatus'] = this.CBStatus;
    data['PanVerificationStatus'] = this.PanVerificationStatus;
    data['CBStatus'] = this.cbStatus;
    data['softOfferDueDays'] = this.softOfferDueDays;
    return data;
  }

  Future<String> toJsonEncode() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['MobileNumber'] = this.mobileNumber;
    data['PANNumber'] = this.pANNumber;
    data['PANImage'] = this.pANImage;
    data['IsAadharLinkedToMobile'] = CustomerOnBoarding != null &&
            CustomerOnBoarding.IsAadharLinkedToMobile != null
        ? CustomerOnBoarding.IsAadharLinkedToMobile
        : plFetchBloc!.onBoardingDTO!.isAadharLinkedToMobile != null
            ? plFetchBloc!.onBoardingDTO!.isAadharLinkedToMobile
            : false;
    data['AadharNumber'] = CustomerOnBoarding.AadharNumber != ""
        ? CustomerOnBoarding.AadharNumber
        : plFetchBloc!.onBoardingDTO!.aadharNumber!;
    data['EmailID'] = CustomerOnBoarding.EmailID != ""
        ? CustomerOnBoarding.EmailID
        : plFetchBloc!.onBoardingDTO!.emailID;
    data['EmploymentType'] = CustomerOnBoarding.employementType != ""
        ? CustomerOnBoarding.employementType
        : plFetchBloc!.onBoardingDTO!.employmentType;
    data['NetSalary'] = double.parse(CustomerOnBoarding.NetSalary != ""
                ? CustomerOnBoarding.NetSalary.replaceAll(",", "")
                : "0") !=
            0
        ? this.netSalary
        : plFetchBloc!.onBoardingDTO!.netSalary!;
    data['ModeOfSalary'] = this.modeOfSalary;
    data['EntityTypeEmployer'] = CustomerOnBoarding.EntityTypeEmployer != ""
        ? CustomerOnBoarding.EntityTypeEmployer
        : plFetchBloc!.onBoardingDTO!.entityTypeEmployer!;
    data['EmployerName'] = CustomerOnBoarding.EmployerName != ""
        ? CustomerOnBoarding.EmployerName
        : plFetchBloc!.onBoardingDTO!.employerName;
    data['PresentMonthlyEMI'] = CustomerOnBoarding.PresentMonthlyEMI != 0
        ? CustomerOnBoarding.PresentMonthlyEMI
        : plFetchBloc!.onBoardingDTO!.presentMonthlyEMI;
    data['RequestID'] = this.requestID;
    data['AllFormFlag'] = this.allFormFlag;
    data['DOB'] = CustomerOnBoarding.DOB != ""
        ? CustomerOnBoarding.DOB
        : plFetchBloc!.onBoardingDTO!.dOB!;
    data['CustomerImage'] = this.customerImage;
    data['Gender'] = this.gender;
    data['Pincode'] = this.pincode;
    data['CurrentAddress1'] = this.currentAddress1;
    data['CurrentAddress2'] = this.currentAddress2;
    data['CurrentAddress3'] = this.currentAddress3;
    data['PermanentAddress1'] = this.permanentAddress1;
    data['PermanentAddress2'] = this.permanentAddress2;
    data['PermanentAddress3'] = this.permanentAddress3;
    data['AadharFrontImage'] = this.aadharFrontImage;
    data['AadharBackImage'] = this.aadharBackImage;
    data['IncomeProof'] = this.incomeProof;
    data['BankStatement'] = this.bankStatement;
    data['AddressProof'] = this.addressProof;
    data['AddressProofPhoto'] = this.addressProofPhoto;
    data['EmploymentProofPhoto'] = this.employmentProofPhoto;
    data['EmploymentIDPhoto'] = this.employmentIDPhoto;
    data['OKYCDocument'] = this.oKYCDocument;
    data['LoanAmount'] = this.loanAmount;
    data['FatherName'] = this.fatherName;
    data['RentalAgreementImage'] = this.rentalAgreementImage;
    data['SalarySlips'] = this.salarySlips;
    data['BankStatements'] = this.bankStatements;
    data['GenderId'] = this.genderId != null ? this.genderId : 0;
    data['MaritalStatusId'] =
        this.maritalStatusId != null ? this.maritalStatusId : 0;
    data['CountryId'] = this.countryId != null ? this.countryId : 0;
    data['StateId'] = this.stateId != null ? this.stateId : 0;
    data['DistrictId'] = this.districtId != null ? this.districtId : 0;
    data['TalukaId'] = this.talukaId != null ? this.talukaId : 0;
    data['PanDocumentTypeId'] = this.panDocumentTypeId != null
        ? this.panDocumentTypeId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);
    data['AadharFrontDocumentTypeId'] = this.aadharFrontDocumentTypeId != null
        ? this.aadharFrontDocumentTypeId
        : MasterDocumentId.builder
            .getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    data['AadharBackDocumentTypeId'] = this.aadharBackDocumentTypeId != null
        ? this.aadharBackDocumentTypeId
        : MasterDocumentId.builder
            .getMasterID(MasterDocIdentifier.aadhaarBackKey);
    data['SelfieId'] = this.selfieId != null
        ? this.selfieId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.selfieKey);
    data['CompanyType_cd_CompanyTypeId'] = CustomerOnBoarding.empId != 0
        ? CustomerOnBoarding.empId
        : plFetchBloc!.onBoardingDTO!.companyTypeCdCompanyTypeId;
    data['EmploymentType_cd_EmploymentType'] = CustomerOnBoarding.entityId != 0
        ? CustomerOnBoarding.entityId
        : plFetchBloc!.onBoardingDTO!.employmentTypeCdEmploymentType;
    data['ModeOfSalary_cd_salaryMode'] = CustomerOnBoarding.modeOfSalaryId != 0
        ? CustomerOnBoarding.modeOfSalaryId
        : plFetchBloc!.onBoardingDTO!.modeOfSalaryCdSalaryMode;
    data['ClientId'] = 0;
    data['RefDetails'] = CustomerOnBoarding != null &&
            CustomerOnBoarding.referenceDetails != null
        ? CustomerOnBoarding.referenceDetails
        : [];
    data['RefAddressRequest'] = CustomerOnBoarding.userAddress != null &&
            CustomerOnBoarding.userAddress.length > 0
        ? CustomerOnBoarding.userAddress
        : plFetchBloc!.onBoardingDTO!.userAddress ?? [];
    data['dsaLoginId'] =
        await SharedPreferenceUtils.sharedPreferenceUtils.getDSAID();
    data['isCurrentAndPermanentAddressSame'] =
        CustomerOnBoarding.currentAddressSameAsPermanant
            ? CustomerOnBoarding.currentAddressSameAsPermanant
            : plFetchBloc!.onBoardingDTO!.isCurrentAndPermanentAddressSame!
                ? true
                : false;
    data['AadharFirstName'] = CustomerOnBoarding.aadhaarFirstName != null &&
            CustomerOnBoarding.aadhaarFirstName != ""
        ? CustomerOnBoarding.aadhaarFirstName
        : plFetchBloc!.onBoardingDTO!.aadhaarFirstName;
    data['AadharMiddleName'] = CustomerOnBoarding.aadhaarMiddleName != null &&
            CustomerOnBoarding.aadhaarMiddleName != ""
        ? CustomerOnBoarding.aadhaarMiddleName
        : plFetchBloc!.onBoardingDTO!.aadhaarMiddleName;
    data['AadharLastName'] = CustomerOnBoarding.aadhaarLastName != null &&
            CustomerOnBoarding.aadhaarLastName != ""
        ? CustomerOnBoarding.aadhaarLastName
        : plFetchBloc!.onBoardingDTO!.aadhaarLastName;
    data['PanFirstName'] = CustomerOnBoarding.panFirstName != null &&
            CustomerOnBoarding.panFirstName != ""
        ? CustomerOnBoarding.panFirstName
        : plFetchBloc!.onBoardingDTO!.panFirstName;
    data['PanMiddleName'] = CustomerOnBoarding.panMiddleName != null &&
            CustomerOnBoarding.panMiddleName != ""
        ? CustomerOnBoarding.panMiddleName
        : plFetchBloc!.onBoardingDTO!.panMiddleName;
    data['PanLastName'] = CustomerOnBoarding.panLastName != null &&
            CustomerOnBoarding.panLastName != ""
        ? CustomerOnBoarding.panLastName
        : plFetchBloc!.onBoardingDTO!.panLastName;
    data['BankStatementPassword'] =
        CustomerOnBoarding.pdfPasswordField != null &&
                CustomerOnBoarding.pdfPasswordField != ""
            ? CustomerOnBoarding.pdfPasswordField
            : "";
    data['softOfferDueDays'] = this.softOfferDueDays != null ? 0 : 0;
    data['isSubDsa'] =
        await SharedPreferenceUtils.sharedPreferenceUtils.isSubDsa();
    return jsonEncode(data);
  }
}
