// To parse this JSON data, do
//
//     final ancModel = ancModelFromJson(jsonString);

import 'dart:convert';

AncModel ancModelFromJson(String str) => AncModel.fromJson(json.decode(str));

String ancModelToJson(AncModel data) => json.encode(data.toJson());

class AncModel {
  AncModel({
    this.weight,
    this.anemia,
    this.swelling,
    this.bloodPressure,
    this.uterusHeight,
    this.babyPresentation,
    this.babyHeartBeat,
    this.other,
    this.ironPills,
    this.wormMedicine,
    this.visitDate,
    this.checkedBy,
    this.nextVisitDate,
  });

  int? weight;
  String? anemia;
  String? swelling;
  String? bloodPressure;
  int? uterusHeight;
  String? babyPresentation;
  int? babyHeartBeat;
  String? other;
  int? ironPills;
  int? wormMedicine;
  String? visitDate;
  String? checkedBy;
  String? nextVisitDate;

  factory AncModel.fromJson(Map<String, dynamic> json) => AncModel(
        weight: json["weight"],
        anemia: json["anemia"],
        swelling: json["swelling"],
        bloodPressure: json["blood_pressure"],
        uterusHeight: json["uterus_height"],
        babyPresentation: json["baby_presentation"],
        babyHeartBeat: json["baby_heart_beat"],
        other: json["other"],
        ironPills: json["iron_pills"],
        wormMedicine: json["worm_medicine"],
        visitDate: json["visit_date"],
        checkedBy: json["checked_by"],
        nextVisitDate: json["next_visit_date"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "anemia": anemia,
        "swelling": swelling,
        "blood_pressure": bloodPressure,
        "uterus_height": uterusHeight,
        "baby_presentation": babyPresentation,
        "baby_heart_beat": babyHeartBeat,
        "other": other,
        "iron_pills": ironPills,
        "worm_medicine": wormMedicine,
        "visit_date": visitDate,
        "checked_by": checkedBy,
        "next_visit_date": nextVisitDate,
      };
}
