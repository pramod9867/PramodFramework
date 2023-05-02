import 'dart:convert';

class GenerateSoftOfferDTO {
  int? refPlId;
  String? entityType;
  int? vintage;
  int? isOwnPincodeServicible;
  int? salesAsPerITR;
  int? declaredMonthlyEmi;
  int? avgSalesToCredits;
  int? age;
  int? isPincodeServicible;

  GenerateSoftOfferDTO(
      {this.refPlId,
        this.entityType,
        this.vintage,
        this.isOwnPincodeServicible,
        this.salesAsPerITR,
        this.declaredMonthlyEmi,
        this.avgSalesToCredits,
        this.age,
        this.isPincodeServicible});

  GenerateSoftOfferDTO.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    entityType = json['entityType'];
    vintage = json['vintage'];
    isOwnPincodeServicible = json['isOwnPincodeServicible'];
    salesAsPerITR = json['salesAsPerITR'];
    declaredMonthlyEmi = json['declaredMonthlyEmi'];
    avgSalesToCredits = json['avgSalesToCredits'];
    age = json['age'];
    isPincodeServicible = json['isPincodeServicible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['entityType'] = this.entityType;
    data['vintage'] = this.vintage;
    data['isOwnPincodeServicible'] = this.isOwnPincodeServicible;
    data['salesAsPerITR'] = this.salesAsPerITR;
    data['declaredMonthlyEmi'] = this.declaredMonthlyEmi;
    data['avgSalesToCredits'] = this.avgSalesToCredits;
    data['age'] = this.age;
    data['isPincodeServicible'] = this.isPincodeServicible;
    return data;
  }


  Future<String> toEncodedJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['entityType'] = this.entityType;
    data['vintage'] = this.vintage;
    data['isOwnPincodeServicible'] = this.isOwnPincodeServicible;
    data['salesAsPerITR'] = this.salesAsPerITR;
    data['declaredMonthlyEmi'] = this.declaredMonthlyEmi;
    data['avgSalesToCredits'] = this.avgSalesToCredits;
    data['age'] = this.age;
    data['isPincodeServicible'] = this.isPincodeServicible;
    return jsonEncode(data);
  }
}