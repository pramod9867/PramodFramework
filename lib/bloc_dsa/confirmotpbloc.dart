import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/panresponse.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/model_dsa/response/verifyOtpRes.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/apprej/AppRej.dart';
import 'package:dhanvarsha/ui_dsa/registration/appsub/AppSub.dart';
import 'package:dhanvarsha/ui_dsa/registration/reg/Rejistration.dart';
import 'package:dhanvarsha/ui_dsa/registration/regcom/RegCom.dart';
import 'package:dhanvarsha/ui_dsa/registration/reginprog/RegInProg.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dhanvarsha/utils_dsa/encryptionutils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ConfirmOTPBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  String otp = '';
  String phone = '';
  String validateToken = '';
  PanResponseDTO? panres;

  VerifyOTPRes? otpres;

  confirmOTP(BuildContext context) async {
    try {
      otp = BasicData.otp;
      print('in otpblock otp = $otp');
      CustomLoader.customloaderbuilder.showLoader();

      phone = BasicData.phone;
      print('in otpblock phone = $phone');
      print('token =');
      print(BasicData.token);
      validateToken = phone + otp;
      print('validateToken =');
      print(validateToken);
      BasicData.validateToken = validateToken;
      print('BasicDatavalidateToken =');
      print(BasicData.validateToken);

      ApiClient apiClient = ApiClient.defaultClient(token: BasicData.token);
      Uuid uuid = new Uuid();
      String reqid = uuid.v4();
      String uniqid =
          uuid.v4() + DateTime.now().microsecondsSinceEpoch.toString();
      String? encryptedData =
          await EncryptionUtils.getEncryptedText(jsonEncode({
        "MobileNumber": phone,
        "otp": otp,
        "ValidateToken": validateToken,
        "RequestId": reqid,
        "UniqueId": uniqid
      }));

      FormData formData = FormData.fromMap({
        'json': encryptedData,
      });
      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.verifyOTPD(),
          data: formData,
          options: Options(headers: {"Platform": "Android"}));

      print(response?.statusCode);
      print(EncryptionUtils.decryptString(response.toString()));

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);
        CustomLoader.customloaderbuilder.hideLoader();

        print('decryptedString $decryptedString');

        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        otpres = VerifyOTPRes.fromJson(jsonDecode(dto.data!));
        print('otpresposne ' + otpres.toString());
        if (otpres?.isValidOTP ?? false) {
          BasicData.otpres = otpres;
          BasicData.id = otpres?.distributorDetails?.distributor?.id ?? 0;

          // BasicData.panres = (otpres?.distributorDetails?.panDetails ?? null)
          //     as PanResponseDTO?;

          print('status');
          print(otpres?.distributorDetails?.distributor?.status);
          print('allformflag');
          print(otpres?.distributorDetails?.distributor?.allFormFlag);

          print('pan number');
          print(otpres?.distributorDetails?.panDetails?.panNumber);
          print('distruber pan number');
          print(otpres?.distributorDetails?.distributor?.pANNumber);
          print('pan number in basic data');
          print(BasicData.panres?.PanNumber);

          print('dstrubuter aadhaar number');
          print(otpres?.distributorDetails?.distributor?.aadharNumber);

          // print('rental name');
          // print(otpres?.distributorDetails?.distributor?.RentalBillName);

          BasicData.panres?.PanNumber =
              otpres?.distributorDetails?.distributor?.pANNumber ?? '';
          BasicData.adharres?.AadharNumber =
              otpres?.distributorDetails?.distributor?.aadharNumber ?? '';
          BasicData.adharres?.FirstName =
              otpres?.distributorDetails?.aadharDetails?.firstName ?? '';
          BasicData.adharres?.MiddleName =
              otpres?.distributorDetails?.aadharDetails?.middleName ?? '';
          BasicData.adharres?.LastName =
              otpres?.distributorDetails?.aadharDetails?.lastName ?? '';
          BasicData.adharres?.DateOfBirth =
              otpres?.distributorDetails?.aadharDetails?.dateOfBirth ?? '';
          BasicData.adharres?.Pincode =
              otpres?.distributorDetails?.aadharDetails?.pincode ?? '';
          BasicData.adharres?.AddressLine1 =
              otpres?.distributorDetails?.aadharDetails?.addressLine1 ?? '';
          BasicData.adharres?.AddressLine2 =
              otpres?.distributorDetails?.aadharDetails?.addressLine2 ?? '';
          BasicData.adharres?.AddressLine3 =
              otpres?.distributorDetails?.aadharDetails?.addressLine3 ?? '';
          BasicData.panImagepath =
              otpres?.distributorDetails?.distributor?.pANImageUrl ?? '';
          BasicData.adharfrontImagepath =
              otpres?.distributorDetails?.distributor?.aadharImageFrontUrl ??
                  '';
          BasicData.adharbackImagepath =
              otpres?.distributorDetails?.distributor?.aadharImageBackUrl ?? '';
          BasicData.buspanimagepath =
              otpres?.distributorDetails?.distributor?.businessPANImageUrl ??
                  '';
          BasicData.gstimagepath =
              otpres?.distributorDetails?.distributor?.gSTCertificateImageUrl ??
                  '';

          BasicData.panres?.FirstName =
              otpres?.distributorDetails?.panDetails?.firstName ?? '';

          BasicData.panres?.MiddleName =
              otpres?.distributorDetails?.panDetails?.middleName ?? '';
//test
          BasicData.panres?.LastName =
              otpres?.distributorDetails?.panDetails?.lastName ?? '';

          BasicData.panres?.DateOfBirth =
              otpres?.distributorDetails?.panDetails?.dateOfBirth ?? '';

          BasicData.fName =
              otpres?.distributorDetails?.distributor?.firstName ?? '';
          BasicData.mName =
              otpres?.distributorDetails?.distributor?.middleName ?? '';
          BasicData.lName =
              otpres?.distributorDetails?.distributor?.lastName ?? '';
          BasicData.moninName =
              otpres?.distributorDetails?.distributor?.mobileNumber ?? '';

          BasicData.proofaddimagepath = otpres?.distributorDetails?.distributor
                  ?.addressProofDocTypeImageUrl ??
              '';
          BasicData.rentalagreementimagepath = otpres
                  ?.distributorDetails?.distributor?.rentalAgreementImageUrl ??
              '';
          BasicData.cancelchequeimagepath = otpres
                  ?.distributorDetails?.distributor?.cancelledChequeImageUrl ??
              '';

          print('the id is ' + BasicData.id.toString());

          if (otpres?.distributorDetails?.distributor?.allFormFlag
                  .toString()
                  .toLowerCase() ==
              'n') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegInProg(
                        context: context,
                      )),
            );
          } else {
            if (otpres?.distributorDetails?.distributor?.status
                    .toString()
                    .toLowerCase() ==
                'pending') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppSub(
                          context: context,
                        )),
              );
            } else if (otpres?.distributorDetails?.distributor?.status
                    .toString()
                    .toLowerCase() ==
                'approved') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegCom(
                          context: context,
                        )),
              );
            } else if (otpres?.distributorDetails?.distributor?.status
                    .toString()
                    .toLowerCase() ==
                'rejected') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppRej(
                          context: context,
                        )),
              );
            }
          }

          /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Registration(
                      context: context,
                    )),
          );*/
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Something went wrong")));
          CustomLoader.customloaderbuilder.hideLoader();
        }
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();
      print('in cathc');
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  dispose() {
    return null;
  }
}
