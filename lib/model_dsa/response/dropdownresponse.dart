class DropDownResponse {
  List<AddressProof>? addressProof;
  List<BankData>? bankData;
  List<BussinessType>? bussinessType;

  DropDownResponse({this.addressProof, this.bankData, this.bussinessType});

  DropDownResponse.fromJson(Map<String, dynamic> json) {
    if (json['AddressProof'] != null) {
      addressProof = <AddressProof>[];
      json['AddressProof'].forEach((v) {
        addressProof?.add(new AddressProof.fromJson(v));
      });
    }
    if (json['BankData'] != null) {
      bankData = <BankData>[];
      json['BankData'].forEach((v) {
        bankData?.add(new BankData.fromJson(v));
      });
    }
    if (json['BussinessType'] != null) {
      bussinessType = <BussinessType>[];
      json['BussinessType'].forEach((v) {
        bussinessType?.add(new BussinessType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressProof != null) {
      data['AddressProof'] = this.addressProof?.map((v) => v.toJson()).toList();
    }
    if (this.bankData != null) {
      data['BankData'] = this.bankData?.map((v) => v.toJson()).toList();
    }
    if (this.bussinessType != null) {
      data['BussinessType'] =
          this.bussinessType?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BussinessType {
  String? name;
  int? value;

  BussinessType({this.name, this.value});

  BussinessType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class BankData {
  String? name;
  int? value;

  BankData({this.name, this.value});

  BankData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class AddressProof {
  String? name;
  int? value;

  AddressProof({this.name, this.value});

  AddressProof.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}