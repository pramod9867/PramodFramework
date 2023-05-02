class BusinessPanResponse {
  String? gstIN;
  String? legalName;
  String? tradeName;
  String? registrationdate;
  String? emailId;
  String? completeAddress;
  String? address;
  String? mobileNumber;
  String? natureOfBusiness;
  String? primaryAddressLastUpdatedDate;
  String? lastUpdated;
  String? status;


  BusinessPanResponse(
      {this.gstIN,
      this.legalName,
      this.tradeName,
      this.registrationdate,
      this.emailId,
      this.completeAddress,
      this.address,
      this.mobileNumber,
      this.natureOfBusiness,
      this.primaryAddressLastUpdatedDate,
      this.lastUpdated,
      this.status});

  BusinessPanResponse.fromJson(Map<String, dynamic> json) {
    gstIN = json['GstIN'] != "" ? json['GstIN'] : "";
    legalName = json['LegalName'] != "" ? json['LegalName'] : "";
    tradeName = json['TradeName'] != "" ? json['TradeName'] : "";
    registrationdate = json['Registrationdate'] != "" ? json['Registrationdate'] : "";
    emailId = json['EmailId'] != "" ? json['EmailId'] : "";
    completeAddress = json['CompleteAddress'] != "" ? json['CompleteAddress'] : "";
    address = json['Address'] != "" ? json['Address'] : "";
    mobileNumber = json['MobileNumber'] != "" ? json['MobileNumber'] : "";
    natureOfBusiness = json['NatureOfBusiness'] != "" ? json['NatureOfBusiness'] : "";
    primaryAddressLastUpdatedDate =
        json['PrimaryAddressLastUpdatedDate'] != "" ? json['PrimaryAddressLastUpdatedDate'] : "";
    lastUpdated = json['LastUpdated'] != "" ? json['LastUpdated'] :"";
    status = json['Status'] != "" ? json['Status'] : "";
    // completeAddress=json['CompleteAddress'] != "" ? json['CompleteAddress'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GstIN'] = this.gstIN!=""?this.gstIN:"123";
    data['LegalName'] = this.legalName;
    data['TradeName'] = this.tradeName;
    data['Registrationdate'] = this.registrationdate;
    data['EmailId'] = this.emailId;
    data['CompleteAddress'] = this.completeAddress;
    data['Address'] = this.address;
    data['MobileNumber'] = this.mobileNumber;
    data['NatureOfBusiness'] = this.natureOfBusiness;
    data['PrimaryAddressLastUpdatedDate'] = this.primaryAddressLastUpdatedDate;
    data['LastUpdated'] = this.lastUpdated;
    data['Status'] = this.status;
    return data;
  }
}
