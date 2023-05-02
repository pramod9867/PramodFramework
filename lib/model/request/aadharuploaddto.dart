
import 'dart:convert';

class AadharUploadDTO {
  List<String>? fileNames;
  int? id;
  String? type;

  AadharUploadDTO({this.fileNames,this.id,this.type});

  AadharUploadDTO.fromJson(Map<String, dynamic> json) {
    fileNames = json['FileNames'].cast<String>();
    id=json['Id'];
    type=json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileNames'] = this.fileNames;
    return data;
  }

  String toEncodedJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileNames'] = this.fileNames;
    data['Id']=this.id;
    data['Type']=this.type!=null?this.type:"PL";
    return jsonEncode(data);
  }
}