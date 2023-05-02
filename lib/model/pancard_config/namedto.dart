class NameDTO {
  String? name;
  double? value;

  NameDTO.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['conf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['conf'] = this.value;
    return data;
  }
}
