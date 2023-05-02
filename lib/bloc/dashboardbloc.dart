import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/loanapplicationdto.dart';
import 'package:dhanvarsha/model/response/dashboardresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/calculator.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';
import 'package:dhanvarsha/utils/dateutils/dateutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DashboardBloc extends Bloc {
  AddRefLoading? appLoading;

  List<ListOfLoanApplicationDTO> get listOfBLPLApplications =>
      _listOfBLPLApplications ?? [];

  set listOfBLPLApplications(List<ListOfLoanApplicationDTO> value) {
    _listOfBLPLApplications = value;
  }

  List<DashboardResponse>? _dashboardResponse;

  List<ListOfLoanApplicationDTO> get listOfLoanResponse =>
      _listOfLoanResponse ?? [];

  List<ListOfLoanApplicationDTO>? _listOfBLPLApplications;

  set listOfLoanResponse(List<ListOfLoanApplicationDTO> value) {
    _listOfLoanResponse = value;
  }

  List<ListOfLoanApplicationDTO>? _listOfLoanResponse;

  ValueNotifier<NetworkCallConnectionStatus> _notifier =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  DashboardBloc(AddRefLoading appLoading) {
    this.appLoading = appLoading;
  }

  List<DashboardResponse> get dashboardResponse => _dashboardResponse ?? [];

  set dashboardResponse(List<DashboardResponse> value) {
    _dashboardResponse = value;
  }

  getDashboardData(FormData formData) async {


    String timeApi =
        await SharedPreferenceUtils.sharedPreferenceUtils.getApliCallTImeData();

    print("NEW TIME IS");
    print(timeApi);

    bool dateTime = true;
    if (timeApi != "") {
      dateTime = DateUtilsGeneric.calculateTimeDifference(DateTime.parse(
          await SharedPreferenceUtils.sharedPreferenceUtils
              .getApliCallTImeData()));

      print("Difference is");
      print(dateTime);
    } else {
      dateTime = true;
    }

    if (dateTime||true) {
      DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {
        print("DTO Response is");

        appLoading!.isSuccessful(dto);

        SharedPreferenceUtils.sharedPreferenceUtils.setDashboardData(dto.data!);

        _dashboardResponse = jsonDecode(dto.data!) != null
            ? jsonDecode(dto.data!) as List != null
                ? (jsonDecode(dto.data!) as List).map((i) {
                    return DashboardResponse.fromJson(i);
                  }).toList()
                : []
            : [];




        // print("Dashboard Response---------------------->");
        // print(jsonEncode(_dashboardResponse));

        DashboardCalculator.builder.dashboardList = _dashboardResponse!;

        DashboardCalculator.builder.calculateByCategory(0);


        // if(!dateTime){
        //
        //   appLoading!.hideProgress();
        // }
      }, () {
        appLoading!.showProgress();
      }, () {
        appLoading!.hideProgress();
        appLoading!.showError();
      }, formData, NetworkConstants.networkUrl.getDashboardData())
          .postDioResponse();
    } else {
      List<DashboardResponse> dashboardData =
          await SharedPreferenceUtils.sharedPreferenceUtils.getDashboardData();

      DashboardCalculator.builder.dashboardList = dashboardData;

      appLoading!.isSuccessful(SuccessfulResponseDTO());
      DashboardCalculator.builder.calculateByCategory(0);
    }
  }

  getListOfTemplateData(FormData formData) async {
    bool dateTime = true;
    String timeApi =
        await SharedPreferenceUtils.sharedPreferenceUtils.getApliCallTImeData();
    if (timeApi != "") {
      dateTime = DateUtilsGeneric.calculateTimeDifference(DateTime.parse(
          await SharedPreferenceUtils.sharedPreferenceUtils
              .getApliCallTImeData()));
    } else {
      dateTime = true;
    }

    if (dateTime) {
      DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {
        SharedPreferenceUtils.sharedPreferenceUtils.setTemplateData(dto.data!);
        _listOfLoanResponse = jsonDecode(dto.data!) != null
            ? jsonDecode(dto.data!) as List != null
                ? (jsonDecode(dto.data!) as List).map((i) {
                    return ListOfLoanApplicationDTO.fromJson(i);
                  }).toList()
                : []
            : [];


    
        SharedPreferenceUtils.sharedPreferenceUtils.setTemplateData(dto.data!);
        appLoading!.isSuccessful2(SuccessfulResponseDTO());

        // if(!dateTime){
        //   appLoading!.hideProgress();
        // }
      }, () {
        appLoading!.showProgress();
      }, () {
        appLoading!.hideProgress();
        appLoading!.showError();
      }, formData, NetworkConstants.networkUrl.getListofLoanApplication())
          .postDioResponse();
    } else {
      List<ListOfLoanApplicationDTO> loanApplicationDTO =
          await SharedPreferenceUtils.sharedPreferenceUtils
              .getListOfLoanApplication();
      appLoading!.isSuccessful2(SuccessfulResponseDTO());
      _listOfLoanResponse = loanApplicationDTO;
      // appLoading!.isSuccessful2(SuccessfulResponseDTO());
    }
  }

  getApplicationData(FormData formData) async {
    // print("Get Application Called");
    bool dateTime = true;
    String timeApi =
        await SharedPreferenceUtils.sharedPreferenceUtils.getApliCallTImeData();
    if (timeApi != "") {
      dateTime = DateUtilsGeneric.calculateTimeDifference(DateTime.parse(
          await SharedPreferenceUtils.sharedPreferenceUtils
              .getApliCallTImeData()));
    } else {
      dateTime = true;
    }

    print("Date TIme is");
    print(dateTime);

    if (dateTime||true) {
      DioDhanvarshaWrapper((SuccessfulResponseDTO dto) {
        SharedPreferenceUtils.sharedPreferenceUtils
            .setBLPLApplicationData(dto.data!);
        _listOfBLPLApplications = jsonDecode(dto.data!) != null
            ? jsonDecode(dto.data!) as List != null
                ? (jsonDecode(dto.data!) as List).map((i) {
                    return ListOfLoanApplicationDTO.fromJson(i);
                  }).toList()
                : []
            : [];



        // print("BL PL APPLICATIONs");
        // print(jsonEncode(_listOfBLPLApplications));

        SharedPreferenceUtils.sharedPreferenceUtils
            .setBLPLApplicationData(dto.data!);

        DateTime dateTime = DateTime.now();
        SharedPreferenceUtils.sharedPreferenceUtils
            .setApiCallTime(dateTime.toIso8601String());
        appLoading!.hideProgress();
      }, () {
        appLoading!.showProgress();
      }, () {
        appLoading!.hideProgress();
        appLoading!.showError();
      }, formData, NetworkConstants.networkUrl.getBLPLApplicationService())
          .postDioResponse();
    } else {
      print("Get Application Data is");
      List<ListOfLoanApplicationDTO> loanApplicationDTO =
          await SharedPreferenceUtils.sharedPreferenceUtils
              .getBLPLApplicationData();
      print(loanApplicationDTO);
      _listOfBLPLApplications = loanApplicationDTO;
    }
  }

  @override
  dispose() {
    return null;
  }
}
