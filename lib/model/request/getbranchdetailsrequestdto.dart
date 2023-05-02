import 'dart:convert';

class GetNearestBranchDetailsRequestDTO {
  String? latitude;
  String? longitude;
  GetNearestBranchDetailsRequestDTO({this.latitude, this.longitude});

  GetNearestBranchDetailsRequestDTO.fromJson(Map<String, dynamic> json) {
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    return jsonEncode(data);
  }
}
