import 'dart:convert';

class DSALoginDTO {
  String? mobileNumber;
  String? token;

  DSALoginDTO({this.mobileNumber});

  DSALoginDTO.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['MobileNumber'];
    token=json['ValidateToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNumber'] = this.mobileNumber;
    data['ValidateToken']=this.token;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNumber'] = this.mobileNumber;
    data['ValidateToken']=this.token;
    return jsonEncode(data);
  }
}
