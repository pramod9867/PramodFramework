import 'dart:convert';

import 'package:dhanvarsha/model/response/dashboardresponse.dart';
import 'package:dhanvarsha/utils/loanidcreator.dart';
import 'package:flutter/cupertino.dart';

class DashboardCalculator {
  ValueNotifier<DashboardResponse>? _dashboardResponse = ValueNotifier(
      DashboardResponse(
          dsaId: "",
          noOfCreditDecisionPending: 0,
          noOfCreditDecisionRejected: 0,
          productId: 0,
          totalApplicationSubmitted: 0,
          totalCreditApproved: 0,
          totalLoanAmountDisbursed: 0,
          totalLoanDisbursed: 0,
          totalOfferAccepted: 0,
          conversionrate: 0,
          noOfApplicationDecisionPending: 0,
          noOfApplicationDecisionRejected: 0,
          percentageOftotalCreditApproved: 0,
          percentageoftotalLoanDisbursed: 0,
          percentageOftotalOfferAccepted: 0,
          percetageOftotalApplicationSubmitted: 0));

  ValueNotifier<DashboardResponse> get dashboardResponse => _dashboardResponse!;

  set dashboardResponse(ValueNotifier<DashboardResponse> value) {
    _dashboardResponse = value;
  }

  int? productcategory;

  static DashboardCalculator builder = DashboardCalculator();

  List<DashboardResponse>? _dashboardList;

  calculateByCategory(int productCateogy) {
    print("Calculation");
    print(productCateogy);
    try {
      if (productCateogy == 9) {
        calculateBLData();
      } else if (productCateogy == 3) {
        calculatePLData();
      } else if (productCateogy == 0) {
        print("IN ALL DATA CALCULATE");
        calculateAllData();
      }
    } catch (e) {
      print(e);
    }
  }

  void calculatePLData() {
    print("Into the ALL");
    DashboardResponse dashboardResponse = DashboardResponse();

    int count = 0;

    print("PL DATA");
    double totalLoanAmountDisbused = 0;
    int totalLoanDisbursed = 0;
    int noOfCreditDecisionPending = 0;
    int noOfCreditDecisionRejected = 0;
    int totalCreditApproved = 0;
    int totalApplicationSubmitted = 0;
    int totalOfferAccepted = 0;
    int noOfApplicationDescionPending = 0;
    int noOfApplicationDescionReject = 0;
    double conversionRate = 0;
    //
    // print("Local PL ID");
    // print(_dashboardList![i].productId);
    // print("Server PL ID");

    try {
      for (int i = 0; i < _dashboardList!.length; i++) {
        print("Local PL ID");
        print(_dashboardList![i].productId);
        print("Server PL ID");
        print(LoanIdFinderGeneric.plLoanIdINT);
        if (_dashboardList![i].productId == LoanIdFinderGeneric.plLoanIdINT ||
            _dashboardList![i].productId == -1) {
          count++;
          dashboardResponse!.dsaId = dashboardList![i].dsaId!;
          dashboardResponse!.productId = dashboardList![i].productId!;
          totalLoanAmountDisbused = totalLoanAmountDisbused +
              _dashboardList![i].totalLoanAmountDisbursed!;

          totalLoanDisbursed =
              totalLoanDisbursed + _dashboardList![i].totalLoanDisbursed!;
          noOfCreditDecisionPending = noOfCreditDecisionPending +
              _dashboardList![i].noOfCreditDecisionPending!;
          noOfCreditDecisionRejected = noOfCreditDecisionRejected +
              _dashboardList![i].noOfCreditDecisionRejected!;
          totalCreditApproved =
              totalCreditApproved + _dashboardList![i].totalCreditApproved!;

          totalApplicationSubmitted = totalApplicationSubmitted +
              _dashboardList![i].totalApplicationSubmitted!;

          totalOfferAccepted =
              totalOfferAccepted + _dashboardList![i].totalOfferAccepted!;

          noOfApplicationDescionPending = noOfApplicationDescionPending +
              _dashboardList![i].noOfApplicationDecisionPending!;

          noOfApplicationDescionReject = noOfApplicationDescionReject +
              _dashboardList![i].noOfApplicationDecisionRejected!;


          // print("Into The Filter");
          // print(_dashboardList![i]!.conversionrate);


          conversionRate =
              _dashboardList![i]!.conversionrate ?? 0 / _dashboardList!.length;
        }
      }

      if (dashboardResponse.dsaId != null) {
        dashboardResponse.totalLoanAmountDisbursed = totalLoanAmountDisbused;
        dashboardResponse.totalLoanDisbursed = totalLoanDisbursed;
        dashboardResponse.noOfCreditDecisionPending = noOfCreditDecisionPending;
        dashboardResponse.noOfCreditDecisionRejected =
            noOfCreditDecisionRejected;
        dashboardResponse.noOfApplicationDecisionRejected =
            noOfApplicationDescionReject;
        dashboardResponse.noOfApplicationDecisionPending =
            noOfApplicationDescionPending;
        dashboardResponse.totalOfferAccepted = totalOfferAccepted;
        dashboardResponse.totalCreditApproved = totalCreditApproved;
        dashboardResponse.totalApplicationSubmitted = totalApplicationSubmitted;
        dashboardResponse.conversionrate = conversionRate;

        int total = dashboardResponse.totalApplicationSubmitted! +
            dashboardResponse.totalLoanDisbursed! +
            dashboardResponse.totalOfferAccepted! +
            dashboardResponse.totalCreditApproved!;

        if (total == 0) {
          total = 1;
        }

        dashboardResponse.percentageOftotalCreditApproved =
            dashboardResponse.totalCreditApproved! / total;

        dashboardResponse.percentageoftotalLoanDisbursed =
            dashboardResponse.totalLoanDisbursed! / total;

        dashboardResponse.percentageOftotalOfferAccepted =
            dashboardResponse.totalOfferAccepted! / total;

        dashboardResponse.percetageOftotalApplicationSubmitted =
            dashboardResponse.totalApplicationSubmitted! / total;

        _dashboardResponse!.value = dashboardResponse;
      } else {
        _dashboardResponse!.notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void calculateBLData() {
    print("Into the ALL");
    DashboardResponse dashboardResponse = DashboardResponse();

    int count = 0;

    double totalLoanAmountDisbused = 0;
    int totalLoanDisbursed = 0;
    int noOfCreditDecisionPending = 0;
    int noOfCreditDecisionRejected = 0;
    int totalCreditApproved = 0;
    int totalApplicationSubmitted = 0;
    int totalOfferAccepted = 0;
    int noOfApplicationDescionPending = 0;
    int noOfApplicationDescionReject = 0;
    double conversionRate = 0;

    try {
      for (int i = 0; i < _dashboardList!.length; i++) {
        if (_dashboardList![i].productId == LoanIdFinderGeneric.blLoanIdINT ||
            _dashboardList![i].productId == -2) {
          count++;
          dashboardResponse!.dsaId = dashboardList![i].dsaId!;
          dashboardResponse!.productId = dashboardList![i].productId!;
          totalLoanAmountDisbused = totalLoanAmountDisbused +
              _dashboardList![i].totalLoanAmountDisbursed!;

          totalLoanDisbursed =
              totalLoanDisbursed + _dashboardList![i].totalLoanDisbursed!;
          noOfCreditDecisionPending = noOfCreditDecisionPending +
              _dashboardList![i].noOfCreditDecisionPending!;
          noOfCreditDecisionRejected = noOfCreditDecisionRejected +
              _dashboardList![i].noOfCreditDecisionRejected!;
          totalCreditApproved =
              totalCreditApproved + _dashboardList![i].totalCreditApproved!;

          totalApplicationSubmitted = totalApplicationSubmitted +
              _dashboardList![i].totalApplicationSubmitted!;

          totalOfferAccepted =
              totalOfferAccepted + _dashboardList![i].totalOfferAccepted!;

          noOfApplicationDescionPending = noOfApplicationDescionPending +
              _dashboardList![i].noOfApplicationDecisionPending!;

          noOfApplicationDescionReject = noOfApplicationDescionReject +
              _dashboardList![i].noOfApplicationDecisionRejected!;





          conversionRate =
              _dashboardList![i]!.conversionrate ?? 0 / _dashboardList!.length;
        }
      }

      if (dashboardResponse.dsaId != null) {
        dashboardResponse.totalLoanAmountDisbursed = totalLoanAmountDisbused;
        dashboardResponse.totalLoanDisbursed = totalLoanDisbursed;
        dashboardResponse.noOfCreditDecisionPending = noOfCreditDecisionPending;
        dashboardResponse.noOfCreditDecisionRejected =
            noOfCreditDecisionRejected;
        dashboardResponse.noOfApplicationDecisionRejected =
            noOfApplicationDescionReject;
        dashboardResponse.noOfApplicationDecisionPending =
            noOfApplicationDescionPending;
        dashboardResponse.totalOfferAccepted = totalOfferAccepted;
        dashboardResponse.totalCreditApproved = totalCreditApproved;
        dashboardResponse.totalApplicationSubmitted = totalApplicationSubmitted;
        dashboardResponse.conversionrate = conversionRate;

        int total = dashboardResponse.totalApplicationSubmitted! +
            dashboardResponse.totalLoanDisbursed! +
            dashboardResponse.totalOfferAccepted! +
            dashboardResponse.totalCreditApproved!;

        if (total == 0) {
          total = 1;
        }

        dashboardResponse.percentageOftotalCreditApproved =
            dashboardResponse.totalCreditApproved! / total;

        dashboardResponse.percentageoftotalLoanDisbursed =
            dashboardResponse.totalLoanDisbursed! / total;

        dashboardResponse.percentageOftotalOfferAccepted =
            dashboardResponse.totalOfferAccepted! / total;

        dashboardResponse.percetageOftotalApplicationSubmitted =
            dashboardResponse.totalApplicationSubmitted! / total;

        _dashboardResponse!.value = dashboardResponse;
      } else {
        _dashboardResponse!.notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void calculateAllData() {
    DashboardResponse dashboardResponse = DashboardResponse();

    double totalLoanAmountDisbused = 0;
    int totalLoanDisbursed = 0;
    int noOfCreditDecisionPending = 0;
    int noOfCreditDecisionRejected = 0;
    int totalCreditApproved = 0;
    int totalApplicationSubmitted = 0;
    int totalOfferAccepted = 0;
    int noOfApplicationDescionPending = 0;
    int noOfApplicationDescionReject = 0;
    double conversionRate = 0;
    try {
      for (int i = 0; i < _dashboardList!.length; i++) {
        dashboardResponse!.dsaId = dashboardList![i].dsaId!;
        dashboardResponse!.productId = dashboardList![i].productId!;
        totalLoanAmountDisbused = totalLoanAmountDisbused +
            _dashboardList![i].totalLoanAmountDisbursed!;

        totalLoanDisbursed =
            totalLoanDisbursed + _dashboardList![i].totalLoanDisbursed!;
        noOfCreditDecisionPending = noOfCreditDecisionPending +
            _dashboardList![i].noOfCreditDecisionPending!;
        noOfCreditDecisionRejected = noOfCreditDecisionRejected +
            _dashboardList![i].noOfCreditDecisionRejected!;
        totalCreditApproved =
            totalCreditApproved + _dashboardList![i].totalCreditApproved!;

        totalApplicationSubmitted = totalApplicationSubmitted +
            _dashboardList![i].totalApplicationSubmitted!;

        totalOfferAccepted =
            totalOfferAccepted + _dashboardList![i].totalOfferAccepted!;

        noOfApplicationDescionPending = noOfApplicationDescionPending +
            _dashboardList![i].noOfApplicationDecisionPending!;

        // print("NO OF APPLICATION");
        // print(noOfApplicationDescionPending);

        noOfApplicationDescionReject = noOfApplicationDescionReject +
            _dashboardList![i].noOfApplicationDecisionRejected!;

        conversionRate =
            conversionRate + _dashboardList![i].conversionrate! ?? 0;
      }

      if (dashboardResponse.dsaId != null) {
        dashboardResponse.totalLoanAmountDisbursed = totalLoanAmountDisbused;
        dashboardResponse.totalLoanDisbursed = totalLoanDisbursed;
        dashboardResponse.noOfCreditDecisionPending = noOfCreditDecisionPending;
        dashboardResponse.noOfCreditDecisionRejected =
            noOfCreditDecisionRejected;
        dashboardResponse.noOfApplicationDecisionRejected =
            noOfApplicationDescionReject;
        dashboardResponse.noOfApplicationDecisionPending =
            noOfApplicationDescionPending;
        dashboardResponse.totalOfferAccepted = totalOfferAccepted;
        dashboardResponse.totalCreditApproved = totalCreditApproved;
        dashboardResponse.totalApplicationSubmitted = totalApplicationSubmitted;
        dashboardResponse.conversionrate = conversionRate;

        int total = dashboardResponse.totalApplicationSubmitted! +
            dashboardResponse.totalLoanDisbursed! +
            dashboardResponse.totalOfferAccepted! +
            dashboardResponse.totalCreditApproved!;

        if (total == 0 || total == null) {
          total = 1;
        }

        dashboardResponse.percentageOftotalCreditApproved =
            dashboardResponse.totalCreditApproved! / total;

        dashboardResponse.percentageoftotalLoanDisbursed =
            dashboardResponse.totalLoanDisbursed! / total;

        dashboardResponse.percentageOftotalOfferAccepted =
            dashboardResponse.totalOfferAccepted! / total;

        dashboardResponse.percetageOftotalApplicationSubmitted =
            dashboardResponse.totalApplicationSubmitted! / total;

        _dashboardResponse!.value = dashboardResponse;
      } else {
        _dashboardResponse!.notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  List<DashboardResponse> get dashboardList => _dashboardList!;

  set dashboardList(List<DashboardResponse> value) {
    _dashboardList = value;
  }
}
