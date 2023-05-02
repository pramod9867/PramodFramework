import 'package:dhanvarsha/model/request/referencdto.dart';
import 'package:dhanvarsha/model/response/refuseraddressdto.dart';

class CustomerOnBoarding {
  static String? _FirstName;
  static String? _MiddleName;

  static String get pdfPasswordField => _pdfPasswordField??"";

  static set pdfPasswordField(String value) {
    _pdfPasswordField = value;
  }

  static String? _LastName;
  static String? _MobileNumber;
  static bool? _isAadhaarLinkedToMobileNumber;
  static String? _pdfPasswordField;

  static bool get isAadhaarLinkedToMobileNumber =>
      _isAadhaarLinkedToMobileNumber!;

  static set isAadhaarLinkedToMobileNumber(bool value) {
    _isAadhaarLinkedToMobileNumber = value;
  }

  static List<ReferenceDTO> get referenceDetails =>
      _referenceDetails != null ? _referenceDetails! : [];

  static set referenceDetails(List<ReferenceDTO> value) {
    _referenceDetails = value;
  }

  static List<ReferenceDTO>? _referenceDetails;
  static int get modeOfSalaryId => _modeOfSalaryId??0;

  static set modeOfSalaryId(int value) {
    _modeOfSalaryId = value;
  }

  static int? _modeOfSalaryId;
  static int get empEngagementId => _empEngagementId??0;

  static set empEngagementId(int value) {
    _empEngagementId = value;
  }

  static int? _empEngagementId;
  static int get empId => _empId??0;

  static set empId(int value) {
    _empId = value;
  }


  static int get ageInNumber => _ageInNumber??0;

  static set ageInNumber(int value) {
    _ageInNumber = value;
  }

  static int? _ageInNumber;
  static int? _empId;
  static int? _entityId;
  static int get genderId => _genderId??0;

  static set genderId(int value) {
    _genderId = value;
  }

  static int? _genderId;

  static String get employementType => _employementType??"";

  static set employementType(String value) {
    _employementType = value;
  }

  static String? _PANNumber;
  static String? _PANImage;
  static bool? _IsAadharLinkedToMobile;
  static String? _AadharNumber;
  static String? _AadhaarFromImage;
  static String? _employementType;
  static List<String> get bankFileName => _bankFileName!;

  static set bankFileName(List<String> value) {
    _bankFileName = value;
  }

  static String get empIdPath => _empIdPath!;

  static set empIdPath(String value) {
    _empIdPath = value;
  }

  static List<String>? _bankFileName;
  static String? _AaadhaarBackImage;
  static String? _AadhaarFronPath;
  static String? _AadhaarBackPath;
  static String? _NetSalary;
  static String? _EmployerName;
  static String? _empIdPath;

  static List<String> get salaryPath => _salaryPath!;

  static set salaryPath(List<String> value) {
    _salaryPath = value;
  }

  static String? _EntityTypeEmployer;
  static List<String>? _salaryPath;
  static String get rentalAgreementPath => _rentalAgreementPath!;

  static set rentalAgreementPath(String value) {
    _rentalAgreementPath = value;
  }

  static List<String>? _bankPath;
  static String? _rentalAgreementPath;
  static String get RentalAgreementImage => _RentalAgreementImage!;

  static set RentalAgreementImage(String value) {
    _RentalAgreementImage = value;
  }

  static String get AadhaarFromImage => _AadhaarFromImage!;
  static String? _RentalAgreementImage;
  static String get EmployerName => _EmployerName??"";

  static set EmployerName(String value) {
    _EmployerName = value;
  }

  static List<String> get bankPath => _bankPath!;

  static set bankPath(List<String> value) {
    _bankPath = value;
  }

  static set AadhaarFromImage(String value) {
    _AadhaarFromImage = value;
  }


  static String get ModeOfSalary => _ModeOfSalary??"";

  static String get NetSalary => _NetSalary??"";

  static set NetSalary(String value) {
    _NetSalary = value;
  }

  static set ModeOfSalary(String value) {
    _ModeOfSalary = value;
  }

  static String? _CustomerImage;
  static String? _EmailID;
  static double? _PresentMonthlyEMI;
  static String? _RequestID = "0";
  static String? _AllFormFlag = "Y";
  static String? _DOB;
  static String? _Gender;
  static String? _Pincode;
  static String? _CurrentAddress1;
  static String? _CurrentAddress2;
  static String? _CurrentAddress3;
  static String? _PermanentAddress1;
  static String? _PermanentAddress2;
  static String? _PermanentAddress3;
  static String? _IncomeProof;
  static List<String>? _BankStatement;
  static List<String>? _SalarySlips;
  static String? _AddressProof;


  static String get aadhaarFirstName => _aadhaarFirstName??"";

  static set aadhaarFirstName(String value) {
    _aadhaarFirstName = value;
  }

  static String? _aadhaarFirstName;
  static String? _aadhaarLastName;
  static String? _aadhaarMiddleName;
  static String? _panFirstName;
  static String? _panMiddleName;
  static String? _panLastName;


  static List<String> get SalarySlips => _SalarySlips!;

  static set SalarySlips(List<String> value) {
    _SalarySlips = value;
  }

  static List<RefUserAddress> get userAddress => _userAddress??[];

  static set userAddress(List<RefUserAddress> value) {
    _userAddress = value;
  }


  static bool get isAadhaarSameCurrent => _isAadhaarSameCurrent??false;

  static set isAadhaarSameCurrent(bool value) {
    _isAadhaarSameCurrent = value;
  }

  static bool? _isAadhaarSameCurrent;
  static List<RefUserAddress>? _userAddress;
  static String? _panImagePath;
  static String? _profileImagePath;
  static String? _aadhaarImagePath;
  static String? _banStatementPath;

  static String? _ModeOfSalary;

  static String get FirstName => _FirstName!;

  static String get panImagePath => _panImagePath!;

  static set panImagePath(String value) {
    _panImagePath = value;
  }

  static String get ProfilePhoto => _ProfilePhoto!;

  static set ProfilePhoto(String value) {
    _ProfilePhoto = value;
  }

  static set FirstName(String value) {
    _FirstName = value;
  }

  static String? _ProfilePhoto;
  static String? _AddressProofPhoto;

  static String get kycPath => _kycPath!;

  static set kycPath(String value) {
    _kycPath = value;
  }

  static String? _EmploymentProofPhoto;
  static String? _EmploymentIDPhoto;
  static String? _OKYCDocument;
  static int? _LoanAmount;
  static String? _FatherName;
  static String? _kycPath;
  static String get addressProofPath => _addressProofPath!;


  static bool get currentAddressSameAsPermanant =>
      _currentAddressSameAsPermanant??false;

  static set currentAddressSameAsPermanant(bool value) {
    _currentAddressSameAsPermanant = value;
  }

  static bool? _currentAddressSameAsPermanant;
  static set addressProofPath(String value) {
    _addressProofPath = value;
  }

  static String? _addressProofPath;
  static String get MiddleName => _MiddleName!;

  static set MiddleName(String value) {
    _MiddleName = value;
  }

  static String get LastName => _LastName!;

  static set LastName(String value) {
    _LastName = value;
  }

  static String get MobileNumber => _MobileNumber!;

  static set MobileNumber(String value) {
    _MobileNumber = value;
  }

  static String get PANNumber => _PANNumber??"";

  static set PANNumber(String value) {
    _PANNumber = value;
  }

  static String get PANImage => _PANImage!;

  static set PANImage(String value) {
    _PANImage = value;
  }

  static bool get IsAadharLinkedToMobile => _IsAadharLinkedToMobile??false;

  static set IsAadharLinkedToMobile(bool value) {
    _IsAadharLinkedToMobile = value;
  }

  static String get AadharNumber => _AadharNumber??"";

  static set AadharNumber(String value) {
    _AadharNumber = value;
  }

  static String get CustomerImage => _CustomerImage!;

  static set CustomerImage(String value) {
    _CustomerImage = value;
  }

  static String get EmailID => _EmailID??"";

  static set EmailID(String value) {
    _EmailID = value;
  }

  static double get PresentMonthlyEMI => _PresentMonthlyEMI??0;

  static set PresentMonthlyEMI(double value) {
    _PresentMonthlyEMI = value;
  }

  static String get RequestID => _RequestID!;

  static set RequestID(String value) {
    _RequestID = value;
  }

  static String get AllFormFlag => _AllFormFlag!;

  static set AllFormFlag(String value) {
    _AllFormFlag = value;
  }

  static String get DOB => _DOB??"";

  static set DOB(String value) {
    _DOB = value;
  }

  static String get Gender => _Gender!;

  static set Gender(String value) {
    _Gender = value;
  }

  static String get Pincode => _Pincode!;

  static set Pincode(String value) {
    _Pincode = value;
  }

  static String get CurrentAddress1 => _CurrentAddress1??"";

  static set CurrentAddress1(String value) {
    _CurrentAddress1 = value;
  }

  static String get CurrentAddress2 => _CurrentAddress2??"";

  static set CurrentAddress2(String value) {
    _CurrentAddress2 = value;
  }

  static String get CurrentAddress3 => _CurrentAddress3??"";

  static set CurrentAddress3(String value) {
    _CurrentAddress3 = value;
  }

  static String get PermanentAddress1 => _PermanentAddress1??"";

  static set PermanentAddress1(String value) {
    _PermanentAddress1 = value;
  }

  static String get PermanentAddress2 => _PermanentAddress2??"";

  static set PermanentAddress2(String value) {
    _PermanentAddress2 = value;
  }

  static String get PermanentAddress3 => _PermanentAddress3??"";

  static set PermanentAddress3(String value) {
    _PermanentAddress3 = value;
  }

  static String get IncomeProof => _IncomeProof!;

  static set IncomeProof(String value) {
    _IncomeProof = value;
  }

  static String get AddressProof => _AddressProof??"";

  static List<String> get BankStatement => _BankStatement!;

  static set BankStatement(List<String> value) {
    _BankStatement = value;
  }

  static set AddressProof(String value) {
    _AddressProof = value;
  }

  static String get AddressProofPhoto => _AddressProofPhoto!;

  static set AddressProofPhoto(String value) {
    _AddressProofPhoto = value;
  }

  static String get EmploymentProofPhoto => _EmploymentProofPhoto!;

  static set EmploymentProofPhoto(String value) {
    _EmploymentProofPhoto = value;
  }

  static String get EmploymentIDPhoto => _EmploymentIDPhoto!;

  static set EmploymentIDPhoto(String value) {
    _EmploymentIDPhoto = value;
  }

  static String get OKYCDocument => _OKYCDocument!;

  static set OKYCDocument(String value) {
    _OKYCDocument = value;
  }

  static int get LoanAmount => _LoanAmount!;

  static set LoanAmount(int value) {
    _LoanAmount = value;
  }

  static String get FatherName => _FatherName!;

  static set FatherName(String value) {
    _FatherName = value;
  }

  static String get profileImagePath => _profileImagePath!;

  static String get banStatementPath => _banStatementPath!;

  static set banStatementPath(String value) {
    _banStatementPath = value;
  }

  static String get aadhaarImagePath => _aadhaarImagePath!;

  static set aadhaarImagePath(String value) {
    _aadhaarImagePath = value;
  }

  static set profileImagePath(String value) {
    _profileImagePath = value;
  }

  static printAll() {
    print("Start");
    // print(_ModeOfSalary);
    // print(_LastName);
    // print(_FatherName);
    // print(_FirstName);
    // print(_Pincode);
    // print(_MobileNumber);
    // print(_LoanAmount);
    // print(_AadhaarFromImage);
    // print(_AaadhaarBackImage);
    // print(_AadhaarBackPath);
    // print(_AadhaarFronPath);
    // print("Priniting");
    // print(_AadharNumber);
    // print(_PermanentAddress1);
    // print(_PermanentAddress2);
    // print(_PermanentAddress3);
    // print(_CurrentAddress1);
    // print(_CurrentAddress2);
    // print(_CurrentAddress3);

    print("Pan Upload");
    print(_profileImagePath);
    print(_ProfilePhoto);
    print(_panImagePath);
    print(_PANImage);

    print("Pan Details");
    print(_profileImagePath);
    print(_ProfilePhoto);
    print(_panImagePath);
    print(_PANImage);
    print("Finish");
  }

  static String get AaadhaarBackImage => _AaadhaarBackImage!;

  static String get AadhaarBackPath => _AadhaarBackPath!;

  static set AadhaarBackPath(String value) {
    _AadhaarBackPath = value;
  }

  static String get AadhaarFronPath => _AadhaarFronPath!;

  static set AadhaarFronPath(String value) {
    _AadhaarFronPath = value;
  }

  static set AaadhaarBackImage(String value) {
    _AaadhaarBackImage = value;
  }

  static String get EntityTypeEmployer => _EntityTypeEmployer??"";

  static set EntityTypeEmployer(String value) {
    _EntityTypeEmployer = value;
  }

  static int get entityId => _entityId??0;

  static set entityId(int value) {
    _entityId = value;
  }


  static clearDATA(){
    _referenceDetails=[];
    _AadharNumber="";
    _FatherName="";
    _MiddleName="";
    _MobileNumber="";
    _PANNumber="";
    _NetSalary="0";
    _ModeOfSalary="";
    _PresentMonthlyEMI=0;
    _employementType="";
    _AddressProof="";
    _empEngagementId=0;
    _employementType="";
    _modeOfSalaryId=0;
    _genderId=0;
    _aadhaarFirstName="";
    _aadhaarLastName="";
    _aadhaarMiddleName="";
    _panFirstName="";
    _panMiddleName="";
    _panLastName="";



  }

  static String get aadhaarLastName => _aadhaarLastName??"";

  static set aadhaarLastName(String value) {
    _aadhaarLastName = value;
  }

  static String get aadhaarMiddleName => _aadhaarMiddleName??"";

  static set aadhaarMiddleName(String value) {
    _aadhaarMiddleName = value;
  }

  static String get panFirstName => _panFirstName??"";

  static set panFirstName(String value) {
    _panFirstName = value;
  }

  static String get panMiddleName => _panMiddleName??"";

  static set panMiddleName(String value) {
    _panMiddleName = value;
  }

  static String get panLastName => _panLastName??"";

  static set panLastName(String value) {
    _panLastName = value;
  }
}
