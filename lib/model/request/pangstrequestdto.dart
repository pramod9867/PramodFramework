import 'dart:convert';

class PanGstnRequestDTO {
  String? consent;
  String? pan;

  PanGstnRequestDTO({this.consent, this.pan});

  PanGstnRequestDTO.fromJson(Map<String, dynamic> json) {
    consent = json['consent'];
    pan = json['pan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consent'] = this.consent;
    data['pan'] = this.pan;
    return data;
  }

String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consent'] = this.consent;
    data['pan'] = this.pan;
    return jsonEncode(data);
  }
}