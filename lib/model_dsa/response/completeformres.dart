//{\"status\":true,\"message\":\"Registration has been completed.\"}
class CompleteForm {
  bool? status;
  String? message;

  CompleteForm({
    this.status,
    this.message,
  });

  CompleteForm.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
