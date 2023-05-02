import 'package:dhanvarsha/utils_dsa/constants/constants/network/urlconstants.dart';

class NetWorkUrl {
  NetWorkUrl();
  // String getBaseUrl() {
  //   return UrlConstants.baseurl;
  // }

  String getPinCodeNumber() {
    return UrlConstants.pinConfiguration;
  }

  String getOcrUrl() {
    return UrlConstants.panOcr;
  }

  String getAdharOcrUrl() {
    return UrlConstants.adhaarOcr;
  }

  String getOtp() {
    return UrlConstants.getOtp;
  }

String getdropdown() {
    return UrlConstants.getdropdown;
  }

  String verifyOTPD() {
    return UrlConstants.verifyOTPD;
  }

  String completeForm() {
    return UrlConstants.completeForm;
  }

  String partialForm() {
    return UrlConstants.partialForm;
  }

  String payment() {
    return UrlConstants.payment;
  }
}
