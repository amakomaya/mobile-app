
import 'dart:convert';

List<Faqsmodel> faqsmodelFromJson(String str) => List<Faqsmodel>.from(json.decode(str).map((x) => Faqsmodel.fromJson(x)));

String faqsmodelToJson(List<Faqsmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faqsmodel {
  int id;
  String questionEn;
  String questionNp;
  String slug;
  String answerEn;
  String answerNp;
  String keywords;
  String mediaLinks;
  int categoryId;
  int weekId;
  int listOrder;

  Faqsmodel({
    required this.id,
    required this.questionEn,
    required this.questionNp,
    required this.slug,
    required this.answerEn,
    required this.answerNp,
    required this.keywords,
    required this.mediaLinks,
    required this.categoryId,
    required this.weekId,
    required this.listOrder,
  });

  factory Faqsmodel.fromJson(Map<String, dynamic> json) => Faqsmodel(
    id: json["id"],
    questionEn: json["question_en"],
    questionNp: json["question_np"],
    slug: json["slug"],
    answerEn: json["answer_en"],
    answerNp: json["answer_np"],
    keywords: json["keywords"],
    mediaLinks: json["media_links"],
    categoryId: json["category_id"],
    weekId: json["week_id"],
    listOrder: json["list_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_en": questionEn,
    "question_np": questionNp,
    "slug": slug,
    "answer_en": answerEn,
    "answer_np": answerNp,
    "keywords": keywords,
    "media_links": mediaLinks,
    "category_id": categoryId,
    "week_id": weekId,
    "list_order": listOrder,
  };
}

