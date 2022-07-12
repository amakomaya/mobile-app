// To parse this JSON data, do
//
//     final pncModel = pncModelFromJson(jsonString);

import 'dart:convert';

PncModel pncModelFromJson(String str) => PncModel.fromJson(json.decode(str));

String pncModelToJson(PncModel data) => json.encode(data.toJson());

class PncModel {
  PncModel({
    this.token,
    this.womanToken,
    this.dateOfVisit,
    this.visitTime,
    this.motherStatus,
    this.babyStatus,
    this.advice,
    this.familyPlan,
    this.checkedBy,
  });

  String? token;
  String? womanToken;
  DateTime? dateOfVisit;
  String? visitTime;
  String? motherStatus;
  String? babyStatus;
  String? advice;
  String? familyPlan;
  String? checkedBy;

  factory PncModel.fromJson(Map<String, dynamic> json) => PncModel(
        token: json["token"],
        womanToken: json["woman_token"],
        dateOfVisit: DateTime.parse(json["date_of_visit"]),
        visitTime: json["visit_time"],
        motherStatus: json["mother_status"],
        babyStatus: json["baby_status"],
        advice: json["advice"],
        familyPlan: json["family_plan"],
        checkedBy: json["checked_by"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "woman_token": womanToken,
        "date_of_visit":
            "${dateOfVisit?.year.toString().padLeft(4, '0')}-${dateOfVisit?.month.toString().padLeft(2, '0')}-${dateOfVisit?.day.toString().padLeft(2, '0')}",
        "visit_time": visitTime,
        "mother_status": motherStatus,
        "baby_status": babyStatus,
        "advice": advice,
        "family_plan": familyPlan,
        "checked_by": checkedBy,
      };
}
