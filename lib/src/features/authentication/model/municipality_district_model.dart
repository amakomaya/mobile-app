class DistrictModel {
  int? id;
  int? provinceId;
  String? districtName;

  DistrictModel({this.id, this.provinceId, this.districtName});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province_id'] = provinceId;
    data['district_name'] = districtName;
    return data;
  }
}

class MunicipalityModel {
  int? id;
  int? provinceId;
  int? districtId;
  String? municipalityName;

  MunicipalityModel(
      {this.id, this.provinceId, this.districtId, this.municipalityName});

  MunicipalityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    municipalityName = json['municipality_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province_id'] = provinceId;
    data['district_id'] = districtId;
    data['municipality_name'] = municipalityName;
    return data;
  }
}
