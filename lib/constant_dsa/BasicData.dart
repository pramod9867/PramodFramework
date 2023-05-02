import 'package:dhanvarsha/model_dsa/response/adharresponse.dart';
import 'package:dhanvarsha/model_dsa/response/dropdownresponse.dart';
import 'package:dhanvarsha/model_dsa/response/panresponse.dart';
import 'package:dhanvarsha/model_dsa/response/verifyOtpRes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicData {
  static String otp = '';
  static String phone = '';
  static String token = '';
  static String validateToken = '';

  static PanResponseDTO? panres = new PanResponseDTO('', '', '', '', '');
  static AdharResponse? adharres = new AdharResponse('', '', '', '', '', '', '', '', '', '');
  static VerifyOTPRes? otpres;
  static DropDownResponse? dd;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  static String panImagepath = "";
  static String adharfrontImagepath = "";
  static String adharbackImagepath = "";
  static String buspanimagepath = "";
  static String gstimagepath = "";
  static String proofaddimagepath = "";
  static String rentalagreementimagepath = "";
  static String cancelchequeimagepath = "";

  static String fName = '';
  static String mName = '';
  static String lName = '';
  static String moninName = '';

  static bool isbusinessregistred = false;

  static String bustype = '';
  static String busname = '';
  static String sizeofshop = '';

  static bool IsPANVerified = false;
  static bool IsAadharVerified = false;

  static String gstNumber = '';
  static String addproofdoctype = '';

  static bool isElectricityBillOnMyName = false;


  static bool isRentalBillOnName = false;
  static String RentalBillName = '';


  static String bankname = '';
  static String ifsc = '';
  static String accnumber = '';
  static String namofaccholder = '';
  static String email = '';

  static bool bdtextfield = false;

  static int id = 0 ;

  static bool ispan = false;
  static bool isadhar = false;

  static String reqid ='';
  static String uniqid ='';

  static void clearData() {
    otp = '';
    phone = '';
    panImagepath = '';
    adharfrontImagepath = '';
    adharbackImagepath = '';
    panres;
    adharres;
    buspanimagepath = '';
    gstimagepath = '';
    proofaddimagepath = '';
    rentalagreementimagepath = '';
    cancelchequeimagepath = '';
    fName = '';
    mName = '';
    lName = '';
    moninName = '';
    isbusinessregistred = false;
    bustype = '';
    busname = '';
    sizeofshop = '';
    IsPANVerified = false;
    IsAadharVerified = false;
    gstNumber = '';
    addproofdoctype = '';
    isElectricityBillOnMyName = false;
    bankname = '';
    ifsc = '';
    accnumber = '';
    namofaccholder = '';
    email = '';
  }
  Future<void> setOTPinfo(String key,String data) async {
    final SharedPreferences prefs = await _prefs;
    /*await prefs.setString('phone', phone);
    await prefs.setString('otp', otp);
    await prefs.setString('token', token);*/
    await prefs.setString(key, data);
  }

  Future<String?> getOTPinfo(String key) async {
    final SharedPreferences prefs = await _prefs;
    String? data = prefs.getString(key);
    /*String? phone = prefs.getString('phone');
    String? otp = prefs.getString('otp');
    String? token = prefs.getString('token');
    print('from shared pred phone $phone');
    print('from shared pred otp $otp');*/
    return data;
  }


}
