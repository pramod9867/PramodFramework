
import 'package:dhanvarsha/model/request/customer_onboarding.dart';

class VerifyOTPResponseDTO{
  bool? isValidOTP;
  String? message;
  int? RefId;
  CustomerOnBoardingDTO? onBoardingDTO;

  VerifyOTPResponseDTO.fromJson(Map<String, dynamic> json) {
    isValidOTP = json['isValidOTP'];
    message = json['message'];
    RefId=json['RefId'];
  }

}