class CustomerBLOnboarding {
  static int? _age;
  static int? _softOfferAmount;


  static bool get isAadhaarAddSameAsCurrent => _isAadhaarAddSameAsCurrent??false;

  static set isAadhaarAddSameAsCurrent(bool value) {
    _isAadhaarAddSameAsCurrent = value;
  }

  static String get completeBLAddress => _completeBLAddress??"";

  static set completeBLAddress(String value) {
    _completeBLAddress = value;
  }

  static String? _completeBLAddress;
  static bool? _isAadhaarAddSameAsCurrent;
  static int get noOfYearsRegistration => _noOfYearsRegistration??0;

  static set noOfYearsRegistration(int value) {
    _noOfYearsRegistration = value;
  }

  static int? _noOfYearsRegistration;
  static bool? _isGstActive;
  static int get age => _age ?? 0;

  static String get addressOfCoApplicant => "";

  static set addressOfCoApplicant(String value) {
    _addressOfCoApplicant = value;
  }

  static bool get isGstActive => _isGstActive ?? false;

  static String? _addressOfCoApplicant;

  static set isGstActive(bool value) {
    _isGstActive = value;
  }

  static set age(int value) {
    _age = value;
  }

  static int get softOfferAmount => _softOfferAmount ?? 0;

  static set softOfferAmount(int value) {
    _softOfferAmount = value;
  }
}
