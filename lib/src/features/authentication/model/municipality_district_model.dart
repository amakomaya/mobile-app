class DistrictModel {
  int? id;
  int? provinceId;
  String? districtName;
  String? districtNameNP;
  String? districtCode;

  DistrictModel(
      {this.id,
      this.provinceId,
      this.districtName,
      this.districtNameNP,
      this.districtCode});

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

class ProvinceModel {
  int? provinceId;
  String? provinceName;
  String? provinceNameNP;

  ProvinceModel({this.provinceId, this.provinceName, this.provinceNameNP});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['id'];
    provinceName = json['name_en'];
    provinceNameNP = json['name_np'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = provinceId;
    data['name_en'] = provinceName;
    data['name_np'] = provinceNameNP;
    return data;
  }
}
