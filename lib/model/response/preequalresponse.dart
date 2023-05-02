class PreEqualResponse {
  int? refPlId;
  String? userName;
  int? eligibleAmount;
  String? status;
  String? message;
  bool? CBStatus;
  int? ClientId;

  PreEqualResponse(
      {this.refPlId, this.userName, this.eligibleAmount, this.status});

  PreEqualResponse.fromJson(Map<String, dynamic> json) {
    refPlId = json['RefPlId'];
    userName = json['UserName'];
    eligibleAmount = json['EligibleAmount'];
    status = json['Status'];
    message = (json['Message'] != null && json['Message'] != "")
        ? json['Message']
        : "You application has been rejected";
    CBStatus = json['CBStatus'];
    ClientId = json['ClientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefPlId'] = this.refPlId;
    data['UserName'] = this.userName;
    data['EligibleAmount'] = this.eligibleAmount;
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['CBStatus'] = this.CBStatus;
    data['ClientId'] = this.ClientId;
    return data;
  }
}
