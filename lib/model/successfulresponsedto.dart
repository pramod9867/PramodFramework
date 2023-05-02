class SuccessfulResponseDTO {
  String? token;
  String? data;

  SuccessfulResponseDTO({this.token, this.data});

  SuccessfulResponseDTO.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['Data'] = this.data;
    return data;
  }
}
