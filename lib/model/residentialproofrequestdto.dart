import 'dart:convert';

class ResidentialProofRequestDTO {
  int? refBlId;
  String? residentialProofResidentialPincode;
  String? residentialProofAddressLine1;
  String? residentialProofAddressLine12;
  String? residentialProofCity;
  String? residentialProofState;
  String? residentialProofCountry;
  String? residentialProofDocumentName;
  String? residentialProofDocumentImage;
  String? customersPanImage;
  bool? residentialProofIsBillOnMyName;

  ResidentialProofRequestDTO(
      {this.refBlId,
        this.residentialProofResidentialPincode,
        this.residentialProofAddressLine1,
        this.residentialProofAddressLine12,
        this.residentialProofCity,
        this.residentialProofState,
        this.residentialProofCountry,
        this.residentialProofDocumentName,
        this.residentialProofDocumentImage,
        this.customersPanImage,
        this.residentialProofIsBillOnMyName});

  ResidentialProofRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    residentialProofResidentialPincode =
    json['ResidentialProofResidentialPincode'];
    residentialProofAddressLine1 = json['ResidentialProofAddressLine1'];
    residentialProofAddressLine12 = json['ResidentialProofAddressLine12'];
    residentialProofCity = json['ResidentialProofCity'];
    residentialProofState = json['ResidentialProofState'];
    residentialProofCountry = json['ResidentialProofCountry'];
    residentialProofDocumentName = json['ResidentialProofDocumentName'];
    residentialProofDocumentImage = json['ResidentialProofDocumentImage'];
    customersPanImage = json['CustomersPanImage'];
    residentialProofIsBillOnMyName = json['ResidentialProofIsBillOnMyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['ResidentialProofResidentialPincode'] =
        this.residentialProofResidentialPincode;
    data['ResidentialProofAddressLine1'] = this.residentialProofAddressLine1;
    data['ResidentialProofAddressLine12'] = this.residentialProofAddressLine12;
    data['ResidentialProofCity'] = this.residentialProofCity;
    data['ResidentialProofState'] = this.residentialProofState;
    data['ResidentialProofCountry'] = this.residentialProofCountry;
    data['ResidentialProofDocumentName'] = this.residentialProofDocumentName;
    data['ResidentialProofDocumentImage'] = this.residentialProofDocumentImage;
    data['CustomersPanImage'] = this.customersPanImage;
    data['ResidentialProofIsBillOnMyName'] =
        this.residentialProofIsBillOnMyName;
    return data;
  }

  Future<String> toEncodedJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['ResidentialProofResidentialPincode'] =
        this.residentialProofResidentialPincode;
    data['ResidentialProofAddressLine1'] = this.residentialProofAddressLine1;
    data['ResidentialProofAddressLine12'] = this.residentialProofAddressLine12;
    data['ResidentialProofCity'] = this.residentialProofCity;
    data['ResidentialProofState'] = this.residentialProofState;
    data['ResidentialProofCountry'] = this.residentialProofCountry;
    data['ResidentialProofDocumentName'] = this.residentialProofDocumentName;
    data['ResidentialProofDocumentImage'] = this.residentialProofDocumentImage;
    data['CustomersPanImage'] = this.customersPanImage;
    data['ResidentialProofIsBillOnMyName'] =
        this.residentialProofIsBillOnMyName;
    return jsonEncode(data);
  }

}