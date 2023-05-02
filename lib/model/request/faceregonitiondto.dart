import 'dart:convert';

class FaceRegonizationDTO {
  List<String>? fileNames;
  int? id;
  String? type;
  FaceRegonizationDTO({this.fileNames,this.id});

  FaceRegonizationDTO.fromJson(Map<String, dynamic> json) {
    fileNames = json['FileNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileNames'] = this.fileNames;
    data['Id']=this.id;
    data['Type']=this.type!=null?this.type:"PL";
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileNames'] = this.fileNames;
    data['Id']=this.id;
    data['Type']=this.type!=null?this.type:"PL";
    return jsonEncode(data);
  }
}