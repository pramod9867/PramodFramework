import 'dart:convert';

class OTPRequestDTO {
  String? mobileNumber;
  String? oTP;

  OTPRequestDTO({this.mobileNumber, this.oTP});

  OTPRequestDTO.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['MobileNumber'];
    oTP = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNumber'] = this.mobileNumber;
    data['OTP'] = this.oTP;
    return data;
  }


 String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNumber'] = this.mobileNumber;
    data['OTP'] = this.oTP;
    return jsonEncode(data);
  }
}