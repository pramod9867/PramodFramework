import 'dart:convert';

class CSDTRequestDTO {
  int? id;

  CSDTRequestDTO({this.id});

  CSDTRequestDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    return data;
  }

 String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    return jsonEncode(data);
  }
}