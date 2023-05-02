class VerifyOTPRes {

  DistributorDetails? distributorDetails;
  bool? isValidOTP;
  String? message;


  VerifyOTPRes({this.distributorDetails, this.isValidOTP, this.message});

  VerifyOTPRes.fromJson(Map<String, dynamic> json) {
    distributorDetails = json['DistributorDetails'] != null
        ? new DistributorDetails.fromJson(json['DistributorDetails'])
        : null;
    isValidOTP = json['isValidOTP'];
    message = json['message'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributorDetails != null) {
      data['DistributorDetails'] = this.distributorDetails?.toJson();
    }
    data['isValidOTP'] = this.isValidOTP;
    data['message'] = this.message;
    return data;
  }


  @override
  String toString() {
    return 'VerifyOTPRes{distributorDetails: $distributorDetails, isValidOTP: $isValidOTP, message: $message}';
  }

}

class DistributorDetails {
  Distributor? distributor;
  PanDetails? panDetails;
  AadharDetails? aadharDetails;

  DistributorDetails({this.distributor, this.panDetails, this.aadharDetails});

  DistributorDetails.fromJson(Map<String, dynamic> json) {
    distributor = json['Distributor'] != null
        ? new Distributor.fromJson(json['Distributor'])
        : null;
    panDetails = json['PanDetails'] != null
        ? new PanDetails.fromJson(json['PanDetails'])
        : null;
    aadharDetails = json['AadharDetails'] != null
        ? new AadharDetails.fromJson(json['AadharDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributor != null) {
      data['Distributor'] = this.distributor?.toJson();
    }
    if (this.panDetails != null) {
      data['PanDetails'] = this.panDetails?.toJson();
    }
    if (this.aadharDetails != null) {
      data['AadharDetails'] = this.aadharDetails?.toJson();
    }
    return data;
  }
}

class Distributor {
  String? pANImageUrl;
  String? aadharImageFrontUrl;
  String? aadharImageBackUrl;
  String? addressProofDocTypeImageUrl;
  String? rentalAgreementImageUrl;
  String? businessPANImageUrl;
  String? gSTCertificateImageUrl;
  String? cancelledChequeImageUrl;
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobileNumber;
  String? monthlyIncome;
  bool? isRegisteredBusiness;
  String? businessType;
  String? businessName;
  String? sizeOfShop;
  String? pANNumber;
  String? pANImage;
  String? aadharNumber;
  String? aadharImageFront;
  String? aadharImageBack;
  bool? isPANVerified;
  bool? isAadharVerified;
  String? gSTNumber;
  String? addressProofDocType;
  String? addressProofDocTypeImage;
  bool? isElectricityBillOnMyName;
  String? rentalAgreementImage;
  bool?  isRentalBillOnName;
  String? RentalBillName ;
  String? bankName;
  String? iFSCCode;
  String? accountNumber;
  String? nameOfAccountHolder;
  String? loginID;
  String? password;
  String? insertDateTime;
  String? updateDateTime;
  String? lastLoginDateTime;
  String? status;
  String? email;
  String? businessPAN;
  String? gSTCertificate;
  String? cancelledCheque;
  String? businessPANImage;
  String? gSTCertificateImage;
  String? cancelledChequeImage;
  String? allFormFlag;

  Distributor(
      {this.pANImageUrl,
        this.aadharImageFrontUrl,
        this.aadharImageBackUrl,
        this.addressProofDocTypeImageUrl,
        this.rentalAgreementImageUrl,
        this.businessPANImageUrl,
        this.gSTCertificateImageUrl,
        this.cancelledChequeImageUrl,
        this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.mobileNumber,
        this.monthlyIncome,
        this.isRegisteredBusiness,
        this.businessType,
        this.businessName,
        this.sizeOfShop,
        this.pANNumber,
        this.pANImage,
        this.aadharNumber,
        this.aadharImageFront,
        this.aadharImageBack,
        this.isPANVerified,
        this.isAadharVerified,
        this.gSTNumber,
        this.addressProofDocType,
        this.addressProofDocTypeImage,
        this.isElectricityBillOnMyName,
        this.rentalAgreementImage,
        this.isRentalBillOnName,
        this.RentalBillName,
        this.bankName,
        this.iFSCCode,
        this.accountNumber,
        this.nameOfAccountHolder,
        this.loginID,
        this.password,
        this.insertDateTime,
        this.updateDateTime,
        this.lastLoginDateTime,
        this.status,
        this.email,
        this.businessPAN,
        this.gSTCertificate,
        this.cancelledCheque,
        this.businessPANImage,
        this.gSTCertificateImage,
        this.cancelledChequeImage,
        this.allFormFlag});

  Distributor.fromJson(Map<String, dynamic> json) {
    pANImageUrl = json['PANImageUrl'];
    aadharImageFrontUrl = json['AadharImageFrontUrl'];
    aadharImageBackUrl = json['AadharImageBackUrl'];
    addressProofDocTypeImageUrl = json['AddressProofDocTypeImageUrl'];
    rentalAgreementImageUrl = json['RentalAgreementImageUrl'];
    businessPANImageUrl = json['BusinessPANImageUrl'];
    gSTCertificateImageUrl = json['GSTCertificateImageUrl'];
    cancelledChequeImageUrl = json['CancelledChequeImageUrl'];
    id = json['Id'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    monthlyIncome = json['MonthlyIncome'];
    isRegisteredBusiness = json['IsRegisteredBusiness'];
    businessType = json['BusinessType'];
    businessName = json['BusinessName'];
    sizeOfShop = json['SizeOfShop'];
    pANNumber = json['PANNumber'];
    pANImage = json['PANImage'];
    aadharNumber = json['AadharNumber'];
    aadharImageFront = json['AadharImageFront'];
    aadharImageBack = json['AadharImageBack'];
    isPANVerified = json['IsPANVerified'];
    isAadharVerified = json['IsAadharVerified'];
    gSTNumber = json['GSTNumber'];
    addressProofDocType = json['AddressProofDocType'];
    addressProofDocTypeImage = json['AddressProofDocTypeImage'];
    isElectricityBillOnMyName = json['IsElectricityBillOnMyName'];
    rentalAgreementImage = json['RentalAgreementImage'];
    isRentalBillOnName = json['isRentalBillOnName'];
    RentalBillName = json['RentalBillName'];
    bankName = json['BankName'];
    iFSCCode = json['IFSCCode'];
    accountNumber = json['AccountNumber'];
    nameOfAccountHolder = json['NameOfAccountHolder'];
    loginID = json['LoginID'];
    password = json['Password'];
    insertDateTime = json['InsertDateTime'];
    updateDateTime = json['UpdateDateTime'];
    lastLoginDateTime = json['LastLoginDateTime'];
    status = json['Status'];
    email = json['Email'];
    businessPAN = json['BusinessPAN'];
    gSTCertificate = json['GSTCertificate'];
    cancelledCheque = json['CancelledCheque'];
    businessPANImage = json['BusinessPANImage'];
    gSTCertificateImage = json['GSTCertificateImage'];
    cancelledChequeImage = json['CancelledChequeImage'];
    allFormFlag = json['AllFormFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PANImageUrl'] = this.pANImageUrl;
    data['AadharImageFrontUrl'] = this.aadharImageFrontUrl;
    data['AadharImageBackUrl'] = this.aadharImageBackUrl;
    data['AddressProofDocTypeImageUrl'] = this.addressProofDocTypeImageUrl;
    data['RentalAgreementImageUrl'] = this.rentalAgreementImageUrl;
    data['BusinessPANImageUrl'] = this.businessPANImageUrl;
    data['GSTCertificateImageUrl'] = this.gSTCertificateImageUrl;
    data['CancelledChequeImageUrl'] = this.cancelledChequeImageUrl;
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['MobileNumber'] = this.mobileNumber;
    data['MonthlyIncome'] = this.monthlyIncome;
    data['IsRegisteredBusiness'] = this.isRegisteredBusiness;
    data['BusinessType'] = this.businessType;
    data['BusinessName'] = this.businessName;
    data['SizeOfShop'] = this.sizeOfShop;
    data['PANNumber'] = this.pANNumber;
    data['PANImage'] = this.pANImage;
    data['AadharNumber'] = this.aadharNumber;
    data['AadharImageFront'] = this.aadharImageFront;
    data['AadharImageBack'] = this.aadharImageBack;
    data['IsPANVerified'] = this.isPANVerified;
    data['IsAadharVerified'] = this.isAadharVerified;
    data['GSTNumber'] = this.gSTNumber;
    data['AddressProofDocType'] = this.addressProofDocType;
    data['AddressProofDocTypeImage'] = this.addressProofDocTypeImage;
    data['IsElectricityBillOnMyName'] = this.isElectricityBillOnMyName;
    data['RentalAgreementImage'] = this.rentalAgreementImage;
    data['isRentalBillOnName'] = this.isRentalBillOnName;
    data['RentalBillName'] = this.RentalBillName;
    data['BankName'] = this.bankName;
    data['IFSCCode'] = this.iFSCCode;
    data['AccountNumber'] = this.accountNumber;
    data['NameOfAccountHolder'] = this.nameOfAccountHolder;
    data['LoginID'] = this.loginID;
    data['Password'] = this.password;
    data['InsertDateTime'] = this.insertDateTime;
    data['UpdateDateTime'] = this.updateDateTime;
    data['LastLoginDateTime'] = this.lastLoginDateTime;
    data['Status'] = this.status;
    data['Email'] = this.email;
    data['BusinessPAN'] = this.businessPAN;
    data['GSTCertificate'] = this.gSTCertificate;
    data['CancelledCheque'] = this.cancelledCheque;
    data['BusinessPANImage'] = this.businessPANImage;
    data['GSTCertificateImage'] = this.gSTCertificateImage;
    data['CancelledChequeImage'] = this.cancelledChequeImage;
    data['AllFormFlag'] = this.allFormFlag;
    return data;
  }
}

class PanDetails {
  String? panNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;

  PanDetails(
      {this.panNumber,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dateOfBirth});

  PanDetails.fromJson(Map<String, dynamic> json) {
    panNumber = json['PanNumber'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    dateOfBirth = json['DateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PanNumber'] = this.panNumber;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    return data;
  }
}

class AadharDetails {
  String? aadharNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? pincode;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;

  AadharDetails(
      {this.aadharNumber,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dateOfBirth,
        this.gender,
        this.pincode,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3});

  AadharDetails.fromJson(Map<String, dynamic> json) {
    aadharNumber = json['AadharNumber'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    pincode = json['Pincode'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AadharNumber'] = this.aadharNumber;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['Pincode'] = this.pincode;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    return data;
  }
}