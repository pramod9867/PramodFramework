import 'dart:convert';

class AadhaarDTO {
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
  String? HouseNo;
  AadhaarDTO(
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

  AadhaarDTO.fromJson(Map<String, dynamic> json) {
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
    HouseNo = json['HouseNumber'];

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
    data['HouseNumber'] = this.HouseNo;


    print("HOUSE NO IS");
    print(data);
    return data;
  }

  String toEncodedJson() {
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
    data['HouseNumber'] = this.HouseNo;
    return jsonEncode(data);
  }
  
}