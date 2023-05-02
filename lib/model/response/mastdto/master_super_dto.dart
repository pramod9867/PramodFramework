import 'dart:convert';

import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';

class MasterSuperDTO {
  List<MasterDataDTO>? companyType;
  List<MasterDataDTO>? empType;
  List<MasterDataDTO>? clientClassificationOptions;
  List<MasterDataDTO>? clientTypeOptions;
  List<MasterDataDTO>? documentTag;
  List<MasterDataDTO>? genderOptions;
  List<MasterDataDTO>? modeOfSalary;
  List<MasterDataDTO>? relationType;
  List<MasterDataDTO>? martialStatus;
  List<MasterDataDTO>? addressTypeOptions;
  List<MasterDataDTO>? natureofBusiness;
  List<MasterDataDTO>? havingCurrentBankAccount;
  List<MasterDataDTO>? coApplicantRelationShip;
  List<MasterDataDTO>? ownedAndCoownedPropertyAddress;
  List<MasterDataDTO>? businessFirmType;
  List<MasterDataDTO>? productId;
  List<MasterDataDTO>? goldKarat;
  List<MasterDataDTO>? timeSlots;

  MasterSuperDTO.fromJson(Map<String, dynamic> json) {
    relationType = json['Relationship Type'] as List != null
        ? (json['Relationship Type'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    clientClassificationOptions =
        json['clientClassificationOptions'] as List != null
            ? (json['clientClassificationOptions'] as List).map((i) {
                return MasterDataDTO.fromJson(i);
              }).toList()
            : [];

    clientTypeOptions = json['clientTypeOptions'] as List != null
        ? (json['clientTypeOptions'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    companyType = json['Company Type'] as List != null
        ? (json['Company Type'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    documentTag = json['Document tags'] as List != null
        ? (json['Document tags'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    empType = json['Employment Type'] as List != null
        ? (json['Employment Type'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];
    martialStatus = json['maritalStatusOptions'] as List != null
        ? (json['maritalStatusOptions'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];
    modeOfSalary = json['Mode Of Salary'] as List != null
        ? (json['Mode Of Salary'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    relationType = json['Relationship Type'] as List != null
        ? (json['Relationship Type'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    genderOptions = json['genderOptions'] as List != null
        ? (json['genderOptions'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    addressTypeOptions = json['AddressTypeOption'] as List != null
        ? (json['AddressTypeOption'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    natureofBusiness = json['NatureOfBusiness'] as List != null
        ? (json['NatureOfBusiness'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    havingCurrentBankAccount = json['HavingCurrentBankAc'] as List != null
        ? (json['HavingCurrentBankAc'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    coApplicantRelationShip = json['CoApplicantRelationship'] as List != null
        ? (json['CoApplicantRelationship'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    ownedAndCoownedPropertyAddress =
        json['OwnedandCoappownedPropertyFlag'] as List != null
            ? (json['OwnedandCoappownedPropertyFlag'] as List).map((i) {
                return MasterDataDTO.fromJson(i);
              }).toList()
            : [];

    businessFirmType = json['Business Firm Type'] as List != null
        ? (json['Business Firm Type'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    productId = json['LoanProductID'] as List != null
        ? (json['LoanProductID'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    goldKarat = json['GoldKarat'] as List != null
        ? (json['GoldKarat'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [];

    timeSlots = json['GoldKarat'] as List != null
        ? (json['GoldKarat'] as List).map((i) {
            return MasterDataDTO.fromJson(i);
          }).toList()
        : [MasterDataDTO("2-3", 1)];

    print("product id");
    print(jsonEncode(productId));

    print("Nature Of Business");
    print(jsonEncode(natureofBusiness));

    print("Having Current Bank Accounts");
    print(jsonEncode(havingCurrentBankAccount));

    print("Co-Applicant Relationship");
    print(jsonEncode(coApplicantRelationShip));

    print("Owned Property Flag");
    print(jsonEncode(ownedAndCoownedPropertyAddress));

    print("Busines Firm Type");
    print(jsonEncode(businessFirmType));
  }
}
