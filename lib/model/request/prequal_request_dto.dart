import 'dart:convert';

class PreEqualRequest {
  int? refPlId;
  int? monthlyEmi;
  String? pincodeServicableStatus;
  int? declaredSalary;
  String? employmentType;
  String? modeOfsalary;
  String? companyCategory;
  int? negPincodeStatus;
  int? age;
  int? loanAmount;

  PreEqualRequest(
      {this.refPlId,
        this.monthlyEmi,
        this.pincodeServicableStatus,
        this.declaredSalary,
        this.employmentType,
        this.modeOfsalary,
        this.companyCategory,
        this.negPincodeStatus,
        this.age,
        this.loanAmount});

  PreEqualRequest.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    monthlyEmi = json['monthlyEmi'];
    pincodeServicableStatus = json['pincodeServicableStatus'];
    declaredSalary = json['declaredSalary'];
    employmentType = json['employmentType'];
    modeOfsalary = json['modeOfsalary'];
    companyCategory = json['companyCategory'];
    negPincodeStatus = json['negPincodeStatus'];
    age = json['age'];
    loanAmount = json['loanAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['monthlyEmi'] = this.monthlyEmi;
    data['pincodeServicableStatus'] = this.pincodeServicableStatus;
    data['declaredSalary'] = this.declaredSalary;
    data['employmentType'] = this.employmentType;
    data['modeOfsalary'] = this.modeOfsalary;
    data['companyCategory'] = this.companyCategory;
    data['negPincodeStatus'] = this.negPincodeStatus!=null?this.negPincodeStatus:0;
    data['age'] = this.age;
    data['loanAmount'] = this.loanAmount;
    return data;
  }


  String toEncodedJson(){
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['RefPlId'] = this.refPlId;
      data['monthlyEmi'] = this.monthlyEmi;
      data['pincodeServicableStatus'] = this.pincodeServicableStatus;
      data['declaredSalary'] = this.declaredSalary;
      data['employmentType'] = this.employmentType;
      data['modeOfsalary'] = this.modeOfsalary;
      data['companyCategory'] = this.companyCategory;
      data['negPincodeStatus'] = this.negPincodeStatus!=null?this.negPincodeStatus:0;
      data['age'] = this.age;
      data['loanAmount'] = this.loanAmount;
      return jsonEncode(data);
  }
}