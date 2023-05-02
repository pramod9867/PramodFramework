import 'dart:convert';

class RefUserAddress {
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


  RefUserAddress(
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

  RefUserAddress.fromJson(Map<String, dynamic> json) {
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
    data['countryId'] = this.countryId!=null?this.countryId:0;
    data['houseNo'] = this.houseNo!=null?this.houseNo:"";
    data['addressLineOne'] = this.addressLineOne!=null?this.addressLineOne:"";
    data['villageTown'] = this.villageTown!=null?this.villageTown:0;
    data['stateId'] = this.stateId!=null?this.stateId:0;
    data['districtId'] = this.districtId!=null?this.districtId:0;
    data['postalCode'] = this.postalCode!=null?this.postalCode:"";
    data['locale'] = this.locale!=null?this.locale:"";
    data['dateFormat'] = this.dateFormat!=null?this.dateFormat:"dd/MM/yyyy";
    data['addressTypes'] = this.addressTypes!=null?this.addressTypes:0;
    data['addressLineTwo']= this.addressLineTwo!=null?this.addressLineTwo:"";
    return data;
  }
  
  String toEncodedJSON(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId!=null?this.countryId:0;
    data['houseNo'] = this.houseNo!=null?this.houseNo:"";
    data['addressLineOne'] = this.addressLineOne!=null?this.addressLineOne:"";
    data['villageTown'] = this.villageTown!=null?this.villageTown:0;
    data['stateId'] = this.stateId!=null?this.stateId:0;
    data['districtId'] = this.districtId!=null?this.districtId:0;
    data['postalCode'] = this.postalCode!=null?this.postalCode:"";
    data['locale'] = this.locale!=null?this.locale:"";
    data['dateFormat'] = this.dateFormat!=null?this.dateFormat:"dd/MM/yyyy";
    data['addressTypes'] = this.addressTypes!=null?this.addressTypes:0;
    data['addressLineTwo']= this.addressLineTwo!=null?this.addressLineTwo:"";
    return jsonEncode(data);
  }
}