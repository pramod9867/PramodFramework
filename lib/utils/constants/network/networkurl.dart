import 'package:dhanvarsha/utils/constants/network/urlconstants.dart';

class NetWorkUrl {
  NetWorkUrl();
  String getBaseUrl() {
    return UrlConstants.baseurl;
  }

  String getPinCodeNumber() {
    return UrlConstants.pinConfiguration;
  }

  String getOcrUrl() {
    return UrlConstants.panOcr;
  }

  String getAadharOcrDetails() {
    return UrlConstants.aadhaarOcr;
  }

  String getCustomerOnBoarding() {
    return UrlConstants.customerOnBoarding;
  }

  String createLoan() {
    return UrlConstants.CreateLoanApplication;
  }

  String createClientInitiate(){
    return UrlConstants.createClientInitiate;
  }

  String createBLClientInitiate(){
    return UrlConstants.createClientInitiateBL;
  }

  String getPrequalRequest() {
    return UrlConstants.getPrequalLoanOffer;
  }

  String getPrequalRequestNew(){
    return UrlConstants.getPrequalRequestNew;
  }

  String getApprovalUrl() {
    return UrlConstants.getApprovalOffer;
  }

  String offerAcceptedStatusBL(){
    return UrlConstants.offerAcceptedStatusBL;
  }

  String getMasterData() {
    return UrlConstants.getMasterGeneralData;
  }

  String fetchPLDetails() {
    return UrlConstants.fetchPLDetails;
  }

  String getFaceRecognition() {
    return UrlConstants.facerecognition;
  }

  String clientVerify() {
    return UrlConstants.clientVerify;
  }




  String getGstnDetails(){
    return UrlConstants.getGstnDetails;
  }

  String addReason(){
    return UrlConstants.addRejectRason;
  }

  String updateLoanType() {
    return UrlConstants.updateLoanType;
  }

  String getDashboardData() {
    return UrlConstants.getDashboardData;
  }

  String getListofLoanApplication() {
    return UrlConstants.ListOfLoanApplicationService;
  }

  String loginDsa() {
    return UrlConstants.loginDsa;
  }

  String getAllProductDetails(){
    return UrlConstants.getAllProductDetails;
  }


  String getAppVersion(){
    return UrlConstants.getAppVersion;
  }

  String verifyDsaOtp() {
    return UrlConstants.validateDsaOTP;
  }

  String verifyOTP() {
    return UrlConstants.verifyOTP;
  }

  String getCountryDetails() {
    return UrlConstants.getCountryDetails;
  }

  String getTalukaDetails() {
    return UrlConstants.getTalukaDetails;
  }

  String getStateDetails() {
    return UrlConstants.getStateDetails;
  }

  String getDistricDetails() {
    return UrlConstants.getDistrictDetails;
  }

  String getEmployerName() {
    return UrlConstants.getEmployerDetails;
  }

  String getBLPLApplicationService() {
    return UrlConstants.blPLApplicationService;
  }

  //BL URL

  String addBusinessBasicDetails() {
    return UrlConstants.addBusinessDetails;
  }


  String uploadBLProof(){
    return UrlConstants.uploadBusinessProof;
  }



  String uploadResidentialProof(){
    return UrlConstants.uploadResidentialProof;
  }

  String getPostalCodeDetails(){
    return UrlConstants.getPostalCodeDetails;
  }


  String addIncorporationDocs(){
    return UrlConstants.addIncorporationDoc;
  }

  String uploadBusinessDurationDocs(){
    return UrlConstants.uploadBusinessDuartionDocs;
  }


  String uploadIncomeTaxReturnDocs(){
    return UrlConstants.uploadIncomeTaxReturnDocs;
  }

  String addBankStatements(){
    return UrlConstants.addBankStatements;
  }

  String addBusinessBasicDocuments() {
    return UrlConstants.addBasicDetailsDocuments;
  }

  String addPropertyDetails() {
    return UrlConstants.addPropertyDetails;
  }

  String fetchBLDetails(){
    return UrlConstants.fetchBLDetails;
  }


  String getBLOffer(){
    return UrlConstants.getBLOffer;
  }

  String addAdditionalDetails() {
    return UrlConstants.addAdditionalDetails;
  }

  String addReferencesData(){
    return UrlConstants.addReferencesDataData;
  }

  String createLoanApplication(){
    return UrlConstants.createBusinessLoanId;
  }

  String getBusinessGSTDetails(){
    return UrlConstants.getBusinessGstDetails;
  }


  String addBusinessDetailsToServer(){
    return UrlConstants.pushBusinessDetailsToServer;
  }


  String addCoApplicantDetails(){
    return UrlConstants.addCoApplicantDetails;
  }

  String addBusinessPanDetails(){
    return UrlConstants.addBusinessPanDetails;
  }

  String addPLPanDetails(){
    return UrlConstants.updatePLPanDetails;
  }

  String addBusinessAadhaarDetails(){
    return UrlConstants.addBusinessAadhaarDetails;
  }

  //GL URL

  String addGLDetails(){
    return UrlConstants.addGlDetails;
  }

  String getNearestBranchDetails(){
    return UrlConstants.getNearestBranchDetails;
  }


  String bookGLAppointment(){
    return UrlConstants.bookGLAppointment;
  }

  String uploadAddressProof(){
    return UrlConstants.uploadAddressProof;
  }

  String uploadAddressProofGL(){
    return UrlConstants.uploadBusinessProofGL;
  }
}



