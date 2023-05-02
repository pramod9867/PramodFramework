import 'dart:convert';

import 'package:dhanvarsha/model/response/refuseraddressdto.dart';

class AadhaarDetailsUploadBLDto {
  String? refID;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  String? gender;
  String? pincode;
  String? aadharNumber;
  String? dob;
  String? genderId;
  List<RefUserAddress>? refAddressRequest;

  AadhaarDetailsUploadBLDto(
      {this.refID,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dateOfBirth,
        this.gender,
        this.pincode,
        this.aadharNumber,
        this.dob,
        this.genderId,
        this.refAddressRequest});

  AadhaarDetailsUploadBLDto.fromJson(Map<String, dynamic> json) {
    refID = json['RefID'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    pincode = json['Pincode'];
    aadharNumber = json['AadharNumber'];
    dob = json['dob'];
    genderId = json['genderId'];
    if (json['RefAddressRequest'] != null) {
      refAddressRequest = [];
      json['RefAddressRequest'].forEach((v) {
        refAddressRequest!.add(new RefUserAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefID'] = this.refID;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['Pincode'] = this.pincode;
    data['AadharNumber'] = this.aadharNumber;
    data['dob'] = this.dob;
    data['genderId'] = this.genderId;
    if (this.refAddressRequest != null) {
      data['RefAddressRequest'] =
          this.refAddressRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }


 String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refID;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['Pincode'] = this.pincode;
    data['AadharNumber'] = this.aadharNumber;
    data['dob'] = this.dob;
    data['genderId'] = this.genderId;
    if (this.refAddressRequest != null) {
      data['RefAddressRequest'] =
          this.refAddressRequest!.map((v) => v.toJson()).toList();
    }
    return jsonEncode(data);
  }
}

// class RefAddressRequest {
//   int? countryId;
//   String? houseNo;
//   String? addressLineOne;
//   String? villageTown;
//   int? stateId;
//   int? districtId;
//   String? postalCode;
//   String? locale;
//   String? dateFormat;
//   int? addressTypes;
//
//   RefAddressRequest(
//       {this.countryId,
//         this.houseNo,
//         this.addressLineOne,
//         this.villageTown,
//         this.stateId,
//         this.districtId,
//         this.postalCode,
//         this.locale,
//         this.dateFormat,
//         this.addressTypes});
//
//   RefAddressRequest.fromJson(Map<String, dynamic> json) {
//     countryId = json['countryId'];
//     houseNo = json['houseNo'];
//     addressLineOne = json['addressLineOne'];
//     villageTown = json['villageTown'];
//     stateId = json['stateId'];
//     districtId = json['districtId'];
//     postalCode = json['postalCode'];
//     locale = json['locale'];
//     dateFormat = json['dateFormat'];
//     addressTypes = json['addressTypes'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['countryId'] = this.countryId;
//     data['houseNo'] = this.houseNo;
//     data['addressLineOne'] = this.addressLineOne;
//     data['villageTown'] = this.villageTown;
//     data['stateId'] = this.stateId;
//     data['districtId'] = this.districtId;
//     data['postalCode'] = this.postalCode;
//     data['locale'] = this.locale;
//     data['dateFormat'] = this.dateFormat;
//     data['addressTypes'] = this.addressTypes;
//     return data;
//   }
// }