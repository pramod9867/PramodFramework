import 'dart:convert';

import 'package:dhanvarsha/framework/local/sharedpref.dart';

class DashboardRequest {
  String? rendDate;
  String? rstartDate;
  String? rdsaId;

  DashboardRequest({this.rendDate, this.rstartDate, this.rdsaId});

  DashboardRequest.fromJson(Map<String, dynamic> json) {
    rendDate = json['RendDate'];
    rstartDate = json['RstartDate'];
    rdsaId = json['RdsaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RendDate'] = this.rendDate;
    data['RstartDate'] = this.rstartDate;
    data['RdsaId'] = this.rdsaId;
    return data;
  }
  
  
  Future<String> toEncodedJson() async{
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RendDate'] = this.rendDate;
    data['RstartDate'] = this.rstartDate;
    data['RdsaId'] =await SharedPreferenceUtils.sharedPreferenceUtils.getDSAID();
    return jsonEncode(data);
  }
}