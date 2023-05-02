import 'dart:convert';

import 'package:dhanvarsha/bloc/dashboardbloc.dart';
import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/constants/dhanvarshaimages.dart';
import 'package:dhanvarsha/framework/bloc_provider.dart';
import 'package:dhanvarsha/model/request/loanapplicationdto.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/ui/dashboard/application_details.dart';
import 'package:dhanvarsha/utils/boxdecoration.dart';
import 'package:dhanvarsha/utils/customvalidator.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:dhanvarsha/utils/inputdecorations.dart';
import 'package:dhanvarsha/utils/keyboardbuilder.dart';
import 'package:dhanvarsha/utils/product_id/product_id_fetcher.dart';
import 'package:dhanvarsha/widgets/Buttons/custombutton.dart';
import 'package:dhanvarsha/widgets/Buttons/customselectablebutton.dart';
import 'package:dhanvarsha/widgets/custom_textfield/dvtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllLeads extends StatefulWidget {
  final String? type;
  final int? count;
  final int? typeOfData;
  final String? loanType;
  final String? blId;
  final String? plId;
  final String? glId;

  const AllLeads(
      {Key? key,
      this.type,
      this.count = 0,
      this.typeOfData = 0,
      this.loanType,
      this.blId = "0",
      this.plId = "0",
      this.glId = "0"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllLeadsState();
}

class _AllLeadsState extends State<AllLeads> {
  DashboardBloc? dashboardBloc;
  late TextEditingController mobilenumberEditingController;
  GlobalKey<_AllLeadsState> _scrollViewKey = GlobalKey();
  @override
  void initState() {
    dashboardBloc = BlocProvider.getBloc<DashboardBloc>();
    // TODO: implement initState
    mobilenumberEditingController = TextEditingController();

    mobilenumberEditingController.addListener(addListner);
    super.initState();
  }

  addListner() {
    setState(() {});
  }

  @override
  void dispose() {
    mobilenumberEditingController.removeListener(addListner);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        isheaderShown: false,
        body: Container(
          key: _scrollViewKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              KeyboardVisibilityBuilder(
                builder: (context, child, isKeyboardVisible) {
                  if (isKeyboardVisible) {
                    return Container();
                  } else {
                    return _getHeader();
                  }
                },
              ),
              _getContainer(),
              _getSearchApplicationText(),
              widget.typeOfData == 0
                  ? (dashboardBloc!.listOfLoanResponse != null &&
                          widget.count != 0)
                      ? Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  dashboardBloc!.listOfLoanResponse != null
                                      ? dashboardBloc!.listOfLoanResponse.length
                                      : 0,
                              itemBuilder: (
                                context,
                                i,
                              ) {
                                if (widget.type ==
                                        dashboardBloc!
                                            .listOfLoanResponse[i].loanStatus &&
                                    (dashboardBloc!.listOfLoanResponse[i]
                                                .productId ==
                                            widget.blId ||
                                        dashboardBloc!.listOfLoanResponse[i]
                                                .productId ==
                                            widget.plId ||
                                        dashboardBloc!.listOfLoanResponse[i]
                                                .productId ==
                                            widget.plId)) {
                                  return _getApplicationCard(
                                      dashboardBloc!.listOfLoanResponse, i);
                                } else {
                                  return Container();
                                }
                              }))
                      : Expanded(
                          child: Center(
                          child: Text(
                            "No Data Available",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                        ))
                  : (dashboardBloc!.listOfBLPLApplications != null &&
                          widget.count != 0)
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: dashboardBloc!.listOfBLPLApplications !=
                                    null
                                ? dashboardBloc!.listOfBLPLApplications.length
                                : 0,
                            itemBuilder: (
                              context,
                              i,
                            ) {
                              if (widget.type ==
                                      dashboardBloc!.listOfBLPLApplications[i]
                                          .loanStatus &&
                                  (dashboardBloc!.listOfBLPLApplications[i]
                                              .productId ==
                                          widget.blId ||
                                      dashboardBloc!.listOfBLPLApplications[i]
                                              .productId ==
                                          widget.plId ||
                                      dashboardBloc!.listOfBLPLApplications[i]
                                              .productId ==
                                          widget.glId)) {
                                return _getApplicationCard(
                                    dashboardBloc!.listOfBLPLApplications, i);
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: Text(
                            "No Data Available",
                            style: CustomTextStyles.boldLargeFonts,
                          ),
                        ))
            ],
          ),
        ),
        context: context);
  }

  _getApplicationCard(
      List<ListOfLoanApplicationDTO> loanApplication, int index) {
    return loanApplication
                .elementAt(index)
                .clientName!
                .toUpperCase()
                .toUpperCase()
                .contains(mobilenumberEditingController.text.toUpperCase()) ||
            mobilenumberEditingController.text == ""
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplicationDetails(
                    loanApplicationDTO: loanApplication[index],
                    typeOfData: widget.typeOfData,
                  ),
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white,
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loanApplication[index]
                              .dateOfApplicationCreated
                              .toString(),
                          style: CustomTextStyles.boldsmallGreyFontGotham,
                        ),
                        Text(
                          ProductIdFetcher.getPorductName(
                              int.parse(loanApplication[index].productId!)),
                          style: CustomTextStyles.MediumBoldLightFontNew,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loanApplication[index].clientName!,
                              style: CustomTextStyles.boldLargeFontsNew,
                            ),
                            Text(
                              "Application Status : ${loanApplication[index].loanStatus}",
                              style: CustomTextStyles.boldsmallGreyFontNew,
                            ),
                          ],
                        )),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       color: AppColors.buttonRed),
                        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //   child: Text(
                        //     "10 %",
                        //     style: CustomTextStyles.regularWhiteSmallFont,
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Divider(),
                    // Text(
                    //   "Next : Provide Personal Info",
                    //   style: CustomTextStyles.regularMediumGreyFont,
                    // )
                  ],
                )),
          )
        : Container();
  }

  _getSearchApplicationText() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: DVTextField(
        controller: mobilenumberEditingController,
        outTextFieldDecoration: BoxDecorationStyles.outTextFieldBoxDecoration,
        inputDecoration: InputDecorationStyles.inputDecorationTextField,
        title: "Search application by name",
        hintText: "Search application by name",
        maxLine: 1,
        isValidatePressed: false,
        isSearchIcon: true,
        isTitleVisible: true,
        image: DhanvarshaImages.srch,
      ),
    );
  }

  _getContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.count} Applications",
            style: CustomTextStyles.MediumBoldLightFont,
          ),
          // GestureDetector(
          //   onTap: () {
          //     Focus.of(context).requestFocus();
          //   },
          //   child: Image.asset(
          //     DhanvarshaImages.srch,
          //     height: 35,
          //     width: 35,
          //   ),
          // )
        ],
      ),
    );
  }

  _getHeader() {
    return Container(
      height: SizeConfig.screenHeight * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(DhanvarshaImages.headerbg),
              fit: BoxFit.fitWidth)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                DhanvarshaImages.right,
                color: AppColors.white,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Loan : ",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Text(
                                "Business & Personal",
                                style: CustomTextStyles.regularsmalleFonts,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Stage : ",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Text(
                                "Application",
                                style: CustomTextStyles.regularsmalleFonts,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Status : ",
                                style: CustomTextStyles.boldMediumFont,
                              ),
                              Text(
                                widget.type!,
                                style: CustomTextStyles.regularsmalleFonts,
                              )
                            ],
                          ),
                        ],
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // showModalBottomSheet<void>(
                      //     //   context: context,
                      //     //   shape: RoundedRectangleBorder(
                      //     //     borderRadius: BorderRadius.vertical(
                      //     //       top: Radius.circular(20),
                      //     //     ),
                      //     //   ),
                      //     //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     //   isScrollControlled: true,
                      //     //   builder: (BuildContext context) {
                      //     //     return Container(
                      //     //         height:
                      //     //             MediaQuery.of(context).size.height * 0.78,
                      //     //         padding: EdgeInsets.symmetric(
                      //     //             horizontal: 20, vertical: 5),
                      //     //         decoration: BoxDecoration(
                      //     //           borderRadius: BorderRadius.only(
                      //     //               topLeft: Radius.circular(20),
                      //     //               topRight: Radius.circular(20)),
                      //     //         ),
                      //     //         child: Column(
                      //     //           crossAxisAlignment:
                      //     //               CrossAxisAlignment.start,
                      //     //           mainAxisSize: MainAxisSize.max,
                      //     //           children: <Widget>[
                      //     //             Text(
                      //     //               "Filter Applications",
                      //     //               style: CustomTextStyles.boldLargeFonts,
                      //     //             ),
                      //     //             Container(
                      //     //               child: Column(
                      //     //                 crossAxisAlignment:
                      //     //                     CrossAxisAlignment.start,
                      //     //                 children: [
                      //     //                   Container(
                      //     //                     margin: EdgeInsets.symmetric(
                      //     //                         vertical: 10),
                      //     //                     child: Text(
                      //     //                       "Loan Type",
                      //     //                       style: CustomTextStyles
                      //     //                           .regularMediumFont,
                      //     //                     ),
                      //     //                   ),
                      //     //                   Column(
                      //     //                     children: [
                      //     //                       Container(
                      //     //                         margin: EdgeInsets.symmetric(
                      //     //                             vertical: 5),
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Personal",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title: "Buisiness",
                      //     //                             )
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                       Container(
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Gold",
                      //     //                             ),
                      //     //                             Expanded(
                      //     //                                 child: Container())
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                     ],
                      //     //                   ),
                      //     //                   Container(
                      //     //                     margin: EdgeInsets.symmetric(
                      //     //                         vertical: 10),
                      //     //                     child: Text(
                      //     //                       "Loan Stages",
                      //     //                       style: CustomTextStyles
                      //     //                           .regularMediumFont,
                      //     //                     ),
                      //     //                   ),
                      //     //                   Column(
                      //     //                     children: [
                      //     //                       Container(
                      //     //                         margin: EdgeInsets.symmetric(
                      //     //                             vertical: 5),
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Applications",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title:
                      //     //                                   "Crediti Decision",
                      //     //                             )
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                       Container(
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Offer",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title: "Post Offer",
                      //     //                             ),
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                     ],
                      //     //                   ),
                      //     //                   Container(
                      //     //                     margin: EdgeInsets.symmetric(
                      //     //                         vertical: 10),
                      //     //                     child: Text(
                      //     //                       "Status",
                      //     //                       style: CustomTextStyles
                      //     //                           .regularMediumFont,
                      //     //                     ),
                      //     //                   ),
                      //     //                   Column(
                      //     //                     children: [
                      //     //                       Container(
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Completed",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title: "Pending",
                      //     //                             )
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                       Container(
                      //     //                         margin: EdgeInsets.symmetric(
                      //     //                             vertical: 7),
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Expiring Soon",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title: "Expired",
                      //     //                             ),
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                       Container(
                      //     //                         child: Row(
                      //     //                           children: [
                      //     //                             CustomSelectableButton(
                      //     //                               rightPadding: 5,
                      //     //                               title: "Accepted",
                      //     //                             ),
                      //     //                             CustomSelectableButton(
                      //     //                               leftPadding: 5,
                      //     //                               title: "Rejected",
                      //     //                             ),
                      //     //                           ],
                      //     //                         ),
                      //     //                       ),
                      //     //                       Container(
                      //     //                         margin: EdgeInsets.symmetric(
                      //     //                             vertical: 13),
                      //     //                         decoration: BoxDecoration(
                      //     //                           borderRadius:
                      //     //                               BorderRadius.circular(
                      //     //                                   10),
                      //     //                           color: AppColors.buttonRed,
                      //     //                         ),
                      //     //                         padding: EdgeInsets.symmetric(
                      //     //                             vertical: 5,
                      //     //                             horizontal: 25),
                      //     //                         child: Text(
                      //     //                           "Save",
                      //     //                           style: CustomTextStyles
                      //     //                               .boldMediumrWhiteFont,
                      //     //                         ),
                      //     //                       )
                      //     //                     ],
                      //     //                   ),
                      //     //                 ],
                      //     //               ),
                      //     //             )
                      //     //           ],
                      //     //         ));
                      //     //   },
                      //     // );
                      //   },
                      //   child: Image.asset(DhanvarshaImages.filter),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
