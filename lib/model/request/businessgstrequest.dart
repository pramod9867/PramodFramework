import 'dart:convert';

class BusinesGstRequest {
  int? refBlId;
  String? gstNumber;
  String? consent;
  String? type;

  BusinesGstRequest({this.refBlId, this.gstNumber, this.consent, this.type});

  BusinesGstRequest.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    gstNumber = json['GstNumber'];
    consent = json['Consent'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['GstNumber'] = this.gstNumber;
    data['Consent'] = this.consent;
    data['Type'] = this.type;
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['GstNumber'] = this.gstNumber;
    data['Consent'] = this.consent;
    data['Type'] = this.type;
    return jsonEncode(data);
  }
}