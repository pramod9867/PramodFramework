import 'dart:convert';

import 'package:dhanvarsha/model/request/addreferencesdto.dart';

class AddReferencesDTONEW {
  int? refBlId;
  List<AddReferencesDTO>? refrences;

  AddReferencesDTONEW({this.refBlId, this.refrences});

  AddReferencesDTONEW.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    if (json['Refrences'] != null) {
      refrences =[];
      json['Refrences'].forEach((v) {
        refrences!.add(new AddReferencesDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    if (this.refrences != null) {
      data['Refrences'] = this.refrences!.map((v) => v.toJson()).toList();
    }
    return data;
  }

 String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    if (this.refrences != null) {
      data['Refrences'] = this.refrences!.map((v) => v.toJson()).toList();
    }
    return jsonEncode(data);
  }
  
}