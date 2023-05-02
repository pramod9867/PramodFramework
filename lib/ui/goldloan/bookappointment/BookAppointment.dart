import 'dart:convert';

import 'package:dhanvarsha/bloc/gold_loan_bloc/glfetchbloc.dart';
import 'package:dhanvarsha/bloc/gold_loan_bloc/nearestbranchbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/model/request/getbranchdetailsrequestdto.dart';
import 'package:dhanvarsha/model/request/glbookappointrequestdto.dart';
import 'package:dhanvarsha/model/response/golddetailrepsonse.dart';
import 'package:dhanvarsha/model/response/listofnearestbranchdto.dart';
import 'package:dhanvarsha/model/response/mastdto/mast_base_dto.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailslist.dart';
import 'package:dhanvarsha/model/response/nearestbranchdetailsresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/goldloan/animator/AppAnimation.dart';
import 'package:dhanvarsha/ui/goldloan/appointmentsumm/AppointmentSumm.dart';
import 'package:dhanvarsha/ui/goldloan/branchoption/NearestBranchResponse.dart';
import 'package:dhanvarsha/ui/goldloan/branchoption/gl_branch_options_page.dart';
import 'package:dhanvarsha/ui/goldloan/kycdocuments/KycDocuments.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/utils/commautils/common_age_validator.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/gold_slots/gold_loan_slots.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/datepicker/customdatepicker.dart';
import 'package:dhanvarsha/widgets/dropdown/customdropdown_master.dart';
import 'package:dhanvarsha/widgets/timepicker/customtimepicker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  final Position? position;
  const BookAppointment({Key? key, this.position}) : super(key: key);
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment>
    implements AppLoadingMultiple {
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();

  NearestBrachDetailsResponseDTO? nearestBrachDetailsResponseDTO;

  GLFetchBloc? glFetchBloc;

  var isValidateUser = false;
  MasterDataDTO _genderDropdownModel = MasterDataDTO("Select Gender", 0);
  List<DropdownMenuItem<MasterDataDTO>> _buildFavouriteFoodModelDropdown(
      List favouriteFoodModelList,
      List<DropdownMenuItem<MasterDataDTO>> dropdownMenuItems,
      MasterDataDTO model,
      {String initialType = "Preffered time"}) {
    dropdownMenuItems.add(DropdownMenuItem(
      value: MasterDataDTO(initialType, 0),
      child: Text(
        initialType!,
        style: CustomTextStyles.regularMediumFontGothamTextFieldGreyCalendar,
      ),
    ));
    for (MasterDataDTO favouriteFoodModel in favouriteFoodModelList) {
      dropdownMenuItems.add(DropdownMenuItem(
        value: favouriteFoodModel,
        child: Text(favouriteFoodModel.name!,
            style: model.value == favouriteFoodModel.value
                ? CustomTextStyles.regularMediumFontGothamTextField
                : CustomTextStyles.boldMediumFontGotham),
      ));
    }
    return dropdownMenuItems;
  }

  late List<DropdownMenuItem<MasterDataDTO>> genderList;
  late List<DropdownMenuItem<MasterDataDTO>> _genderDropdownlist;

  bool isSaturday = false;

  NearestBranchBloc? nearestBranchBloc;
  late MasterBloc? masterBloc;
  @override
  void initState() {
    print("LONGITUDE IS ->");
    print(widget.position!.longitude);
    print("Lattitude IS ->");
    print(widget.position!.latitude);
    isSaturday = DateTime.now().weekday == 6;
    masterBloc = BlocProvider.getBloc<MasterBloc>();
    genderList = [];
    _genderDropdownlist = _buildFavouriteFoodModelDropdown(
        isSaturday ? GoldLoanSlots.goldSlotsSaturday : GoldLoanSlots.goldSlots,
        genderList,
        _genderDropdownModel);
    _genderDropdownModel = genderList.elementAt(0).value!;
    nearestBranchBloc = NearestBranchBloc(this);
    glFetchBloc = BlocProvider.getBloc<GLFetchBloc>();
    BlocProvider.setBloc<NearestBranchBloc>(nearestBranchBloc);

    getAllBranchDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: SingleChildScrollView(
        child: _getNewBLBody(),
      ),
      context: context,
      isBackDialogRequired: true,
      isheaderShown: true,
      isBackPressed: true,
      type: false,
      isBurgerVisble: true,
    );
  }

  Widget _getNewBLBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      // color: AppColors.blue,
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight -
              MediaQuery.of(context).viewInsets.bottom -
              MediaQuery.of(context).viewInsets.top -
              45 -
              50),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book Your Appointment",
                  style: CustomTextStyles.boldVeryLargerFont2Gotham,
                ),
                ValueListenableBuilder(
                    builder: (BuildContext context,
                        List<NearestBrachDetailsResponseDTO> value,
                        Widget? child) {
                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BranchOptionPage(
                                nearestBranchDetails: value,
                              ),
                            ),
                          );

                          nearestBrachDetailsResponseDTO =
                              NearestBrachDetailsResponseDTO.fromJson(
                                  jsonDecode(result));

                          print(nearestBrachDetailsResponseDTO!.branchName);

                          nearestBranchBloc!.nearestBranchList
                              .notifyListeners();

                          // nearestBrachDetailsResponseDTO!.longitude=result.longitude;
                          // nearestBrachDetailsResponseDTO!.latitude= result.latitude;

                          print("Result Is ----------------->");
                          print(result);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                DhanvarshaImages.vb,
                                height: 45,
                                width: 45,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nearestBrachDetailsResponseDTO != null &&
                                            value.length > 0
                                        ? nearestBrachDetailsResponseDTO!
                                            .branchName!
                                        : "",
                                    style:
                                        CustomTextStyles.regularMediumDarkFont,
                                  ),
                                  value.length > 0
                                      ? RichText(
                                          text: TextSpan(
                                            text: nearestBrachDetailsResponseDTO !=
                                                    null
                                                ? CommonAgeValidator.KmsToMeterst(
                                                        nearestBrachDetailsResponseDTO!
                                                            .distance
                                                            .toString()) +
                                                    " KM "
                                                : "",
                                            style: CustomTextStyles
                                                .regularMediumDarkFont,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Open till 7PM',
                                                  style: TextStyle(
                                                      color: AppColors.green)),
                                            ],
                                          ),
                                        )
                                      : Text(""),
                                ],
                              ),
                              Image.asset(
                                DhanvarshaImages.drop6,
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    valueListenable: nearestBranchBloc!.nearestBranchList!),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDatePicker(
                    controller: dateController,
                    isValidateUser: isValidateUser,
                    selectedDate: dateController.text,
                    title: "Preffered date",
                    isCurrentDateVisible: true,
                    isTitleVisible: true,
                    onTimeUpdate: () {
                      print(DateFormat('dd/MM/yyyy')
                              .parse(dateController.text)
                              .weekday ==
                          6);
                      print(DateFormat('dd/MM/yyyy')
                          .parse(dateController.text)
                          .weekday);
                      print(dateController.text);

                      if (DateFormat('dd/MM/yyyy')
                              .parse(dateController.text)
                              .weekday ==
                          6) {
                        genderList = [];
                        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
                            GoldLoanSlots.goldSlotsSaturday,
                            genderList,
                            _genderDropdownModel);
                        _genderDropdownModel = genderList.elementAt(0).value!;

                        print("Build Model Called");
                        setState(() {
                          isSaturday = true;
                        });
                      } else {
                        print("Build Model Not Called");
                        genderList = [];
                        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
                            GoldLoanSlots.goldSlots,
                            genderList,
                            _genderDropdownModel);
                        _genderDropdownModel = genderList.elementAt(0).value!;
                        setState(() {
                          isSaturday = false;
                        });
                      }
                    },
                    isSpecificDateRequired: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: CustomDropdownMaster<MasterDataDTO>(
                    dropdownMenuItemList: _genderDropdownlist,
                    onChanged: onChangeFavouriteFoodModelDropdown,
                    value: _genderDropdownModel,
                    isEnabled: true,
                    title: "Preffered time",
                    isTitleVisible: true,
                    errorText: "Please select preffered time",
                    isValidate: isValidateUser,
                  ),
                ),
                //
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                //   child: CustomTimePicker(
                //     controller: timeController,
                //     isValidateUser: isValidateUser,
                //     selectedDate: timeController.text,
                //     title: "Preferred Time",
                //     calIcon: DhanvarshaImages.drop6,
                //     isTitleVisible: true,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onButtonPressed: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       //builder: (context) => CommonScreen(),
                  //       //builder: (context) => KycDocuments(),
                  //       builder: (context) => BranchOptionPage(),
                  //     ));
                  setState(() {
                    isValidateUser = true;
                  });

                  // CustomValidator(pincodeEditingController
                  //     .value.text)
                  //     .validate(Validation.isEmpty) &&
                  //     _buisinessDropdownmodel.value != 0
                  // print("Time checking");
                  //
                  // print(getTimeFromString(timeController.text));
                  // print(checkRestaurentStatus("10:00 AM", "5:00 PM",timeController.text));
                  // if (checkRestaurentStatus("10:00AM", "5:00PM",timeController.text)) {
                  //   return;
                  // }
                  if (CustomValidator(dateController.value.text)
                          .validate(Validation.isEmpty) &&
                      _genderDropdownModel.value != 0) {
                    bookAppointment();
                  }
                },
                title: "CONTINUE",
                boxDecoration: ButtonStyles.redButtonWithCircularBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool getTimeFromString(String time) {
    DateTime dateTime = DateFormat("h:mm a").parse(time);

    DateTime startTimeDate = DateFormat("h:mm a").parse("10:00 AM");
    ;

    DateTime endTime = DateFormat("h:mm a").parse("05:00 PM");
    return dateTime.isBefore(startTimeDate) && dateTime.isAfter(endTime);

    // return timeOfDay.;
  }

  getAllBranchDetails() async {
    GetNearestBranchDetailsRequestDTO getNearestBranchDetailsRequestDTO =
        GetNearestBranchDetailsRequestDTO();
    getNearestBranchDetailsRequestDTO.latitude =
        widget.position!.latitude.toString();
    getNearestBranchDetailsRequestDTO.longitude =
        widget.position!.longitude.toString();

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          getNearestBranchDetailsRequestDTO.toEncodedJson()),
    });

    nearestBranchBloc!.getNearestBranchDetails(formData);
  }

  onChangeFavouriteFoodModelDropdown(
    MasterDataDTO? favouriteFoodModel,
  ) {
    if (favouriteFoodModel!.value != 0) {
      print("Value Updated");
      setState(() {
        _genderDropdownModel = favouriteFoodModel!;
        genderList = [];
        _genderDropdownlist = _buildFavouriteFoodModelDropdown(
            isSaturday
                ? GoldLoanSlots.goldSlotsSaturday
                : GoldLoanSlots.goldSlots,
            genderList,
            _genderDropdownModel);
      });
    }
  }

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  bookAppointment() async {
    GLBookAppointmentRequestDTO glBookAppointmentRequestDTO =
        GLBookAppointmentRequestDTO();

    glBookAppointmentRequestDTO.refGLId =
        glFetchBloc!.fetchGLResponseDTO!.refGLId;
    glBookAppointmentRequestDTO.appointmentDate = dateController.text;
    glBookAppointmentRequestDTO.appointmentTime =_genderDropdownModel.name;

    glBookAppointmentRequestDTO.branchId = nearestBrachDetailsResponseDTO!.id;

    FormData formData = FormData.fromMap({
      'json': await EncryptionUtils.getEncryptedText(
          glBookAppointmentRequestDTO.toEncodedJson()),
    });

    nearestBranchBloc!.bookAppointment(formData);
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto, int type) {
    if (type == 0) {
      nearestBranchBloc!.nearestBranchList.value =
          ListOfNearestBranchResponseDTO.from(jsonDecode(dto.data!))
              .nearestBranchDetailsDTO!;

      if (nearestBranchBloc!.nearestBranchList.value.length > 0) {
        nearestBrachDetailsResponseDTO =
            nearestBranchBloc!.nearestBranchList.value.elementAt(0);
      }

      nearestBranchBloc!.nearestBranchList.notifyListeners();
      print("Nearest Branch Response");
      // print(jsonEncode(nearestBranchBloc!.nearestBranchList.value));
    } else if (type == 1) {
      GoldDetailsResponse goldDetailsResponse =
          GoldDetailsResponse.fromJson(jsonDecode(dto.data!));

      print("Successful Response ------------>");
      print(jsonEncode(dto.data!));

      if (goldDetailsResponse.status!) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AppAnimation(
                gifPath: "assets/images/glappreceived.gif",
                navigation: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AppointmentSumm(
                        branchAddress:
                            nearestBrachDetailsResponseDTO!.addressLine1,
                        branchName: nearestBrachDetailsResponseDTO!.branchName,
                        day: dateController.text,
                        time:_genderDropdownModel.name,
                      ),
                    ),
                  );
                })));

        glFetchBloc!.selectedBranch = nearestBrachDetailsResponseDTO!;
        SuccessfulResponse.showScaffoldMessage(
            goldDetailsResponse.message!, context);
      } else {
        SuccessfulResponse.showScaffoldMessage(
            goldDetailsResponse.message!, context);
      }
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
