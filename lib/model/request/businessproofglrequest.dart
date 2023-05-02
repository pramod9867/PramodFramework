
import 'dart:convert';

class BusinessProofGLRequestDTO {
  int? refGLId;
  String? documentType;
  List<String>? documentNames;
  String? businessPincode;
  String? businessPin;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? allFormFlag;
  // String? requestId;
  // String? uniqueId;

  BusinessProofGLRequestDTO(
      {this.refGLId,
        this.documentType,
        this.documentNames,
        this.businessPincode,
        this.businessPin,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.allFormFlag,
       });

  BusinessProofGLRequestDTO.fromJson(Map<String, dynamic> json) {
    refGLId = json['RefGLId'];
    documentType = json['DocumentType'];
    documentNames = json['DocumentNames'].cast<String>();
    businessPincode = json['BusinessPincode'];
    businessPin = json['BusinessPin'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    city = json['City'];
    state = json['State'];
    allFormFlag = json['AllFormFlag'];
    // requestId = json['RequestId'];
    // uniqueId = json['UniqueId'];
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['DocumentType'] = this.documentType;
    data['DocumentNames'] = this.documentNames;
    data['BusinessPincode'] = this.businessPincode;
    data['BusinessPin'] = this.businessPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['City'] = this.city;
    data['State'] = this.state;
    data['AllFormFlag'] = this.allFormFlag;
    // data['RequestId'] = this.requestId;
    // data['UniqueId'] = this.uniqueId;
    return jsonEncode(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['DocumentType'] = this.documentType;
    data['DocumentNames'] = this.documentNames;
    data['BusinessPincode'] = this.businessPincode;
    data['BusinessPin'] = this.businessPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['City'] = this.city;
    data['State'] = this.state;
    data['AllFormFlag'] = this.allFormFlag;
    // data['RequestId'] = this.requestId;
    // data['UniqueId'] = this.uniqueId;
    return data;
  }
}