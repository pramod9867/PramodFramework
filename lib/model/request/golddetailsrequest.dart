import 'dart:convert';

class GoldDetailsRequest {
  int? refGlId;
  String? dsaId;
  bool? isSubDsa;
  String? employmentType;
  String? goldKarat;
  String? goldWeight;

  GoldDetailsRequest(
      {this.refGlId,
        this.dsaId,
        this.isSubDsa,
        this.employmentType,
        this.goldKarat,
        this.goldWeight});

  GoldDetailsRequest.fromJson(Map<String, dynamic> json) {
    refGlId = json['RefGlId'];
    dsaId = json['DsaId'];
    isSubDsa = json['isSubDsa'];
    employmentType = json['EmploymentType'];
    goldKarat = json['GoldKarat'];
    goldWeight = json['GoldWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGlId'] = this.refGlId;
    data['DsaId'] = this.dsaId;
    data['isSubDsa'] = this.isSubDsa;
    data['EmploymentType'] = this.employmentType;
    data['GoldKarat'] = this.goldKarat;
    data['GoldWeight'] = this.goldWeight;
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGlId'] = this.refGlId;
    data['DsaId'] = this.dsaId;
    data['isSubDsa'] = this.isSubDsa;
    data['EmploymentType'] = this.employmentType;
    data['GoldKarat'] = this.goldKarat;
    data['GoldWeight'] = this.goldWeight;
    return jsonEncode(data);
  }
}