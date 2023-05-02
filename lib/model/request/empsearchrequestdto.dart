import 'dart:convert';

class EmployerRequestDTO {
  String? companyName;

  EmployerRequestDTO({this.companyName});

  EmployerRequestDTO.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    return data;
  }

String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    return jsonEncode(data);
  }
}