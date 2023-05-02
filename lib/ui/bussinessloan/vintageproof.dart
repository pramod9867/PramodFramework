import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/vintagebloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_bl_onboarding.dart';
import 'package:dhanvarsha/model/request/businessvintageproofdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/business_add_ref.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/bussinessloan/incorporationdoc.dart';
import 'package:dhanvarsha/ui/bussinessloan/itrdocs.dart';
import 'package:dhanvarsha/ui/bussinessloan/repaymentdetails.dart';
import 'package:dhanvarsha/ui/loanreward/addressproof.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload_bl.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/widgets/Buttons/CustomBtnBlackborder.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class VintageProof extends StatefulWidget {
  final String flag;

  const VintageProof({Key? key, this.flag = "proprietor"}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VintageProofState();
}

class _VintageProofState extends State<VintageProof> implements AppLoading {
  bool? value = false;
  bool isSwitchPressed = false;
  TextEditingController pdfPassword = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();

  BLFetchBloc? blFetchBloc;

  // GlobalKey<CustomImageBuilderState> _continuityProofImage = GlobalKey();
  GlobalKey<CustomImageBuilderState> _vintageProofImage = GlobalKey();

  late VintageProofBloc? vintageProofBloc;

  @override
  void initState() {
    vintageProofBloc = VintageProofBloc(this);
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: widget.flag == "" ? const [5, 7] : const [6, 8],
        type: false,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight -
                    45 -
                    MediaQuery.of(context).viewInsets.top -
                    MediaQuery.of(context).viewInsets.bottom -
                    30),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          _getTitleCompoenentNEW(),
                          (!CustomerBLOnboarding.isGstActive &&
                                  !(CustomerBLOnboarding.noOfYearsRegistration >
                                      3))
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.symmetric(vertical: 5),
                                    //   child: Image.asset(
                                    //     DhanvarshaImages.i,
                                    //     height: 15,
                                    //     width: 15,
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "If GST Certificate is already added under Business Vintage Proof, please skip this step.",
                                          style:
                                              CustomTextStyles.boldMediumFont,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                          SizedBox(
                            height: 20,
                          ),
                          CustomImageBuilder(
                            initialImage: blFetchBloc!.fetchBLResponseDTO
                                    .businessVintageProofDocumentImage ??
                                "",
                            no: "",
                            // subtitleImage: DhanvarshaImages.userphoto,
                            subtitleImage: DhanvarshaImages.uploadnew,
                            key: _vintageProofImage,
                            image: DhanvarshaImages.poa,
                            value: "Upload Business Vintage Proof",
                            subtitleString: "Upload",
                            description: AppConstants.aadharUploadDescription,
                            firstImageUploaded: () {
                              // uploadPanToServer();
                            },
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // CustomImageBuilder(
                          //   initialImage: blFetchBloc!
                          //           .fetchBLResponseDTO.businessCommunityProofDocumentImage ??
                          //       "",
                          //   no: "",
                          //   // subtitleImage: DhanvarshaImages.userphoto,
                          //   subtitleImage: DhanvarshaImages.uploadnew,
                          //   key: _continuityProofImage,
                          //   image: DhanvarshaImages.poa,
                          //   value: "Upload Business Continuity Proof",
                          //   subtitleString: "Upload",
                          //   description: AppConstants.aadharUploadDescription,
                          //   firstImageUploaded: () {
                          //     // uploadPanToServer();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    (!CustomerBLOnboarding.isGstActive &&
                            !(CustomerBLOnboarding.noOfYearsRegistration > 3))
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (CustomerBLOnboarding.softOfferAmount >
                                  500000) {
                                if (widget.flag == "") {
                                  // DialogUtils.showBusinessLoanPopup(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ITRDocument(
                                        flag: widget.flag,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ITRDocument(
                                        flag: widget.flag,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BusinessAddRef(
                                      flag: widget.flag,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 25),
                              alignment: Alignment.center,
                              child: Text(
                                "SKIP",
                                style: CustomTextStyles.buttonTextStyleRed,
                              ),
                            ),
                          ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: CustomBtnBlackborder(
                        onButtonPressed: () {
                          print("BUSINESS VINTAGE PROOF PRESSED");
                          if (_vintageProofImage
                                  .currentState!.imagepicked.value ==
                              "") {
                            SuccessfulResponse.showScaffoldMessage(
                                "Please upload vintage proof", context);
                            return;
                          }
                          // if (_continuityProofImage
                          //         .currentState!.imagepicked.value ==
                          //     "") {
                          //   SuccessfulResponse.showScaffoldMessage(
                          //       "Please upload continuity proof", context);
                          //   return;
                          // }

                          uploadBusinessVintageProof();
                        },
                        title: "CONTINUE",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  Widget _getTitleCompoenent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Income Tax Return",
            style: CustomTextStyles.boldLargeFonts,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _getTitleCompoenentNEW() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Business Duration",
              style: CustomTextStyles.boldLargeFonts,
              textAlign: TextAlign.left,
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

  uploadBusinessVintageProof() async {
    BusinessVintageProofRequestDTO businessVintageProofRequestDTO =
        BusinessVintageProofRequestDTO();

    businessVintageProofRequestDTO.refBlId =
        blFetchBloc!.fetchBLResponseDTO.refBlId;
    businessVintageProofRequestDTO.businessCommunityProofDocumentImage = "";
    // _continuityProofImage.currentState!.fileName;
    businessVintageProofRequestDTO.businessVintageProofDocumentImage =
        _vintageProofImage.currentState!.fileName;

    List<MultipartFile> appFiles = [];

    if (_vintageProofImage.currentState!.imagepicked.value != "" &&
        !Uri.parse(_vintageProofImage.currentState!.imagepicked.value)
            .isAbsolute) {
      appFiles.add(
        MultipartFile.fromFileSync(
            _vintageProofImage.currentState!.imagepicked.value,
            filename: _vintageProofImage.currentState!.fileName),
      );
    }

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await businessVintageProofRequestDTO.toEncodedJson()),
      'MyFiles': appFiles
    });

    //
    // print("App Files Are");
    // print(appFiles);
    vintageProofBloc!.addVintageProof(formData);
  }

  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) {
    BusinessCommonDTO commonDTO =
        BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
    if (commonDTO.status!) {
      if (CustomerBLOnboarding.softOfferAmount > 500000) {
        if (widget.flag == "") {
          // DialogUtils.showBusinessLoanPopup(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ITRDocument(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ITRDocument(
                flag: widget.flag,
              ),
            ),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessAddRef(
              flag: widget.flag,
            ),
          ),
        );
      }
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
