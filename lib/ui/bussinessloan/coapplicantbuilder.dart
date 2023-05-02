import 'dart:convert';

import 'package:dhanvarsha/model/CoApplicantModel.dart';
import 'package:flutter/cupertino.dart';

class CoApplicantBuilder {
  static CoApplicantBuilder builder = CoApplicantBuilder();
  ValueNotifier<List<CoApplicantModel>> notifier = ValueNotifier([]);

  addUser(CoApplicantModel name) {
    int count = 0;
    if (name.name != null && name.name!.length > 0) {
      count++;
    }

    if (name.middleName != null && name.middleName!.length > 0) {
      count++;
    }

    if (name.lastName != null && name.lastName!.length > 0) {
      count++;
    }

    if (name.dobOfUser != null && name.dobOfUser!.length > 0) {
      count++;
    }

    if (name.emailId != null && name.emailId!.length > 0) {
      count++;
    }
    if (name.mobileNumber != null && name.mobileNumber!.length > 0) {
      count++;
    }
    if (name.address != null && name.address!.length > 0) {
      count++;
    }
    if (name.coApplicantPan != null && name.coApplicantPan!.length > 0) {
      count++;
    }
    if (name.customerAadhaar != null && name.customerAadhaar!.length > 0) {
      count++;
    }
    if (name.proofOfAddress != null && name!.proofOfAddress!.length > 0) {
      count++;
    }

    if (name.houseNo != null && name!.proofOfAddress!.length > 0) {
      count++;
    }

    if (name.coApplicantPanNumber != null &&
        name!.coApplicantPanNumber!.length > 0) {
      count++;
    }

    if (name.coApplicantAadhaarNumber != null &&
        name!.coApplicantAadhaarNumber!.length > 0) {
      count++;
    }

    if (name.stateDTO != null && name!.stateDTO!.length > 0) {
      count++;
    }

    if (name.cityDTO != null && name!.cityDTO!.length > 0) {
      count++;
    }

    if (name.countryDTO != null && name!.countryDTO!.length > 0) {
      count++;
    }

    if (name.genderId != null && name!.genderId != 0) {
      count++;
    }

    if (name.percentageShareHolding != null &&
        name!.percentageShareHolding != "") {
      count++;
    }

    name.count = count;
    // notifier.value.add(name);

    notifier.value.add(name);

    notifier.notifyListeners();
  }

  updateModel(CoApplicantModel name, int index) {
    print("Update Claled");
    int count = 0;
    if (name.name != null && name.name!.length > 0) {
      count++;
    }

    if (name.middleName != null && name.middleName!.length > 0) {
      count++;
    }

    if (name.lastName != null && name.lastName!.length > 0) {
      count++;
    }

    if (name.dobOfUser != null && name.dobOfUser!.length > 0) {
      count++;
    }

    if (name.emailId != null && name.emailId!.length > 0) {
      count++;
    }
    if (name.mobileNumber != null && name.mobileNumber!.length > 0) {
      count++;
    }
    if (name.address != null && name.address!.length > 0) {
      count++;
    }
    if (name.coApplicantPan != null && name.coApplicantPan!.length > 0) {
      count++;
    }
    if (name.customerAadhaar != null && name.customerAadhaar!.length > 0) {
      count++;
    }
    if (name.proofOfAddress != null && name!.proofOfAddress!.length > 0) {
      count++;
    }

    if (name.houseNo != null && name!.proofOfAddress!.length > 0) {
      count++;
    }

    if (name.coApplicantPanNumber != null &&
        name!.coApplicantPanNumber!.length > 0) {
      count++;
    }

    if (name.coApplicantAadhaarNumber != null &&
        name!.coApplicantAadhaarNumber!.length > 0) {
      count++;
    }

    if (name.stateDTO != null && name!.stateDTO!.length > 0) {
      count++;
    }

    if (name.cityDTO != null && name!.cityDTO!.length > 0) {
      count++;
    }

    if (name.countryDTO != null && name!.countryDTO!.length > 0) {
      count++;
    }

    if (name.genderId != null && name!.genderId != 0) {
      count++;
    }

    if (name.percentageShareHolding != null &&
        name!.percentageShareHolding != "") {
      count++;
    }

    name.count = count;

    List<CoApplicantModel> newList = [];

    for (int i = 0; i < notifier.value.length; i++) {
      if (i == index) {
        print("updating");
        notifier.value.elementAt(i).name = name.name != null ? name.name : "";

        notifier.value.elementAt(i).middleName =
            name.middleName != null ? name.middleName : "";
        notifier.value.elementAt(i).percentageShareHolding =
            name.percentageShareHolding != null
                ? name.percentageShareHolding
                : "";

        notifier.value.elementAt(i).lastName =
            name.lastName != null ? name.lastName : "";

        notifier.value.elementAt(i).mobileNumber =
            name.mobileNumber != null ? name.mobileNumber : "";
        notifier.value.elementAt(i).emailId =
            name.emailId != null ? name.emailId : "";
        notifier.value.elementAt(i).address =
            name.address != null ? name.address : "";

        notifier.value.elementAt(i).coApplicantPanNumber =
            name.coApplicantPanNumber != null ? name.coApplicantPanNumber : "";
        notifier.value.elementAt(i).coApplicantAadhaarNumber =
            name.coApplicantAadhaarNumber != null
                ? name.coApplicantAadhaarNumber
                : "";
        notifier.value.elementAt(i).houseNo =
            name.houseNo != null ? name.houseNo : "";
        notifier.value.elementAt(i).genderId =
            name.genderId != null ? name.genderId : 0;

        notifier.value.elementAt(i).stateDTO =
            name.genderId != null ? name.stateDTO : [];

        notifier.value.elementAt(i).countryDTO =
            name.genderId != null ? name.countryDTO : [];

        notifier.value.elementAt(i).cityDTO =
            name.genderId != null ? name.cityDTO : [];

        notifier.value.elementAt(i).customerAadhaarBack =
            name.customerAadhaarBack != null ? name.customerAadhaarBack : "";
        notifier.value.elementAt(i).customerAadhaar =
            name.customerAadhaar != null ? name.customerAadhaar : "";

        notifier.value.elementAt(i).pinCode =
        name.pinCode != null ? name.pinCode : "";

        notifier.value.elementAt(i).coApplicantPan =
            name.coApplicantPan != null ? name.coApplicantPan : "";
        notifier.value.elementAt(i).proofOfAddress =
            name.proofOfAddress != null ? name.proofOfAddress : "";

        notifier.value.elementAt(i).isCurrentAddresSameAsAadhar =
            name.isCurrentAddresSameAsAadhar != null
                ? name.isCurrentAddresSameAsAadhar
                : true;

        notifier.value.elementAt(i).count = name.count != null ? count : count;

        newList.add(notifier.value.elementAt(i));
      } else {
        newList.add(notifier.value.elementAt(i));
      }
    }

    notifier.value = newList;
    notifier.notifyListeners();
  }
}
