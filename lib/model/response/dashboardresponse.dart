import 'dart:convert';

class DashboardResponse {
  String? dsaId;
  int? productId;
  int? totalLoanDisbursed;
  double? totalLoanAmountDisbursed;
  int? totalApplicationSubmitted;
  int? totalCreditApproved;
  int? totalOfferAccepted;
  int? noOfCreditDecisionPending;
  int? noOfCreditDecisionRejected;
  int? noOfApplicationDecisionPending;
  int? noOfApplicationDecisionRejected;
  double? conversionrate;
  double? percetageOftotalApplicationSubmitted;
  double? percentageOftotalCreditApproved;
  double? percentageOftotalOfferAccepted;
  double? percentageoftotalLoanDisbursed;

  DashboardResponse(
      {this.dsaId,
      this.productId,
      this.totalLoanDisbursed,
      this.totalLoanAmountDisbursed,
      this.totalApplicationSubmitted,
      this.totalCreditApproved,
      this.totalOfferAccepted,
      this.noOfCreditDecisionPending,
      this.noOfCreditDecisionRejected,
      this.conversionrate,
      this.noOfApplicationDecisionPending,
      this.noOfApplicationDecisionRejected,
      this.percentageOftotalCreditApproved,
      this.percentageoftotalLoanDisbursed,
      this.percentageOftotalOfferAccepted,
      this.percetageOftotalApplicationSubmitted
      });

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    dsaId = json['dsaId'];
    productId = json['productId'];
    totalLoanDisbursed = json['totalLoanDisbursed'];
    totalLoanAmountDisbursed = json['totalLoanAmountDisbursed'] != null
        ? json['totalLoanAmountDisbursed']
        : "";
    totalApplicationSubmitted = json['totalApplicationSubmitted'];
    totalCreditApproved = json['totalCreditApproved'];
    totalOfferAccepted = json['totalOfferAccepted'];
    noOfCreditDecisionPending = json['noOfCreditDecisionPending'];
    noOfCreditDecisionRejected = json['noOfCreditDecisionRejected'];
    noOfApplicationDecisionPending = json['ApplicationPending'];
    noOfApplicationDecisionRejected =  json['ApplicationRejected'];
    conversionrate =  json['ConversionRate'];
    percentageOftotalOfferAccepted=0;
    percentageOftotalOfferAccepted=0;
    percentageoftotalLoanDisbursed=0;
    percentageOftotalCreditApproved=0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsaId'] = this.dsaId;
    data['productId'] = this.productId;
    data['totalLoanDisbursed'] = this.totalLoanDisbursed;
    data['totalLoanAmountDisbursed'] = this.totalLoanAmountDisbursed;
    data['totalApplicationSubmitted'] = this.totalApplicationSubmitted;
    data['totalCreditApproved'] = this.totalCreditApproved;
    data['totalOfferAccepted'] = this.totalOfferAccepted;
    data['noOfCreditDecisionPending'] = this.noOfCreditDecisionPending;
    data['noOfCreditDecisionRejected'] = this.noOfCreditDecisionRejected;
    data['ApplicationPending']=this.noOfApplicationDecisionPending;
    data['ApplicationRejected']=this.noOfApplicationDecisionRejected;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dsaId'] = this.dsaId;
    data['productId'] = this.productId;
    data['totalLoanDisbursed'] = this.totalLoanDisbursed;
    data['totalLoanAmountDisbursed'] = this.totalLoanAmountDisbursed;
    data['totalApplicationSubmitted'] = this.totalApplicationSubmitted;
    data['totalCreditApproved'] = this.totalCreditApproved;
    data['totalOfferAccepted'] = this.totalOfferAccepted;
    data['noOfCreditDecisionPending'] = this.noOfCreditDecisionPending;
    data['noOfCreditDecisionRejected'] = this.noOfCreditDecisionRejected;
    data['ApplicationPending']=this.noOfApplicationDecisionPending;
    data['ApplicationRejected']=this.noOfApplicationDecisionRejected;
    return jsonEncode(data);
  }
}
