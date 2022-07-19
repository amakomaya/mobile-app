// To parse this JSON data, do
//
//     final labtestmodel = labtestmodelFromJson(jsonString);

import 'dart:convert';

Labtestmodel labtestmodelFromJson(String str) =>
    Labtestmodel.fromJson(json.decode(str));

String labtestmodelToJson(Labtestmodel data) => json.encode(data.toJson());

class Labtestmodel {
  Labtestmodel({
    this.token,
    this.womanToken,
    this.testDate,
    this.hb,
    this.albumin,
    this.urineProtein,
    this.urineSugar,
    this.bloodSugar,
    this.hbsag,
    this.vdrl,
    this.retroVirus,
    this.other,
  });

  String? token;
  String? womanToken;
  DateTime? testDate;
  String? hb;
  String? albumin;
  String? urineProtein;
  String? urineSugar;
  String? bloodSugar;
  String? hbsag;
  String? vdrl;
  String? retroVirus;
  String? other;

  factory Labtestmodel.fromJson(Map<String, dynamic> json) => Labtestmodel(
        token: json["token"],
        womanToken: json["woman_token"],
        testDate: DateTime.parse(json["test_date"]),
        hb: json["hb"],
        albumin: json["albumin"],
        urineProtein: json["urine_protein"],
        urineSugar: json["urine_sugar"],
        bloodSugar: json["blood_sugar"],
        hbsag: json["hbsag"],
        vdrl: json["vdrl"],
        retroVirus: json["retro_virus"],
        other: json["other"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "woman_token": womanToken,
        "test_date":
            "${testDate?.year.toString().padLeft(4, '0')}-${testDate?.month.toString().padLeft(2, '0')}-${testDate?.day.toString().padLeft(2, '0')}",
        "hb": hb,
        "albumin": albumin,
        "urine_protein": urineProtein,
        "urine_sugar": urineSugar,
        "blood_sugar": bloodSugar,
        "hbsag": hbsag,
        "vdrl": vdrl,
        "retro_virus": retroVirus,
        "other": other,
      };
}
