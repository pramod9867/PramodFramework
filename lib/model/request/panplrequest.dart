import 'dart:convert';

class PanPLRequestDTO {
  int? refPLId;
  String? firstName;
  String? lastName;
  String? middleName;
  String? dOB;
  String? panNumber;

  PanPLRequestDTO(
      {this.refPLId,
        this.firstName,
        this.lastName,
        this.middleName,
        this.dOB,
        this.panNumber});

  PanPLRequestDTO.fromJson(Map<String, dynamic> json) {
    refPLId = json['RefPLId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    middleName = json['MiddleName'];
    dOB = json['DOB'];
    panNumber = json['PanNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPLId'] = this.refPLId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['MiddleName'] = this.middleName;
    data['DOB'] = this.dOB;
    data['PanNumber'] = this.panNumber;
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPLId'] = this.refPLId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['MiddleName'] = this.middleName;
    data['DOB'] = this.dOB;
    data['PanNumber'] = this.panNumber;
    return jsonEncode(data);
  }
}