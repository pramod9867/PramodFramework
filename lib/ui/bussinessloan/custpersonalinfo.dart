import 'dart:convert';

import 'package:dhanvarsha/Inheritedwidgets/Inheritedstep.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/uploadimagebloc.dart';
import 'package:dhanvarsha/bloc/panbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/basicdetailsupload.dart';
import 'package:dhanvarsha/model/request/faceregonitiondto.dart';
import 'package:dhanvarsha/model/request/panuploaddto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/blpancompletedetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/businessaadhardetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/propertydetails.dart';
import 'package:dhanvarsha/ui/loantype/aadhardetails.dart';
import 'package:dhanvarsha/ui/loantype/employeedetails.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/buttonstyles.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  final String flag;

  const CustomerProfile({Key? key, this.flag = "proprietor"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile>
    implements AppLoading {
  GlobalKey<CustomImageBuilderState> _profilePickey = GlobalKey();
  GlobalKey<CustomImageBuilderState> _panPickey = GlobalKey();
  PanDetailsBloc? panDetailsBloc;
  BLFetchBloc? blFetchBloc;

  late UploadImageBloc? uploadImageBloc;
  @override
  void initState() {
    // TODO: implement initState
    panDetailsBloc = PanDetailsBloc();
    BlocProvider.setBloc<PanDetailsBloc>(panDetailsBloc);

    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    uploadImageBloc = UploadImageBloc(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        type: false,
        stepArray: [2, 4],
        isBackDialogRequired: true,
        isStepShown: true,
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: SizeConfig.screenHeight -
                  45 -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _getTitleCompoenentNEW(),
                      // ValueListenableBuilder(
                      //     valueListenable:
                      //         panDetailsBloc!.connectionStatusOfPanDetails,
                      //     builder: (_, status, Widget? child) {
                      //       return _getHoirzontalImageUpload();
                      //     }),
                      _getHoirzontalImageUploadProfile(),
                    ],
                  ),
                  _getContinueButton()
                ],
              ),
            )),
        context: context);
  }

  Widget _getTitleCompoenent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Personal info.",
            style: CustomTextStyles.boldSubtitleLargeFonts,
          ),
        ],
      ),
    );
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Customer Details",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
            GestureDetector(
              onTap: () {
                DialogUtils.UploadInsturctionDialog(context);
              },
              child: Image.asset(
                DhanvarshaImages.question,
                height: 25,
                width: 25,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getHoirzontalImageUpload() {
    return Container(
      child: Column(
        children: [
          CustomImageBuilder(
            isAadhaarORPan: false,
            key: _panPickey,
            isPan: true,
            image: DhanvarshaImages.npan,
            value: "Upload Customer's PAN",
            description: AppConstants.aadharUploadDescription,
            no: (panDetailsBloc?.panResponseDTO?.panNumber != null &&
                    panDetailsBloc?.panResponseDTO?.panNumber != "")
                ? "PAN :- ${panDetailsBloc?.panResponseDTO?.panNumber}"
                : "",
            initialImage: blFetchBloc!.fetchBLResponseDTO.customersPanImage!,
            firstImageUploaded: () {
              uploadPanToServer();
              if (_profilePickey.currentState!.imagepicked.value != "" &&
                  _panPickey.currentState!.imagepicked.value != "" &&
                  !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                      .isAbsolute &&
                  !Uri.parse(_profilePickey.currentState!.imagepicked.value)
                      .isAbsolute) {
                faceMatch();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _getHoirzontalImageUploadProfile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CustomImageBuilder(
            isAadhaarORPan: false,
            isProfilePic: true,
            isPan: true,
            key: _profilePickey,
            subtitle: "Photo Added",
            subtitleImage: DhanvarshaImages.userphoto,
            image: DhanvarshaImages.usernewpicprofile,
            value: "Upload Customer's Photo",
            subtitleString: "TAKE A PHOTO",
            initialImage: blFetchBloc!.fetchBLResponseDTO.customersPhotoImage!,
            description: AppConstants.aadharUploadDescription,
            firstImageUploaded: () {
              faceMatch();
            },
          ),
        ],
      ),
    );
  }

  uploadPanToServer() {
    PanUpload panUpload = PanUpload(
        fileName: _panPickey.currentState!.fileName,
        id: blFetchBloc!.fetchBLResponseDTO.refBlId,
        type: "BL");

    panDetailsBloc!.getPanDetails(
        jsonEncode(panUpload!.toJson()),
        _panPickey.currentState!.imagepicked!.value!,
        _panPickey.currentState!.fileName,
        context);
  }

  faceMatch() async {
    FaceRegonizationDTO recognitionDTO = FaceRegonizationDTO();

    List<String> fileName = [_profilePickey.currentState!.fileName];
    recognitionDTO.fileNames = fileName;
    recognitionDTO.id = blFetchBloc!.fetchBLResponseDTO.refBlId;
    recognitionDTO.type = "BL";

    List<MultipartFile> files = [];

    files.add(MultipartFile.fromFileSync(
        _profilePickey.currentState!.imagepicked.value,
        filename: _profilePickey.currentState!.fileName));

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          recognitionDTO.toEncodedJson()),
      "Myfiles": files,
    });

    panDetailsBloc?.getFaceDetails(formData);
  }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          CustomButton(
            onButtonPressed: () {
              // if (_panPickey.currentState?.imagepicked.value == null ||
              //     _panPickey.currentState?.imagepicked.value == "") {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text("Please Upload Pan Card")));
              //   return;
              // }

              if (_profilePickey.currentState?.imagepicked.value == null ||
                  _profilePickey.currentState?.imagepicked.value == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please Upload Profile Pic")));
                return;
              }

              if (panDetailsBloc != null) {
                if (panDetailsBloc!.faceRegonizeResponseDTO != null) {
                  if (panDetailsBloc!.faceRegonizeResponseDTO!.matchScore! >=
                      30.0) {
                    addDocumentToServer();
                  } else {
                    SuccessfulResponse.showScaffoldMessage(
                        "Face not recognized with adhaar front image please reupload image",
                        context);
                  }
                } else {
                  addDocumentToServer();
                }
              } else {
                addDocumentToServer();
              }
            },
            title: "CONTINUE",
            boxDecoration: ButtonStyles.redButtonWithCircularBorder,
          ),
        ],
      ),
    );
  }

  addDocumentToServer() async {
    BasicDetailsUpload basicDetailsUpload = BasicDetailsUpload();

    basicDetailsUpload.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    basicDetailsUpload.customersPanImage = "";
    basicDetailsUpload.customersPhotoImage =
        _profilePickey.currentState!.fileName;
    basicDetailsUpload.customersAadharFrontImage = "";
    basicDetailsUpload.customersAadharBackImage = "";
    print(basicDetailsUpload.toEncodedJson());

    List<MultipartFile> appFiles = [];

    if (_profilePickey.currentState!.imagepicked != "" &&
        !Uri.parse(_profilePickey.currentState!.imagepicked.value).isAbsolute) {
      appFiles.add(MultipartFile.fromFileSync(
          _profilePickey.currentState!.imagepicked.value,
          filename: _profilePickey.currentState!.fileName));
    }
    String data = await basicDetailsUpload.toEncodedJson();

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(data),
      "Myfiles": appFiles
    });
    ;
    uploadImageBloc!.uploadKycImages(formData);
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    BusinessCommonDTO commonDTO =
        BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
    if (commonDTO.status!) {
      SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PropertyDetails(
            flag: widget.flag,
          ),
        ),
      );
    } else {
      SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
    }
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    CustomLoaderBuilder.builder.showLoader();
  }
}
