import 'dart:convert';

import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';

class CoApplicantAddDTO {
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
  int? percentageCompleted;
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
  String? ShareHolderPercentage;
  bool? isCurrentAddressSameAadhaar;

  CoApplicantAddDTO(
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
      this.houseNo});

  CoApplicantAddDTO.fromJson(Map<String, dynamic> json) {
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
    ShareHolderPercentage = json['ShareHolderPercentage'] != null
        ? json['ShareHolderPercentage']
        : "";
    isCurrentAddressSameAadhaar=json['isCurrentAddresSameAsAadhar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['Id'] = 0;
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
    data['panFinFluxId'] =
        MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);
    data['aadharFrontFinFluxId'] = MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    data['aadharBackFinFluxId'] = MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarBackKey);
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['addressType'] = MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarAddress);
    data['houseNo'] = this.houseNo;
    data['ShareHolderPercentage'] =
        this.ShareHolderPercentage != null ? this.ShareHolderPercentage : "";
    data['isCurrentAddresSameAsAadhar']=this.isCurrentAddressSameAadhaar;
    return data;
  }

  String toEncodedJson() {
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
    data['panFinFluxId'] = MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);
    data['aadharFrontFinFluxId'] = MasterDocumentId.builder.getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    data['aadharBackFinFluxId'] = MasterDocumentId.builder.getMasterID(MasterDocIdentifier.aadhaarBackKey);
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['districtId'] = this.districtId;
    data['addressType'] = MasterDocumentId.builder.getMasterAddressID(MasterDocIdentifier.aadhaarAddress);
    data['houseNo'] = this.houseNo;
    data['ShareHolderPercentage'] =
        this.ShareHolderPercentage != null ? this.ShareHolderPercentage : "";
    data['isCurrentAddresSameAsAadhar']=this.isCurrentAddressSameAadhaar;
    print("Co-Applicant Add Data");
    print(jsonEncode(data));
    return jsonEncode(data);
  }
}
