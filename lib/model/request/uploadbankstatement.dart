import 'dart:convert';

class UploadBankStatementDTO {
  int? refBlId;
  List<String>? bankStatements;
  String? BankStatementPassword;

  UploadBankStatementDTO({this.refBlId, this.bankStatements});

  UploadBankStatementDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    bankStatements = json['BankStatements'].cast<String>();
    BankStatementPassword=json['BankStatementPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BankStatements'] = this.bankStatements;
    data['BankStatementPassword']=this.BankStatementPassword;
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BankStatements'] = this.bankStatements;
    data['BankStatementPassword']=this.BankStatementPassword;
    return jsonEncode(data);
  }
}