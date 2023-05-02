class OfferAcceptedStatus {
  bool? status;
  String? message;
  int? clientId;

  OfferAcceptedStatus({this.status, this.message,this.clientId});

  OfferAcceptedStatus.fromJson(Map<String, dynamic> json) {
    try{
      status = json['status'];
      message = json['message'];
      clientId=json['ClientId'];
    }catch(e){
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['ClientId']=this.clientId;
    return data;
  }
}