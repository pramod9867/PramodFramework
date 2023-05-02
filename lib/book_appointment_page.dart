// import 'dart:convert';
//
// import 'package:dhanvarshab2c/bloc/getNearestBranchbloc.dart';
// import 'package:dhanvarshab2c/constants/AppConstants.dart';
// import 'package:dhanvarshab2c/constants/colors.dart';
// import 'package:dhanvarshab2c/constants/dhanvarshaimages.dart';
// import 'package:dhanvarshab2c/interfaces/app_interface.dart';
// import 'package:dhanvarshab2c/model/messages/request_messages.dart';
// import 'package:dhanvarshab2c/model/request/BookAppointmentRequest.dart';
// import 'package:dhanvarshab2c/model/request/GetNearestBranchDto.dart';
// import 'package:dhanvarshab2c/model/response/NearestBranchResponse.dart';
// import 'package:dhanvarshab2c/model/response/engine_register_res.dart';
// import 'package:dhanvarshab2c/model/successfulresponsedto.dart';
// import 'package:dhanvarshab2c/model/update_gold_weight_and_karat_req_dto.dart';
// import 'package:dhanvarshab2c/ui/BaseView.dart';
// import 'package:dhanvarshab2c/ui/goldloan/salaried/book_appointment_model.dart';
// import 'package:dhanvarshab2c/ui/goldloan/salaried/branchDataNameId.dart';
// import 'package:dhanvarshab2c/ui/goldloan/salaried/gl_appointment_schedule.dart';
// import 'package:dhanvarshab2c/ui/goldloan/salaried/gl_branch_options_page.dart';
// import 'package:dhanvarshab2c/utils/boxdecoration.dart';
// import 'package:dhanvarshab2c/utils/buttonstyles.dart';
// import 'package:dhanvarshab2c/utils/customtextstyles.dart';
// import 'package:dhanvarshab2c/utils/customvalidator.dart';
// import 'package:dhanvarshab2c/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
// import 'package:dhanvarshab2c/utils/size_config.dart';
// import 'package:dhanvarshab2c/widgets/Buttons/custombutton.dart';
// import 'package:dhanvarshab2c/widgets/custom_loader/custom_loader_builder.dart';
// import 'package:dhanvarshab2c/widgets/datepicker/customdatepicker.dart';
// import 'package:dhanvarshab2c/widgets/timepicker/customtimepicker.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
//
// class BookAppointmentPage extends StatefulWidget {
//   final int? refId;
//
//   const BookAppointmentPage({Key? key, required this.refId}) : super(key: key);
//
//   @override
//   _BookAppointmentPageState createState() => _BookAppointmentPageState();
// }
//
// late GetNearestBranchBloc _getNearestBranchBloc;
//
// class _BookAppointmentPageState extends State<BookAppointmentPage>
//     implements AppLoadingMultiple {
//
//   String latitude="",longitude="";
//   Location currentLocation = Location();
//   int _timeSlotSelected = 0;
//   var isValidatePressed = false, _selectedDayIndex = -1;
//   late List<AppointmentDay> _appointmentDays;
//   TextEditingController dateController = new TextEditingController();
//   TextEditingController timeController = new TextEditingController();
//
//   TextEditingController branchNameController = new TextEditingController();
//   TextEditingController branchDistanceController = new TextEditingController();
//   NearestBranchDetails? responseBranch;
//   String? branchName;
//   String? branchAddress;
//   String? branchId;
//
//   //TextEditingController branchName=new TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     //getLocation();
//
//     _appointmentDays = getAppointmentDays();
//     _getNearestBranchBloc = GetNearestBranchBloc(this);
//     getNearestBranch("19.124225","72.848765");
//   }
//
//   void _navigateAndDisplaySelection(BuildContext context) async {
//     // Navigator.push returns a Future that completes after calling
//     // Navigator.pop on the Selection Screen.
//     final result = await Navigator.push(
//       context,
//       // Create the SelectionScreen in the next step.
//       MaterialPageRoute(
//           builder: (context) => BranchOptionPage(
//             nearestBranchDetails: responseBranch,
//           )),
//     );
//
//     branchNameController.text = result['branchName'];
//     branchDistanceController.text = result['distance'] + " KM";
//     branchId = result['branchId'];
//     branchAddress = result['branchAddress'];
//     branchNameController.notifyListeners();
//
// //    ScaffoldMessenger.of(context)
// //      ..removeCurrentSnackBar()
// //      ..showSnackBar(SnackBar(content: Text('$result')));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseView(
//         context: context,
//         type: false,
//         isStepShown: false,
//         body: Container(
//           color: AppColors.gra3,
//           height: (SizeConfig.screenHeight) - 70,
//           child: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                       child: Text(
//                         "Book your appointment",
//                         style: CustomTextStyles.boldLargeFonts,
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         "Deposit your Gold at your nearest Dhanvarsha Branch",
//                         style: CustomTextStyles.regularMediumGreyFont1,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         print(jsonEncode(responseBranch));
//                         print(responseBranch!.branchDetailsData!.length);
//                         if (responseBranch != null) {
//                           _navigateAndDisplaySelection(context);
//
// //                          final result= await Navigator.push(
// //                            context,
// //                            MaterialPageRoute(
// //                              builder: (context) => BranchOptionPage(
// //                                nearestBranchDetails: responseBranch,
// //                              ),
// //                            ),
// //                          );
//
//                         }
//                       },
//                       child: Container(
//                         // width: double.infinity,
//                         decoration:
//                         BoxDecorationStyles.outTextFieldBoxDecoration,
//                         padding: EdgeInsets.all(9),
//                         margin:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   dhanvarshaImages.glVistBranch,
//                                   fit: BoxFit.contain,
//                                   // height: 50,
//                                   // width: 50,
//                                 ),
//                                 ValueListenableBuilder(
//                                     valueListenable: branchNameController,
//                                     builder: (_, status, __) {
//                                       return Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 25),
//                                         // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               branchNameController.text +
//                                                   "\n " +
//                                                   branchDistanceController.text,
//                                               style:
//                                               CustomTextStyles.boldMedium1Font,
//                                             ),
//                                             Row(
//                                               children: [],
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                               ],
//                             ),
//                             Container(
//                               child: Image.asset(
//                                 dhanvarshaImages.drop6,
//                                 fit: BoxFit.contain,
//                                 // height: 50,
//                                 // width: 50,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin:
//                       EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       child: CustomDatePicker(
//                         controller: dateController,
//                         isValidateUser: isValidatePressed,
//                         selectedDate: dateController.text,
//                         title: "Select Preferred Date",
//                         isTitleVisible: true,
//                       ),
//                     ),
//                     Container(
//                       margin:
//                       EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       child: CustomTimePicker(
//                         controller: timeController,
//                         isValidateUser: isValidatePressed,
//                         selectedDate: timeController.text,
//                         title: "Select Preferred Time",
//                         calIcon: dhanvarshaImages.drop6,
//                         isTitleVisible: true,
//                       ),
//                     ),
// //                    Container(
// //                        alignment: Alignment.centerLeft,
// //                        margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
// //                        child: Row(
// //                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                          crossAxisAlignment: CrossAxisAlignment.center,
// //                          children: [
// //                            Text(
// //                              "Select Day",
// //                              style: CustomTextStyles.regularMediumFont,
// //                            ),
// //                            Image.asset(
// //                              dhanvarshaImages.left,
// //                              height: 15,
// //                              width: 15,
// //                            )
// //                          ],
// //                        )),
// //                    _dayHrLv(),
// //                    Container(
// //                        alignment: Alignment.centerLeft,
// //                        margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
// //                        child: Text(
// //                          "Select Time",
// //                          style: CustomTextStyles.regularMediumFont,
// //                        )),
// //                    Row(
// //                      children: [
// //                        Expanded(
// //                          child: GestureDetector(
// //                            onTap: () {
// //                              setState(() {
// //                                if (_timeSlotSelected == 1) {
// //                                  _timeSlotSelected = 0;
// //                                } else {
// //                                  _timeSlotSelected = 1;
// //                                }
// //                              });
// //                            },
// //                            child: Container(
// //                              decoration: _timeSlotSelected == 1
// //                                  ? BoxDecorationStyles.outButtonOfBoxRed
// //                                  : BoxDecorationStyles
// //                                      .outTextFieldBoxDecoration,
// //                              padding: EdgeInsets.all(15),
// //                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
// //                              child: Column(
// //                                children: [
// //                                  Text(
// //                                    AppConstants.morning,
// //                                    style: _timeSlotSelected == 1
// //                                        ? CustomTextStyles.boldMediumFont
// //                                            .copyWith(color: AppColors.white)
// //                                        : CustomTextStyles.boldMediumFont
// //                                            .copyWith(color: AppColors.black),
// //                                  ),
// //                                  Text(
// //                                    AppConstants.morningTime,
// //                                    style: _timeSlotSelected == 1
// //                                        ? CustomTextStyles.regularMediumFont
// //                                            .copyWith(color: AppColors.white)
// //                                        : CustomTextStyles.regularMediumFont
// //                                            .copyWith(
// //                                                color: AppColors.lightGrey3),
// //                                  )
// //                                ],
// //                              ),
// //                            ),
// //                          ),
// //                        ),
// //                        Expanded(
// //                          child: GestureDetector(
// //                            onTap: () {
// //                              setState(() {
// //                                if (_timeSlotSelected == 2) {
// //                                  _timeSlotSelected = 0;
// //                                } else {
// //                                  _timeSlotSelected = 2;
// //                                }
// //                              });
// //                            },
// //                            child: Container(
// //                              decoration: _timeSlotSelected == 2
// //                                  ? BoxDecorationStyles.outButtonOfBoxRed
// //                                  : BoxDecorationStyles
// //                                      .outTextFieldBoxDecoration,
// //                              padding: EdgeInsets.all(15),
// //                              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
// //                              child: Column(
// //                                children: [
// //                                  Text(
// //                                    AppConstants.evening,
// //                                    style: _timeSlotSelected == 2
// //                                        ? CustomTextStyles.boldMediumFont
// //                                            .copyWith(color: AppColors.white)
// //                                        : CustomTextStyles.boldMediumFont
// //                                            .copyWith(color: AppColors.black),
// //                                  ),
// //                                  Text(
// //                                    AppConstants.eveningTime,
// //                                    style: _timeSlotSelected == 2
// //                                        ? CustomTextStyles.regularMediumFont
// //                                            .copyWith(color: AppColors.white)
// //                                        : CustomTextStyles.regularMediumFont
// //                                            .copyWith(
// //                                                color: AppColors.lightGrey3),
// //                                  )
// //                                ],
// //                              ),
// //                            ),
// //                          ),
// //                        ),
// //                      ],
// //                    ),
//                   ],
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                   child: CustomButton(
//                       widthScale: 1,
//                       boxDecoration: ButtonStyles.redButtonWithCircularBorder,
//                       title: AppConstants.submit_caps,
//                       onButtonPressed: () async {
//                         print(branchNameController.text);
//
//                         setState(() {
//                           isValidatePressed = true;
//                         });
//
//                         if (CustomValidator(dateController.value.text)
//                             .validate(Validation.isEmpty) &&
//                             CustomValidator(timeController.value.text)
//                                 .validate(Validation.isEmpty)) {
//                           getBookAppointment();
//                         }
//                       }),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget _dayHrLv() {
//     return SizedBox(
//         height: 100,
//         child: ListView.builder(
//           itemCount: _appointmentDays.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, int index) {
//             return _itemDay(_appointmentDays, index);
//           },
//         ));
//   }
//
//   Widget _itemDay(List<AppointmentDay> appointmentDays, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (_selectedDayIndex == index) {
//             _selectedDayIndex = -1;
//           } else {
//             _selectedDayIndex = index;
//           }
//         });
//       },
//       child: Container(
//         alignment: Alignment.center,
//         width: (SizeConfig.screenWidth - 15) / 2.5,
//         decoration: _selectedDayIndex == index
//             ? BoxDecorationStyles.outButtonOfBoxRed
//             : BoxDecorationStyles.outTextFieldBoxDecoration,
//         padding: EdgeInsets.all(15),
//         margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               appointmentDays[index].day ?? "",
//               style: _selectedDayIndex == index
//                   ? CustomTextStyles.boldMediumFont
//                   .copyWith(color: AppColors.white)
//                   : CustomTextStyles.boldMediumFont
//                   .copyWith(color: AppColors.black),
//             ),
//             Text(
//               appointmentDays[index].date ?? "",
//               style: _timeSlotSelected == 2
//                   ? CustomTextStyles.regularMediumFont
//                   .copyWith(color: AppColors.white)
//                   : CustomTextStyles.regularMediumFont
//                   .copyWith(color: AppColors.lightGrey3),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void hideProgress() {
//     CustomLoaderBuilder.builder.hideLoader();
//   }
//
//   @override
//   void isEngineSuccessful(Engine_register_res dto) {
//     // TODO: implement isEngineSuccessful
//   }
//
//   @override
//   void isSuccessful(SuccessfulResponseDTO dto, int index) {
//     if (index == 0) {
//       responseBranch = NearestBranchDetails.fromJson(jsonDecode(dto.data!));
//       branchNameController.text =
//       responseBranch!.branchDetailsData!.elementAt(0).branchName!;
//
//       branchDistanceController.text =
//           responseBranch!.branchDetailsData!.elementAt(0).Distance! + " KMs";
//
//       branchId = responseBranch!.branchDetailsData!.elementAt(0).id!;
//
//       branchAddress =
//           responseBranch!.branchDetailsData!.elementAt(0).branchAddress;
//     } else {
//       UpdateGoldWeightAndKaratResDto res =
//       UpdateGoldWeightAndKaratResDto.fromJson(jsonDecode(dto.data!));
//
//       SuccessfulResponse.showScaffoldMessage(res.message!, context);
//
//       if (res.status!) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => GlAppointmentSchedule(
//                 appointtime:timeController.text,
//                 appointmentDate:dateController.text,
//                 distance: branchDistanceController.text,
//                 refId: widget.refId,
//                 address: branchAddress),
//           ),
//         );
//       } else {
//         SuccessfulResponse.showScaffoldMessage(res.message!, context);
//       }
//     }
//   }
//
//   @override
//   void showError() {
//     SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
//   }
//
//   @override
//   void showProgress() {
//     CustomLoaderBuilder.builder.showLoader();
//   }
//
//   Future<void> getNearestBranch(String latitude,String longitude) async {
//     GetNearestBranchRequest getnearestbranchdto = new GetNearestBranchRequest();
//
//     //getnearestbranchdto.Latitude = "19.1750512";
//     getnearestbranchdto.Latitude = latitude;
//     //getnearestbranchdto.Longitude = "72.8558798";
//     getnearestbranchdto.Longitude = longitude;
//
//     FormData formData = FormData.fromMap({
//       'json': await EncryptionUtils.getEncryptedText(
//           getnearestbranchdto.toEncodedJson()),
//     });
//     // FormData formData= FormData.fromMap({
//     //       'json': await (
//     //           req.toEncodedJson()),});
//     print(formData.fields);
//     _getNearestBranchBloc!.GetNearestBranch(formData);
//   }
//
//   Future<void> getBookAppointment() async {
//     BookAppintmentRequest bookappointmentdto = new BookAppintmentRequest();
//
//     bookappointmentdto.BranchId = branchId;
//     bookappointmentdto.AppointmentDate = dateController.text;
//     bookappointmentdto.AppointmentTime = timeController.text;
//     bookappointmentdto.RefGLId = widget.refId;
//
//
//     FormData formData = FormData.fromMap({
//       'json': await EncryptionUtils.getEncryptedText(
//           bookappointmentdto.toEncodedJson()),
//     });
//     // FormData formData= FormData.fromMap({
//     //       'json': await (
//     //           req.toEncodedJson()),});
//     print(bookappointmentdto);
//     _getNearestBranchBloc!.BookAppointment(formData);
//   }
//
//   void getLocation() async {
//     var location = await currentLocation.getLocation();
//     latitude = location.latitude.toString();
//     longitude = location.longitude.toString();
//
//     getNearestBranch(latitude,longitude);
//
//
//     print(latitude);
//     print(longitude);
//   }
// }
//
// List<AppointmentDay> getAppointmentDays() {
//   List<AppointmentDay> appointmentDays = [];
//   var todayDate = new DateTime.now();
//   var tomorrowDate = new DateTime.now();
//   var formatter = new DateFormat('dd-MMM-yyyy');
//   String formattedtodayDate = formatter.format(todayDate);
//   String formattedtodayTomorrowDate = formatter.format(todayDate);
//   print(formattedtodayDate);
//
//   var i = 0;
//   while (appointmentDays.length <= 6) {
//     var date = getNextDate(i);
//     print("Weekday=${date.weekday}");
//
//     /*if (!(date.weekday == 6 || date.weekday == 7))
//     {*/
//
//     if (appointmentDays.length == 0) {
//       appointmentDays
//           .add(AppointmentDay(getFormattedDate(getNextDate(i)), "Today"));
//     } else if (appointmentDays.length == 1) {
//       appointmentDays
//           .add(AppointmentDay(getFormattedDate(getNextDate(i)), "Tomorrow"));
//     } else {
//       appointmentDays.add(AppointmentDay(
//           getFormattedDate(getNextDate(i)), getFormattedDay(getNextDate(i))));
//     }
//     /* }*/
//
//     print(
//         "Formatted Appointment :date:${appointmentDays[i].date}, day:${appointmentDays[i].day}");
//     i++;
//   }
//   return appointmentDays;
// }
//
// DateTime getNextDate(int day) {
//   var todayDate = new DateTime.now();
//   var nextDate =
//   new DateTime(todayDate.year, todayDate.month, todayDate.day + day);
//   return nextDate;
// }
//
// String getFormattedDate(DateTime dateTime) {
//   var formatter = new DateFormat('dd MMM');
//   String formattedDate;
//   return formattedDate = formatter.format(dateTime);
// }
//
// String getFormattedDay(DateTime datetime) {
//   var formatter = new DateFormat('EEEE');
//   String formattedDay;
//   return formattedDay = formatter.format(datetime);
// }
//
//
