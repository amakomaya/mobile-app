// To parse this JSON data, do
//
//     final medicationmodel = medicationmodelFromJson(jsonString);

import 'dart:convert';

Medicationmodel medicationmodelFromJson(String str) =>
    Medicationmodel.fromJson(json.decode(str));

String medicationmodelToJson(Medicationmodel data) =>
    json.encode(data.toJson());

class Medicationmodel {
  Medicationmodel({
    this.token,
    this.womanToken,
    this.vaccineRegNo,
    this.vaccineType,
    this.vaccinatedDateEn,
    this.vaccinatedDateNp,
    this.noOfPills,
    this.hpCode,
    this.createdAt,
  });

  String? token;
  String? womanToken;
  String? vaccineRegNo;
  String? vaccineType;
  DateTime? vaccinatedDateEn;
  DateTime? vaccinatedDateNp;
  int? noOfPills;
  String? hpCode;
  DateTime? createdAt;

  factory Medicationmodel.fromJson(Map<String, dynamic> json) =>
      Medicationmodel(
        token: json["token"],
        womanToken: json["woman_token"],
        vaccineRegNo: json["vaccine_reg_no"],
        vaccineType: json["vaccine_type"],
        vaccinatedDateEn: DateTime.parse(json["vaccinated_date_en"]),
        vaccinatedDateNp: DateTime.parse(json["vaccinated_date_np"]),
        noOfPills: json["no_of_pills"],
        hpCode: json["hp_code"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "woman_token": womanToken,
        "vaccine_reg_no": vaccineRegNo,
        "vaccine_type": vaccineType,
        "vaccinated_date_en":
            "${vaccinatedDateEn?.year.toString().padLeft(4, '0')}-${vaccinatedDateEn?.month.toString().padLeft(2, '0')}-${vaccinatedDateEn?.day.toString().padLeft(2, '0')}",
        "vaccinated_date_np":
            "${vaccinatedDateNp?.year.toString().padLeft(4, '0')}-${vaccinatedDateNp?.month.toString().padLeft(2, '0')}-${vaccinatedDateNp?.day.toString().padLeft(2, '0')}",
        "no_of_pills": noOfPills,
        "hp_code": hpCode,
        "created_at": createdAt?.toIso8601String(),
      };
}
