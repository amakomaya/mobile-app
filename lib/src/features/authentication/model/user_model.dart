class UserModel {
  String? token;
  String? name;
  String? noOfPregnantBefore;
  int? age;
  String? height;
  int? districtId;
  int? municipalityId;
  String? ward;
  String? tole;
  int? phone;
  String? bloodGroup;
  String? husbandName;
  String? lmpDateEn;
  String? lmpDateNp;
  String? hpCode;
  String? healthpostName;
  int? hpDistrict;
  int? hpMunicipality;
  int? hpWard;
  String? chronicIllness;
  String? currentHealthpost;
  String? moolDartaNo;
  String? sewaDartaNo;
  String? orcDartaNo;
  String? healthWorkerFullName;
  String? healthWorkerPost;
  String? healthWorkerPhone;
  String? registerAs;

  UserModel(
      {this.token,
      this.name,
      this.noOfPregnantBefore,
      this.age,
      this.height,
      this.districtId,
      this.municipalityId,
      this.ward,
      this.tole,
      this.phone,
      this.bloodGroup,
      this.husbandName,
      this.lmpDateEn,
      this.lmpDateNp,
      this.hpCode,
      this.healthpostName,
      this.hpDistrict,
      this.hpMunicipality,
      this.hpWard,
      this.chronicIllness,
      this.currentHealthpost,
      this.moolDartaNo,
      this.sewaDartaNo,
      this.orcDartaNo,
      this.healthWorkerFullName,
      this.healthWorkerPost,
      this.healthWorkerPhone,
      this.registerAs});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    noOfPregnantBefore = json['no_of_pregnant_before'];
    age = json['age'];
    height = json['height'];
    districtId = json['district_id'];
    municipalityId = json['municipality_id'];
    ward = json['ward'];
    tole = json['tole'];
    phone = json['phone'];
    bloodGroup = json['bloodGroup'];
    husbandName = json['husband_name'];
    lmpDateEn = json['lmp_date_en'];
    lmpDateNp = json['lmp_date_np'];
    hpCode = json['hp_code'];
    healthpostName = json['healthpost_name'];
    hpDistrict = json['hp_district'];
    hpMunicipality = json['hp_municipality'];
    hpWard = json['hp_ward'];
    chronicIllness = json['chronic_illness'];
    currentHealthpost = json['current_healthpost'];
    moolDartaNo = json['mool_darta_no'];
    sewaDartaNo = json['sewa_darta_no'];
    orcDartaNo = json['orc_darta_no'];
    healthWorkerFullName = json['health_worker_full_name'];
    healthWorkerPost = json['health_worker_post'];
    healthWorkerPhone = json['health_worker_phone'];
    registerAs = json['register_as'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['no_of_pregnant_before'] = noOfPregnantBefore;
    data['age'] = age;
    data['height'] = height;
    data['district_id'] = districtId;
    data['municipality_id'] = municipalityId;
    data['ward'] = ward;
    data['tole'] = tole;
    data['phone'] = phone;
    data['bloodGroup'] = bloodGroup;
    data['husband_name'] = husbandName;
    data['lmp_date_en'] = lmpDateEn;
    data['lmp_date_np'] = lmpDateNp;
    data['hp_code'] = hpCode;
    data['healthpost_name'] = healthpostName;
    data['hp_district'] = hpDistrict;
    data['hp_municipality'] = hpMunicipality;
    data['hp_ward'] = hpWard;
    data['chronic_illness'] = chronicIllness;
    data['current_healthpost'] = currentHealthpost;
    data['mool_darta_no'] = moolDartaNo;
    data['sewa_darta_no'] = sewaDartaNo;
    data['orc_darta_no'] = orcDartaNo;
    data['health_worker_full_name'] = healthWorkerFullName;
    data['health_worker_post'] = healthWorkerPost;
    data['health_worker_phone'] = healthWorkerPhone;
    data['register_as'] = registerAs;
    return data;
  }
}
