class LoginBankDetailsDTO {
  String? accountNumber;
  String? bankName;
  String? iFSCCode;
  String? name;

  LoginBankDetailsDTO(
      {this.accountNumber, this.bankName, this.iFSCCode, this.name});

  LoginBankDetailsDTO.fromJson(Map<String, dynamic> json) {
    accountNumber = json['AccountNumber']!=""?json['AccountNumber']:"-";
    bankName = json['BankName']!=""?json['BankName']:"-";
    iFSCCode = json['IFSCCode']!=""?json['IFSCCode']:"-";
    name = json['Name']!=""?json['Name']:"-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccountNumber'] = this.accountNumber;
    data['BankName'] = this.bankName;
    data['IFSCCode'] = this.iFSCCode;
    data['Name'] = this.name;
    return data;
  }
}