// To parse this JSON data, do
//
//     final faqsmodel = faqsmodelFromJson(jsonString);

import 'dart:convert';

Faqsmodel faqsmodelFromJson(String str) => Faqsmodel.fromJson(json.decode(str));

String faqsmodelToJson(Faqsmodel data) => json.encode(data.toJson());

class Faqsmodel {
  Faqsmodel({
    this.id,
    this.question,
    this.slug,
    this.answer,
    this.keywords,
    this.mediaLinks,
    this.categoryId,
    this.weekId,
    this.listOrder,
  });

  int? id;
  String? question;
  String? slug;
  String? answer;
  String? keywords;
  String? mediaLinks;
  int? categoryId;
  int? weekId;
  int? listOrder;

  factory Faqsmodel.fromJson(Map<String, dynamic> json) => Faqsmodel(
        id: json["id"],
        question: json["question"],
        slug: json["slug"],
        answer: json["answer"],
        keywords: json["keywords"],
        mediaLinks: json["media_links"],
        categoryId: json["category_id"],
        weekId: json["week_id"],
        listOrder: json["list_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "slug": slug,
        "answer": answer,
        "keywords": keywords,
        "media_links": mediaLinks,
        "category_id": categoryId,
        "week_id": weekId,
        "list_order": listOrder,
      };
}
