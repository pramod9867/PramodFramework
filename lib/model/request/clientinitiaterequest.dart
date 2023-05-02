import 'dart:convert';

class RefClientRequest {
  int? refId;

  RefClientRequest({this.refId});

  RefClientRequest.fromJson(Map<String, dynamic> json) {
    refId = json['RefId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefId'] = this.refId;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefId'] = this.refId;
    return jsonEncode(data);
  }
}