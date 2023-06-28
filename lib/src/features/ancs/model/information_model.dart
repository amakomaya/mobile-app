// To parse this JSON data, do
//
//     final informationModel = informationModelFromJson(jsonString);

import 'dart:convert';

InformationModel informationModelFromJson(String str) => InformationModel.fromJson(json.decode(str));

String informationModelToJson(InformationModel data) => json.encode(data.toJson());

class InformationModel {
  String titleEn;
  String titleNp;
  String shortDescEn;
  String shortDescNp;
  String contentEn;
  String contentNp;

  InformationModel({
    required this.titleEn,
    required this.titleNp,
    required this.shortDescEn,
    required this.shortDescNp,
    required this.contentEn,
    required this.contentNp,
  });

  factory InformationModel.fromJson(Map<String, dynamic> json) => InformationModel(
    titleEn: json["title_en"],
    titleNp: json["title_np"],
    shortDescEn: json["short_desc_en"],
    shortDescNp: json["short_desc_np"],
    contentEn: json["content_en"],
    contentNp: json["content_np"],
  );

  Map<String, dynamic> toJson() => {
    "title_en": titleEn,
    "title_np": titleNp,
    "short_desc_en": shortDescEn,
    "short_desc_np": shortDescNp,
    "content_en": contentEn,
    "content_np": contentNp,
  };
}
