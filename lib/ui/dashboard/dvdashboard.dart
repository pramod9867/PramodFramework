import 'dart:convert';

import 'package:dhanvarsha/bloc/dashboardbloc.dart';
import 'package:dhanvarsha/bloc/masterbloc.dart';
import 'package:dhanvarsha/bloc/offerbloc.dart';
import 'package:dhanvarsha/constants/AppConstants.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/framework/local/sharedpref.dart';
import 'package:dhanvarsha/framework/network/typedef.dart';
import 'package:dhanvarsha/interfaces/app_interface.dart';
import 'package:dhanvarsha/master/customer_onboarding.dart';
import 'package:dhanvarsha/model/app_models/loan_model.dart';
import 'package:dhanvarsha/model/postofferdto.dart';
import 'package:dhanvarsha/model/request/dashboardrequest.dart';
import 'package:dhanvarsha/model/response/dashboardresponse.dart';
import 'package:dhanvarsha/model/response/dsaloginresponse.dart';
import 'package:dhanvarsha/model/successfulresponsedto.dart';
import 'package:dhanvarsha/navigatorservice/navigatorservice.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/calendar/dhanvarsha_calendar.dart';
import 'package:dhanvarsha/ui/customerdetails/customerdetails.dart';
import 'package:dhanvarsha/ui/customerdetails/pancommondetails.dart';
import 'package:dhanvarsha/ui/dashboard/application_details.dart';
import 'package:dhanvarsha/ui/dashboard/postoffer.dart';
import 'package:dhanvarsha/ui/loantype/selectloantype.dart';
import 'package:dhanvarsha/ui/messages/request_messages.dart';
import 'package:dhanvarsha/ui/profile/all_leads.dart';
import 'package:dhanvarsha/ui/profile/profilescreen.dart';
import 'package:dhanvarsha/utils/calculator.dart';
import 'package:dhanvarsha/utils/commautils/commatester.dart';
import 'package:dhanvarsha/utils/dateutils/dateutils.dart';
import 'package:dhanvarsha/utils/dialog/dialogutils.dart';
import 'package:dhanvarsha/utils/encryption/aes_pkcs5padding/encryptionutils.dart';
import 'package:dhanvarsha/utils/geo_locator/dhanvarsha_geo_locator.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/loanidcreator.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/custom_loader/custom_loader_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_builder.dart';
import 'package:dhanvarsha/widgets/dropdown_controller/menu_drop_down.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:super_tooltip/super_tooltip.dart';

class DVDashboard extends StatefulWidget {
  final BuildContext context;
  const DVDashboard({Key? key, required this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DVDashboardState();
}

class _DVDashboardState extends State<DVDashboard>
    with TickerProviderStateMixin
    implements AddRefLoading {
  late AnimationController controller;
  int num = 10;
  MenueBuilder? empTypBuilder;
  DashboardBloc? dashboardBloc;

  DSALoginResponseDTO? loginResponseDTO;

  // LoginDataBloc _loginDataBloc= BlocProvider.getBloc<LoginDataBloc>();

  String? newDate;
  String? endDateFormat;
  String? uiDate;
  MasterBloc? bloc;
  @override
  void initState() {
    dashboardBloc = DashboardBloc(this);

    BlocProvider.setBloc<DashboardBloc>(dashboardBloc);

    empTypBuilder = MenueBuilder();
    // bloc = MasterBloc();

    getDashboardData();
    // BlocProvider.setBloc<MasterBloc>(bloc);
    // bloc!.getMasterData();
    super.initState();
  }

  List<PostOfferDTO> listOfPostOffer = [
    new PostOfferDTO("Agreement Stage", 23, 24),
    new PostOfferDTO("Repayment Setup", 27, 19),
    new PostOfferDTO("Loan    Disbursal", 15, 20),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  getDashboardData() async {
    String data =
        await SharedPreferenceUtils.sharedPreferenceUtils.getLoginData();

    loginResponseDTO = DSALoginResponseDTO.fromJson(jsonDecode(data));

    print("Dashboard Data is..");
    print(jsonEncode(loginResponseDTO));

    _getDashboarddata();
  }

  ValueNotifier<NetworkCallConnectionStatus> _notifier =
      ValueNotifier(NetworkCallConnectionStatus.statle);

  _getDashboarddata() async {
    DateTime startDate = DateTime.now();
    newDate = DateUtilsGeneric.convertToMMMdyyyyFormat(startDate);

    DateTime newUIDate = DateTime.now().subtract(Duration(days: 0));

    uiDate = DateUtilsGeneric.convertToMMMdyyyyFormat(newUIDate);
    DateTime end = DateTime.now().subtract(Duration(days: 60));
    endDateFormat = DateUtilsGeneric.convertToMMMdyyyyFormat(end);
    MenueBuilder? empTypBuilder;
    DashboardRequest dashboardRequest = DashboardRequest();
    // dashboardRequest.rdsaId = await SharedPreferenceUtils.sharedPreferenceUtils.getDSAID();

    // print(newDate);
    // print(endDateFormat);

    dashboardRequest.rendDate = newDate;
    dashboardRequest.rstartDate = endDateFormat;

    String? data = await dashboardRequest.toEncodedJson();

    print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await dashboardRequest.toEncodedJson()),
    });
    print("DSA ID IS");

    dashboardBloc!.getDashboardData(formData);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Focus(
      autofocus: true,
      onFocusChange: (hasFocus) {
        print("Into the focus");
        print(hasFocus);
        print("Index is " + newIndex.toString());
        if (hasFocus && newIndex == 2) {
          getDashboardData();
        }
      },
      child: BaseView(
          context: context,
          isBurgerVisble: true,
          body: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ValueListenableBuilder(
                valueListenable: DashboardCalculator.builder.dashboardResponse,
                builder:
                    (BuildContext context, DashboardResponse hasError, child) {
                  return _getBody();
                }),
          )),
    );
  }

  Widget _getUnlockingDashboard() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.newBg,
        child: Stack(
          children: [
            ClipPath(
              clipper: CurveImage(),
              child: Image.asset(DhanvarshaImages.dashboardbg),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "${DateUtilsGeneric.greeting()}, ${loginResponseDTO != null ? loginResponseDTO!.name : ""}!",
                      style: CustomTextStyles.regularWhiteMediumFont,
                    ),
                  ),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: SizeConfig.screenWidth - 30,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Unlock Earnings !",
                              style: CustomTextStyles.boldLargeFonts,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "WITH OUR PRODUCTS",
                              style: CustomTextStyles.boldLargeFonts2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                        DhanvarshaImages.businessLoanDashboard),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        "Gold\nLoan",
                                        textAlign: TextAlign.center,
                                        style:
                                            CustomTextStyles.boldsmallGreyFont,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                        DhanvarshaImages.businessLoanDashboard),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        "Personal\nLoan",
                                        textAlign: TextAlign.center,
                                        style:
                                            CustomTextStyles.boldsmallGreyFont,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                        DhanvarshaImages.businessLoanDashboard),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        "Business\nLoan",
                                        textAlign: TextAlign.center,
                                        style:
                                            CustomTextStyles.boldsmallGreyFont,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Divider(
                              thickness: 1.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "ADD CUSTOMERS",
                              style: CustomTextStyles.boldLargeFonts2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "START adding customer\n application earn on every\n application!",
                              style: CustomTextStyles.regularMediumGreyFont1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Image.asset(DhanvarshaImages.emptyTick),
                          CustomButton(
                            onButtonPressed: () {
                              // CustomerOnBoarding.clearDATA();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         CustomerDetails(context: context),
                              //   ),
                              // );
                            },
                            title: "ADD NEW APPLICATION",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Your Business Card",
                            style: CustomTextStyles.boldMediumFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: SizeConfig.screenWidth - 30,
                      height: 200,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(DhanvarshaImages.dvnewcard),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              DhanvarshaImages.dhansetuNewCard,
                              height: 40,
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "EMPANELLED AGENT",
                                  style: CustomTextStyles.boldlargerRedFont,
                                ),
                                Text(
                                  "${loginResponseDTO != null ? loginResponseDTO!.name : ""}",
                                  style: CustomTextStyles.boldLargerWhiteFont,
                                ),
                                Text(
                                  "+91 ${loginResponseDTO != null ? loginResponseDTO!.mobileNumber : ""}",
                                  style: CustomTextStyles.boldLargerWhiteFont,
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    DateTime dateTime = DateTime.now().add(Duration(days: 1440));
    await SharedPreferenceUtils.sharedPreferenceUtils
        .setApiCallTime(dateTime.toIso8601String());
    getDashboardData();
  }

  List<LoanModel> loanList = [
    new LoanModel(3, "Persoanl Loan"),
    new LoanModel(9, "Business Loan"),
    new LoanModel(0, "All Products"),
  ];

  ValueNotifier<LoanModel> _loanModel =
      ValueNotifier(LoanModel(0, "All Products"));

  onProductPressed() {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            height: SizeConfig.screenHeight * 0.45,
            child: ListView.builder(
              itemCount: loanList.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                return Container(
                  height: SizeConfig.screenHeight * 0.45 / 3,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            newIndex = index;
                          });

                          if (index == 0) {
                            DashboardCalculator.builder.calculateByCategory(3);
                          } else if (index == 1) {
                            DashboardCalculator.builder.calculateByCategory(9);
                          } else if (index == 2) {
                            DashboardCalculator.builder.calculateByCategory(0);
                          }
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loanList[index].type!,
                              style: CustomTextStyles.boldLargeFonts,
                            ),
                            newIndex == index
                                ? Image.asset(
                                    DhanvarshaImages.tickmrk,
                                    height: 20,
                                    width: 20,
                                  )
                                : Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColors.lighterGrey)),
                                  )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  String getTextAccordingtoIndex(int index) {
    switch (index) {
      case 0:
        return "PERSONAL LOAN";
      case 1:
        return "BUSINESS LOAN";
      case 2:
        return "ALL PRODUCTS";
    }

    return "";
  }

  int newIndex = 2;
  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        height: (SizeConfig.screenHeight * 2.3) -
            (68) -
            SizeConfig.verticalviewinsects,
        color: AppColors.newBg,
        child: Stack(
          children: [
            ClipPath(
                clipper: CurveImage(),
                child: Image.asset(DhanvarshaImages.dashboardbg)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 60,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              "${DateUtilsGeneric.greeting()}, ${loginResponseDTO != null ? loginResponseDTO!.name : ""}!",
                              style: CustomTextStyles.regularWhiteMediumFont,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 7),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onProductPressed();
                                    // DashboardCalculator.builder.calculateByCategory(9);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          getTextAccordingtoIndex(newIndex),
                                          style: CustomTextStyles
                                              .boldLargerWhiteFontGothamNew,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Image.asset(
                                          DhanvarshaImages.drop6,
                                          height: 15,
                                          width: 15,
                                          color: AppColors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // DhanvarshaCalendar.showDhanvarshaCalendar(
                              //     context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white24,
                              ),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dashboard for last 2 months",
                                          style: CustomTextStyles
                                              .regularWhiteMediumFontGotham,
                                        ),
                                        Text(
                                          "${DateUtilsGeneric.convertToddMMyyyyFormat(endDateFormat ?? "")} - ${DateUtilsGeneric.convertToddMMyyyyFormat(uiDate ?? "")}",
                                          style: CustomTextStyles
                                              .regularWhiteMediumFontGotham,
                                        ),
                                        // Text(
                                        //   "Dashboard for last 2 months",
                                        //   style: CustomTextStyles
                                        //       .regularMediumGreyFont,
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Image.asset(
                                              DhanvarshaImages.greenUp,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      DhanvarshaImages
                                                          .rupeeblack,
                                                      height: 18,
                                                      width: 18,
                                                    ),
                                                    Text(
                                                      CommaTester.addCommaToStringNew(
                                                              DashboardCalculator
                                                                  .builder
                                                                  .dashboardResponse
                                                                  .value
                                                                  .totalLoanAmountDisbursed
                                                                  .toString()) ??
                                                          "",
                                                      style: CustomTextStyles
                                                          .dvAmountFontsGotham,
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Loans disbursed",
                                                  style: CustomTextStyles
                                                      .regularSmallGreyFontGotham,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Image.asset(
                                              DhanvarshaImages.redDown,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  DashboardCalculator
                                                          .builder
                                                          .dashboardResponse
                                                          .value
                                                          .conversionrate
                                                          .toString() +
                                                      "%",
                                                  style: CustomTextStyles
                                                      .dvAmountFontsGotham,
                                                ),
                                                Text(
                                                  "Conversion rate",
                                                  style: CustomTextStyles
                                                      .regularSmallGreyFontGotham,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomButton(
                                    onButtonPressed: () async {
                                      CustomerOnBoarding.clearDATA();
                                      // bool isSubDsa= await SharedPreferenceUtils.sharedPreferenceUtils.isSubDsa();
                                      //
                                      // print(isSubDsa);
                                      // print(NavigationService.navigationService.navigateTo('\login'));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PanCommonDetails(),
                                        ),
                                      );

                                      // Position positon = await DhanvarshaGeoLocator.determinePosition(
                                      //
                                      // );

                                      // print("Location Are -------------->");
                                      // print(positon.latitude);
                                      // print(positon.longitude);

                                      // DialogUtils.clientIdDialog(context, "2", () {
                                      //   Navigator.pop(context);
                                      // });
                                      // onTap();
                                      // DialogUtils.clientIdDialog(context, "2", () { });
                                    },
                                    title: "ADD NEW APPLICATION",
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "BUSINESS OVERVIEW",
                              style: CustomTextStyles.boldMediumFontGotham,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 25,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Applications Submitted",
                                          style:
                                              CustomTextStyles.boldMediumFontGotham,
                                        ),
                                        Container(
                                            alignment: Alignment.topCenter,
                                            child: LinearProgressIndicator(
                                              value: DashboardCalculator
                                                  .builder
                                                  .dashboardResponse
                                                  .value
                                                  .percetageOftotalApplicationSubmitted,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(AppColors.blue),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Image.asset(
                                              DhanvarshaImages.upImage,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 6),
                                            child: Text(
                                              DashboardCalculator
                                                  .builder
                                                  .dashboardResponse
                                                  .value
                                                  .totalApplicationSubmitted
                                                  .toString(),
                                              style: CustomTextStyles
                                                  .boldMediumFontGotham,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 25,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Credit Approved",
                                            style:
                                                CustomTextStyles.boldMediumFontGotham,
                                          ),
                                          Container(
                                              alignment: Alignment.topCenter,
                                              child: LinearProgressIndicator(
                                                value: DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .percentageOftotalCreditApproved,
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(AppColors.pink),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 6),
                                              child: Image.asset(
                                                DhanvarshaImages.upImage,
                                                height: 10,
                                                width: 10,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 6),
                                              child: Text(
                                                DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .totalCreditApproved
                                                    .toString(),
                                                style: CustomTextStyles
                                                    .boldMediumFontGotham,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //     child: Container(
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         flex: 25,
                          //         child: Container(
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceEvenly,
                          //             children: [
                          //               Text(
                          //                 "Offers Accepted",
                          //                 style:
                          //                     CustomTextStyles.boldMediumFont,
                          //               ),
                          //               Container(
                          //                   alignment: Alignment.topCenter,
                          //                   child: LinearProgressIndicator(
                          //                     value: DashboardCalculator
                          //                         .builder
                          //                         .dashboardResponse
                          //                         .value
                          //                         .percentageOftotalOfferAccepted,
                          //                     valueColor:
                          //                         new AlwaysStoppedAnimation<
                          //                             Color>(AppColors.yellow),
                          //                   ))
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         flex: 10,
                          //         child: Container(
                          //           margin: EdgeInsets.only(left: 20),
                          //           child: Material(
                          //             elevation: 2,
                          //             borderRadius: BorderRadius.circular(5),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Container(
                          //                   margin: EdgeInsets.symmetric(
                          //                       horizontal: 6),
                          //                   child: Image.asset(
                          //                     DhanvarshaImages.upImage,
                          //                     height: 10,
                          //                     width: 10,
                          //                   ),
                          //                 ),
                          //                 Container(
                          //                   margin: EdgeInsets.symmetric(
                          //                       horizontal: 6, vertical: 6),
                          //                   child: Text(
                          //                     DashboardCalculator
                          //                         .builder
                          //                         .dashboardResponse
                          //                         .value
                          //                         .totalOfferAccepted
                          //                         .toString(),
                          //                     style: CustomTextStyles
                          //                         .boldMediumFont,
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // )),
                          Expanded(
                              child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 25,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Loans disbursed",
                                          style:
                                              CustomTextStyles.boldMediumFontGotham,
                                        ),
                                        Container(
                                            alignment: Alignment.topCenter,
                                            child: LinearProgressIndicator(
                                              value: DashboardCalculator
                                                  .builder
                                                  .dashboardResponse
                                                  .value
                                                  .percentageoftotalLoanDisbursed,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(AppColors.green),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Material(
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: Image.asset(
                                              DhanvarshaImages.upImage,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 6),
                                            child: Text(
                                              DashboardCalculator
                                                  .builder
                                                  .dashboardResponse
                                                  .value
                                                  .totalLoanDisbursed
                                                  .toString(),
                                              style: CustomTextStyles
                                                  .boldMediumFontGotham,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "APPLICATION DETAILS",
                      style: CustomTextStyles.boldMediumFontGotham,
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 25,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Application",
                                            style:
                                                CustomTextStyles.boldMediumFontGotham,
                                          ),
                                          // Image.asset(
                                          //   DhanvarshaImages.left,
                                          //   height: 15,
                                          //   width: 15,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // print("LOAN ID");
                                          // print("MASTER KEY ID");
                                          // print( LoanIdFinderGeneric
                                          //     .blLoanId);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AllLeads(
                                                type: "Pending",
                                                count: DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .noOfApplicationDecisionPending,
                                                typeOfData: 1,
                                                blId: newIndex == 2
                                                    ? LoanIdFinderGeneric
                                                        .blLoanId
                                                    : newIndex == 1
                                                        ? LoanIdFinderGeneric
                                                            .blLoanId
                                                        : "-1",
                                                plId: newIndex == 2
                                                    ? LoanIdFinderGeneric
                                                        .plLoanId
                                                    : newIndex == 0
                                                        ? LoanIdFinderGeneric
                                                            .plLoanId
                                                        : "-1",
                                                glId: newIndex == 2
                                                    ? LoanIdFinderGeneric
                                                        .glLoanId
                                                    : newIndex == 0
                                                        ? LoanIdFinderGeneric
                                                            .glLoanId
                                                        : "-1",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.blue)),
                                          width: (SizeConfig.screenWidth -
                                                  20 -
                                                  40) /
                                              2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .noOfApplicationDecisionPending
                                                    .toString(),
                                                style: CustomTextStyles
                                                    .boldMediumFontPurple,
                                              ),
                                              Text(
                                                "Pending",
                                                style: CustomTextStyles
                                                    .boldMediumFontGotham,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AllLeads(
                                                type: "Rejected",
                                                count: DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .noOfApplicationDecisionRejected,
                                                typeOfData: 1,
                                                blId: newIndex == 2
                                                    ? LoanIdFinderGeneric
                                                        .blLoanId
                                                    : newIndex == 1
                                                        ? LoanIdFinderGeneric
                                                            .blLoanId
                                                        : "-1",
                                                plId: newIndex == 2
                                                    ? LoanIdFinderGeneric
                                                        .plLoanId
                                                    : newIndex == 0
                                                        ? LoanIdFinderGeneric
                                                            .plLoanId
                                                        : "-1",
                                                glId: newIndex == 3
                                                    ? LoanIdFinderGeneric
                                                        .glLoanId
                                                    : newIndex == 0
                                                        ? LoanIdFinderGeneric
                                                            .glLoanId
                                                        : "-1",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.blue)),
                                          width: (SizeConfig.screenWidth -
                                                  20 -
                                                  40) /
                                              2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DashboardCalculator
                                                    .builder
                                                    .dashboardResponse
                                                    .value
                                                    .noOfApplicationDecisionRejected
                                                    .toString(),
                                                style: CustomTextStyles
                                                    .boldMediumFontPurple,
                                              ),
                                              Text(
                                                "Rejected",
                                                style: CustomTextStyles
                                                    .boldMediumFontGotham,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 40,
                            child: Container(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => AllLeads(),
                                          //   ),
                                          // );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Loan Status",
                                              style: CustomTextStyles
                                                  .boldMediumFontGotham,
                                            ),
                                            // Image.asset(DhanvarshaImages.left,height: 15,width: 15,)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AllLeads(
                                                  type: "Approved",
                                                  count: DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .totalCreditApproved,
                                                  blId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .blLoanId
                                                      : newIndex == 1
                                                          ? LoanIdFinderGeneric
                                                              .blLoanId
                                                          : "-1",
                                                  plId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .plLoanId
                                                      : newIndex == 0
                                                          ? LoanIdFinderGeneric
                                                              .plLoanId
                                                          : "-1",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.pink)),
                                            width: (SizeConfig.screenWidth -
                                                    20 -
                                                    40) /
                                                2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .totalCreditApproved
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .boldMediumFontpink,
                                                ),
                                                Text(
                                                  "Approved",
                                                  style: CustomTextStyles
                                                      .boldMediumFontGotham,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AllLeads(
                                                  type: "Pending",
                                                  count: DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .noOfCreditDecisionPending,
                                                  blId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .blLoanId
                                                      : newIndex == 1
                                                          ? LoanIdFinderGeneric
                                                              .blLoanId
                                                          : "-1",
                                                  plId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .plLoanId
                                                      : newIndex == 0
                                                          ? LoanIdFinderGeneric
                                                              .plLoanId
                                                          : "-1",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.pink)),
                                            width: (SizeConfig.screenWidth -
                                                    20 -
                                                    40) /
                                                2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .noOfCreditDecisionPending
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .boldMediumFontpink,
                                                ),
                                                Text(
                                                  "Pending",
                                                  style: CustomTextStyles
                                                      .boldMediumFontGotham,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AllLeads(
                                                  type: "Rejected",
                                                  count: DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .noOfCreditDecisionRejected,
                                                  blId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .blLoanId
                                                      : newIndex == 1
                                                          ? LoanIdFinderGeneric
                                                              .blLoanId
                                                          : "-1",
                                                  plId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .plLoanId
                                                      : newIndex == 0
                                                          ? LoanIdFinderGeneric
                                                              .plLoanId
                                                          : "-1",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.pink)),
                                            width: (SizeConfig.screenWidth -
                                                    20 -
                                                    40) /
                                                2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .noOfCreditDecisionRejected
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .boldMediumFontpink,
                                                ),
                                                Text(
                                                  "Rejected",
                                                  style: CustomTextStyles
                                                      .boldMediumFont,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AllLeads(
                                                  type: "Disbursed",
                                                  count: DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .totalLoanDisbursed,
                                                  blId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .blLoanId
                                                      : newIndex == 1
                                                          ? LoanIdFinderGeneric
                                                              .blLoanId
                                                          : "-1",
                                                  plId: newIndex == 2
                                                      ? LoanIdFinderGeneric
                                                          .plLoanId
                                                      : newIndex == 0
                                                          ? LoanIdFinderGeneric
                                                              .plLoanId
                                                          : "-1",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.pink)),
                                            width: (SizeConfig.screenWidth -
                                                    20 -
                                                    40) /
                                                2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DashboardCalculator
                                                      .builder
                                                      .dashboardResponse
                                                      .value
                                                      .totalLoanDisbursed
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .boldMediumFontpink,
                                                ),
                                                Text(
                                                  "Disbursed",
                                                  style: CustomTextStyles
                                                      .boldMediumFont,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: SizeConfig.screenHeight > 700 ? 28 : 36,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Your Business Card",
                              style: CustomTextStyles.boldMediumFont,
                            ),
                          ),
                          Expanded(
                            child: Container(
                                width: SizeConfig.screenWidth - 30,
                                height: SizeConfig.screenWidth - 30,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage(DhanvarshaImages.dvnewcard),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        DhanvarshaImages.dhansetuNewCard,
                                        height: 40,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "EMPANELLED AGENT",
                                            style: CustomTextStyles
                                                .boldlargerRedFont,
                                          ),
                                          Text(
                                            "${loginResponseDTO != null ? loginResponseDTO!.name : ""}",
                                            style: CustomTextStyles
                                                .boldLargerWhiteFont,
                                          ),
                                          Text(
                                            "+91 ${loginResponseDTO != null ? loginResponseDTO!.mobileNumber : ""}",
                                            style: CustomTextStyles
                                                .boldLargerWhiteFont,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                  // width: SizeConfig.screenWidth - 30,
                  // Expanded(
                  //   flex: 16,
                  //   child: _getBannerImage(),
                  // ),
                  // Expanded(
                  //   flex: 5,
                  //   child: _getProductsDropDown(),
                  // ),
                  // Expanded(
                  //   flex: 16,
                  //   child: _ProgressOverView(),
                  // ),
                  // Expanded(
                  //   flex: 12,
                  //   child: _getApplication(),
                  // ),
                  // Expanded(
                  //   flex: 25,
                  //   child: _getPostOffer(),
                  // ),
                  // Expanded(
                  //   flex: 25,
                  //   child: _getPostList(),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getBannerImage() {
    return Container(
      color: AppColors.blue,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Image.asset(
        DhanvarshaImages.banner,
        fit: BoxFit.fill,
        width: SizeConfig.screenWidth,
      ),
    );
  }

  Widget _getProductsDropDown() {
    return Container(
      width: SizeConfig.screenWidth * 0.70,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighterGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All Products",
            style: CustomTextStyles.regularMediumFont,
          ),
          Image.asset(
            DhanvarshaImages.drop,
            width: 10,
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _ProgressOverView() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lighterGrey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overview",
                        style: CustomTextStyles.regularMediumFont,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.lighterGrey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        child: Text("JUL 21"),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        DashboardCalculator.builder.calculateByCategory(9);
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * 0.15,
                        width: SizeConfig.screenHeight * 0.15,
                        child: CircularPercentIndicator(
                          radius: SizeConfig.screenHeight * 0.15,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 8.0,
                          percent: 0.4,
                          center: new Text("25.8 %",
                              style: CustomTextStyles.regularsmalleFonts),
                          circularStrokeCap: CircularStrokeCap.butt,
                          backgroundColor: AppColors.lighterGrey,
                          progressColor: AppColors.light,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '186',
                                    style: CustomTextStyles.boldsmallRedFontGotham),
                                TextSpan(
                                    text: ' Applications',
                                    style: CustomTextStyles.regularsmalleFonts),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '46',
                                    style: CustomTextStyles.boldsmallRedFontGotham),
                                TextSpan(
                                    text: ' Loan Disbursed',
                                    style: CustomTextStyles.regularsmalleFonts),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Value of Loans",
                                  style: CustomTextStyles.regularMediumFont,
                                ),
                                Text(
                                  "₹ 18.5 L",
                                  style: CustomTextStyles.boldMediumFont,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getApplication() {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighBox,
          ),
          color: AppColors.lighBox,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Application",
              style: CustomTextStyles.boldMediumFont,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 7),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "246",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Pending",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  )),
                  Container(
                      height: 30,
                      child: VerticalDivider(color: AppColors.lighterGrey)),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "186",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Submitted",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  )),
                  Container(
                      height: 30,
                      child: VerticalDivider(color: AppColors.lighterGrey)),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "74",
                        style: CustomTextStyles.boldLargeFonts,
                      ),
                      Text(
                        "Expired",
                        style: CustomTextStyles.regularLightBoxsmalleFonts,
                      ),
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getPostOffer() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pre- Offer",
                style: CustomTextStyles.regularMediumFont,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostOffer(
                        type: "Pre",
                      ),
                    ),
                  );
                },
                child: Text(
                  "14 Tasks",
                  style: CustomTextStyles.boldsmallRedFontGotham,
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.lighBox,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 13,
                        child: Container(
                          color: AppColors.lighBox,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "246",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Text(
                                "Pending",
                                style: CustomTextStyles.regularSmallGreyFont,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 35,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Credit Descision",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "15 approved * ",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  ),
                                  Text(
                                    "9 rejected",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.lighBox,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 12,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        DhanvarshaImages.burger,
                                        height: 20,
                                        width: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Offers",
                                          style:
                                              CustomTextStyles.boldMediumFont,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: AppColors.lighBox,
                                  ),
                                  child: Text(
                                    "5 Expired",
                                    style:
                                        CustomTextStyles.regularSmallGreyFont,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "23 Approved * ",
                                        style: CustomTextStyles
                                            .regularSmallGreyFont,
                                      ),
                                      Text(
                                        "39 Rejected",
                                        style: CustomTextStyles
                                            .regularSmallGreyFont,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: CustomButton(
                                    onButtonPressed: () {},
                                    title: "51 Pending",
                                    boxDecoration: ButtonStyles
                                        .greyButtonWithCircularBorder,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getPostList() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Post-Offer",
                      style: CustomTextStyles.regularMediumFont,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostOffer(),
                          ),
                        );
                      },
                      child: Text(
                        "14 Tasks",
                        style: CustomTextStyles.boldsmallRedFontGotham,
                      ),
                    )
                  ],
                ),
                _horizontalListView()
              ],
            ),
            CustomButton(
              onButtonPressed: () {
                //

                // detailsBloc.verifyPINNumber();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationDetails(),
                  ),
                );

                //  PinCodeDTO pincodeDto = new PinCodeDTO(pincode: "400037");
                //
                //
                // String encryptedValue = AesHelper.encrypt("1234",pincodeDto.toString());
                // print(encryptedValue);
              },
              title: "NEW APPLICATION",
            )
          ],
        ));
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
          itemCount: listOfPostOffer.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _returnSimpleCard(listOfPostOffer, index)),
    );
  }

  Widget _returnSimpleCard(List<PostOfferDTO> list, int index) {
    return Container(
      width: (SizeConfig.screenWidth - 15) / 3,
      height: 140,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lighterGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            list.elementAt(index).title,
            style: CustomTextStyles.boldMediumFont,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text(
                  list.elementAt(index).pending.toString() + " Pending",
                  style: CustomTextStyles.regularsmalleFonts,
                ),
                Text(
                  list.elementAt(index).signed.toString() + " Signed",
                  style: CustomTextStyles.regularsmalleFonts,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBox({Color color = Colors.black}) => Container(
        margin: EdgeInsets.all(12),
        height: 100,
        width: 200,
        color: color,
      );

  @override
  void hideProgress() {
    CustomLoaderBuilder.builder.hideLoader();
  }

  @override
  void isSuccessful(SuccessfulResponseDTO dto) async {
    DashboardRequest dashboardRequest = DashboardRequest();

    dashboardRequest.rendDate = newDate;
    dashboardRequest.rstartDate = endDateFormat;

    String? data = await dashboardRequest.toEncodedJson();

    print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await dashboardRequest.toEncodedJson()),
    });

    dashboardBloc!.getListOfTemplateData(formData);
  }

  @override
  void showError() {
    SuccessfulResponse.showScaffoldMessage(AppConstants.errorMessage, context);
  }

  @override
  void showProgress() {
    print("Show Progressed Called");
    CustomLoaderBuilder.builder.showLoader();
  }

  @override
  void isSuccessful2(SuccessfulResponseDTO dto) async {
    print("IS SUCCESSFUL 2nd TIME CALLED");
    DashboardRequest dashboardRequest = DashboardRequest();

    dashboardRequest.rendDate = newDate;
    dashboardRequest.rstartDate = endDateFormat;

    String? data = await dashboardRequest.toEncodedJson();

    print(data);

    FormData formData = FormData.fromMap({
      "json": await EncryptionUtils.getEncryptedText(
          await dashboardRequest.toEncodedJson()),
    });

    dashboardBloc!.getApplicationData(formData);
  }
}

class CurveImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
