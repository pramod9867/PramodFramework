import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';

class VersionTypeFinder {
  static String uat = "UAT";
  static String local = "LOCAL";
  static String production = "PRODUCTION";

  static String localURL = "https://mgenius.in/Dhanvarsha/";
  static String uatURL = "https://cpuat.dfltd.in/Dhanvarsha/";
  static String prodURL = "";

  static String getBuildVersion() {
    if (localURL == UrlConstants.baseurl) {
      return local;
    } else if (uatURL == UrlConstants.baseurl) {
      return uat;
    } else {
      // print("INTO THE PRODUCTION");
      return production;
    }
  }
}
