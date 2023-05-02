import 'dart:convert';

import 'package:dhanvarsha/framework/local/sharedpref.dart';

class BasicBusinessDetailsRequestDTO {
  int? refBlId;
  String? dsaId;
  int? firmId;
  int? categoryId;
  String? firmType;
  String? businessPincode;
  bool? isSubDsa;

  BasicBusinessDetailsRequestDTO(
      {this.refBlId,
      this.dsaId,
      this.firmId,
      this.categoryId,
      this.firmType,
      this.businessPincode});

  BasicBusinessDetailsRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    dsaId = json['DsaId'];
    firmId = json['FirmId'];
    categoryId = json['CategoryId'];
    firmType = json['FirmType'];
    businessPincode = json['BusinessPincode'];
    isSubDsa=json['isSubDsa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['DsaId'] = this.dsaId;
    data['FirmId'] = this.firmId;
    data['CategoryId'] = this.categoryId;
    data['FirmType'] = this.firmType;
    data['BusinessPincode'] = this.businessPincode;
    return data;
  }

  Future<String> toEncodedJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['DsaId'] =
        await SharedPreferenceUtils.sharedPreferenceUtils.getDSAID();
    data['FirmId'] = this.firmId;
    data['CategoryId'] = this.categoryId;
    data['FirmType'] = this.firmType;
    data['BusinessPincode'] = this.businessPincode;
    data['isSubDsa']=this.isSubDsa;
    return jsonEncode(data);
  }
}
