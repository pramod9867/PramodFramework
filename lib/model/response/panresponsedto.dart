class PanResponseDTO {
  String? panNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dateOfBirth;
  int? CommmonPanId;

  PanResponseDTO(
      {this.panNumber,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dateOfBirth});

  PanResponseDTO.fromJson(Map<String, dynamic> json) {
    panNumber = json['PanNumber'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    dateOfBirth = json['DateOfBirth'];
    CommmonPanId = json['CommmonPanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PanNumber'] = this.panNumber;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['CommmonPanId'] = this.CommmonPanId;
    return data;
  }
}
