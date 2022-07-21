// To parse this JSON data, do
//
//     final symptomsmodel = symptomsmodelFromJson(jsonString);

import 'dart:convert';

Symptomsmodel symptomsmodelFromJson(String str) =>
    Symptomsmodel.fromJson(json.decode(str));

String symptomsmodelToJson(Symptomsmodel data) => json.encode(data.toJson());

class Symptomsmodel {
  Symptomsmodel({
    this.womenToken,
    this.headache,
    this.vaginaBleed,
    this.trembleOrFaint,
    this.eyesBlur,
    this.abdominalPain,
    this.feverHundred,
    this.difficultBreathe,
    this.coughAndCold,
    this.symptomsType,
    this.otherProblems,
    this.longitude,
    this.latitude,
    this.createdAt,
  });

  String? womenToken;
  int? headache;
  int? vaginaBleed;
  int? trembleOrFaint;
  int? eyesBlur;
  int? abdominalPain;
  int? feverHundred;
  int? difficultBreathe;
  int? coughAndCold;
  int? symptomsType;
  String? otherProblems;
  dynamic longitude;
  dynamic latitude;
  DateTime? createdAt;

  factory Symptomsmodel.fromJson(Map<String, dynamic> json) => Symptomsmodel(
        womenToken: json["women_token"],
        headache: json["headache"],
        vaginaBleed: json["vagina_bleed"],
        trembleOrFaint: json["tremble_or_faint"],
        eyesBlur: json["eyes_blur"],
        abdominalPain: json["abdominal_pain"],
        feverHundred: json["fever_hundred"],
        difficultBreathe: json["difficult_breathe"],
        coughAndCold: json["cough_and_cold"],
        symptomsType: json["symptoms_type"],
        otherProblems: json["other_problems"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "women_token": womenToken,
        "headache": headache,
        "vagina_bleed": vaginaBleed,
        "tremble_or_faint": trembleOrFaint,
        "eyes_blur": eyesBlur,
        "abdominal_pain": abdominalPain,
        "fever_hundred": feverHundred,
        "difficult_breathe": difficultBreathe,
        "cough_and_cold": coughAndCold,
        "symptoms_type": symptomsType,
        "other_problems": otherProblems,
        "longitude": longitude,
        "latitude": latitude,
        "created_at": createdAt?.toIso8601String(),
      };
}
