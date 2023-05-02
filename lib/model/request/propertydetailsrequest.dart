import 'dart:convert';

class PropertyDetailsRequestDTO {
  int? refBlId;
  bool? isPropertyOwnedByACustomer;
  String? typeOfProperty;
  String? propertyPincode;
  bool? isCoApplicantOwnsProperty;
  String? propertyCoApplicantsName;
  String? propertyCoApplicantsRelation;
  String? propertyCoApplicantPropertyType;
  String? propertyCoApplicantPropertyPincode;
  int? OwnerownId;
  int? coapplicantrelationId;
  int? CoapplicantOwnid;
  PropertyDetailsRequestDTO(
      {this.refBlId,
        this.isPropertyOwnedByACustomer,
        this.typeOfProperty,
        this.propertyPincode,
        this.isCoApplicantOwnsProperty,
        this.propertyCoApplicantsName,
        this.propertyCoApplicantsRelation,
        this.propertyCoApplicantPropertyType,
        this.propertyCoApplicantPropertyPincode,
        this.OwnerownId,
        this.CoapplicantOwnid
      });

  PropertyDetailsRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    isPropertyOwnedByACustomer = json['IsPropertyOwnedByACustomer'];
    typeOfProperty = json['TypeOfProperty'];
    propertyPincode = json['PropertyPincode'];
    isCoApplicantOwnsProperty = json['IsCoApplicantOwnsProperty'];
    propertyCoApplicantsName = json['PropertyCoApplicantsName'];
    propertyCoApplicantsRelation = json['PropertyCoApplicantsRelation'];
    propertyCoApplicantPropertyType = json['PropertyCoApplicantPropertyType'];
    propertyCoApplicantPropertyPincode =
    json['PropertyCoApplicantPropertyPincode'];
    OwnerownId = json['OwnerownId'];
    CoapplicantOwnid = json['CoapplicantOwnid'];
    coapplicantrelationId=json['relationShipType_cd_coApplicantRelationShip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
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
    data['OwnerownId'] = this.OwnerownId;
    data['CoapplicantOwnid'] = this.CoapplicantOwnid;
    data['relationShipType_cd_coApplicantRelationShip']=this.coapplicantrelationId;
    return data;
  }


 Future<String> toEncodedJson() async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
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
    data['OwnerownId'] = this.OwnerownId;
    data['CoapplicantOwnid'] = this.CoapplicantOwnid;
    data['relationShipType_cd_coApplicantRelationShip']=this.coapplicantrelationId;
    return jsonEncode(data);
  }
}