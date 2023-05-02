import 'package:dhanvarsha/model/request/referencdto.dart';

class FetchBLResponseDTO {
  int? refBlId;
  String? dSAId;
  String? SoftOfferAmount;
  String? softOfferStatus;
  bool? isSoftOfferAccepted;
  String? CBStatus;
  String? firmType;
  bool? isProprietor;
  int? firmId;
  int? categoryId;
  String? businessPincode;
  int? panDocumentTypeId;
  int? selfieId;
  int? aadharFrontDocumentTypeId;
  int? aadharBackDocumentTypeId;
  String? customersPanImage;
  String? customersPhotoImage;
  String? customersAadharFrontImage;
  String? customersAadharBackImage;
  bool? isAadharLinkedToMobile;
  bool? isPropertyOwnedByACustomer;
  String? typeOfProperty;
  String? propertyPincode;
  bool? isCoApplicantOwnsProperty;
  String? propertyCoApplicantsName;
  String? propertyCoApplicantsRelation;
  String? propertyCoApplicantPropertyType;
  String? propertyCoApplicantPropertyPincode;
  int? yesNoCdOwnedPropertyFlag;
  int? relationShipTypeCdCoApplicantRelationShip;
  int? ownerOwnid;
  int? coapplicantOwnid;
  int? lastYearTurnOver;
  int? averageMonthlySales;
  String? natureofBusiness;
  int? natureofBusinessId;
  String? businessStartDate;
  bool? doesBusinessHaveCurrentBankAccount;
  int? presentMonthlyEmi;
  int? yesNoCdBankAccountFlag;
  List<String>? bankStatements;
  String? businessPanNumber;
  String? businessPanImageName;
  bool? businessHaveGSTRegistered;
  String? gSTINNumber;
  String? VintageYears;
  String? gSTLegalName;
  String? gSTTradeName;
  String? gSTServiceTaxRegistrationNumber;
  String? gSTDateOfRegistration;
  int? businessPanId;
  String? residentialProofResidentialPincode;
  String? residentialProofAddressLine1;
  String? residentialProofAddressLine12;
  String? residentialProofCity;
  String? residentialProofState;
  String? residentialProofCountry;
  String? residentialProofDocumentName;
  String? residentialProofDocumentImage;
  String? residentialProofIsBillOnMyName;
  String? businessProofBusinessPincode;
  String? businessProofDocumentName;
  String? businessProofDocumentImage;
  String? businessProofAddressLine1;
  String? businessProofAddressLine2;
  String? businessProofCity;
  String? businessProofState;
  String? businessProofCountry;
  String? businessVintageProofDocumentImage;
  String? businessCommunityProofDocumentImage;
  String? iTRDocumentImage;
  String? profitAndLossBalanceSheet;
  List<ReferenceDTO>? refrences;
  List<CoApplicants>? coApplicants;
  String? incorporationDocumentName;
  String? incorporationDocumentImage;
  String? panNumber;
  String? nameOnPan;
  String? dateOfBirthPan;
  String? typeOfUser;
  String? aadharNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? genderId;
  List<RefAddressRequest>? refAddressRequest;
  String? panFirstName;
  String? panMiddleName;
  String? panLastName;
  int? loanId;
  int? clientId;
  String? MobileNumber;
  int?softOfferDueDays;

  FetchBLResponseDTO(
      {this.refBlId,
      this.dSAId,
      this.SoftOfferAmount,
      this.softOfferStatus,
      this.isSoftOfferAccepted,
      this.CBStatus,
      this.firmType,
      this.isProprietor,
      this.firmId,
      this.categoryId,
      this.businessPincode,
      this.panDocumentTypeId,
      this.selfieId,
      this.aadharFrontDocumentTypeId,
      this.aadharBackDocumentTypeId,
      this.customersPanImage,
      this.customersPhotoImage,
      this.customersAadharFrontImage,
      this.customersAadharBackImage,
      this.isAadharLinkedToMobile,
      this.isPropertyOwnedByACustomer,
      this.typeOfProperty,
      this.propertyPincode,
      this.isCoApplicantOwnsProperty,
      this.propertyCoApplicantsName,
      this.propertyCoApplicantsRelation,
      this.propertyCoApplicantPropertyType,
      this.propertyCoApplicantPropertyPincode,
      this.yesNoCdOwnedPropertyFlag,
      this.relationShipTypeCdCoApplicantRelationShip,
      this.ownerOwnid,
      this.coapplicantOwnid,
      this.lastYearTurnOver,
      this.averageMonthlySales,
      this.natureofBusiness,
      this.natureofBusinessId,
      this.businessStartDate,
      this.doesBusinessHaveCurrentBankAccount,
      this.presentMonthlyEmi,
      this.yesNoCdBankAccountFlag,
      this.bankStatements,
      this.businessPanNumber,
      this.businessPanImageName,
      this.businessHaveGSTRegistered,
      this.gSTINNumber,
      this.gSTLegalName,
      this.gSTTradeName,
      this.gSTServiceTaxRegistrationNumber,
      this.gSTDateOfRegistration,
      this.businessPanId,
      this.residentialProofResidentialPincode,
      this.residentialProofAddressLine1,
      this.residentialProofAddressLine12,
      this.residentialProofCity,
      this.residentialProofState,
      this.residentialProofCountry,
      this.residentialProofDocumentName,
      this.residentialProofDocumentImage,
      this.residentialProofIsBillOnMyName,
      this.businessProofBusinessPincode,
      this.businessProofDocumentName,
      this.businessProofDocumentImage,
      this.businessProofAddressLine1,
      this.businessProofAddressLine2,
      this.businessProofCity,
      this.businessProofState,
      this.businessProofCountry,
      this.businessVintageProofDocumentImage,
      this.businessCommunityProofDocumentImage,
      this.iTRDocumentImage,
      this.profitAndLossBalanceSheet,
      this.refrences,
      this.coApplicants,
      this.incorporationDocumentName,
      this.incorporationDocumentImage,
      this.panNumber,
      this.nameOnPan,
      this.dateOfBirthPan,
      this.typeOfUser,
      this.aadharNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.genderId,
      this.refAddressRequest,
      this.MobileNumber});

  FetchBLResponseDTO.fromJson(Map<String, dynamic> json) {
    try {
      refBlId = json['RefBLId'];
      dSAId = json['DSAId'];
      SoftOfferAmount = json['SoftOfferAmount'];
      print("Soft Offer Amount");
      print(SoftOfferAmount);
      softOfferStatus = json['SoftOfferStatus'];
      isSoftOfferAccepted = json['isSoftOfferAccepted'];
      CBStatus = json['CBStatus'];
      firmType = json['firmType'];
      isProprietor = json['isProprietor'];
      firmId = json['FirmId'] != null ? json['FirmId'] : 284;
      // categoryId = json['CategoryId'];
      businessPincode =
          json['BusinessPincode'] != null ? json['BusinessPincode'] : "400037";
      panDocumentTypeId = json['PanDocumentTypeId'];
      selfieId = json['SelfieId'];
      aadharFrontDocumentTypeId = json['AadharFrontDocumentTypeId'];
      aadharBackDocumentTypeId = json['AadharBackDocumentTypeId'];
      customersPanImage = json['CustomersPanImage'] != null
          ? json['CustomersPanImage']
          : "https://mgenius.in/FundingNXT_TopUp/Files/2899/PanPhoto.jpg";
      customersPhotoImage = json['CustomersPhotoImage'] != null
          ? json['CustomersPhotoImage']
          : "https://mgenius.in/FundingNXT_TopUp/Files/2899/PanPhoto.jpg";
      panFirstName =
          json['PanFirstName'] != null ? json['PanFirstName'] : "Avinash";
      panMiddleName =
          json['PanMiddleName'] != null ? json['PanMiddleName'] : "Kumar";
      panLastName =
          json['PanLastName'] != null ? json['PanLastName'] : "Lakhane";
      customersAadharFrontImage = json['CustomersAadharFrontImage'] != null
          ? json['CustomersAadharFrontImage']
          : "https://mgenius.in/FundingNXT_TopUp/Files/2899/PanPhoto.jpg";
      customersAadharBackImage = json['CustomersAadharBackImage'] != null
          ? json['CustomersAadharBackImage']
          : "https://mgenius.in/FundingNXT_TopUp/Files/2899/PanPhoto.jpg";
      isAadharLinkedToMobile = json['isAadharLinkedToMobile'] != null
          ? json['isAadharLinkedToMobile']
          : true;
      isPropertyOwnedByACustomer = json['IsPropertyOwnedByACustomer'] != null
          ? json['IsPropertyOwnedByACustomer']
          : true;
      typeOfProperty =
          json['TypeOfProperty'] != null ? json['TypeOfProperty'] : "Business";
      propertyPincode =
          json['PropertyPincode'] != null ? json['PropertyPincode'] : "400037";
      isCoApplicantOwnsProperty = json['IsCoApplicantOwnsProperty'] != null
          ? json['IsPropertyOwnedByACustomer']
          : false;
      propertyCoApplicantsName = json['PropertyCoApplicantsName'] != null
          ? json['PropertyCoApplicantsName']
          : "Avinash";
      propertyCoApplicantsRelation =
          json['PropertyCoApplicantsRelation'] != null
              ? json['PropertyCoApplicantsRelation']
              : "";
      propertyCoApplicantPropertyType =
          json['PropertyCoApplicantPropertyType'] != null
              ? json['PropertyCoApplicantPropertyType']
              : ""
                  "";
      propertyCoApplicantPropertyPincode =
          json['PropertyCoApplicantPropertyPincode'] != null
              ? json['PropertyCoApplicantPropertyPincode']
              : "400037";
      yesNoCdOwnedPropertyFlag = json['YesNo_cd_ownedPropertyFlag'] != null
          ? json['YesNo_cd_ownedPropertyFlag']
          : false;
      relationShipTypeCdCoApplicantRelationShip =
          json['relationShipType_cd_coApplicantRelationShip'] != null
              ? json['relationShipType_cd_coApplicantRelationShip']
              : 396;
      ownerOwnid = json['OwnerOwnid'] != null ? json['OwnerOwnid'] : 271;
      coapplicantOwnid =
          json['CoapplicantOwnid'] != null ? json['CoapplicantOwnid'] : 270;
      lastYearTurnOver = json['LastYearTurnOver'];
      averageMonthlySales = json['AverageMonthlySales'];
      natureofBusiness = json['NatureofBusiness'];
      natureofBusinessId = json['NatureofBusinessId'];
      businessStartDate = json['BusinessStartDate'];
      doesBusinessHaveCurrentBankAccount =
          json['DoesBusinessHaveCurrentBankAccount'];
      presentMonthlyEmi = json['PresentMonthlyEmi'];
      yesNoCdBankAccountFlag = json['YesNo_cd_bankAccountFlag'];
      bankStatements = json['BankStatements'].cast<String>();
      businessPanNumber = json['BusinessPanNumber'];
      businessPanImageName = json['BusinessPanImageName'];
      businessHaveGSTRegistered = json['BusinessHaveGSTRegistered'];
      gSTINNumber = json['GSTINNumber'];
      gSTLegalName = json['GSTLegalName'];
      gSTTradeName = json['GSTTradeName'];
      gSTServiceTaxRegistrationNumber = json['GSTServiceTaxRegistrationNumber'];
      gSTDateOfRegistration = json['GSTDateOfRegistration'];
      businessPanId = json['BusinessPanId'];
      residentialProofResidentialPincode =
          json['ResidentialProofResidentialPincode'];
      residentialProofAddressLine1 = json['ResidentialProofAddressLine1'];
      residentialProofAddressLine12 = json['ResidentialProofAddressLine12'];
      residentialProofCity = json['ResidentialProofCity'];
      residentialProofState = json['ResidentialProofState'];
      residentialProofCountry = json['ResidentialProofCountry'];
      residentialProofDocumentName = json['ResidentialProofDocumentName'];
      residentialProofDocumentImage = json['ResidentialProofDocumentImage'];
      residentialProofIsBillOnMyName = json['ResidentialProofIsBillOnMyName'];
      businessProofBusinessPincode = json['BusinessProofBusinessPincode'];
      businessProofDocumentName = json['BusinessProofDocumentName'];
      businessProofDocumentImage = json['BusinessProofDocumentImage'];
      businessProofAddressLine1 = json['BusinessProofAddressLine1'];
      businessProofAddressLine2 = json['BusinessProofAddressLine2'];
      businessProofCity = json['BusinessProofCity'];
      businessProofState = json['BusinessProofState'];
      businessProofCountry = json['BusinessProofCountry'];
      businessVintageProofDocumentImage =
          json['BusinessVintageProofDocumentImage'];
      businessCommunityProofDocumentImage =
          json['BusinessCommunityProofDocumentImage'];
      iTRDocumentImage = json['ITRDocumentImage'];
      profitAndLossBalanceSheet = json['ProfitAndLossBalanceSheet'];
      if (json['Refrences'] != null) {
        refrences = [];
        json['Refrences'].forEach((v) {
          refrences!.add(new ReferenceDTO.fromBLJSONJson(v));
        });
      }
      if (json['CoApplicants'] != null) {
        coApplicants = [];
        json['CoApplicants'].forEach((v) {
          coApplicants!.add(new CoApplicants.fromJson(v));
        });
      }
      incorporationDocumentName = json['IncorporationDocumentName'];
      incorporationDocumentImage = json['IncorporationDocumentImage'];
      panNumber = json['PanNumber'] != null ? json['PanNumber'] : "DKTP986710";
      // nameOnPan = json['NameOnPan'];
      dateOfBirthPan = json['DateOfBirth_Pan'] != null
          ? json['DateOfBirth_Pan']
          : "23/09/1997";
      MobileNumber = json['MobileNumber'];
      // typeOfUser = json['TypeOfUser'];
      aadharNumber = json['AadharNumber'] != null ? json['AadharNumber'] : "";
      firstName = json['FirstName'] != null ? json['FirstName'] : "";
      middleName = json['MiddleName'] != null ? json['MiddleName'] : "";
      lastName = json['LastName'] != null ? json['LastName'] : "";
      dateOfBirth = json['DateOfBirth'] != null ? json['DateOfBirth'] : "";
      gender = json['Gender'] != null ? json['Gender'] : "";
      genderId = json['genderId'] != null ? json['genderId'] : "";
      if (json['RefAddressRequest'] != null) {
        refAddressRequest = [];
        json['RefAddressRequest'].forEach((v) {
          refAddressRequest!.add(new RefAddressRequest.fromJson(v));
        });
      } else {
        refAddressRequest = [
          RefAddressRequest(
              countryId: 101,
              houseNo: "21",
              addressLineOne: "59/585, Secotr 2, Antop hill",
              villageTown: "Jamunagar",
              stateId: 1,
              districtId: 1,
              postalCode: "400037",
              addressTypes: 13,
              dateFormat: "dd/MM/yyyy",
              locale: "en"),
          RefAddressRequest(
              countryId: 101,
              houseNo: "21",
              addressLineOne: "59/585, Secotr 2, Antop hill",
              villageTown: "Jamunagar",
              stateId: 1,
              districtId: 1,
              postalCode: "400037",
              addressTypes: 14,
              dateFormat: "dd/MM/yyyy",
              locale: "en"),
          RefAddressRequest(
              countryId: 101,
              houseNo: "21",
              addressLineOne: "59/585, Secotr 2, Antop hill",
              villageTown: "Jamunagar",
              stateId: 1,
              districtId: 1,
              postalCode: "400037",
              addressTypes: 74,
              dateFormat: "dd/MM/yyyy",
              locale: "en"),
        ];
      }
      ;
      loanId = json['LoanId'];
      clientId = json['ClientId'];
      VintageYears = json['VintageYears'] != null ? json['VintageYears'] : "5";
      softOfferDueDays=json['softOfferDueDays']!=null?json['softOfferDueDays']:0;
    } catch (e) {
      print("Into the error");
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBLId'] = this.refBlId;
    data['DSAId'] = this.dSAId;
    data['SoftOfferAmount'] = this.SoftOfferAmount;
    data['SoftOfferStatus'] = this.softOfferStatus;
    data['isSoftOfferAccepted'] = this.isSoftOfferAccepted;
    data['CBStatus'] = this.CBStatus;
    data['firmType'] = this.firmType;
    data['isProprietor'] = this.isProprietor;
    data['FirmId'] = this.firmId;
    data['CategoryId'] = this.categoryId;
    data['BusinessPincode'] = this.businessPincode;
    data['PanDocumentTypeId'] = this.panDocumentTypeId;
    data['SelfieId'] = this.selfieId;
    data['AadharFrontDocumentTypeId'] = this.aadharFrontDocumentTypeId;
    data['AadharBackDocumentTypeId'] = this.aadharBackDocumentTypeId;
    data['CustomersPanImage'] = this.customersPanImage;
    data['CustomersPhotoImage'] = this.customersPhotoImage;
    data['CustomersAadharFrontImage'] = this.customersAadharFrontImage;
    data['CustomersAadharBackImage'] = this.customersAadharBackImage;
    data['isAadharLinkedToMobile'] = this.isAadharLinkedToMobile;
    data['IsPropertyOwnedByACustomer'] = this.isPropertyOwnedByACustomer;
    data['TypeOfProperty'] = this.typeOfProperty;
    data['PropertyPincode'] = this.propertyPincode;
    data['IsCoApplicantOwnsProperty'] = this.isCoApplicantOwnsProperty;
    data['PropertyCoApplicantsName'] = this.propertyCoApplicantsName;
    data['PropertyCoApplicantsRelation'] = this.propertyCoApplicantsRelation;
    data['PropertyCoApplicantPropertyType'] =
        this.propertyCoApplicantPropertyType;
    data['PropertyCoApplicantPropertyPincode'] =
        this.propertyCoApplicantPropertyPincode;
    data['YesNo_cd_ownedPropertyFlag'] = this.yesNoCdOwnedPropertyFlag;
    data['relationShipType_cd_coApplicantRelationShip'] =
        this.relationShipTypeCdCoApplicantRelationShip;
    data['OwnerOwnid'] = this.ownerOwnid;
    data['CoapplicantOwnid'] = this.coapplicantOwnid;
    data['LastYearTurnOver'] = this.lastYearTurnOver;
    data['AverageMonthlySales'] = this.averageMonthlySales;
    data['NatureofBusiness'] = this.natureofBusiness;
    data['NatureofBusinessId'] = this.natureofBusinessId;
    data['BusinessStartDate'] = this.businessStartDate;
    data['DoesBusinessHaveCurrentBankAccount'] =
        this.doesBusinessHaveCurrentBankAccount;
    data['PresentMonthlyEmi'] = this.presentMonthlyEmi;
    data['YesNo_cd_bankAccountFlag'] = this.yesNoCdBankAccountFlag;
    data['BankStatements'] = this.bankStatements;
    data['BusinessPanNumber'] = this.businessPanNumber;
    data['BusinessPanImageName'] = this.businessPanImageName;
    data['BusinessHaveGSTRegistered'] = this.businessHaveGSTRegistered;
    data['GSTINNumber'] = this.gSTINNumber;
    data['GSTLegalName'] = this.gSTLegalName;
    data['GSTTradeName'] = this.gSTTradeName;
    data['GSTServiceTaxRegistrationNumber'] =
        this.gSTServiceTaxRegistrationNumber;
    data['GSTDateOfRegistration'] = this.gSTDateOfRegistration;
    data['BusinessPanId'] = this.businessPanId;
    data['ResidentialProofResidentialPincode'] =
        this.residentialProofResidentialPincode;
    data['ResidentialProofAddressLine1'] = this.residentialProofAddressLine1;
    data['ResidentialProofAddressLine12'] = this.residentialProofAddressLine12;
    data['ResidentialProofCity'] = this.residentialProofCity;
    data['ResidentialProofState'] = this.residentialProofState;
    data['ResidentialProofCountry'] = this.residentialProofCountry;
    data['ResidentialProofDocumentName'] = this.residentialProofDocumentName;
    data['ResidentialProofDocumentImage'] = this.residentialProofDocumentImage;
    data['ResidentialProofIsBillOnMyName'] =
        this.residentialProofIsBillOnMyName;
    data['BusinessProofBusinessPincode'] = this.businessProofBusinessPincode;
    data['BusinessProofDocumentName'] = this.businessProofDocumentName;
    data['BusinessProofDocumentImage'] = this.businessProofDocumentImage;
    data['BusinessProofAddressLine1'] = this.businessProofAddressLine1;
    data['BusinessProofAddressLine2'] = this.businessProofAddressLine2;
    data['BusinessProofCity'] = this.businessProofCity;
    data['BusinessProofState'] = this.businessProofState;
    data['BusinessProofCountry'] = this.businessProofCountry;
    data['BusinessVintageProofDocumentImage'] =
        this.businessVintageProofDocumentImage;
    data['BusinessCommunityProofDocumentImage'] =
        this.businessCommunityProofDocumentImage;
    data['ITRDocumentImage'] = this.iTRDocumentImage;
    data['ProfitAndLossBalanceSheet'] = this.profitAndLossBalanceSheet;
    if (this.refrences != null) {
      data['Refrences'] = this.refrences!.map((v) => v.toJson()).toList();
    }
    if (this.coApplicants != null) {
      data['CoApplicants'] = this.coApplicants!.map((v) => v.toJson()).toList();
    }
    data['IncorporationDocumentName'] = this.incorporationDocumentName;
    data['IncorporationDocumentImage'] = this.incorporationDocumentImage;
    data['PanNumber'] = this.panNumber;
    data['NameOnPan'] = this.nameOnPan;
    data['DateOfBirth_Pan'] = this.dateOfBirthPan;
    data['TypeOfUser'] = this.typeOfUser;
    data['AadharNumber'] = this.aadharNumber;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['genderId'] = this.genderId;
    if (this.refAddressRequest != null) {
      data['RefAddressRequest'] =
          this.refAddressRequest!.map((v) => v.toJson()).toList();
    };
    data['LoanId'] = this.loanId;
    data['VintageYears']=this.VintageYears;
    data['ClientId'] = this.clientId;
    data['MobileNumber'] = this.MobileNumber;
    data['softOfferDueDays']=this.softOfferDueDays;

    return data;
  }
}

class Refrences {
  int? id;
  int? refBlId;
  String? fullName;
  String? emailId;
  String? mobileNumber;
  int? relationShipWithCustomer;
  bool? deleteFlag;

  Refrences(
      {this.id,
      this.refBlId,
      this.fullName,
      this.emailId,
      this.mobileNumber,
      this.relationShipWithCustomer,
      this.deleteFlag});

  Refrences.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    refBlId = json['RefBLId'];
    fullName = json['FullName'];
    emailId = json['EmailId'];
    mobileNumber = json['MobileNumber'];
    relationShipWithCustomer = json['RelationShipWithCustomer'];
    deleteFlag = json['DeleteFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['RefBLId'] = this.refBlId;
    data['FullName'] = this.fullName;
    data['EmailId'] = this.emailId;
    data['MobileNumber'] = this.mobileNumber;
    data['RelationShipWithCustomer'] = this.relationShipWithCustomer;
    data['DeleteFlag'] = this.deleteFlag;
    return data;
  }
}

class CoApplicants {
  int? refBlId;
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobileNumber;
  String? emailId;
  String? pincode;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? coApplicantPanNumber;
  String? coApplicantPanImage;
  String? coApplicantAadharNumber;
  String? coApplicantAadharFrontImage;
  String? coApplicantAadharBackImage;
  String? coApplicantProofOfAddressDocumentType;
  String? coApplicantProofOfAddressDocumentImage;
  double? percentageCompleted;
  String? gender;
  String? dob;
  int? genderId;
  int? panFinFluxId;
  int? aadharFrontFinFluxId;
  int? aadharBackFinFluxId;
  int? countryId;
  int? stateId;
  int? districtId;
  int? addressType;
  String? houseNo;
  String? shareHolderPercentage;
  bool? isCurrentAddresSameAsAadhar;

  CoApplicants(
      {this.refBlId,
      this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobileNumber,
      this.emailId,
      this.pincode,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.country,
      this.coApplicantPanNumber,
      this.coApplicantPanImage,
      this.coApplicantAadharNumber,
      this.coApplicantAadharFrontImage,
      this.coApplicantAadharBackImage,
      this.coApplicantProofOfAddressDocumentType,
      this.coApplicantProofOfAddressDocumentImage,
      this.percentageCompleted,
      this.gender,
      this.dob,
      this.genderId,
      this.panFinFluxId,
      this.aadharFrontFinFluxId,
      this.aadharBackFinFluxId,
      this.countryId,
      this.stateId,
      this.districtId,
      this.addressType,
      this.houseNo,
      this.shareHolderPercentage});

  CoApplicants.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    id = json['Id'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    mobileNumber = json['MobileNumber'];
    emailId = json['EmailId'];
    pincode = json['Pincode'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    coApplicantPanNumber = json['CoApplicantPanNumber'];
    coApplicantPanImage = json['CoApplicantPanImage'];
    coApplicantAadharNumber = json['CoApplicantAadharNumber'];
    coApplicantAadharFrontImage = json['CoApplicantAadharFrontImage'];
    coApplicantAadharBackImage = json['CoApplicantAadharBackImage'];
    coApplicantProofOfAddressDocumentType =
        json['CoApplicantProofOfAddressDocumentType'];
    coApplicantProofOfAddressDocumentImage =
        json['CoApplicantProofOfAddressDocumentImage'];
    percentageCompleted = json['PercentageCompleted'];
    gender = json['gender'];
    dob = json['dob'];
    genderId = json['genderId'];
    panFinFluxId = json['panFinFluxId'];
    aadharFrontFinFluxId = json['aadharFrontFinFluxId'];
    aadharBackFinFluxId = json['aadharBackFinFluxId'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    addressType = json['addressType'];
    houseNo = json['houseNo'];
    shareHolderPercentage = json['ShareHolderPercentage'];
    isCurrentAddresSameAsAadhar=json['isCurrentAddresSameAsAadhar'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['MobileNumber'] = this.mobileNumber;
    data['EmailId'] = this.emailId;
    data['Pincode'] = this.pincode;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['CoApplicantPanNumber'] = this.coApplicantPanNumber;
    data['CoApplicantPanImage'] = this.coApplicantPanImage;
    data['CoApplicantAadharNumber'] = this.coApplicantAadharNumber;
    data['CoApplicantAadharFrontImage'] = this.coApplicantAadharFrontImage;
    data['CoApplicantAadharBackImage'] = this.coApplicantAadharBackImage;
    data['CoApplicantProofOfAddressDocumentType'] =
        this.coApplicantProofOfAddressDocumentType;
    data['CoApplicantProofOfAddressDocumentImage'] =
        this.coApplicantProofOfAddressDocumentImage;
    data['PercentageCompleted'] = this.percentageCompleted;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['genderId'] = this.genderId;
    data['panFinFluxId'] = this.panFinFluxId;
    data['aadharFrontFinFluxId'] = this.aadharFrontFinFluxId;
    data['aadharBackFinFluxId'] = this.aadharBackFinFluxId;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['addressType'] = this.addressType;
    data['houseNo'] = this.houseNo;
    data['ShareHolderPercentage'] = this.shareHolderPercentage;
    data['isCurrentAddresSameAsAadhar']=this.isCurrentAddresSameAsAadhar;
    return data;
  }
}

class RefAddressRequest {
  int? countryId;
  String? houseNo;
  String? addressLineOne;
  String? addressLineTwo;
  String? villageTown;
  int? stateId;
  int? districtId;
  String? postalCode;
  String? locale;
  String? dateFormat;
  int? addressTypes;

  RefAddressRequest(
      {this.countryId,
      this.houseNo,
      this.addressLineOne,
      this.villageTown,
      this.stateId,
      this.districtId,
      this.postalCode,
      this.locale,
      this.dateFormat,
      this.addressTypes});

  RefAddressRequest.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    houseNo = json['houseNo'];
    addressLineOne = json['addressLineOne'];
    villageTown = json['villageTown'];
    stateId = json['stateId'];
    districtId = json['districtId'];
    postalCode = json['postalCode'];
    locale = json['locale'];
    dateFormat = json['dateFormat'];
    addressTypes = json['addressTypes'];
    addressLineTwo=json['addressLineTwo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['houseNo'] = this.houseNo;
    data['addressLineOne'] = this.addressLineOne;
    data['villageTown'] = this.villageTown;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['postalCode'] = this.postalCode;
    data['locale'] = this.locale;
    data['dateFormat'] = this.dateFormat;
    data['addressTypes'] = this.addressTypes;
    data['addressLineTwo'] = this.addressLineTwo;
    return data;
  }
}
