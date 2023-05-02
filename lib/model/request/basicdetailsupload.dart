import 'dart:convert';

import 'package:dhanvarsha/generics/master_doc_tag_identifier.dart';
import 'package:dhanvarsha/generics/master_value_getter.dart';

class BasicDetailsUpload {
  int? refBlId;
  int? panDocumentTypeId;
  int? selfieId;
  int? aadharFrontDocumentTypeId;
  int? aadharBackDocumentTypeId;
  String? customersPanImage;
  String? customersPhotoImage;
  String? customersAadharFrontImage;
  String? customersAadharBackImage;
  bool? isAadharLinkedToMobile;

  BasicDetailsUpload(
      {this.refBlId,
      this.panDocumentTypeId,
      this.selfieId,
      this.aadharFrontDocumentTypeId,
      this.aadharBackDocumentTypeId,
      this.customersPanImage,
      this.customersPhotoImage,
      this.customersAadharFrontImage,
      this.customersAadharBackImage,
      this.isAadharLinkedToMobile});

  BasicDetailsUpload.fromJson(Map<String, dynamic> json) {
    refBlId = json['RefBlId'];
    panDocumentTypeId = json['PanDocumentTypeId'];
    selfieId = json['SelfieId'];
    aadharFrontDocumentTypeId = json['AadharFrontDocumentTypeId'];
    aadharBackDocumentTypeId = json['AadharBackDocumentTypeId'];
    customersPanImage = json['CustomersPanImage'];
    customersPhotoImage = json['CustomersPhotoImage'];
    customersAadharFrontImage = json['CustomersAadharFrontImage'];
    customersAadharBackImage = json['CustomersAadharBackImage'];
    isAadharLinkedToMobile = json['isAadharLinkedToMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['PanDocumentTypeId'] =  this.panDocumentTypeId != null
        ? this.panDocumentTypeId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);
    data['SelfieId'] = this.selfieId != null
        ? this.selfieId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.selfieKey);
    data['AadharFrontDocumentTypeId'] = this.aadharFrontDocumentTypeId != null
        ? this.aadharFrontDocumentTypeId
        : MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    data['AadharBackDocumentTypeId'] = this.aadharBackDocumentTypeId != null
        ? this.aadharBackDocumentTypeId
        : MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarBackKey);
    data['CustomersPanImage'] = this.customersPanImage;
    data['CustomersPhotoImage'] = this.customersPhotoImage;
    data['CustomersAadharFrontImage'] = this.customersAadharFrontImage;
    data['CustomersAadharBackImage'] = this.customersAadharBackImage;
    data['isAadharLinkedToMobile'] = this.isAadharLinkedToMobile != null
        ? this.isAadharLinkedToMobile
        : false;
    return data;
  }


  Future<String>  toEncodedJson() async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefBlId'] = this.refBlId;
    data['PanDocumentTypeId'] =  this.panDocumentTypeId != null
        ? this.panDocumentTypeId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.panKey);
    data['SelfieId'] = this.selfieId != null
        ? this.selfieId
        : MasterDocumentId.builder.getMasterID(MasterDocIdentifier.selfieKey);
    data['AadharFrontDocumentTypeId'] = this.aadharFrontDocumentTypeId != null
        ? this.aadharFrontDocumentTypeId
        : MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarFrontKey);
    data['AadharBackDocumentTypeId'] = this.aadharBackDocumentTypeId != null
        ? this.aadharBackDocumentTypeId
        : MasterDocumentId.builder
        .getMasterID(MasterDocIdentifier.aadhaarBackKey);
    data['CustomersPanImage'] = this.customersPanImage;
    data['CustomersPhotoImage'] = this.customersPhotoImage;
    data['CustomersAadharFrontImage'] = this.customersAadharFrontImage;
    data['CustomersAadharBackImage'] = this.customersAadharBackImage;
    data['isAadharLinkedToMobile'] = this.isAadharLinkedToMobile != null
        ? this.isAadharLinkedToMobile
        : false;
    return jsonEncode(data);
  }
}
