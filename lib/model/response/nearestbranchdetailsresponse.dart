import 'dart:convert';

class NearestBrachDetailsResponseDTO {
  int? id;
  String? distance;
  String? branchID;
  String? branchName;
  String? addressLine1;
  String? state;
  String? city;
  String? pincode;
  String? latitude;
  String? longitude;

  NearestBrachDetailsResponseDTO(
      {this.id,
      this.distance,
      this.branchID,
      this.branchName,
      this.addressLine1,
      this.state,
      this.city,
      this.pincode,
      this.latitude,
      this.longitude});

  NearestBrachDetailsResponseDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    distance = json['Distance'];
    branchID = json['Branch_ID'];
    branchName = json['Branch_Name'];
    addressLine1 = json['Address_Line1'];
    state = json['State'];
    city = json['City'];
    pincode = json['Pincode'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Distance'] = this.distance;
    data['Branch_ID'] = this.branchID;
    data['Branch_Name'] = this.branchName;
    data['Address_Line1'] = this.addressLine1;
    data['State'] = this.state;
    data['City'] = this.city;
    data['Pincode'] = this.pincode;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Distance'] = this.distance;
    data['Branch_ID'] = this.branchID;
    data['Branch_Name'] = this.branchName;
    data['Address_Line1'] = this.addressLine1;
    data['State'] = this.state;
    data['City'] = this.city;
    data['Pincode'] = this.pincode;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return jsonEncode(data);
  }
}
