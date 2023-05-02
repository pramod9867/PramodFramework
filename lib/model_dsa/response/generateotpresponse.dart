class GenerateOTPRes {
  bool? isSuccess;
  String? message;
  String? otp;

  GenerateOTPRes({
    this.isSuccess,
    this.message,
    this.otp,
  });

  GenerateOTPRes.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['otp'] = this.otp;

    return data;
  }
}
