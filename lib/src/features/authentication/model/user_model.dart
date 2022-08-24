// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'package:hive/hive.dart';

import 'dart:convert';

part 'user_model.g.dart';


UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());


@HiveType(typeId: 0)
class UserModel extends HiveObject{
  UserModel({
    this.name,
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
    this.healthpostName,
    this.hpDistrict,
    this.hpMunicipality,
    this.hpWard,
    this.chronicIllness,
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
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? age;
  @HiveField(2)
  String? height;
  @HiveField(3)
  int? districtId;
  @HiveField(4)
  int? municipalityId;
  @HiveField(5)
  String? ward;
  @HiveField(25)
  String? tole;
  @HiveField(6)
  dynamic phone;
  @HiveField(7)
  String? bloodGroup;
  @HiveField(8)
  String? husbandName;
  @HiveField(9)
  String? lmpDateEn;
  @HiveField(10)
  String? lmpDateNp;
  @HiveField(11)
  String? healthpostName;
  @HiveField(12)
  int? hpDistrict;
  @HiveField(13)
  int? hpMunicipality;
  @HiveField(14)
  int? hpWard;
  @HiveField(15)
  String? chronicIllness;
  @HiveField(16)
  String? currentHealthpost;
  @HiveField(17)
  String? noOfPregnantBefore;
  @HiveField(18)
  String? moolDartaNo;
  @HiveField(19)
  String? sewaDartaNo;
  @HiveField(20)
  String? orcDartaNo;
  @HiveField(21)
  String? healthWorkerFullName;
  @HiveField(22)
  String? healthWorkerPost;
  @HiveField(23)
  String? healthWorkerPhone;
  @HiveField(24)
  String? registerAs;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        age: json["age"],
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
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "height": height,
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
      };
}
