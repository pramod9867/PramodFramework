import 'dart:convert';

class OfferAcceptRejectDTO {
  int? refPlId;
  int? softOfferStatus;
  String? RejectReason;
  String? RejectDescription;

  OfferAcceptRejectDTO(
      {this.refPlId,
      this.softOfferStatus,
      this.RejectReason,
      this.RejectDescription});

  OfferAcceptRejectDTO.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    softOfferStatus = json['SoftOfferStatus'];
    RejectReason=json['RejectReason'];
    RejectDescription=json['RejectDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['SoftOfferStatus'] = this.softOfferStatus;
    data['RejectReason']=this.RejectReason;
    data['RejectDescription']=this.RejectDescription;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['SoftOfferStatus'] = this.softOfferStatus;
    data['RejectReason']=this.RejectReason;
    data['RejectDescription']=this.RejectDescription;
    return jsonEncode(data);
  }
}
