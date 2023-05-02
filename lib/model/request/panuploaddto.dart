class PanUpload {
  String? fileName;
  int? id;
  String? type;

  PanUpload({this.fileName,this.id,this.type="PL"});

  PanUpload.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['Id']=this.id;
    data['Type']=this.type!=null?this.type:"PL";
    return data;
  }
}