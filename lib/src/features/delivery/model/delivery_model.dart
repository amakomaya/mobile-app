// To parse this JSON data, do
//
//     final deliverymodel = deliverymodelFromJson(jsonString);

import 'dart:convert';

Deliverymodel deliverymodelFromJson(String str) =>
    Deliverymodel.fromJson(json.decode(str));

String deliverymodelToJson(Deliverymodel data) => json.encode(data.toJson());

class Deliverymodel {
  Deliverymodel({
    this.token,
    this.womanToken,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryPlace,
    this.presentation,
    this.deliveryType,
    this.complexity,
    this.otherProblem,
    this.advice,
    this.deliveryBy,
  });

  String? token;
  String? womanToken;
  DateTime? deliveryDate;
  String? deliveryTime;
  String? deliveryPlace;
  String? presentation;
  String? deliveryType;
  Complexity? complexity;
  String? otherProblem;
  String? advice;
  String? deliveryBy;

  factory Deliverymodel.fromJson(Map<String, dynamic> json) => Deliverymodel(
        token: json["token"],
        womanToken: json["woman_token"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        deliveryTime: json["delivery_time"],
        deliveryPlace: json["delivery_place"],
        presentation: json["presentation"],
        deliveryType: json["delivery_type"],
        complexity: Complexity.fromJson(json["complexity"]),
        otherProblem: json["other_problem"],
        advice: json["advice"],
        deliveryBy: json["delivery_by"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "woman_token": womanToken,
        "delivery_date":
            "${deliveryDate?.year.toString().padLeft(4, '0')}-${deliveryDate?.month.toString().padLeft(2, '0')}-${deliveryDate?.day.toString().padLeft(2, '0')}",
        "delivery_time": deliveryTime,
        "delivery_place": deliveryPlace,
        "presentation": presentation,
        "delivery_type": deliveryType,
        "complexity": complexity?.toJson(),
        "other_problem": otherProblem,
        "advice": advice,
        "delivery_by": deliveryBy,
      };
}

class Complexity {
  Complexity({
    this.excessBloodflow,
    this.the12HrsLaborPain,
    this.placentalRetention,
  });

  String? excessBloodflow;
  String? the12HrsLaborPain;
  String? placentalRetention;

  factory Complexity.fromJson(Map<String, dynamic> json) => Complexity(
        excessBloodflow: json["Excess Bloodflow"],
        the12HrsLaborPain: json["12 Hrs Labor pain"],
        placentalRetention: json["Placental Retention"],
      );

  Map<String, dynamic> toJson() => {
        "Excess Bloodflow": excessBloodflow,
        "12 Hrs Labor pain": the12HrsLaborPain,
        "Placental Retention": placentalRetention,
      };
}
