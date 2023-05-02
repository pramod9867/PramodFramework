class MasterDataDTO{
  String? name;
  String? description;


  String? FinalCat;
  String? image;

  MasterDataDTO(this.name, this.value,{this.image,this.description,this.FinalCat});

  int? value;

  MasterDataDTO.fromJson(Map<String,dynamic> json){
      name=json['name'];
      value=json['value'];

  }

  MasterDataDTO.fromGSTDetails(Map<String,dynamic> json){
    name=json['gstinId'];
    value=json['GeneratedId'];
  }

  MasterDataDTO.fromJsonEMP(Map<String,dynamic> json){
    name=json['CompanyName'];
    value=json['Id'];
    FinalCat=json['FinalCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}