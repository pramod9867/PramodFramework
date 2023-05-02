class BLGstDetailsDTO {
  String? emailId;
  String? applicationStatus;
  String? mobNum;
  String? pan;
  String? gstinRefId;
  String? regType;
  String? authStatus;
  String? gstinId;
  String? registrationName;
  String? tinNumber;

  BLGstDetailsDTO(
      {this.emailId,
        this.applicationStatus,
        this.mobNum,
        this.pan,
        this.gstinRefId,
        this.regType,
        this.authStatus,
        this.gstinId,
        this.registrationName,
        this.tinNumber});

  BLGstDetailsDTO.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    applicationStatus = json['applicationStatus'];
    mobNum = json['mobNum'];
    pan = json['pan'];
    gstinRefId = json['gstinRefId'];
    regType = json['regType'];
    authStatus = json['authStatus'];
    gstinId = json['gstinId'];
    registrationName = json['registrationName'];
    tinNumber = json['tinNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailId'] = this.emailId;
    data['applicationStatus'] = this.applicationStatus;
    data['mobNum'] = this.mobNum;
    data['pan'] = this.pan;
    data['gstinRefId'] = this.gstinRefId;
    data['regType'] = this.regType;
    data['authStatus'] = this.authStatus;
    data['gstinId'] = this.gstinId;
    data['registrationName'] = this.registrationName;
    data['tinNumber'] = this.tinNumber;
    return data;
  }
}