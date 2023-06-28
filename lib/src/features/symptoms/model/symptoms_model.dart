// To parse this JSON data, do
//
//     final symptomsmodel = symptomsmodelFromJson(jsonString);

import 'dart:convert';

Symptomsmodel symptomsmodelFromJson(String str) =>
    Symptomsmodel.fromJson(json.decode(str));

String symptomsmodelToJson(Symptomsmodel data) => json.encode(data.toJson());

class Symptomsmodel {
  Symptomsmodel({
    this.healthCondition,
    this.headache,
    this.vaginaBleed,
    this.vaginalDischarge,
    this.trembleOrFaint,
    this.eyesBlur,
    this.abdominalPain,
    this.feverDegree,
    this.fever,
    this.difficultBreathe,
    this.coughAndCold,
    this.otherProblems,
    this.laborPain,
    this.cordProtrusion,
    this.excessiveBleedingBirth,
    this.lowerAbdominalPain,
    this.dizzinessFaint,
    this.createdAt,
    this.comments
  });

  int? healthCondition;
  int? headache;
  int? vaginaBleed;
  int? vaginalDischarge;
  int? trembleOrFaint;
  int? eyesBlur;
  int? abdominalPain;
  int? feverDegree;
  int? fever;
  int? difficultBreathe;
  int? coughAndCold;
  int? laborPain;
  int? cordProtrusion;
  int? excessiveBleedingBirth;
  int? lowerAbdominalPain;
  int? dizzinessFaint;
  String? otherProblems;
  DateTime? createdAt;
  String? comments;

  factory Symptomsmodel.fromJson(Map<String, dynamic> json) => Symptomsmodel(
    healthCondition: json["health_condition"],
        headache: json["headache"],
        vaginaBleed: json["vaginal_bleeding"],
    vaginalDischarge: json["vaginal_discharge"],
        trembleOrFaint: json["trembling_hands_feet"],
        eyesBlur: json["blurred_eyes"],
        abdominalPain: json["first_month_abdominal_pain"],
    feverDegree: json["fever_degree"],
    fever: json["fever"],
        difficultBreathe: json["breathing_difficulty"],
        coughAndCold: json["cough_cold"],
        otherProblems: json["other_symptoms"],
    laborPain: json["labor_pain"],
    cordProtrusion: json["cord_protrusion"],
    excessiveBleedingBirth: json["excessive_bleeding_birth"],
    lowerAbdominalPain: json["lower_abdominal_pain"],
    dizzinessFaint: json["dizziness_faint"],
        comments: json["comments"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "health_condition": healthCondition,
        "headache": headache,
        "comments":comments,
        "vaginal_bleeding": vaginaBleed,
        "vaginal_discharge": vaginalDischarge,
        "trembling_hands_feet": trembleOrFaint,
        "fever": fever,
        "blurred_eyes": eyesBlur,
        "first_month_abdominal_pain": abdominalPain,
        "fever_degree": feverDegree,
        "breathing_difficulty": difficultBreathe,
        "cough_cold": coughAndCold,
        "labor_pain": laborPain,
        "cord_protrusion": cordProtrusion,
        "excessive_bleeding_birth": excessiveBleedingBirth,
        "lower_abdominal_pain": lowerAbdominalPain,
        "dizziness_faint": dizzinessFaint,
        "other_symptoms": otherProblems,
        "created_at": createdAt?.toIso8601String(),
      };
}
