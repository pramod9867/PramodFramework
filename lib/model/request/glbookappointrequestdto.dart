import 'dart:convert';

class GLBookAppointmentRequestDTO {
  int? refGLId;
  int? branchId;
  String? appointmentDate;
  String? appointmentTime;

  GLBookAppointmentRequestDTO(
      {this.refGLId,
        this.branchId,
        this.appointmentDate,
        this.appointmentTime});

  GLBookAppointmentRequestDTO.fromJson(Map<String, dynamic> json) {
    refGLId = json['RefGLId'];
    branchId = json['BranchId'];
    appointmentDate = json['AppointmentDate'];
    appointmentTime = json['AppointmentTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['BranchId'] = this.branchId;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentTime'] = this.appointmentTime;
    return data;
  }

  String toEncodedJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RefGLId'] = this.refGLId;
    data['BranchId'] = this.branchId;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentTime'] = this.appointmentTime;

    print("Encoded JSON ------------->");
    print(jsonEncode(data));
    return jsonEncode(data);
  }
}