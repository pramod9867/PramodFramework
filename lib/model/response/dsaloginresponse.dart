import 'package:dhanvarsha/model/response/loginbankdetailsdto.dart';
import 'package:dhanvarsha/model/response/loginbusinessdetailsdto.dart';

class DSALoginResponseDTO {
  bool? isValidLogin;
  String? message;
  String? name;
  String? mobileNumber;
  String? emailId;
  String? otp;
  String? id;
  bool? isSubDsa;
  LoginBusinessDetailsDTO? loginBusinessDetailsDTO;
  LoginBankDetailsDTO? loginBankDetailsDTO;

  DSALoginResponseDTO(
      {this.isValidLogin,
      this.message,
      this.name,
      this.mobileNumber,
      this.emailId,
      this.id});

  DSALoginResponseDTO.fromJson(Map<String, dynamic> json) {
    isValidLogin = json['isValidLogin'];
    message = json['Message'];
    name = json['Name'];
    mobileNumber = json['MobileNumber'];
    emailId = json['EmailId'];
    otp = json['OTP'];
    id = json['LoginId'] != null ? json['LoginId'] : "0";
    loginBusinessDetailsDTO =
        LoginBusinessDetailsDTO.fromJson(json['BusinessDetails']);
    loginBankDetailsDTO = LoginBankDetailsDTO.fromJson(json['BankDetails']);
    isSubDsa = json['isSubDsa'] != null ? json['isSubDsa'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isValidLogin'] = this.isValidLogin;
    data['Message'] = this.message;
    data['Name'] = this.name;
    data['MobileNumber'] = this.mobileNumber;
    data['EmailId'] = this.emailId;
    data['LoginId'] = this.id;
    data['BankDetails'] = this.loginBankDetailsDTO;
    data['BusinessDetails'] = this.loginBusinessDetailsDTO;
    data['isSubDsa'] = this.isSubDsa;
    return data;
  }
}
