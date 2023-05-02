import 'dart:convert';

class PinCodeDTO {
  String? pincode;

  PinCodeDTO({this.pincode});

  @override
  String toString() {
    return 'PinCodeDTO{pincode: $pincode}';
  }

  PinCodeDTO.fromJson(Map<String, dynamic> json) {
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pincode'] = this.pincode;
    return data;
  }


  String toEncodedJsonJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pincode'] = this.pincode;
    return jsonEncode(data);
  }
}
