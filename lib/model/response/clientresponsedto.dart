class ClientVerifyResponseDTO {
  int? loanId;
  int? clientId;
  String? message;
  String? statusFlag;
  String? oTP;
  int? refID;
  String? noDays;

  ClientVerifyResponseDTO(
      {this.loanId,
        this.clientId,
        this.message,
        this.statusFlag,
        this.oTP,
        this.refID});

  ClientVerifyResponseDTO.fromJson(Map<String, dynamic> json) {
    loanId = json['LoanId'];
    clientId = json['ClientId'];
    message = json['Message'];
    statusFlag = json['StatusFlag'];
    oTP = json['OTP'];
    refID = json['RefID'];
    noDays=json['noDays']!=null?json['noDays']:"24";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoanId'] = this.loanId;
    data['ClientId'] = this.clientId;
    data['Message'] = this.message;
    data['StatusFlag'] = this.statusFlag;
    data['OTP'] = this.oTP;
    data['RefID'] = this.refID;
    data['noDays']=this.noDays;
    return data;
  }
}