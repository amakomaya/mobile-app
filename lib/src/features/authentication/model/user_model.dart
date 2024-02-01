// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'package:hive/hive.dart';

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends HiveObject {
  UserModel({
    this.name,
    this.firstName,
    this.middleName,
    this.lastName,
    this.age,
    this.height,
    this.districtId,
    this.municipalityId,
    this.dobChild,
    this.districtName,
    this.provinceName,
    this.ward,
    this.tole,
    this.phone,
    this.bloodGroup,
    this.husbandName,
    this.lmpDateEn,
    this.lmpDateNp,
    this.healthpostName,
    this.hpDistrict,
    this.hpMunicipality,
    this.hpWard,
    this.chronicIllness,
    this.district,
    this.municipalityName,
    this.streetName,
    this.haveDiseasePreviously,
    this.pregnantTimes,
    this.currentHealthPost,
    this.modeType,
    this.currentHealthpost,
    this.noOfPregnantBefore,
    this.moolDartaNo,
    this.sewaDartaNo,
    this.orcDartaNo,
    this.healthWorkerFullName,
    this.healthWorkerPost,
    this.healthWorkerPhone,
    this.registerAs,
  });

  String? name;
  String? firstName;
  String? middleName;
  String? lastName;
  int? age;
  String? height;
  int? districtId;
  int? municipalityId;
  String? districtName;
  String? municipalityName;
  String? provinceName;
  String? dobChild;

  String? ward;
  String? tole;
  dynamic phone;
  String? bloodGroup;
  String? husbandName;
  String? lmpDateEn;
  String? lmpDateNp;
  String? healthpostName;
  int? hpDistrict;

  int? hpMunicipality;

  int? hpWard;

  String? chronicIllness;
  String? district;
  String? streetName;
  String? haveDiseasePreviously;
  int? pregnantTimes;
  String? currentHealthPost;
  String? modeType;

  String? currentHealthpost;

  String? noOfPregnantBefore;

  String? moolDartaNo;

  String? sewaDartaNo;

  String? orcDartaNo;

  String? healthWorkerFullName;

  String? healthWorkerPost;

  String? healthWorkerPhone;

  String? registerAs;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
        age: json["age"],
    dobChild: json["dobChild"],
        height: json["height"],
        districtId: json["district_id"],
        municipalityId: json["municipality_id"],
        ward: json["ward"],
        tole: json["tole"],
        phone: json["phone"],
        bloodGroup: json["bloodGroup"],
        husbandName: json["husband_name"],
        lmpDateEn: json["lmp_date_en"],
        lmpDateNp: json["lmp_date_np"],
        healthpostName: json["healthpost_name"],
        hpDistrict: json["hp_district"],
        hpMunicipality: json["hp_municipality"],
        hpWard: json["hp_ward"],
        chronicIllness: json["chronic_illness"],
        currentHealthpost: json["current_healthpost"],
        noOfPregnantBefore: json["no_of_pregnant_before"],
        moolDartaNo: json["mool_darta_no"],
        sewaDartaNo: json["sewa_darta_no"],
        orcDartaNo: json["orc_darta_no"],
        healthWorkerFullName: json["health_worker_full_name"],
        healthWorkerPost: json["health_worker_post"],
        healthWorkerPhone: json["health_worker_phone"],
        registerAs: json["register_as"],
        district: json["district"],
        provinceName: json["province_name"],
        municipalityName: json["municipality_name"],
        districtName: json["district_name"],
        streetName: json["street_name"],
        haveDiseasePreviously: json["have_disease_previously"],
        pregnantTimes: json["pregnant_times"],
        currentHealthPost: json["current_health_post"],
        modeType: json["mode_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "age": age,
        "height": height,
        "dobChild": dobChild,
        "district_id": districtId,
        "municipality_id": municipalityId,
        "ward": ward,
        "tole": tole,
        "phone": phone,
        "bloodGroup": bloodGroup,
        "husband_name": husbandName,
        "lmp_date_en": lmpDateEn,
        "lmp_date_np": lmpDateNp,
        "healthpost_name": healthpostName,
        "hp_district": hpDistrict,
        "hp_municipality": hpMunicipality,
        "hp_ward": hpWard,
        "chronic_illness": chronicIllness,
        "current_healthpost": currentHealthpost,
        "no_of_pregnant_before": noOfPregnantBefore,
        "mool_darta_no": moolDartaNo,
        "sewa_darta_no": sewaDartaNo,
        "orc_darta_no": orcDartaNo,
        "health_worker_full_name": healthWorkerFullName,
        "health_worker_post": healthWorkerPost,
        "health_worker_phone": healthWorkerPhone,
        "register_as": registerAs,
        "district": district,
        "municipality_name": municipalityName,
        "district_name": districtName,
        "province_name": provinceName,
        "street_name": streetName,
        "have_disease_previously": haveDiseasePreviously,
        "pregnant_times": pregnantTimes,
        "current_health_post": currentHealthPost,
        "mode_type": modeType,
      };
}
