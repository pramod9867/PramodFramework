import 'dart:convert';

class MobileVerificationDTO {
  String? mobiliNumber;

  MobileVerificationDTO({this.mobiliNumber});

  MobileVerificationDTO.fromJson(Map<String, dynamic> json) {
    mobiliNumber = json['MobiliNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobiliNumber'] = this.mobiliNumber;
    return data;
  }


  String toEncodeJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobiliNumber'] = this.mobiliNumber;
    return jsonEncode(data);
  }
}