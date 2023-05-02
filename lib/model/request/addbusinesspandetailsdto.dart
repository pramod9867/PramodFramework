import 'dart:convert';

class AddBusinessPanDetailsDTO {
  int? refBlId;
  String? businessPanNumber;
  bool? businessHaveGSTRegistered;
  String? gSTINNumber;
  String? gSTLegalName;
  String? gSTTradeName;
  String? gSTServiceTaxRegistrationNumber;
  String? gSTDateOfRegistration;
  int? yesNoCdBankAccountFlag;
  String? businessPanImages;
  String? VintageYears;
  int? BusinessPanId;

  AddBusinessPanDetailsDTO(
      {this.refBlId,
      this.businessPanNumber,
      this.businessHaveGSTRegistered,
      this.gSTINNumber,
      this.gSTLegalName,
      this.gSTTradeName,
      this.gSTServiceTaxRegistrationNumber,
      this.gSTDateOfRegistration,
      this.yesNoCdBankAccountFlag,
      this.businessPanImages});

  AddBusinessPanDetailsDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    businessPanNumber = json['BusinessPanNumber'];
    businessHaveGSTRegistered = json['BusinessHaveGSTRegistered'];
    gSTINNumber = json['GSTINNumber'];
    gSTLegalName = json['GSTLegalName'];
    gSTTradeName = json['GSTTradeName'];
    gSTServiceTaxRegistrationNumber = json['GSTServiceTaxRegistrationNumber'];
    gSTDateOfRegistration = json['GSTDateOfRegistration'];
    businessPanImages = json['BusinessPanImageName'];
    BusinessPanId = json['BusinessPanId'];
    VintageYears=json['VintageYears'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessPanNumber'] = this.businessPanNumber;
    data['BusinessHaveGSTRegistered'] = this.businessHaveGSTRegistered;
    data['GSTINNumber'] = this.gSTINNumber;
    data['GSTLegalName'] = this.gSTLegalName;
    data['GSTTradeName'] = this.gSTTradeName;
    data['GSTServiceTaxRegistrationNumber'] =
        this.gSTServiceTaxRegistrationNumber;
    data['GSTDateOfRegistration'] = this.gSTDateOfRegistration;
    data['BusinessPanImageName'] = this.businessPanImages;
    data['BusinessPanId '] = 119;
    data['VintageYears']=this.VintageYears;
    return data;
  }

  Future<String> toEncodedJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessPanNumber'] = this.businessPanNumber;
    data['BusinessHaveGSTRegistered'] = this.businessHaveGSTRegistered;
    data['GSTINNumber'] = this.gSTINNumber;
    data['GSTLegalName'] = this.gSTLegalName;
    data['GSTTradeName'] = this.gSTTradeName;
    data['GSTServiceTaxRegistrationNumber'] =
        this.gSTServiceTaxRegistrationNumber;
    data['GSTDateOfRegistration'] = this.gSTDateOfRegistration;
    data['BusinessPanImageName'] = this.businessPanImages;
    data['BusinessPanId'] = 119;
    data['VintageYears']=this.VintageYears;
    return jsonEncode(data);
  }
}
