import 'dart:convert';

import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/model/request/versiondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/typeofversion.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionBloc extends Bloc {
  checkAppVersion() async {


    DioDhanvarshaWrapper((SuccessfulResponseDTO dto) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();


      VersionDTO versionDTO= VersionDTO.fromJson(jsonDecode(dto.data!));

      if (VersionTypeFinder.getBuildVersion() == VersionTypeFinder.uat) {
        bool isUpdate = checkVersionUpdate(packageInfo.version, versionDTO.androidVersionUAT!);
        if(isUpdate){
          DialogUtils.versionUpdateDialog(url: versionDTO.androidAppLinkUAT!);
        }
      } else if (VersionTypeFinder.getBuildVersion() == VersionTypeFinder.local) {
        bool isUpdate = checkVersionUpdate(packageInfo.version, versionDTO.androidVersionMgenius!);
        if(isUpdate){
          DialogUtils.versionUpdateDialog(url: versionDTO.androidAppLinkMgenius!);
        }
      } else {
        print("Production URL");
        bool isUpdate = checkVersionUpdate(packageInfo.version, versionDTO.androidVersionLive!);
        if(isUpdate){
          DialogUtils.versionUpdateDialog(url: versionDTO.androidAppLinkLive!);
        }
      }
    }, () {
      // CustomLoaderBuilder.builder.showLoader();
    }, () {
      // CustomLoaderBuilder.builder.hideLoader();
      SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage,
          NavigationService.navigationService.navigatorKey.currentContext!);
    }, FormData(), NetworkConstants.networkUrl.getAppVersion())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }

  bool checkVersionUpdate(String appVersion, String serverVersion) {
    int intA = int.parse(appVersion.replaceAll(".", ""));
    int intB = int.parse(serverVersion.replaceAll(".", ""));

    print("App Version From YAML File");
    print(intA);

    print("App Version From Live File");
    print(intB);

    if (intB > intA) {
      print("Version Update Available");
      return true;
    } else {
      print("Version Update Not Available");
      return false;
    }
  }
}
