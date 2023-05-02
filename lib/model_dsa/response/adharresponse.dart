//{\"AadharNumber\":\"223918045048\",
// \"FirstName\":\"Shubham\",
// \"MiddleName\":\"Sudhir\",
// \"LastName\":\"Pawar\",
// \"DateOfBirth\":\"04/01/1999\",
// \"Gender\":\"MALE\",
// \"Pincode\":\"400078\",
// \"AddressLine1\":\"RNLANIL NIWAS SAHYADRI NGR SAMBHAJI MARG VTC.
// Bhandup West, Po : Bhandup West, pbil Sub District :
// Bhandup West, District : Mumbai, State : Maharashtra Code : 400078\",
// \"AddressLine2\":\"SAHYADRI NGR SAMBHAJI MARG \",
// \"AddressLine3\":\" Mumbai Maharashtra\"}

class AdharResponse {
  String? AadharNumber;
  String? FirstName;
  String? MiddleName;
  String? LastName;
  String? DateOfBirth;
  String? Gender;
  String? Pincode;
  String? AddressLine1;
  String? AddressLine2;
  String? AddressLine3;

  AdharResponse(
      this.AadharNumber,
      this.FirstName,
      this.MiddleName,
      this.LastName,
      this.DateOfBirth,
      this.Gender,
      this.Pincode,
      this.AddressLine1,
      this.AddressLine2,
      this.AddressLine3);

  AdharResponse.fromJson(Map<String, dynamic> json) {
    AadharNumber = json['AadharNumber'];
    FirstName = json['FirstName'];
    MiddleName = json['MiddleName'];
    LastName = json['LastName'];
    DateOfBirth = json['DateOfBirth'];
    Gender = json['Gender'];
    Pincode = json['Pincode'];
    AddressLine1 = json['AddressLine1'];
    AddressLine2 = json['AddressLine2'];
    AddressLine3 = json['AddressLine3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AadharNumber'] = this.AadharNumber;
    data['FirstName'] = this.FirstName;
    data['MiddleName'] = this.MiddleName;
    data['LastName'] = this.LastName;
    data['DateOfBirth'] = this.DateOfBirth;
    data['Gender'] = this.Gender;
    data['Pincode'] = this.Pincode;
    data['AddressLine1'] = this.AddressLine1;
    data['AddressLine2'] = this.AddressLine2;
    data['AddressLine3'] = this.AddressLine3;
    return data;
  }
}
