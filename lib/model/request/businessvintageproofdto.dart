import 'dart:convert';

class BusinessVintageProofRequestDTO {
  int? refBlId;
  String? businessVintageProofDocumentImage;
  String? businessCommunityProofDocumentImage;

  BusinessVintageProofRequestDTO(
      {this.refBlId,
        this.businessVintageProofDocumentImage,
        this.businessCommunityProofDocumentImage});

  BusinessVintageProofRequestDTO.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    businessVintageProofDocumentImage =
    json['BusinessVintageProofDocumentImage'];
    businessCommunityProofDocumentImage =
    json['BusinessCommunityProofDocumentImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessVintageProofDocumentImage'] =
        this.businessVintageProofDocumentImage;
    data['BusinessCommunityProofDocumentImage'] =
        this.businessCommunityProofDocumentImage;
    return data;
  }

  Future<String> toEncodedJson() async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['BusinessVintageProofDocumentImage'] =
        this.businessVintageProofDocumentImage;
    data['BusinessCommunityProofDocumentImage'] =
        this.businessCommunityProofDocumentImage;
    return jsonEncode(data);
  }
}