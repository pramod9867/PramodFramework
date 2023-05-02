import 'dart:convert';

class PostMappingRequest {
  String? pincode;

  PostMappingRequest({this.pincode});

  PostMappingRequest.fromJson(Map<String, dynamic> json) {
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pincode'] = this.pincode;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pincode'] = this.pincode;
    return jsonEncode(data);
  }
}