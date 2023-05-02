import 'dart:convert';

class UploadAddressProofRequestDTO {
  int? refGLId;
  String? documentType;
  List<String>? documentNames;
  String? allFormFlag;

  UploadAddressProofRequestDTO(
      {this.refGLId,
        this.documentType,
        this.documentNames,
        this.allFormFlag});

  UploadAddressProofRequestDTO.fromJson(Map<String, dynamic> json) {
    refGLId = json['RefGLId'];
    documentType = json['DocumentType'];
    documentNames = json['DocumentNames'];
    allFormFlag = json['AllFormFlag'];

  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['DocumentType'] = this.documentType;
    data['DocumentNames'] = this.documentNames;
    data['AllFormFlag'] = this.allFormFlag;

    return jsonEncode(data);
  }
  
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['DocumentType'] = this.documentType;
    data['DocumentNames'] = this.documentNames;
    data['AllFormFlag'] = this.allFormFlag;

    return data;
  }
}