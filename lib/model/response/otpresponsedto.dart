class OtpResponseDTO {
  bool? isValidOTP;
  String? message;

  OtpResponseDTO({this.isValidOTP, this.message});

  OtpResponseDTO.fromJson(Map<String, dynamic> json) {
    isValidOTP = json['isValidOTP'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isValidOTP'] = this.isValidOTP;
    data['Message'] = this.message;
    return data;
  }
}