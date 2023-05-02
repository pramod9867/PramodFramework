import 'dart:convert';

import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/network/dio_wrapper.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/response/onboardingsuccessful.dart';
import 'package:dhanvarsha/model/response/preequalresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/loanreward/loanflowsuccessful.dart';
import 'package:dhanvarsha/ui/loantype/numberverification.dart';
import 'package:dhanvarsha/utils/constants/network/network.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef onSuccessfulCallBack = Function(CustomerOnBoardingResponseDTO dto);
typedef onPrequalSuccessCallBack = Function(PreEqualResponse dto);

class CustomerBoardingBloc extends Bloc {
  CustomerOnBoardingResponseDTO? onBoardinDTOP;
  PreEqualResponse? preEqualResponse;

  AddRefLoading? appLoading;
  AppLoading? appLoadingClient;
  CustomerBoardingBloc();

  CustomerBoardingBloc.appLoadingRef(AddRefLoading appLoading) {
    this.appLoading = appLoading;
  }
  CustomerBoardingBloc.appLoadingClient(AppLoading appLoading) {
    this.appLoadingClient = appLoading;
  }

  applyForPersonalLoan(FormData formData, BuildContext context,
      onSuccessfulCallBack onSuccessfulCallBack,
      {bool isLoaderHide = false,
      FormData? prequalFormData,
      onPrequalSuccessCallBack? onPrequalSuccessCallBack}) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  print("Successful Response"),
                  onBoardinDTOP = CustomerOnBoardingResponseDTO.fromJson(
                      jsonDecode(dto.data!)),
                  if (!isLoaderHide)
                    {
                      onSuccessfulCallBack(onBoardinDTOP!!),
                      CustomLoaderBuilder.builder.hideLoader(),
                    }
                  else
                    {
                      getPrequalOffer(
                          prequalFormData!, context, onPrequalSuccessCallBack!),

                    }
                },
            () => {
                  CustomLoaderBuilder.builder.showLoader(),
                },
            () => {
                  CustomLoaderBuilder.builder.hideLoader(),
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something Went Wrong")))
                },
            formData,
            NetworkConstants.networkUrl.getCustomerOnBoarding())
        .postDioResponse();
  }

  getPrequalOffer(FormData formData, BuildContext context,
      onPrequalSuccessCallBack onPrequalSuccessCallBack) async {
    print("Prequal Called");
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  preEqualResponse =
                      PreEqualResponse.fromJson(jsonDecode(dto.data!)),
                  if (preEqualResponse != null)
                    {
                      onPrequalSuccessCallBack(preEqualResponse!),
                      CustomLoaderBuilder.builder.hideLoader(),
                    }
                  else
                    {
                      CustomLoaderBuilder.builder.hideLoader(),
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Something Went Wrong")))
                    }
                },
            () => {
                  CustomLoaderBuilder.builder.showLoaderUIDiff(),
                },
            () => {
                  CustomLoaderBuilder.builder.hideLoader(),
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something Went Wrong")))
                },
            formData,
            NetworkConstants.networkUrl.getPrequalRequestNew())
        .postDioResponse();
  }

  applyForPersonalLoanDynamic(FormData formData, BuildContext context) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  print("Success ful Service"),
                  appLoading!.isSuccessful(dto),
                },
            () => {
                  CustomLoaderBuilder.builder.showLoader(),
                },
            () => {
                  CustomLoaderBuilder.builder.hideLoader(),
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something Went Wrong")))
                },
            formData,
            NetworkConstants.networkUrl.getCustomerOnBoarding())
        .postDioResponse();
  }

  createLoanApplication(FormData formData) async {
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoading!.isSuccessful2(dto),
                  appLoading!.hideProgress(),
                },
            () => {
                  appLoading!.showProgress(),
                },
            () => {
                  appLoading!.hideProgress(),
                },
            formData,
            NetworkConstants.networkUrl.createLoan())
        .postDioResponse();
  }

  createClientInitiate(FormData formData) {
    print("Create Client Called");
    DioDhanvarshaWrapper(
            (SuccessfulResponseDTO dto) => {
                  appLoadingClient!.isSuccessful(dto),
                  appLoadingClient!.hideProgress(),
                },
            () => {
                  appLoadingClient!.showProgress(),
                },
            () => {
                  appLoadingClient!.hideProgress(),
                },
            formData,
            NetworkConstants.networkUrl.createClientInitiate())
        .postDioResponse();
  }

  @override
  dispose() {
    return null;
  }
}
