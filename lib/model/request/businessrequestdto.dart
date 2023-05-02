import 'dart:convert';

class BusinessProofRequestDTO {
  int? refBlId;
  String? businessProofBusinessPincode;
  String? businessProofDocumentName;
  String? businessProofDocumentImage;
  String? businessProofAddressLine1;
  String? businessProofAddressLine2;
  String? businessProofCity;
  String? businessProofState;
  String? businessProofCountry;

  BusinessProofRequestDTO(
      {this.refBlId,
        this.businessProofBusinessPincode,
        this.businessProofDocumentName,
        this.businessProofDocumentImage,
        this.businessProofAddressLine1,
        this.businessProofAddressLine2,
        this.businessProofCity,
        this.businessProofState,
        this.businessProofCountry});

  BusinessProofRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    businessProofBusinessPincode = json['BusinessProofBusinessPincode'];
    businessProofDocumentName = json['BusinessProofDocumentName'];
    businessProofDocumentImage = json['BusinessProofDocumentImage'];
    businessProofAddressLine1 = json['BusinessProofAddressLine1'];
    businessProofAddressLine2 = json['BusinessProofAddressLine2'];
    businessProofCity = json['BusinessProofCity'];
    businessProofState = json['BusinessProofState'];
    businessProofCountry = json['BusinessProofCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessProofBusinessPincode'] = this.businessProofBusinessPincode;
    data['BusinessProofDocumentName'] = this.businessProofDocumentName;
    data['BusinessProofDocumentImage'] = this.businessProofDocumentImage;
    data['BusinessProofAddressLine1'] = this.businessProofAddressLine1;
    data['BusinessProofAddressLine2'] = this.businessProofAddressLine2;
    data['BusinessProofCity'] = this.businessProofCity;
    data['BusinessProofState'] = this.businessProofState;
    data['BusinessProofCountry'] = this.businessProofCountry;
    return data;
  }


  Future<String> toEncodedJson()  async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessProofBusinessPincode'] = this.businessProofBusinessPincode;
    data['BusinessProofDocumentName'] = this.businessProofDocumentName;
    data['BusinessProofDocumentImage'] = this.businessProofDocumentImage;
    data['BusinessProofAddressLine1'] = this.businessProofAddressLine1;
    data['BusinessProofAddressLine2'] = this.businessProofAddressLine2;
    data['BusinessProofCity'] = this.businessProofCity;
    data['BusinessProofState'] = this.businessProofState;
    data['BusinessProofCountry'] = this.businessProofCountry;
    return jsonEncode(data);
  }
}