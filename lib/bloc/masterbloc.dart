import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/csdtrequestdto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/mastdto/master_super_dto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/registration_new/splash.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';




class MasterBloc extends Bloc {
  MasterSuperDTO? _masterSuperDTO;

  ValueNotifier<List<MasterDataDTO>>? _countryDTO=ValueNotifier([]);
  ValueNotifier<List<MasterDataDTO>>? _stateDTO=ValueNotifier([]);
  ValueNotifier<List<MasterDataDTO>>? _districtDTO=ValueNotifier([]);
  ValueNotifier<List<MasterDataDTO>>? _talukaDTO=ValueNotifier([]);

  AppLoading? appLoading;

  MasterBloc(AppLoading appLoading) {
    this.appLoading = appLoading;
  }
  getMasterData() async {
    await SharedPreferenceUtils.sharedPreferenceUtils.initSharedPref();
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _masterSuperDTO =
                      MasterSuperDTO.fromJson(jsonDecode(dto.data!)),
                  getCountryDetails()
                },
            () => {appLoading!.showProgress()},
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            FormData(),
            NetworkConstants.networkUrl.getMasterData())
        .getDioResponse();
  }

  getCountryDetails({int id = 0}) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  print("Country Details"),
                  print(jsonDecode(dto.data!)['Countries']),

                  _countryDTO!.value = jsonDecode(dto.data!)['Countries'] != null
                      ? jsonDecode(dto.data!)['Countries'] as List != null
                          ? (jsonDecode(dto.data!)['Countries'] as List)
                              .map((i) {
                              return MasterDataDTO.fromJson(i);
                            }).toList()
                          : []
                      : [],



                getStateDetails(id: id)

                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            FormData(),
            NetworkConstants.networkUrl.getCountryDetails())
        .postDioResponse();
  }

  getStateDetails({int id = 0}) async {


    print("ID IS");
    print(id);
    CSDTRequestDTO stateRequest = CSDTRequestDTO(id: id);
    print(stateRequest.toEncodedJson());
    FormData formData = FormData.fromMap({
      "json":
          await EncryptionUtils.getEncryptedText(stateRequest.toEncodedJson())
    });

    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _stateDTO!.value = jsonDecode(dto.data!)['States'] != null
                      ? jsonDecode(dto.data!)['States'] as List != null
                          ? (jsonDecode(dto.data!)['States'] as List).map((i) {
                              return MasterDataDTO.fromJson(i);
                            }).toList()
                          : []
                      : [],


                 if(id==0){
                   getDistrictDetails()
                 }else{

                   appLoading!.hideProgress(),
                 }
                },
            () => {
               if(id!=0){
                 appLoading!.showProgress(),
               }
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getStateDetails())
        .postDioResponse();
  }

  getDistrictDetails({int id = 0}) async {
    CSDTRequestDTO districtRequest = CSDTRequestDTO(id: id);
    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          districtRequest.toEncodedJson())
    });

    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _districtDTO!.value = jsonDecode(dto.data!)['Districts'] != null
                      ? jsonDecode(dto.data!)['Districts'] as List != null
                          ? (jsonDecode(dto.data!)['Districts'] as List)
                              .map((i) {
                              return MasterDataDTO.fromJson(i);
                            }).toList()
                          : []
                      : [],

              if(id!=0){
                appLoading!.hideProgress()
              }else{
                getTalukaDetails()
              }

            },
            () => {
                  if(id!=0){
                    appLoading!.showProgress(),
                  }
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getDistricDetails())
        .postDioResponse();
  }

  getTalukaDetails({int id = 0}) async {
    CSDTRequestDTO talukaRequest = CSDTRequestDTO(id: id);
    FormData formData = FormData.fromMap({
      "json":
          await EncryptionUtils.getEncryptedText(talukaRequest.toEncodedJson())
    });
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  _talukaDTO!.value = jsonDecode(dto.data!)['Talukas'] != null
                      ? jsonDecode(dto.data!)['Talukas'] as List != null
                          ? (jsonDecode(dto.data!)['Talukas'] as List).map((i) {
                              return MasterDataDTO.fromJson(i);
                            }).toList()
                          : []
                      : [],

                  if(id!=0){
                    appLoading!.hideProgress()
                  }else{
                    appLoading!.isSuccessful(dto),
                    appLoading!.hideProgress()
                  }

                },
            () => {
                  if(id!=0){
                    appLoading!.showProgress(),
                  }
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getTalukaDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }

  MasterSuperDTO get masterSuperDTO => _masterSuperDTO!;

  set masterSuperDTO(MasterSuperDTO value) {
    _masterSuperDTO = value;
  }


  ValueNotifier<List<MasterDataDTO>> get countryDTO => _countryDTO!;

  set countryDTO(ValueNotifier<List<MasterDataDTO>> value) {
    _countryDTO = value;
  }

  ValueNotifier<List<MasterDataDTO>> get stateDTO => _stateDTO!;

  set stateDTO(ValueNotifier<List<MasterDataDTO>> value) {
    _stateDTO = value;
  }

  ValueNotifier<List<MasterDataDTO>> get districtDTO => _districtDTO!;

  set districtDTO(ValueNotifier<List<MasterDataDTO>> value) {
    _districtDTO = value;
  }

  ValueNotifier<List<MasterDataDTO>> get talukaDTO => _talukaDTO!;

  set talukaDTO(ValueNotifier<List<MasterDataDTO>> value) {
    _talukaDTO = value;
  }
}
