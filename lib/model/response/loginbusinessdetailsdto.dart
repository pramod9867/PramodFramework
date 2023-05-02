class LoginBusinessDetailsDTO {
  String? businessName;
  String? businessType;
  String? sizeOfShop;
  String? monthlyIncome;

  LoginBusinessDetailsDTO(
      {this.businessName,
        this.businessType,
        this.sizeOfShop,
        this.monthlyIncome});

  LoginBusinessDetailsDTO.fromJson(Map<String, dynamic> json) {
    businessName = json['BusinessName']!=""?json['BusinessName']:"-";
    businessType = json['BusinessType']!=""?json['BusinessType']:"-";
    sizeOfShop = json['SizeOfShop']!=""?json['SizeOfShop']:"-";
    monthlyIncome = json['MonthlyIncome']!=""?json['MonthlyIncome']:"-";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusinessName'] = this.businessName;
    data['BusinessType'] = this.businessType;
    data['SizeOfShop'] = this.sizeOfShop;
    data['MonthlyIncome'] = this.monthlyIncome;
    return data;
  }
}