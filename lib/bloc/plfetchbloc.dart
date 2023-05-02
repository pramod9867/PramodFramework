import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/mobileveriificationdto.dart';
import 'package:dhanvarsha/model/response/verifyotpresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';

class PLFetchBloc extends Bloc {
  CustomerOnBoardingDTO? onBoardingDTO;
  AppLoading? appLoading;
  AppLoadingGeneric? appLoadingMultiple;
  VerifyOTPResponseDTO? verifyOTPResponseDTO;

  PLFetchBloc();

  PLFetchBloc.appLoading(AppLoading appLoading) {
    this.appLoading = appLoading;
  }

  PLFetchBloc.appLoadingMultiple(AppLoadingGeneric appLoadingMultiple) {
    this.appLoadingMultiple = appLoadingMultiple;
  }

  fetchPLDetails(String mobileNumber) async {
    MobileVerificationDTO mobileVerificationDTO = MobileVerificationDTO();
    mobileVerificationDTO.mobiliNumber = mobileNumber;

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          mobileVerificationDTO.toEncodeJson()),
    });
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  print(dto.data),
                  onBoardingDTO =
                      CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!)),
                  print(onBoardingDTO!.aadharFrontImage),
                  CustomLoaderBuilder.builder.hideLoader()
                },
            () => {
                  print("Into the Progress"),
                  CustomLoaderBuilder.builder.showLoader()
                },
            () => {
                  print("Into THe Error"),
                  CustomLoaderBuilder.builder.hideLoader()
                },
            formData,
            NetworkConstants.networkUrl.fetchPLDetails())
        .postDioResponse();
  }

  verifyOTP(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  verifyOTPResponseDTO =
                      VerifyOTPResponseDTO.fromJson(jsonDecode(dto.data!)),
                  // onBoardingDTO=verifyOTPResponseDTO!.onBoardingDTO,
                  // print(onBoardingDTO!.mobileNumber),
                  appLoading!.hideProgress(),

                  appLoading!.isSuccessful(dto),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.verifyOTP())
        .postDioResponse();
  }

  selectLoanType(FormData formData, {int index = 0}) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  // onBoardingDTO= CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!)),
                  appLoadingMultiple!.hideProgress(),

                  appLoadingMultiple!.isAllSuccessResponse(dto, index),
                },
            () => {
                  appLoadingMultiple!.showProgress(),
                },
            () => {
                  appLoadingMultiple!.hideProgress(),
                  appLoadingMultiple!.showError()
                },
            formData,
            NetworkConstants.networkUrl.updateLoanType())
        .postDioResponse();
  }

  fetchDropoutDetails(FormData formData) {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  // onBoardingDTO= CustomerOnBoardingDTO.fromJson(jsonDecode(dto.data!)),
                  appLoading!.hideProgress(),

                  appLoading!.isSuccessful(dto),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {appLoading!.hideProgress(), appLoading!.showError()},
            formData,
            NetworkConstants.networkUrl.getAllProductDetails())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
