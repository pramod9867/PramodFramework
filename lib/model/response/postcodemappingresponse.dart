import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';

class PostalCodeMapping {
  MasterDataDTO? districtMaster;
  MasterDataDTO? stateMaster;
  MasterDataDTO? countryMaster;

  PostalCodeMapping({this.districtMaster, this.stateMaster});

  PostalCodeMapping.fromJson(Map<String, dynamic> json) {
    districtMaster = json['district'] != null && json['district'] != ""
        ? new MasterDataDTO.fromJson(json['district'])
        : null;
    stateMaster = json['state'] != null && json['state'] != ""
        ? new MasterDataDTO.fromJson(json['state'])
        : null;
    countryMaster = json['country'] != null && json['country'] != ""
        ? new MasterDataDTO.fromJson(json['country'])
        : null;
  }
}
