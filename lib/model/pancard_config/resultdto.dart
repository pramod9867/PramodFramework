import 'package:dhanvarsha/model/pancard_config/namedto.dart';
import 'package:dhanvarsha/model/pancard_config/qualitycheckdto.dart';

class ResultDTO {
  NameDTO? date;
  NameDTO? dateOfIssue;
  NameDTO? father;
  NameDTO? name;
  NameDTO? panNumber;
  QualityCheckDTO? qualityCheckDTO;

  ResultDTO.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateOfIssue = NameDTO.fromJson(json['dateOfIssue']);
    father = NameDTO.fromJson(json['father']);
    name = NameDTO.fromJson(json['name']);
    panNumber = NameDTO.fromJson(json['name']);
    qualityCheckDTO = QualityCheckDTO.fromJson(json['qualityCheck']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.name;
    data['dateOfIssue'] = this.dateOfIssue;
    data['father'] = this.father;
    data['name'] = this.name;
    data['panNo'] = this.panNumber;
    data['qualityCheck'] = this.qualityCheckDTO;
    return data;
  }
}
