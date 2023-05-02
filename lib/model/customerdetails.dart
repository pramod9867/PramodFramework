class CustomerDetailsDTO {
  static String? _empName;
  static String? _mobileNumber;

  static String get mobileNumber => _mobileNumber!;

  static set mobileNumber(String value) {
    _mobileNumber = value;
  }

  static String get empName => _empName!;

  static set empName(String value) {
    _empName = value;
  }
}
