import 'dart:convert';

import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';

class ReferenceDTO {
  int? clientId;
  String? contactName;
  String? emailID;
  int? relationShipTypeCdRelationType;
  String? mobno;
  String? locale;
  String? dateFormat;
  PLFetchBloc? plFetchBloc;

  ReferenceDTO(
      {this.clientId,
        this.contactName,
        this.emailID,
        this.relationShipTypeCdRelationType,
        this.mobno,
        this.locale,
        this.dateFormat}){
  plFetchBloc=BlocProvider.getBloc<PLFetchBloc>();

  }

  ReferenceDTO.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    contactName = json['contactName'];
    emailID = json['emailID'];
    relationShipTypeCdRelationType = json['relationShipType_cd_relationType'];
    mobno = json['mobno'];
    locale = json['locale'];
    dateFormat = json['dateFormat'];
  }

  ReferenceDTO.fromBLJSONJson(Map<String, dynamic> json) {
    clientId = json['RefBLId'];
    contactName = json['FullName'];
    emailID = json['EmailId'];
    relationShipTypeCdRelationType = json['RelationShipWithCustomer'];
    mobno = json['MobileNumber'];
    locale = json['locale']!=null?json['locale']:"eu";
    dateFormat = json['dateFormat']!=null?json['dateFormat']:"dd/mm/yyyy";;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = plFetchBloc!.onBoardingDTO!.id!=null?plFetchBloc!.onBoardingDTO!.id:"";
    data['contactName'] = this.contactName;
    data['emailID'] = this.emailID;
    data['relationShipType_cd_relationType'] =
        this.relationShipTypeCdRelationType;
    data['mobno'] = this.mobno;
    data['locale'] = this.locale!=null?"en":"en";
    data['dateFormat'] = this.dateFormat!=null?"dd/mm/yyyy":"dd/mm/yyyy";
    return data;
  }


  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = plFetchBloc!.onBoardingDTO!.id!=null?plFetchBloc!.onBoardingDTO!.id:"";
    data['contactName'] = this.contactName;
    data['emailID'] = this.emailID;
    data['relationShipType_cd_relationType'] =
        this.relationShipTypeCdRelationType;
    data['mobno'] = this.mobno;
    data['locale'] = this.locale!=null?"en":"en";
    data['dateFormat'] = this.dateFormat!=null?"dd/mm/yyyy":"dd/mm/yyyy";
    return jsonEncode(data);
  }
}