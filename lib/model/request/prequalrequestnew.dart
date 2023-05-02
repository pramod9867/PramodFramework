import 'dart:convert';

class PreEqualRequestNewDto {
  int? refPlId;
  int? pincode;
  int? declaredSalary;
  String? employmentType;
  String? modeOfsalary;
  String? employerName;
  int? declaredObligation;
  int? age;
  int? isPincodeServicible;

  PreEqualRequestNewDto(
      {this.refPlId,
        this.pincode,
        this.declaredSalary,
        this.employmentType,
        this.modeOfsalary,
        this.employerName,
        this.declaredObligation,
        this.age,
        this.isPincodeServicible});

  PreEqualRequestNewDto.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    pincode = json['pincode'];
    declaredSalary = json['declaredSalary'];
    employmentType = json['employmentType'];
    modeOfsalary = json['modeOfsalary'];
    employerName = json['employerName'];
    declaredObligation = json['declaredObligation'];
    age = json['age'];
    isPincodeServicible = json['isPincodeServicible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['pincode'] = this.pincode;
    data['declaredSalary'] = this.declaredSalary;
    data['employmentType'] = this.employmentType;
    data['modeOfsalary'] = this.modeOfsalary;
    data['employerName'] = this.employerName;
    data['declaredObligation'] = this.declaredObligation;
    data['age'] = this.age;
    data['isPincodeServicible'] = this.isPincodeServicible;
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['pincode'] = this.pincode;
    data['declaredSalary'] = this.declaredSalary;
    data['employmentType'] = this.employmentType;
    data['modeOfsalary'] = this.modeOfsalary;
    data['employerName'] = this.employerName;
    data['declaredObligation'] = this.declaredObligation;
    data['age'] = this.age;
    data['isPincodeServicible'] = this.isPincodeServicible;
    return jsonEncode(data);
  }
}