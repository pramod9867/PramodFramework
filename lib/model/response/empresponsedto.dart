import 'package:dhanvarsha/widgets/autocomplete/autocomplete.dart';

import 'mastdto/mast_base_dto.dart';

class EmployerResponseDTO extends MasterDataDTO {
  int? id;
  int? refLMSID;

  String? companyName;
  String? finalCat;

  EmployerResponseDTO.fromJson(Map<String, dynamic> json)
      : super.fromJsonEMP(json){
    id = json['Id'];
    refLMSID = json['RefLMSID'];
    companyName = json['CompanyName'];
    finalCat = json['FinalCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['RefLMSID'] = this.refLMSID;
    data['CompanyName'] = this.companyName;
    data['FinalCat'] = this.finalCat;
    return data;
  }
}
