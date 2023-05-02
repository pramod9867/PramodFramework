import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';

class FetchGLResponseDTO {
  int? refGLId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? employmentType;
  String? emailID;
  String? mobileNumber;
  String? pANNumber;
  String? pANImage;
  String? dateOfBirth;
  String? loanAmount;
  String? pincode;
  String? goldKarat;
  String? goldWeight;
  int? branchId;
  String? appointmentDate;
  String? appointmentTime;
  String? addressProofDocumentType;
  String? businessProofDocumentType;
  String? businessProofPincode;
  String? businessProofPin;
  String? businessProofAddressLine1;
  String? businessProofAddressLine2;
  String? businessProofCity;
  String? businessProofState;
  String? appointmentType;
  String? allFormFlag;
  List<String>? addressProofs;
  List<String>? businessProofs;
  NearestBrachDetailsResponseDTO? nearestBrachDetailsResponseDTO;
  // String? branchName;

  FetchGLResponseDTO(
      {this.refGLId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.employmentType,
      this.emailID,
      this.mobileNumber,
      this.pANNumber,
      this.pANImage,
      this.dateOfBirth,
      this.loanAmount,
      this.pincode,
      this.goldKarat,
      this.goldWeight,
      this.branchId,
      this.appointmentDate,
      this.appointmentTime,
      this.addressProofDocumentType,
      this.businessProofDocumentType,
      this.businessProofPincode,
      this.businessProofPin,
      this.businessProofAddressLine1,
      this.businessProofAddressLine2,
      this.businessProofCity,
      this.businessProofState,
      this.appointmentType,
      this.allFormFlag,
      this.addressProofs,
      this.businessProofs});

  FetchGLResponseDTO.fromJson(Map<String, dynamic> json) {
    refGLId = json['RefGLId'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    employmentType = json['EmploymentType'];
    emailID = json['EmailID'];
    mobileNumber = json['MobileNumber'];
    pANNumber = json['PANNumber'];
    pANImage = json['PANImage'];
    dateOfBirth = json['DateOfBirth'];
    loanAmount = json['LoanAmount'];
    pincode = json['Pincode'];
    goldKarat = json['GoldKarat'];
    goldWeight = json['GoldWeight'];
    branchId = json['BranchId'];
    appointmentDate = json['AppointmentDate'];
    appointmentTime = json['AppointmentTime'];
    addressProofDocumentType = json['AddressProofDocumentType'];
    businessProofDocumentType = json['BusinessProofDocumentType'];
    businessProofPincode = json['BusinessProofPincode'];
    businessProofPin = json['BusinessProofPin'];
    businessProofAddressLine1 = json['BusinessProofAddressLine1'];
    businessProofAddressLine2 = json['BusinessProofAddressLine2'];
    businessProofCity = json['BusinessProofCity'];
    businessProofState = json['BusinessProofState'];
    appointmentType = json['AppointmentType'];
    allFormFlag = json['AllFormFlag'];
    nearestBrachDetailsResponseDTO =
    json['BranchDetails']!=null?   NearestBrachDetailsResponseDTO.fromJson(json['BranchDetails']):

    NearestBrachDetailsResponseDTO(
      addressLine1: "test",
      branchID: "0",
      branchName: "",
      city: "",
      state: "",
      distance: "",
      latitude: "0",
      longitude: "0",
      pincode: "",
      id: 0
    )
    ;
    if (json['AddressProofs'] != null) {
      addressProofs = [];
      if (json['AddressProofs'] != []) {
        json['AddressProofs'].forEach((v) {
          addressProofs!.add(v);
        });
      }
    }

    if (json['BusinessProofs'] != null) {
      businessProofs = [];
      if (json['BusinessProofs'] != []) {
        json['BusinessProofs'].forEach((v) {
          businessProofs!.add(v);
        });
      }
    }
    // addressProofs = json['AddressProofs']!=[]?json['AddressProofs']:[];
    // businessProofs =json['AddressProofs']!=[]? json['BusinessProofs']:[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['EmploymentType'] = this.employmentType;
    data['EmailID'] = this.emailID;
    data['MobileNumber'] = this.mobileNumber;
    data['PANNumber'] = this.pANNumber;
    data['PANImage'] = this.pANImage;
    data['DateOfBirth'] = this.dateOfBirth;
    data['LoanAmount'] = this.loanAmount;
    data['Pincode'] = this.pincode;
    data['GoldKarat'] = this.goldKarat;
    data['GoldWeight'] = this.goldWeight;
    data['BranchId'] = this.branchId;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentTime'] = this.appointmentTime;
    data['AddressProofDocumentType'] = this.addressProofDocumentType;
    data['BusinessProofDocumentType'] = this.businessProofDocumentType;
    data['BusinessProofPincode'] = this.businessProofPincode;
    data['BusinessProofPin'] = this.businessProofPin;
    data['BusinessProofAddressLine1'] = this.businessProofAddressLine1;
    data['BusinessProofAddressLine2'] = this.businessProofAddressLine2;
    data['BusinessProofCity'] = this.businessProofCity;
    data['BusinessProofState'] = this.businessProofState;
    data['AppointmentType'] = this.appointmentType;
    data['AllFormFlag'] = this.allFormFlag;
    data['AddressProofs'] = this.addressProofs;
    data['BusinessProofs'] = this.businessProofs;
    data['BranchDetails'] = this.nearestBrachDetailsResponseDTO;
    return data;
  }
}
