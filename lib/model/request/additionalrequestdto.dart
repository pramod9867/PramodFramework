import 'dart:convert';

class AdditionalDetailsRequestDTO {
  int? refBlId;
  int? lastYearTurnOver;
  int? averageMonthlySales;
  String? natureofBusiness;
  int? natureofBusinessId;
  String? businessStartDate;
  bool? doesBusinessHaveCurrentBankAccount;
  int? presentMonthlyEmi;

  int? YesNo_cd_bankAccountFlag;

  AdditionalDetailsRequestDTO(
      {this.refBlId,
      this.lastYearTurnOver,
      this.averageMonthlySales,
      this.natureofBusiness,
      this.natureofBusinessId,
      this.businessStartDate,
      this.doesBusinessHaveCurrentBankAccount,
      this.presentMonthlyEmi,
    });

  AdditionalDetailsRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    lastYearTurnOver = json['LastYearTurnOver'];
    averageMonthlySales = json['AverageMonthlySales'];
    natureofBusiness = json['NatureofBusiness'];
    natureofBusinessId = json['NatureofBusinessId'];
    businessStartDate = json['BusinessStartDate'];
    doesBusinessHaveCurrentBankAccount =
        json['DoesBusinessHaveCurrentBankAccount'];
    presentMonthlyEmi = json['PresentMonthlyEmi'];
    YesNo_cd_bankAccountFlag=json['YesNo_cd_bankAccountFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['LastYearTurnOver'] = this.lastYearTurnOver;
    data['AverageMonthlySales'] = this.averageMonthlySales;
    data['NatureofBusiness'] = this.natureofBusiness;
    data['NatureofBusinessId'] = this.natureofBusinessId;
    data['BusinessStartDate'] = this.businessStartDate;
    data['DoesBusinessHaveCurrentBankAccount'] =
        this.doesBusinessHaveCurrentBankAccount;
    data['PresentMonthlyEmi'] = this.presentMonthlyEmi;
    data['YesNo_cd_bankAccountFlag']=this.YesNo_cd_bankAccountFlag;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['LastYearTurnOver'] = this.lastYearTurnOver;
    data['AverageMonthlySales'] = this.averageMonthlySales;
    data['NatureofBusiness'] = this.natureofBusiness;
    data['NatureofBusinessId'] = this.natureofBusinessId;
    data['BusinessStartDate'] = this.businessStartDate;
    data['DoesBusinessHaveCurrentBankAccount'] =
        this.doesBusinessHaveCurrentBankAccount;
    data['PresentMonthlyEmi'] = this.presentMonthlyEmi;
    data['YesNo_cd_bankAccountFlag']=this.YesNo_cd_bankAccountFlag;
    return jsonEncode(data);
  }
}
