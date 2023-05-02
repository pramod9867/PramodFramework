
class BLSoftOfferResponseDTO {
  int? refPlId;
  String? userName;
  String? status;
  int? eligibleAmount;
  String? category;
  String? message;
  bool? CBStatus;
  int? ClientId;

  BLSoftOfferResponseDTO(
      {this.refPlId,
        this.userName,
        this.status,
        this.eligibleAmount,
        this.category,
        this.message});

  BLSoftOfferResponseDTO.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    userName = json['UserName']!=null?json['UserName']:"";
    status = json['Status'];
    eligibleAmount = json['EligibleAmount']!=null?json['EligibleAmount']:0;
    category = json['category'];
    message = json['Message'];
    CBStatus=json['CBStatus'];
    ClientId=json['ClientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['UserName'] = this.userName;
    data['Status'] = this.status;
    data['EligibleAmount'] = this.eligibleAmount;
    data['category'] = this.category;
    data['Message'] = this.message;
    data['CBStatus']=this.CBStatus;
    data['ClientId']=this.ClientId;
    return data;
  }
}