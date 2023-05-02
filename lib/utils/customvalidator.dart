import 'package:dhanvarsha/utils/constants/regex.dart';

enum Validation {
  isEmpty,
  minLength,
  mobileNumber,
  isValidPinCode,
  isPan,
  isEmail,
  isAadhaar,
  isGstnNumber,
  isGstnLength,
  isMaxValue,
  isMinValue
}

class CustomValidator {
  final String value;

  CustomValidator(this.value);

  bool validate(Validation type) {
    switch (type) {
      case Validation.isEmpty:
        return checkValueIsEmpty(this.value);
      case Validation.minLength:
        return minLength(this.value);
      case Validation.mobileNumber:
        return isValidPhoneNumber(this.value);
      case Validation.isValidPinCode:
        return isValidPinCode(this.value);
      case Validation.isPan:
        return isPan(this.value);
      case Validation.isEmail:
        return isEmail(this.value);
      case Validation.isAadhaar:
        return isAadhaar(this.value);
      case Validation.isGstnNumber:
        return isGstnNumber(this.value);
      case Validation.isMaxValue:
        return isMaxValue(this.value);
    }
    return true;
  }



  bool checkValueIsEmpty(value) {
    return this.value.replaceAll(" ", "").length > 0;
    ;
  }

  bool minLength(value) {
    return this.value.length == 6;
  }

  bool isValidPhoneNumber(value) {
    final regExp = RegExp(RegExPattern.mobileNumberRegex);
    return regExp.hasMatch(value);
  }

  bool isValidPinCode(value) {
    final regExp = RegExp(RegExPattern.pinCodeRegex);
    return regExp.hasMatch(value);
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
    final regExp = RegExp(RegExPattern.aadhaarRegex);
    return regExp.hasMatch(value);
  }

  bool isGstnNumber(value) {
    final regExp = RegExp(RegExPattern.gstnNumber);

    print("Regex Value");
    print(regExp.hasMatch(value));
    return regExp.hasMatch(value);
  }

  bool isMaxValue(value) {
    return value != "" && int.parse(this.value) <= 100;
  }

  bool isLength(value) {
    return this.value.length == 15;
  }
}
