class QualityCheckDTO {
  String? brightness;
  String? isCutCard;
  String? isblackWhite;
  String? isBlur;

  QualityCheckDTO(
      {this.brightness, this.isCutCard, this.isblackWhite, this.isBlur});

  QualityCheckDTO.fromJson(Map<String, dynamic> json) {
    brightness = json['brightness'];
    isCutCard = json['isCutCard'];
    isblackWhite = json['isBlackWhite'];
    isBlur = json['isBlur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brightness'] = this.brightness;
    data['isCutCard'] = this.isCutCard;
    data['isBlackWhite'] = this.isblackWhite;
    data['isBlur'] = this.isBlur;
    return data;
  }
}
