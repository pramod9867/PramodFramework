import 'constants/constants/RegExPattern.dart';

class CustomValidator {
  final String value;

  CustomValidator(this.value);

  bool validate(String type) {
    switch (type) {
      case "isEmpty":
        return checkValueIsEmpty(this.value);
      case "minLength":
        return minLength(this.value);
      case "isPan":
        return isPan(this.value);
      case "isEmail":
        return isEmail(this.value);
      case "isAadhaar":
        return isAadhaar(this.value);
      case "isPin":
        return isValidPinCode(this.value);
      case "isIFSC":
        return isIFSC(this.value);
      case "isAccount":
        return isAccountNumber(this.value);
      case "isGst":
        return isGSTNumber(this.value);
    }
    return true;
  }

  bool isValidPinCode(value) {
    final regExp = RegExp(RegExPattern.pinCodeRegex);
    return regExp.hasMatch(value);
  }

  bool checkValueIsEmpty(value) {
    return this.value.replaceAll(" ", "").length > 0;
  }

  bool minLength(value) {
    return this.value.length > 4;
  }

  bool isPan(value) {
    final regExp = RegExp(RegExPattern.panRegex);
    return regExp.hasMatch(value);
  }

  bool isEmail(value) {
    final regExp = RegExp(RegExPattern.emailRegex);
    return regExp.hasMatch(value);
  }

  bool isAadhaar(value) {
    //if(value == 12){
      final regExp = RegExp(RegExPattern.aadhaarRegex);
      print("12 adhar");
      return regExp.hasMatch(value);
    /*}else{
      return false;
    }*/

  }

  bool isIFSC(value) {
    final regExp = RegExp(RegExPattern.isIFSCCode);
    return regExp.hasMatch(value);
  }

  bool isAccountNumber(value) {
    final regExp = RegExp(RegExPattern.isAccountNumber);
    return regExp.hasMatch(value);
  }

  bool isGSTNumber(value) {
    final regExp = RegExp(RegExPattern.isGSTNumber);
    return regExp.hasMatch(value);
  }
}
