class CustomerOnBoardingResponseDTO {
  bool? status;
  String? message;
  int? id;

  CustomerOnBoardingResponseDTO({this.status, this.message, this.id});

  CustomerOnBoardingResponseDTO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['Id'] = this.id;
    return data;
  }
}