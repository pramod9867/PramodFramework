class PanResponseDTO {
  String? PanNumber;
  String? FirstName;
  String? MiddleName;
  String? LastName;
  String? DateOfBirth;


  PanResponseDTO(
      this.PanNumber,
      this.FirstName,
      this.MiddleName,
      this.LastName,
      this.DateOfBirth,
      );

  PanResponseDTO.fromJson(Map<String, dynamic> json) {
    PanNumber = json['PanNumber'];
    FirstName = json['FirstName'];
    MiddleName = json['MiddleName'];
    LastName = json['LastName'];
    DateOfBirth = json['DateOfBirth'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PanNumber'] = this.PanNumber;
    data['FirstName'] = this.FirstName;
    data['MiddleName'] = this.MiddleName;
    data['LastName'] = this.LastName;
    data['DateOfBirth'] = this.DateOfBirth;
    return data;
  }
}

