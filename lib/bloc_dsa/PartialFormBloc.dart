import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
//
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/completeformres.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/addressproof/proofofaddress.dart';
import 'package:dhanvarsha/ui_dsa/registration/appreview/Appreview.dart';
import 'package:dhanvarsha/ui_dsa/registration/bankdetail/BankDetails.dart';
import 'package:dhanvarsha/ui_dsa/registration/gst/billingdocuments.dart';
import 'package:dhanvarsha/ui_dsa/registration/pan/personaldoccapture.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dhanvarsha/utils_dsa/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils_dsa/inputdecorations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PartialFormBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  String allformflag = "N";

  CompleteForm? comres;

  submitform(String type, BuildContext context) async {
    try {
      print('this is bloc $type');
      if (type == 'e') {
        allformflag = "Y";
      }
      print("All Form FLag");
      print(allformflag);

      CustomLoader.customloaderbuilder.showLoader();
      ApiClient apiClient = ApiClient.defaultClient(token: BasicData.token);

      List<MultipartFile> appFiles = [];

      if (BasicData.panImagepath != "" &&
          !Uri.parse(BasicData.panImagepath).isAbsolute) {
        appFiles.add(
          await MultipartFile.fromFileSync(BasicData.panImagepath,
              filename: getfilename(BasicData.panImagepath)),
        );
      }
      if (BasicData.adharfrontImagepath != "" &&
          !Uri.parse(BasicData.adharfrontImagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(
            BasicData.adharfrontImagepath,
            filename: getfilename(BasicData.adharfrontImagepath)));
      }
      if (BasicData.adharbackImagepath != "" &&
          !Uri.parse(BasicData.adharbackImagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(
            BasicData.adharbackImagepath,
            filename: getfilename(BasicData.adharbackImagepath)));
      }

      if (BasicData.buspanimagepath != "" &&
          !Uri.parse(BasicData.buspanimagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(BasicData.buspanimagepath,
            filename: getfilename(BasicData.buspanimagepath)));
      }

      if (!BasicData.gstimagepath.isEmpty &&
          !Uri.parse(BasicData.gstimagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(BasicData.gstimagepath,
            filename: getfilename(BasicData.gstimagepath)));
      }
      if (!BasicData.proofaddimagepath.isEmpty &&
          !Uri.parse(BasicData.proofaddimagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(
            BasicData.proofaddimagepath,
            filename: getfilename(BasicData.proofaddimagepath)));
      }
      if (!BasicData.rentalagreementimagepath.isEmpty &&
          !Uri.parse(BasicData.rentalagreementimagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(
            BasicData.rentalagreementimagepath,
            filename: getfilename(BasicData.rentalagreementimagepath)));
      }
      if (!BasicData.cancelchequeimagepath.isEmpty &&
          !Uri.parse(BasicData.cancelchequeimagepath).isAbsolute) {
        appFiles.add(await MultipartFile.fromFileSync(
            BasicData.cancelchequeimagepath,
            filename: getfilename(BasicData.cancelchequeimagepath)));
      }

      print(appFiles);
      print('before json');
      print(BasicData.panres?.PanNumber);
      print('Rental name');
      print(BasicData.RentalBillName);
      Uuid uuid = new Uuid();
      String reqid = uuid.v4();
      String uniqid =
          uuid.v4() + DateTime.now().microsecondsSinceEpoch.toString();

      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(jsonEncode({
          "Id": BasicData.id,
          "FirstName": BasicData.fName,
          "MiddleName": BasicData.mName,
          "LastName": BasicData.lName,
          "MobileNumber": BasicData.phone,
          "MonthlyIncome": BasicData.moninName,
          "IsRegisteredBusiness": BasicData.isbusinessregistred,
          "BusinessType": BasicData.bustype,
          "BusinessName": BasicData.busname,
          "SizeOfShop": BasicData.sizeofshop,
          "PANNumber":
              BasicData.panres != null ? BasicData.panres?.PanNumber : '',
          "PANImage": Uri.parse(BasicData.panImagepath).isAbsolute
              ? ""
              : getfilename(BasicData.panImagepath),
          "AadharNumber": BasicData.adharres != null
              ? BasicData.adharres!.AadharNumber
              : '',
          "AadharImageFront":
              Uri.parse(BasicData.adharfrontImagepath).isAbsolute
                  ? ""
                  : getfilename(BasicData.adharfrontImagepath),
          "AadharImageBack": Uri.parse(BasicData.adharbackImagepath).isAbsolute
              ? ""
              : getfilename(BasicData.adharbackImagepath),
          "IsPANVerified": BasicData.ispan,
          "IsAadharVerified": BasicData.isadhar,
          "GSTNumber": BasicData.gstNumber,
          "AddressProofDocType": BasicData.addproofdoctype,
          "AddressProofDocTypeImage": getfilename(BasicData.proofaddimagepath),
          "IsElectricityBillOnMyName": BasicData.isElectricityBillOnMyName,
          "RentalAgreementImage":
              Uri.parse(BasicData.rentalagreementimagepath).isAbsolute
                  ? ""
                  : getfilename(BasicData.rentalagreementimagepath),
          "isRentalBillOnName": BasicData.isRentalBillOnName,
          "RentalBillName": BasicData.RentalBillName,
          "BankName": BasicData.bankname,
          "IFSCCode": BasicData.ifsc,
          "AccountNumber": BasicData.accnumber,
          "NameOfAccountHolder": BasicData.namofaccholder,
          "Email": "",
          "PanDetails": BasicData.panres != null
              ? {
                  "PanNumber": BasicData.panres!.PanNumber ?? '',
                  "FirstName": BasicData.panres!.FirstName ?? '',
                  "MiddleName": BasicData.panres!.MiddleName ?? '',
                  "LastName": BasicData.panres!.LastName ?? '',
                  "DateOfBirth": BasicData.panres!.DateOfBirth ?? '',
                }
              : {
                  "PanNumber": '',
                  "FirstName": '',
                  "MiddleName": '',
                  "LastName": '',
                  "DateOfBirth": '',
                },
          "AadharDetails": (BasicData.adharres != null)
              ? {
                  "AadharNumber": BasicData.adharres!.AadharNumber ?? '',
                  "FirstName": BasicData.adharres!.FirstName ?? '',
                  "MiddleName": BasicData.adharres!.MiddleName ?? '',
                  "LastName": BasicData.adharres!.LastName ?? '',
                  "DateOfBirth": BasicData.adharres!.DateOfBirth ?? '',
                  "Gender": BasicData.adharres!.Gender ?? '',
                  "Pincode": BasicData.adharres!.Pincode ?? '',
                  "AddressLine1": BasicData.adharres!.AddressLine1 ?? '',
                  "AddressLine2": BasicData.adharres!.AddressLine2 ?? '',
                  "AddressLine3": BasicData.adharres!.AddressLine3 ?? '',
                }
              : {
                  "AadharNumber": '',
                  "FirstName": '',
                  "MiddleName": '',
                  "LastName": '',
                  "DateOfBirth": '',
                  "Gender": '',
                  "Pincode": '',
                  "AddressLine1": '',
                  "AddressLine2": '',
                  "AddressLine3": '',
                },
          "BusinessPAN": "",
          "GSTCertificate": BasicData.gstNumber,
          "CancelledCheque": "",
          "BusinessPANImage": Uri.parse(BasicData.buspanimagepath).isAbsolute
              ? ""
              : getfilename(BasicData.buspanimagepath),
          "GSTCertificateImage": Uri.parse(BasicData.gstimagepath).isAbsolute
              ? ""
              : getfilename(BasicData.gstimagepath),
          "CancelledChequeImage":
              Uri.parse(BasicData.cancelchequeimagepath).isAbsolute
                  ? ""
                  : getfilename(BasicData.cancelchequeimagepath),
          //"AllFormFlag": "N",
          "AllFormFlag": allformflag,
          "RequestId": reqid,
          "UniqueId": uniqid
        })),
        "Myfiles": appFiles
      });

      print("Files Are");
      print(formData.toString());
      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.partialForm(),
          data: formData,
          options: Options(headers: {"Platform": "Android"}));

      print(response?.statusCode);
      print(EncryptionUtils.decryptString(response.toString()));

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? decryptedString =
            await EncryptionUtils.decryptString(response?.data);

        print('decryptedString $decryptedString');

        SuccessfulResponseDTO dto =
            SuccessfulResponseDTO.fromJson(jsonDecode(decryptedString!!)[0]);

        if (true) {
          comres = CompleteForm.fromJson(jsonDecode(dto.data!));
          if (comres?.status ?? false) {
            CustomLoader.customloaderbuilder.hideLoader();

            if (type == 'a') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalDocCapture(
                          context: context,
                        )),
              );
            } else if (type == 'b') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BillingDocuments(
                          context: context,
                        )),
              );
            } else if (type == 'c') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProofofAddress(
                          context: context,
                        )),
              );
            } else if (type == 'd') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BankDetails(
                          context: context,
                        )),
              );
            } else if (type == 'e') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    //builder: (context) => AppReceived(
                    builder: (context) => Appreview(
                          context: context,
                        )),
              );
            }
          } else {
            CustomLoader.customloaderbuilder.hideLoader();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(comres?.message ?? 'something went wrong')));
          }
        } else {
          DialogUtils.showMyDialog(context);
        }
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  dispose() {
    return null;
  }

  getfilename(String imagePath) {
    if (imagePath != '') {
      print('image path  ' + imagePath.split('/').last);
      return imagePath.split('/').last;
    } else {
      return '';
    }
  }
}
