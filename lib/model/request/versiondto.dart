class VersionDTO {
  String? iosVersionUAT;
  String? iosAppLinkUAT;
  String? androidVersionUAT;
  String? androidAppLinkUAT;
  String? iosVersionLive;
  String? iosAppLinkLive;
  String? androidVersionLive;
  String? androidAppLinkLive;
  String? iosVersionMgenius;
  String? iosAppLinkMgenius;
  String? androidVersionMgenius;
  String? androidAppLinkMgenius;
  String? dsaIosVersionUAT;
  String? dsaIosAppLinkUAT;
  String? dsaAndroidVersionUAT;
  String? dsaAndroidAppLinkUAT;
  String? dsaIosVersionLive;
  String? dsaIosAppLinkLive;
  String? dsaAndroidVersionLive;
  String? dsaAndroidAppLinkLive;
  String? dsaIosVersionMgenius;
  String? dsaIosAppLinkMgenius;
  String? dsaAndroidVersionMgenius;
  String? dsaAndroidAppLinkMgenius;

  VersionDTO(
      {this.iosVersionUAT,
        this.iosAppLinkUAT,
        this.androidVersionUAT,
        this.androidAppLinkUAT,
        this.iosVersionLive,
        this.iosAppLinkLive,
        this.androidVersionLive,
        this.androidAppLinkLive,
        this.iosVersionMgenius,
        this.iosAppLinkMgenius,
        this.androidVersionMgenius,
        this.androidAppLinkMgenius,
        this.dsaIosVersionUAT,
        this.dsaIosAppLinkUAT,
        this.dsaAndroidVersionUAT,
        this.dsaAndroidAppLinkUAT,
        this.dsaIosVersionLive,
        this.dsaIosAppLinkLive,
        this.dsaAndroidVersionLive,
        this.dsaAndroidAppLinkLive,
        this.dsaIosVersionMgenius,
        this.dsaIosAppLinkMgenius,
        this.dsaAndroidVersionMgenius,
        this.dsaAndroidAppLinkMgenius});

  VersionDTO.fromJson(Map<String, dynamic> json) {
    iosVersionUAT = json['iosVersionUAT'];
    iosAppLinkUAT = json['iosAppLinkUAT'];
    androidVersionUAT = json['androidVersionUAT'];
    androidAppLinkUAT = json['androidAppLinkUAT'];
    iosVersionLive = json['iosVersionLive'];
    iosAppLinkLive = json['iosAppLinkLive'];
    androidVersionLive = json['androidVersionLive'];
    androidAppLinkLive = json['androidAppLinkLive'];
    iosVersionMgenius = json['iosVersionMgenius'];
    iosAppLinkMgenius = json['iosAppLinkMgenius'];
    androidVersionMgenius = json['androidVersionMgenius'];
    androidAppLinkMgenius = json['androidAppLinkMgenius'];
    dsaIosVersionUAT = json['dsa_iosVersionUAT'];
    dsaIosAppLinkUAT = json['dsa_iosAppLinkUAT'];
    dsaAndroidVersionUAT = json['dsa_androidVersionUAT'];
    dsaAndroidAppLinkUAT = json['dsa_androidAppLinkUAT'];
    dsaIosVersionLive = json['dsa_iosVersionLive'];
    dsaIosAppLinkLive = json['dsa_iosAppLinkLive'];
    dsaAndroidVersionLive = json['dsa_androidVersionLive'];
    dsaAndroidAppLinkLive = json['dsa_androidAppLinkLive'];
    dsaIosVersionMgenius = json['dsa_iosVersionMgenius'];
    dsaIosAppLinkMgenius = json['dsa_iosAppLinkMgenius'];
    dsaAndroidVersionMgenius = json['dsa_androidVersionMgenius'];
    dsaAndroidAppLinkMgenius = json['dsa_androidAppLinkMgenius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iosVersionUAT'] = this.iosVersionUAT;
    data['iosAppLinkUAT'] = this.iosAppLinkUAT;
    data['androidVersionUAT'] = this.androidVersionUAT;
    data['androidAppLinkUAT'] = this.androidAppLinkUAT;
    data['iosVersionLive'] = this.iosVersionLive;
    data['iosAppLinkLive'] = this.iosAppLinkLive;
    data['androidVersionLive'] = this.androidVersionLive;
    data['androidAppLinkLive'] = this.androidAppLinkLive;
    data['iosVersionMgenius'] = this.iosVersionMgenius;
    data['iosAppLinkMgenius'] = this.iosAppLinkMgenius;
    data['androidVersionMgenius'] = this.androidVersionMgenius;
    data['androidAppLinkMgenius'] = this.androidAppLinkMgenius;
    data['dsa_iosVersionUAT'] = this.dsaIosVersionUAT;
    data['dsa_iosAppLinkUAT'] = this.dsaIosAppLinkUAT;
    data['dsa_androidVersionUAT'] = this.dsaAndroidVersionUAT;
    data['dsa_androidAppLinkUAT'] = this.dsaAndroidAppLinkUAT;
    data['dsa_iosVersionLive'] = this.dsaIosVersionLive;
    data['dsa_iosAppLinkLive'] = this.dsaIosAppLinkLive;
    data['dsa_androidVersionLive'] = this.dsaAndroidVersionLive;
    data['dsa_androidAppLinkLive'] = this.dsaAndroidAppLinkLive;
    data['dsa_iosVersionMgenius'] = this.dsaIosVersionMgenius;
    data['dsa_iosAppLinkMgenius'] = this.dsaIosAppLinkMgenius;
    data['dsa_androidVersionMgenius'] = this.dsaAndroidVersionMgenius;
    data['dsa_androidAppLinkMgenius'] = this.dsaAndroidAppLinkMgenius;
    return data;
  }
}