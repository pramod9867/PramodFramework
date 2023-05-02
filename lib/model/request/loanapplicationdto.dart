class ListOfLoanApplicationDTO {
  String? dsaId;
  int? clientId;
  int? loanApplicationId;
  String? clientName;
  String? dateOfApplicationCreated;
  String? loanStatus;
  String? mobileNumber;
  String? emailID;
  String? applicationLastModifiedDate;
  String? productId;
  int? RefId;

  ListOfLoanApplicationDTO(
      {this.dsaId,
        this.clientId,
        this.loanApplicationId,
        this.clientName,
        this.dateOfApplicationCreated,
        this.loanStatus,
        this.mobileNumber,
        this.emailID,
        this.applicationLastModifiedDate,
        this.productId});

  ListOfLoanApplicationDTO.fromJson(Map<String, dynamic> json) {
    dsaId = json['dsaId'];
    clientId = json['clientId'];
    loanApplicationId = json['loanApplicationId'];
    clientName = json['clientName'];
    dateOfApplicationCreated = json['dateOfApplicationCreated'];
    loanStatus = json['loanStatus'];
    mobileNumber = json['mobileNumber'];
    emailID = json['emailID'];
    applicationLastModifiedDate = json['applicationLastModifiedDate'];
    productId = json['productId'];
    RefId=json['RefId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsaId'] = this.dsaId;
    data['clientId'] = this.clientId;
    data['loanApplicationId'] = this.loanApplicationId;
    data['clientName'] = this.clientName;
    data['dateOfApplicationCreated'] = this.dateOfApplicationCreated;
    data['loanStatus'] = this.loanStatus;
    data['mobileNumber'] = this.mobileNumber;
    data['emailID'] = this.emailID;
    data['applicationLastModifiedDate'] = this.applicationLastModifiedDate;
    data['productId'] = this.productId;
    data['RefId']=this.RefId;
    return data;
  }
}