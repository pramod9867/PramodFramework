class RegExPattern {
  static String mobileNumberRegex = r'(^[6-9]\d{9}$)';
  static String pinCodeRegex = r'(^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$)';
  static String commaSeprated = (r'(\d{2,3})(?=(\d{3})+(?!\d))');
  static String panRegex =
      (r'[A-Z]{3}[ABCFGHLJPTF]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}');
  static String emailRegex =
      (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static String aadhaarRegex = (r"^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$");
  static String isNumber = (r"^[0-9]+$");
  static String gstnNumber =
      (r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$");
  static String onlyNumberWithSpace = (r"^[a-zA-Z]+(?:\s[a-zA-Z]+)?$");
}
