

class BranchDetailsData {
  String? id;
  String? branchName;
  String? branchAddress;
  String? Latitude;
  String? Longitude;
  String? Distance;
  String? Pincode;

  BranchDetailsData(this.id, this.branchName, this.branchAddress, this.Latitude,
      this.Longitude, this.Distance, this.Pincode);

  //BranchDetailsData({this.id, this.branchName, this.branchAddress});

  BranchDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['BranchName'];
    branchAddress = json['BranchAddress'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    Distance = json['Distance'];
    Pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BranchName'] = this.branchName;
    data['BranchAddress'] = this.branchAddress;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;
    data['Distance'] = this.Distance;
    data['Pincode'] = this.Pincode;
    return data;
  }
}