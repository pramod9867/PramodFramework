import 'dart:convert';
import 'dart:io';

import 'package:dhanvarsha/bloc/business_blocs/bankstatmentbloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/uploadbankstatement.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/bussinessloan/businesspandetails.dart';
import 'package:dhanvarsha/ui/loanreward/loanaccepted.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customtextstyles.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/imagebuilder/customimagebuilder.dart';
import 'package:dhanvarsha/utils/imagebuilder/multiple_file_upload.dart';
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

class BusinessBankStatement extends StatefulWidget {
  final String flag;

  const BusinessBankStatement({Key? key, this.flag = "proprietor"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BusinessBankStatementState();
}

class _BusinessBankStatementState extends State<BusinessBankStatement>
    implements AppLoading {
  bool value = false;
  bool isSwitchPressed = false;
  TextEditingController pdfPassword = TextEditingController();
  GlobalKey<CustomImageBuilderState> _key = GlobalKey();
  GlobalKey<MultipleFilerUploaderState> _fileUploadingKey = GlobalKey();
  BankStatementBloc? bankStatementBloc;

  BLFetchBloc? blFetchBloc;

  @override
  void initState() {
    // TODO: implement initState
    bankStatementBloc = BankStatementBloc(this);
    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        title: "",
        isStepShown: true,
        isBackDialogRequired: true,
        stepArray: widget.flag == "" ? const [2, 7] : const [2, 8],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitleCompoenent(),
                    SizedBox(
                      height: 10,
                    ),
                    _getBankStatement(),
                  ],
                ),
                // Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomBtnBlackborder(
                    onButtonPressed: () {
                      // if (widget.flag == "") {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BusinessPanDetails(
                      //         flag: widget.flag,
                      //       ),
                      //     ),
                      //   );
                      // } else {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BusinessPanDetails(flag: widget.flag),
                      //     ),
                      //   );
                      // }
                      if (_fileUploadingKey
                              .currentState!.imagepicked.value.length >
                          0) {
                        if (_fileUploadingKey.currentState!.isSwitchPressed) {
                          if (CustomValidator(_fileUploadingKey
                                  .currentState!.pdfPassword.text)
                              .validate(Validation.isEmpty)) {
                            addBankStatements();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please enter pdf password")));
                          }
                        } else {
                          addBankStatements();
                        }
                      } else {
                        SuccessfulResponse.showScaffoldMessage(
                            "Please upload bank statements", context);
                      }
                    },
                    title: "SUBMIT",
                  ),
                )
              ],
            ),
          ),
        ),
        context: context);
  }

  addBankStatements() async {
    List<String> bankStatementArray = [];
    List<String> bankPathArray = [];

    List<MultipartFile> appFiles = [];
    for (int i = 0;
        i < _fileUploadingKey.currentState!.imagepicked.value.length;
        i++) {
      String fileName;
      if (!Uri.parse(_fileUploadingKey.currentState!.imagepicked.value[i])
          .isAbsolute) {
        File file = new File(
            _fileUploadingKey.currentState!.imagepicked.value.elementAt(i));
        fileName = file.path.split('/').last;
      } else {
        fileName =
            _fileUploadingKey.currentState!.imagepicked.value.elementAt(i);
      }
      bankPathArray
          .add(_fileUploadingKey.currentState!.imagepicked.value.elementAt(i));

      if (!Uri.parse(
              _fileUploadingKey.currentState!.imagepicked.value.elementAt(i))
          .isAbsolute) {
        bankStatementArray.add(fileName);
      }
    }

    for (int i = 0; i < bankPathArray.length; i++) {
      if (!Uri.parse(bankPathArray[i]).isAbsolute) {
        appFiles.add(MultipartFile.fromFileSync(bankPathArray[i],
            filename: bankStatementArray[i]));
      }
    }

    print("App FIles Are");
    print(appFiles);
    print(bankStatementArray);

    UploadBankStatementDTO bankStatementDTO = UploadBankStatementDTO();
    bankStatementDTO.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    bankStatementDTO.bankStatements = bankStatementArray;
    bankStatementDTO.BankStatementPassword =
        _fileUploadingKey.currentState!.pdfPassword!.text != null
            ? _fileUploadingKey.currentState!.pdfPassword!.text
            : "";

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          bankStatementDTO.toEncodedJson()),
      "Myfiles": appFiles
    });

    bankStatementBloc!.addBankStatements(formData);
  }

  Widget _getBankStatement() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: MultipleFileUploader(
        isBankStatements: true,
        title: "Add Bank Statement",
        key: _fileUploadingKey,
        initialData: blFetchBloc!.fetchBLResponseDTO.bankStatements ?? [],
      ),
    );
  }

  // Widget _getOKKycDetails() {
  //   return Material(
  //     elevation: 0,
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       width: double.infinity,
  //
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10), color: AppColors.white),
  //       child: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 10),
  //           child: Container(
  //             margin: EdgeInsets.symmetric(vertical: 10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   "Verify Income Using NetBanking",
  //                   style: CustomTextStyles.boldLargeFonts,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 10),
  //                   child: Text(
  //                     "Send sms link to the customer to verify the income, Customers need to open link and log in using their net banking to verify income",
  //                     style: CustomTextStyles.regularMedium2GreyFont1,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 5),
  //                   child: Text(
  //                     "This process is 100% safe and secure",
  //                     style: CustomTextStyles.boldMediumFont,
  //                   ),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     DialogUtils.showKycDialog(context);
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.symmetric(vertical: 5),
  //                     child: Text(
  //                       "SHARE LINK",
  //                       style: CustomTextStyles.boldMediumRedFont,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )),
  //       // color: AppColors.white,
  //     ),
  //   );
  // }

  // Widget _getCardDetails() {
  //   return Material(
  //     elevation: 2,
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       width: double.infinity,
  //       height: SizeConfig.screenHeight * 0.16,
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10), color: AppColors.white),
  //       child: Container(
  //         margin: EdgeInsets.symmetric(horizontal: 10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   "Automatic Verification",
  //                   style: CustomTextStyles.boldLargeFonts,
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 5),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Verify by uploading bank \nstatement",
  //                         style: CustomTextStyles.regularMedium2GreyFont1,
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   FlutterSwitch(
  //                     width: 55,
  //                     height: 35,
  //                     activeColor: AppColors.buttonRed,
  //                     value: isSwitchPressed,
  //                     onToggle: (value) {
  //                       setState(() {
  //                         isSwitchPressed = value;
  //                       });
  //                     },
  //                   ),
  //                 ])
  //           ],
  //         ),
  //       ),
  //       // color: AppColors.white,
  //     ),
  //   );
  // }

  Widget _getTitleCompoenent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Bank Statement",
            style: CustomTextStyles.boldLargeFonts,
          ),
        ),
        // Text(
        //   "Upload Bank Statement From Janury from January 18, 2021 to February 18, 2021",
        //   style: CustomTextStyles.regularSmallGreyFont,
        // )
      ],
    );
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
      if (widget.flag == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessPanDetails(
              flag: widget.flag,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessPanDetails(flag: widget.flag),
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
