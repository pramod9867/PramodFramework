import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/model/response/aadhaardetailsdto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AadhaarDetailsBloc extends Bloc {
  AadhaarDTO? aadhaarDTO;
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusOfAadharDetails =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  ValueNotifier<NetworkCallConnectionStatus>
      get connectionStatusOfAadharDetails => _connectionStatusOfAadharDetails;

  set connectionStatusOfAadharDetails(
      ValueNotifier<NetworkCallConnectionStatus> value) {
    _connectionStatusOfAadharDetails = value;
  }

  getAadhaarDetails(FormData formData, @required VoidCallback navigateToAadhar,
      @required VoidCallback showToast) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  aadhaarDTO = AadhaarDTO.fromJson(jsonDecode(dto.data!)),
                  // print(aadhaarDTO?.aadharNumber),


                  print(aadhaarDTO!.toEncodedJson()),
                  CustomLoaderBuilder.builder.hideLoader(),
                  if (aadhaarDTO?.aadharNumber != null &&
                      aadhaarDTO!.aadharNumber != "")
                    {navigateToAadhar()}
                  else
                    {showToast()},
                  _connectionStatusOfAadharDetails.notifyListeners()
                },
            () => {
                  CustomLoaderBuilder.builder.showLoader(),
                  _connectionStatusOfAadharDetails.notifyListeners()
                },
            () => {
                  CustomLoaderBuilder.builder.hideLoader(),
                  showToast(),
                  _connectionStatusOfAadharDetails.notifyListeners()
                },
            formData,
            NetworkConstants.networkUrl.getAadharOcrDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
