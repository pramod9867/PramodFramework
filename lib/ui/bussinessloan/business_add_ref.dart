import 'dart:convert';

import 'package:dhanvarsha/bloc/business_blocs/addreferencebloc.dart';
import 'package:dhanvarsha/bloc/business_blocs/fetchblbloc.dart';
import 'package:dhanvarsha/bloc/customerboardingbloc.dart';
import 'package:dhanvarsha/bloc/plfetchbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/addreferencesdto.dart';
import 'package:dhanvarsha/model/request/addreferencesdto_new.dart';
import 'package:dhanvarsha/model/request/customer_onboarding.dart';
import 'package:dhanvarsha/model/request/referencdto.dart';
import 'package:dhanvarsha/model/response/businessflowcommondto.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/loanreward/refrence_form/reference_form.dart';
import 'package:dhanvarsha/ui/loanreward/repaymentdatails.dart';
import 'package:dhanvarsha/ui/loantype/widget.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessAddRef extends StatefulWidget {
  final flag;
  const BusinessAddRef({Key? key, this.flag = ""}) : super(key: key);

  @override
  _AddRefrenceState createState() => _AddRefrenceState();
}

class _AddRefrenceState extends State<BusinessAddRef>
    implements AppLoadingMultiple {
  List<GlobalKey<RefrenceFormState>> form = [];
  // late PLFetchBloc plFetchBloc;
  late CustomerBoardingBloc boardingBloc;
  bool isValidateForm = true;
  List<ReferenceDTO> listOfReferences = [];
  List<AddReferencesDTO>? listOfReferesblDTO = [];
  AddReferenceBloc? addReferenceBloc;

  BLFetchBloc? blFetchBloc;
  void initState() {
    // TODO: implement initState
    super.initState();

    blFetchBloc = BlocProvider.getBloc<BLFetchBloc>();
    // plFetchBloc = BlocProvider.getBloc<PLFetchBloc>();
    boardingBloc = CustomerBoardingBloc();

    addReferenceBloc = AddReferenceBloc(this);

    if (blFetchBloc!.fetchBLResponseDTO?.refrences != null &&
        blFetchBloc!.fetchBLResponseDTO?.refrences!.length != 0) {
      List<ReferenceDTO>? refDto = blFetchBloc!.fetchBLResponseDTO?.refrences;

      for (int i = 0; i < refDto!.length; i++) {
        final GlobalKey<RefrenceFormState> _key = GlobalKey();
        form.add(_key);

        // _key.currentState!.fullNameController.text=refDto[i].contactName!;
      }
    } else {
      print("INTO THE ELSE ADD REFERENCES");
      for (int i = 0; i < 2; i++) {
        final GlobalKey<RefrenceFormState> _key = GlobalKey();
        form.add(_key);

        // _key.currentState!.fullNameController.text=refDto[i].contactName!;
      }
    }

    // print(plFetchBloc.onBoardingDTO!.referenceDetails![0].mobno);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      isheaderShown: true,
      type: false,
      title: "",
      isStepShown: true,
      isBackDialogRequired: true,
      stepArray: widget.flag == "" ? const [7, 7] : const [8, 8],
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _getTitleCompoenentNEW(),
              Container(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  // color: AppColors.newBg,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: form.length,
                            itemBuilder: (context, index) {
                              return blFetchBloc!.fetchBLResponseDTO.refrences!
                                              .length -
                                          1 >=
                                      index
                                  ? RefrenceForm(
                                      index: index,
                                      key: form[index],
                                      initialName: blFetchBloc!
                                              .fetchBLResponseDTO
                                              .refrences![index]
                                              .contactName ??
                                          "",
                                      emailId: blFetchBloc!.fetchBLResponseDTO
                                              .refrences![index].emailID ??
                                          "",
                                      mobileNumber: blFetchBloc!
                                              .fetchBLResponseDTO
                                              .refrences![index]
                                              .mobno ??
                                          "",
                                      id: blFetchBloc!
                                              .fetchBLResponseDTO
                                              .refrences![index]
                                              .relationShipTypeCdRelationType ??
                                          0,
                                      deletItem: () {
                                        for (int i = 0; i < form.length; i++) {
                                          if (i == index) {
                                            form.removeAt(i);
                                          }
                                        }
                                        setState(() {
                                          form = form;
                                        });
                                        // form.removeAt(index);
                                      },
                                    )
                                  : RefrenceForm(
                                      key: form[index],
                                      initialName: "",
                                      emailId: "",
                                      mobileNumber: "",
                                      id: 0,
                                      index: index,
                                      deletItem: () {
                                        for (int i = 0; i < form.length; i++) {
                                          if (i == index) {
                                            form.removeAt(i);
                                          }
                                        }
                                        setState(() {
                                          form = form;
                                        });
                                      },
                                    );
                            }),
                      ),
                      GestureDetector(
                        onTap: () {
                          _addRefForms();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Add References",
                            style: CustomTextStyles.boldMediumRedFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              form.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: CustomButton(
                        onButtonPressed: () async {
                          listOfReferesblDTO = [];
                          listOfReferences = [];
                          bool isAddtoArray = true;

                          for (int i = 0; i < form.length; i++) {
                            isValidateForm =
                                true & form[i].currentState!.onSubmitPressed();

                            ReferenceDTO referenceDTO = ReferenceDTO();
                            referenceDTO.contactName =
                                form[i].currentState!.fullNameController.text;
                            referenceDTO.emailID =
                                form[i].currentState!.emailIdController.text;
                            referenceDTO.mobno = form[i]
                                .currentState!
                                .mobileNumberController
                                .text;
                            referenceDTO.relationShipTypeCdRelationType =
                                form[i].currentState!.favouriteFoodModel.value;

                            isAddtoArray = CustomerOnBoarding.MobileNumber !=
                                    form[i]
                                        .currentState!
                                        .mobileNumberController
                                        .text &&
                                isAddtoArray;

                            listOfReferences.add(referenceDTO);
                          }

                          if (isValidateForm) {
                            for (int i = 0; i < listOfReferences.length; i++) {
                              AddReferencesDTO dto = AddReferencesDTO();

                              dto.refBlId =
                                  blFetchBloc!.fetchBLResponseDTO.refBlId;
                              dto.id = i + 1;
                              dto.mobileNumber = listOfReferences[i].mobno;
                              dto.fullName = listOfReferences[i].contactName;
                              dto.emailId = listOfReferences[i].emailID;
                              dto.relationShipWithCustomer = listOfReferences[i]
                                  .relationShipTypeCdRelationType;

                              listOfReferesblDTO!.add(dto);
                            }

                            bool isDuplicateNumber = false;
                            for (int i = 0;
                                i < listOfReferesblDTO!.length;
                                i++) {
                              for (int j = 0;
                                  j < listOfReferesblDTO!.length;
                                  j++) {
                                if (listOfReferesblDTO![i].mobileNumber ==
                                        listOfReferesblDTO![j].mobileNumber &&
                                    i != j) {
                                  isDuplicateNumber = true;
                                }
                              }
                            }

                            if (!isAddtoArray) {
                              SuccessfulResponse.showScaffoldMessage(
                                  "Mobile number should not be same as customer number",
                                  context);
                              return;
                            }

                            if (isDuplicateNumber) {
                              SuccessfulResponse.showScaffoldMessage(
                                  "References should not have same mobile number",
                                  context);
                              return;
                            }

                            if (form.length < 2) {
                              SuccessfulResponse.showScaffoldMessage(
                                  "Please add atleast two references", context);
                              return;
                            }
                            if (isValidateForm && isAddtoArray) {
                              addReferences();
                            }
                          }
                        },
                        title: "SUBMIT APPLICATION",
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      context: context,
    );
  }

  addReferences() async {
    AddReferencesDTONEW addReferencesDTONEW = AddReferencesDTONEW();
    addReferencesDTONEW.refBlId = blFetchBloc!.fetchBLResponseDTO.refBlId;
    addReferencesDTONEW.refrences = listOfReferesblDTO;

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await addReferencesDTONEW.toEncodedJson())
    });

    addReferenceBloc!.addReferences(formData);
  }

  _addRefForms() {
    final GlobalKey<RefrenceFormState> _key = GlobalKey();
    form.add(_key);
    setState(() {
      form = form;
    });
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
              "Add References",
              style: CustomTextStyles.boldSubtitleLargeFonts,
            ),
          ],
        ),
      ),
    );
  }

  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int index) {
    if (index == 1) {
      BusinessCommonDTO commonDTO =
          BusinessCommonDTO.fromJson(jsonDecode(dto.data!));
      if (commonDTO.status!) {
        createLoanId();
      } else {
        SuccessfulResponse.showScaffoldMessage(commonDTO.message!, context);
      }
    } else if (index == 2) {
      Map<String, dynamic> json = jsonDecode(dto.data!);
      if (json['status']) {
        SuccessfulResponse.showScaffoldMessage(json['message'], context);
        DialogUtils.successfulappdialog(context);
      } else {
        SuccessfulResponse.showScaffoldMessage(json['message'], context);
      }
    }
  }

  createLoanId() async {
    Map<String, dynamic> map = {"Id": blFetchBloc!.fetchBLResponseDTO!.refBlId};

    String encodedmap = jsonEncode(map);
    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(encodedmap),
    });
    addReferenceBloc!.createLoanId(formData);
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
