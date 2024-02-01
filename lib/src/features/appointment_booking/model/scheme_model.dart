class SchemeGeneralModel {
  int? id;
  String? title;
  String? img;
  String? rateNew;
  String? rateFu;

  SchemeGeneralModel({
    required this.id,
    required this.title,
    required this.img,
    required this.rateNew,
    required this.rateFu,
  });



  SchemeGeneralModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    rateNew = json['rate_new'];
    rateFu = json['rate_fu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img'] = img;
    data['rate_new'] = rateNew;
    data['rate_fu'] = rateFu;
    return data;
  }
}

class SchemePayingModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? code;

  SchemePayingModel({
     this.id,
     this.name,
     this.createdAt,
     this.updatedAt,
     this.code,
  });

  SchemePayingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['code'] = code;
    return data;
  }

}
