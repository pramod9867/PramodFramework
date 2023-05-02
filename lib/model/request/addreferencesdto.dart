class AddReferencesDTO {
  int? id;
  int? refBlId;
  String? fullName;
  String? emailId;
  String? mobileNumber;
  int? relationShipWithCustomer;

  AddReferencesDTO(
      {this.id,
        this.refBlId,
        this.fullName,
        this.emailId,
        this.mobileNumber,
        this.relationShipWithCustomer});

  AddReferencesDTO.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    refBlId = json['RefBlId'];
    fullName = json['FullName'];
    emailId = json['EmailId'];
    mobileNumber = json['MobileNumber'];
    relationShipWithCustomer = json['RelationShipWithCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['RefBlId'] = this.refBlId;
    data['FullName'] = this.fullName;
    data['EmailId'] = this.emailId;
    data['MobileNumber'] = this.mobileNumber;
    data['RelationShipWithCustomer'] = this.relationShipWithCustomer;
    return data;
  }
}