import 'dart:convert';

import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/sharedprefkeys.dart';
import 'package:dhanvarsha/model/request/loanapplicationdto.dart';
import 'package:dhanvarsha/model/response/dashboardresponse.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static SharedPreferenceUtils sharedPreferenceUtils = SharedPreferenceUtils();

  FlutterSecureStorage? preferences;

  initSharedPref() async {
    preferences = await new FlutterSecureStorage();
    print("Intialized Shared Pref");
  }

  setLogindata(String data) async {
    if (preferences != null) {
      preferences!.write(key: SharedPrefKeys.dsa_data, value: data);
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_data, value: data);
    }
  }

  setApiCallTime(String data) async {
    if (preferences != null) {
      preferences!
          .write(key: SharedPrefKeys.api_time, value: data)
          .whenComplete(() => {
                print("Date Time Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.api_time, value: data);
    }
  }

  Future<String> getApliCallTImeData() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.api_time);

      if (data != null) {
        return data!;
      } else {
        return "";
      }
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.api_time);
    }
    return "";
  }

  Future<String> getLoginData() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_data);
      if (data != null) {
        return data!;
      } else {
        return "";
      }
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_data);
    }
    return "";
  }

  Future<void> clearAllData() async {
    await preferences!.deleteAll();
  }

  Future<String> getDSAID() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_data);

      print("Stored DSA DATA");
      print(data);

      DSALoginResponseDTO loginResponseDTO =
          DSALoginResponseDTO.fromJson(jsonDecode(data!));

      print("DSA LOGIN ID NEW IS");
      print(loginResponseDTO.id);

      return loginResponseDTO.id ?? "0";
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_data);
    }
    return "0";
  }

  Future<bool> isSubDsa() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_data);

      DSALoginResponseDTO loginResponseDTO =
          DSALoginResponseDTO.fromJson(jsonDecode(data!));


      print(jsonEncode(loginResponseDTO));
      return loginResponseDTO.isSubDsa??false;
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_data);
    }
    return false;
  }

  setDashboardData(String data) async {
    if (preferences != null) {
      await preferences!
          .write(key: SharedPrefKeys.dsa_dashboard, value: data)
          .whenComplete(() => {
                print("Data Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_data, value: data);
    }
  }

  setTemplateData(String data) async {
    if (preferences != null) {
      await preferences!
          .write(key: SharedPrefKeys.dsa_template_api, value: data)
          .whenComplete(() => {
                print("Template Data Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_data, value: data);
    }
  }

  setBLPLApplicationData(String data) async {
    if (preferences != null) {
      await preferences!
          .write(key: SharedPrefKeys.dsa_application_data, value: data)
          .whenComplete(() => {
                print("BL PL  Data Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_application_data, value: data);
    }
  }

  Future<List<DashboardResponse>> getDashboardData() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_dashboard);

      if (data != null) {
        List<DashboardResponse> dashboardResponse = jsonDecode(data!) != null
            ? jsonDecode(data!) as List != null
                ? (jsonDecode(data!) as List).map((i) {
                    return DashboardResponse.fromJson(i);
                  }).toList()
                : []
            : [];
        return dashboardResponse;
      } else {
        return [];
      }
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_dashboard);
    }
    return [];
  }

  Future<List<ListOfLoanApplicationDTO>> getListOfLoanApplication() async {
    if (preferences != null) {
      String? data =
          await preferences!.read(key: SharedPrefKeys.dsa_template_api);

      print("Data is");
      if (data != null) {
        List<ListOfLoanApplicationDTO> loanApplicationList =
            jsonDecode(data!) != null
                ? jsonDecode(data!) as List != null
                    ? (jsonDecode(data!) as List).map((i) {
                        return ListOfLoanApplicationDTO.fromJson(i);
                      }).toList()
                    : []
                : [];
        return loanApplicationList;
      } else {
        return [];
      }
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_dashboard);
    }
    return [];
  }

  addToken(String data) async {
    if (preferences != null) {
      await preferences!
          .write(key: SharedPrefKeys.dsa_token, value: data)
          .whenComplete(() => {
                print("BL PL  Data Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_token, value: data);
    }
  }

  Future<String> getToken() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_token);
      if (data != null) {
        return data!;
      } else {
        return "valid";
      }
    } else {
      initSharedPref();
      await preferences!.read(key: SharedPrefKeys.dsa_data);
    }
    return "";
  }

  addMobileNumber(String data) async {
    if (preferences != null) {
      preferences!
          .write(key: SharedPrefKeys.dsa_mobile_no, value: data)
          .whenComplete(() => {
                print("BL PL  Data Added Success Fully"),
              });
    } else {
      initSharedPref();
      preferences!.write(key: SharedPrefKeys.dsa_mobile_no, value: data);
    }
  }

  Future<String> getMobileNumber() async {
    if (preferences != null) {
      String? data = await preferences!.read(key: SharedPrefKeys.dsa_mobile_no);
      if (data != null) {
        return data!;
      } else {
        return "";
      }
    } else {
      initSharedPref();
      preferences!.read(key: SharedPrefKeys.dsa_mobile_no);
    }
    return "";
  }

  Future<List<ListOfLoanApplicationDTO>> getBLPLApplicationData() async {
    if (preferences != null) {
      String? data =
          await preferences!.read(key: SharedPrefKeys.dsa_application_data);

      print("Data is");
      if (data != null) {
        List<ListOfLoanApplicationDTO> loanApplicationList =
            jsonDecode(data!) != null
                ? jsonDecode(data!) as List != null
                    ? (jsonDecode(data!) as List).map((i) {
                        return ListOfLoanApplicationDTO.fromJson(i);
                      }).toList()
                    : []
                : [];
        return loanApplicationList;
      } else {
        return [];
      }
    } else {
      initSharedPref();
      await preferences!.read(key: SharedPrefKeys.dsa_application_data);
    }
    return [];
  }
}
