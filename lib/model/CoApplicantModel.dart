import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';

class CoApplicantModel {
  String? name;
  String? middleName;
  String? lastName;
  String? Id ;
  String? mobileNumber;
  String? houseNo;
  String? addressProofPath;
  String? percentageShareHolding;


  CoApplicantModel(
      {this.name,
      this.middleName,
      this.lastName,
      this.Id,
      this.mobileNumber,
      this.houseNo,
      this.addressProofPath,
      this.percentageShareHolding,
      this.genderId,
      this.emailId,
      this.address,
      this.coApplicantPan,
      this.customerAadhaar,
      this.customerAadhaarBack,
      this.proofOfAddress,
      this.coApplicantAadhaarNumber,
      this.coApplicantPanNumber,
      this.countryDTO,
      this.stateDTO,
      this.cityDTO,
      this.dobOfUser,
      this.count,
      this.isCurrentAddresSameAsAadhar,
        this.pinCode
      });

  int? genderId;
  String? emailId;
  String? address;
  String? coApplicantPan;
  String? customerAadhaar;
  String? customerAadhaarBack;
  String? proofOfAddress;
  String? coApplicantAadhaarNumber;
  String? coApplicantPanNumber;
  List<MasterDataDTO>? countryDTO;
  List<MasterDataDTO>? stateDTO;
  List<MasterDataDTO>? cityDTO;
  String? dobOfUser;
  int? count;
  String? pinCode;

  bool? isCurrentAddresSameAsAadhar;


}
