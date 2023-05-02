class RegExPattern {
  static String mobileNumberRegex = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static String pinCodeRegex = r'(^[1-9]{1}[0-9]{2}\s{0,1}[0-9]{3}$)';
  static String commaSeprated = (r'(\d{2,3})(?=(\d{3})+(?!\d))');
  static String panRegex =
      (r'[A-Z]{3}[ABCFGHLJPTF]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}');
  static String emailRegex =
      (r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-z A-Z]+");
  static String aadhaarRegex = (r"^[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}$");
  //static String aadhaarRegex = (r"^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$");
  static String isIFSCCode = (r"^[A-Z]{4}0[A-Z0-9]{6}$");
  static String isAccountNumber= ("[0-9]{9,18}");
  static String isGSTNumber= (r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$");

}
