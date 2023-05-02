import 'dart:convert';

class ITRReturnDocDTO {
  int? refBlId;
  String? iTRDocumentImage;
  String? profitAndLossBalanceSheet;

  ITRReturnDocDTO(
      {this.refBlId, this.iTRDocumentImage, this.profitAndLossBalanceSheet});

  ITRReturnDocDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    iTRDocumentImage = json['ITRDocumentImage'];
    profitAndLossBalanceSheet = json['ProfitAndLossBalanceSheet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['ITRDocumentImage'] = this.iTRDocumentImage;
    data['ProfitAndLossBalanceSheet'] = this.profitAndLossBalanceSheet;
    return data;
  }



  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['ITRDocumentImage'] = this.iTRDocumentImage;
    data['ProfitAndLossBalanceSheet'] = this.profitAndLossBalanceSheet;
    return jsonEncode(data);
  }
}