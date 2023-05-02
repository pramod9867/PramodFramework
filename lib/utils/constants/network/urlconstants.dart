class UrlConstants {
  //mgenius = https://mgenius.in/Dhanvarsha/
  //uar = https://cpuat.dfltd.in/Dhanvarsha/
  //prod= https://chanelpartnerandroid.dhanvarsha.co/DhanVarsha/

  // static String typeOfBuild="";
  static String baseurl = "https://cpuat.dfltd.in/Dhanvarsha/";

  //common for all
  static String pinConfiguration = "Service/PincodeConfiguration";
  static String panOcr = "CommonService/CommonPanOCR";
  static String aadhaarOcr = "CommonService/AadharOCR";
  static String getMasterGeneralData = "Service/GetMasterAndTemplateData";
  // CommonService/FaceMatching
  static String facerecognition = "CommonService/AadharFaceMatching";
  static String getMasterData = "Service/GetMasterData";
  static String getCountryDetails = "Service/GetCountryDetails";
  static String getStateDetails = "Service/GetStateDetails";
  static String getDistrictDetails = "Service/GetDistrictDetails";
  static String getTalukaDetails = "/Service/GetTalukaDetails";

  // PL Services
  static String customerOnBoarding = "Service/PLOnBoarding_v1";
  static String fetchPLDetails = "Service/FetchPlDetails";
  static String clientVerify = "Service/ClientVerify_New_v1";
  static String verifyOTP = "Service/ClientVerifyOTP_New";
  static String getEmployerDetails = "/Service/SearchCompanyMaster";
  static String getPrequalLoanOffer = '/Service/GetPostPrequalResult';
  static String getApprovalOffer = '/Service/OfferAcceptedStatus_New_v1';
  static String CreateLoanApplication = '/Service/CreateLoanApplication_v1';
  static String updateLoanType = '/Service/UpdateLoanType_v1';
  static String loginDsa = "/Service/DsaLogin_v1";
  static String validateDsaOTP = '/Service/ValidateDsaOTP';
  static String getDashboardData = '/Service/DashboardApiService_v1';
  static String ListOfLoanApplicationService =
      '/Service/ListOfLoanApplicationService';
  static String blPLApplicationService = '/Service/BLPLListOfApplications_v1';
  static String getPrequalRequestNew = '/Service/GetPostPrequalResult_New_v1';
  static String updatePLPanDetails = '/Service/UpdatePLPanDetails_v1';
  static String getAllProductDetails = '/Service/GetAllProductDetails';
  static String createClientInitiate = "/Service/InitiateClient_v1";

  //BL Services
  static String addBusinessDetails =
      "/BLService/CustomerBasicBusinessDetails_v1";
  static String addBasicDetailsDocuments = '/BLService/BasicDetailsDocuments';
  static String addPropertyDetails = "/BLService/PropertyDetails";
  static String addAdditionalDetails = "/BLService/AdditionalDetails";
  static String getBLOffer = "/BLService/GetBLPostPrequalResult_New_v1";
  static String offerAcceptedStatusBL = "/BLService/OfferAcceptedStatus_v1";
  static String addBankStatements = "/BLService/UploadBankStatementRequest_v1";
  static String uploadBusinessProof = "/BLService/BusinessProof";
  static String uploadResidentialProof = "/BLService/ResidentialAddress";
  static String uploadBusinessDuartionDocs = "/BLService/BusinessDuration";
  static String uploadIncomeTaxReturnDocs = '/BLService/IncomeTaxReturn';
  static String addReferencesDataData = "/BLService/AddReferenceData";
  static String getBusinessGstDetails = '/BLService/GetGSTDetails';
  static String fetchBLDetails = '/BLService/FetchBlDetails_New';
  static String addCoApplicantDetails = "/BLService/AddUpdateBLCoApplicants";
  static String addBusinessPanDetails = '/BLService/PanDetails_v1';
  static String addIncorporationDoc = "/BLService/Incorporation";
  static String addBusinessAadhaarDetails = "/BLService/AadharDetails";
  static String pushBusinessDetailsToServer = "/BLService/BusinessDetails_v1";
  static String createBusinessLoanId = "/BLService/CreateBLLoanApplication_v1";
  static String getGstnDetails = "/BLService/GetGSTSearchBasis";
  static String createClientInitiateBL = "/BLService/InitiateClient_v1";
  static String addRejectRason = "/BLService/InitiateClient_v1";

  //common api for bl pl gl

  static String getPostalCodeDetails = "/Service/GetPincodeData";
  //app api's
  static String getAppVersion = 'Service/VersionDetails';

  //GL Details

  static String addGlDetails = "/GLService/UpdateGoldKarat";
  static String getNearestBranchDetails = "/GLService/GetnearestBranchDetails";
  static String bookGLAppointment="/GLService/BookBranchAppointment";
  static String uploadAddressProof="/GLService/UploadAddressProof";
  static String uploadBusinessProofGL="/GLService/UploadBusineeProof";
}
