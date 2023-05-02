class AddCoapplicantResponseDTO {
  bool? status;
  int? id;
  String? message;

  AddCoapplicantResponseDTO({this.status, this.id, this.message});

  AddCoapplicantResponseDTO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['Id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['Id'] = this.id;
    data['message'] = this.message;
    return data;
  }
}