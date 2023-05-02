import 'dart:convert';

class PanPostDTO {
  int? refID;
  String? panNumber;
  String? nameOnPan;
  String? dateOfBirth;
  String? typeOfUser;

  PanPostDTO(
      {this.refID,
        this.panNumber,
        this.nameOnPan,
        this.dateOfBirth,
        this.typeOfUser});

  PanPostDTO.fromJson(Map<String, dynamic> json) {
    refID = json['RefID'];
    panNumber = json['PanNumber'];
    nameOnPan = json['NameOnPan'];
    dateOfBirth = json['DateOfBirth'];
    typeOfUser = json['TypeOfUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefID'] = this.refID;
    data['PanNumber'] = this.panNumber;
    data['NameOnPan'] = this.nameOnPan;
    data['DateOfBirth'] = this.dateOfBirth;
    data['TypeOfUser'] = this.typeOfUser;
    return data;
  }


  Future<String> toEncodedJson()  async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefID'] = this.refID;
    data['PanNumber'] = this.panNumber;
    data['NameOnPan'] = this.nameOnPan;
    data['DateOfBirth'] = this.dateOfBirth;
    data['TypeOfUser'] = this.typeOfUser;
    return jsonEncode(data);
  }
}