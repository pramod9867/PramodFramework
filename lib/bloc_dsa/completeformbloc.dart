import 'dart:convert';

import 'package:dhanvarsha/constant_dsa/BasicData.dart';
// import 'package:dhanvarsha/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/framework_dsa/bloc_provider.dart';
import 'package:dhanvarsha/framework_dsa/network/dio_client.dart';
import 'package:dhanvarsha/framework_dsa/network/typedef.dart';
import 'package:dhanvarsha/model_dsa/response/completeformres.dart';
import 'package:dhanvarsha/model_dsa/response/successfulresponsedto.dart';
import 'package:dhanvarsha/ui_dsa/loader/CustomLoader.dart';
import 'package:dhanvarsha/ui_dsa/registration/apprecived/AppReceived.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils_dsa/constants/constants/network/network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CompleteformBloc extends Bloc {
  ValueNotifier<NetworkCallConnectionStatus> _connectionStatusLiveData =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  CompleteForm? comres;

  submitform(String formjson, BuildContext context) async {
    try {
      print('this is bloc $formjson');

      CustomLoader.customloaderbuilder.showLoader();
      ApiClient apiClient = ApiClient.defaultClient(token : BasicData.token);

      /////////
      //       { 	"Id": 0,
      // "FirstName": "John",
      // "MiddleName": "A",
      // "LastName": "Doe",
      // "MobileNumber": "9892756378",
      // "MonthlyIncome": "15000",
      // "IsRegisteredBusiness": true,
      // "BusinessType": "E-Commerce",
      // "BusinessName": "Amazon",
      // "SizeOfShop": "40",
      // "PANNumber": "DERTP1234W",
      // "PANImage": "PanImage.jpg",
      // "AadharNumber": "785214569852",
      // "AadharImageFront": "AadharFront.jpg",
      // "AadharImageBack": "AadharBack.png",
      // "IsPANVerified": true,
      // "IsAadharVerified": true,
      // "GSTNumber": "1234567890",
      // "AddressProofDocType": "",
      // "AddressProofDocTypeImage": "",
      // "IsElectricityBillOnMyName": true,
      // "RentalAgreementImage": "",
      // "BankName": "SBI",
      // "IFSCCode": "14523",
      // "AccountNumber": "145896325876",
      // "NameOfAccountHolder": "john doe",
      // "Email": "shubham.p@mobitrail.jks.com",
      // "PanDetails": { "PanNumber": "DERTP1234W",
      // "FirstName": "John",
      // "MiddleName": "A",
      // "LastName": "Doe",
      // "DateOfBirth": "04-01-1999"
      // },
      // "AadharDetails": {
      // "AadharNumber": "785214569852",
      // "FirstName": "John",
      // "MiddleName": "A",
      // "LastName": "Doe",
      // "DateOfBirth": "04-01-1999",
      // "Gender": "M",
      // "Pincode": "400063",
      // "AddressLine1": "RNLANIL NIWAS SAHYADRI NGR SAMBHAJI MARG VTC. Bhandup West,"
      // " Po : Bhandup West, pbil Sub District : Bhandup West, District "
      // ": Mumbai, State : Maharashtra Code : 400078",
      // "AddressLine2": "SAHYADRI NGR SAMBHAJI MARG ",
      // "AddressLine3": " Mumbai Maharashtra" 	},
      //
      // "BusinessPAN": "",
      // "GSTCertificate": "145296387",
      // "CancelledCheque": "",
      // "BusinessPANImage": "BusinessPan.jpg",
      // "GSTCertificateImage": "GstCertificate.jpg",
      // "CancelledChequeImage": "CancelledCheque.png"
      //       }
      ////////
      Uuid uuid = new Uuid();
      String reqid = uuid.v4();
      String uniqid = uuid.v4()+DateTime.now().microsecondsSinceEpoch.toString();
      FormData formData = FormData.fromMap({
        'json': await EncryptionUtils.getEncryptedText(jsonEncode({
          "Id": 0,
          "FirstName": BasicData.fName,
          "MiddleName": BasicData.mName,
          "LastName": BasicData.lName,
          "MobileNumber": BasicData.phone,
          "MonthlyIncome": BasicData.moninName,
          "IsRegisteredBusiness": BasicData.isbusinessregistred,
          "BusinessType": BasicData.bustype,
          "BusinessName": BasicData.busname,
          "SizeOfShop": BasicData.sizeofshop,
          "PANNumber": BasicData.panres!.PanNumber,
          "PANImage": getfilename(BasicData.panImagepath),
          "AadharNumber": BasicData.adharres!.AadharNumber,
          "AadharImageFront": getfilename(BasicData.adharfrontImagepath),
          "AadharImageBack": getfilename(BasicData.adharbackImagepath),
          "IsPANVerified": true,
          "IsAadharVerified": true,
          "GSTNumber": BasicData.gstNumber,
          "AddressProofDocType": BasicData.addproofdoctype,
          "AddressProofDocTypeImage": getfilename(BasicData.proofaddimagepath),
          "IsElectricityBillOnMyName": BasicData.isElectricityBillOnMyName,
          "RentalAgreementImage":
              getfilename(BasicData.rentalagreementimagepath),
          "BankName": BasicData.bankname,
          "IFSCCode": BasicData.ifsc,
          "AccountNumber": BasicData.accnumber,
          "NameOfAccountHolder": BasicData.namofaccholder,
          "Email": "",
          "PanDetails": {
            "PanNumber": BasicData.panres!.PanNumber,
            "FirstName": BasicData.panres!.FirstName,
            "MiddleName": BasicData.panres!.MiddleName,
            "LastName": BasicData.panres!.LastName,
            "DateOfBirth": BasicData.panres!.DateOfBirth
          },
          "AadharDetails": {
            "AadharNumber": BasicData.adharres!.AadharNumber,
            "FirstName": BasicData.adharres!.FirstName,
            "MiddleName": BasicData.adharres!.MiddleName,
            "LastName": BasicData.adharres!.LastName,
            "DateOfBirth": BasicData.adharres!.DateOfBirth,
            "Gender": BasicData.adharres!.Gender,
            "Pincode": BasicData.adharres!.Pincode,
            "AddressLine1": BasicData.adharres!.AddressLine1,
            "AddressLine2": BasicData.adharres!.AddressLine2,
            "AddressLine3": BasicData.adharres!.AddressLine3,
          },
          "BusinessPAN": "",
          "GSTCertificate": BasicData.gstNumber,
          "CancelledCheque": "",
          "BusinessPANImage": getfilename(BasicData.buspanimagepath),
          "GSTCertificateImage": getfilename(BasicData.gstimagepath),
          "CancelledChequeImage": getfilename(BasicData.cancelchequeimagepath),
          "RequestId": reqid,
          "UniqueId": uniqid
        })),
        "Myfiles": [
          await MultipartFile.fromFileSync(BasicData.panImagepath,
              filename: getfilename(BasicData.panImagepath)),
          await MultipartFile.fromFileSync(BasicData.adharfrontImagepath,
              filename: getfilename(BasicData.adharfrontImagepath)),
          await MultipartFile.fromFileSync(BasicData.adharbackImagepath,
              filename: getfilename(BasicData.adharbackImagepath)),
          await MultipartFile.fromFileSync(BasicData.buspanimagepath,
              filename: getfilename(BasicData.buspanimagepath)),
          if(!BasicData.gstimagepath.isEmpty){
            await MultipartFile.fromFileSync(BasicData.gstimagepath,
                filename: getfilename(BasicData.gstimagepath)),
          },
          await MultipartFile.fromFileSync(BasicData.proofaddimagepath,
              filename: getfilename(BasicData.proofaddimagepath)),
          if(!BasicData.rentalagreementimagepath.isEmpty){
            await MultipartFile.fromFileSync(BasicData.rentalagreementimagepath,
                filename: getfilename(BasicData.rentalagreementimagepath)),
          },
          await MultipartFile.fromFileSync(BasicData.cancelchequeimagepath,
              filename: getfilename(BasicData.cancelchequeimagepath)),
        ]
      });

      final response = await apiClient.dioClient?.post(
          NetworkConstants.networkUrl.completeForm(),
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

        comres = CompleteForm.fromJson(jsonDecode(dto.data!));
        if (comres?.status ?? false) {
          CustomLoader.customloaderbuilder.hideLoader();

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppReceived(
                      context: context,
                    )),
          );
        } else {
          CustomLoader.customloaderbuilder.hideLoader();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(comres?.message ?? 'something went wrong')));
        }
      }
    } catch (e) {
      CustomLoader.customloaderbuilder.hideLoader();

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
