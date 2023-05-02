import 'dart:convert';

class ClientVerifyDTO {
  String? mobileNo;
  String? fullName;
  int? loanAmount;
  String? pAN;
  String? pincode;
  String? PanFileName;
  String? DOB;

  ClientVerifyDTO(
      {this.mobileNo, this.fullName, this.loanAmount, this.pAN, this.pincode});

  ClientVerifyDTO.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    fullName = json['FullName'];
    loanAmount = json['LoanAmount'];
    pAN = json['PAN'];
    pincode = json['Pincode'];
    PanFileName = json['PanFileName'];
    DOB = json['DOB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['FullName'] = this.fullName;
    data['LoanAmount'] = this.loanAmount;
    data['PAN'] = this.pAN;
    data['Pincode'] = this.pincode;
    data['PanFileName'] = this.PanFileName;
    data['DOB'] = this.DOB;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['FullName'] = this.fullName;
    data['LoanAmount'] = this.loanAmount;
    data['PAN'] = this.pAN;
    data['Pincode'] = this.pincode;
    data['PanFileName'] = this.PanFileName;
    data['DOB'] = this.DOB;

    print("Encoded JSON");
    print(jsonEncode(data));
    return jsonEncode(data);
  }
}
