import 'dart:convert';

class IncorporationDTO {
  int? refBlId;
  String? incorporationDocumentName;
  String? incorporationDocumentImage;

  IncorporationDTO(
      {this.refBlId,
        this.incorporationDocumentName,
        this.incorporationDocumentImage});

  IncorporationDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    incorporationDocumentName = json['IncorporationDocumentName'];
    incorporationDocumentImage = json['IncorporationDocumentImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['IncorporationDocumentName'] = this.incorporationDocumentName;
    data['IncorporationDocumentImage'] = this.incorporationDocumentImage;
    return data;
  }


  Future<String> toEncodedJson() async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['IncorporationDocumentName'] = this.incorporationDocumentName;
    data['IncorporationDocumentImage'] = this.incorporationDocumentImage;
    return jsonEncode(data);
  }
}