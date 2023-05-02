import 'dart:convert';

class VerifyOTP {
  int? refID;
  String? oTP;
  String? mobileNumber;

  VerifyOTP({this.refID, this.oTP, this.mobileNumber});

  VerifyOTP.fromJson(Map<String, dynamic> json) {
    refID = json['RefID'];
    oTP = json['OTP'];
    mobileNumber = json['MobileNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefID'] = this.refID;
    data['OTP'] = this.oTP;
    data['MobileNumber'] = this.mobileNumber;
    return data;
  }


String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefID'] = this.refID;
    data['OTP'] = this.oTP;
    data['MobileNumber'] = this.mobileNumber;
    return jsonEncode(data);
  }
}