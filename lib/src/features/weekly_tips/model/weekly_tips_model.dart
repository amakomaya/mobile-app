import 'dart:convert';

List<WeeklyTips> weeklyTipsFromJson(String str) =>
    List<WeeklyTips>.from(json.decode(str).map((x) => WeeklyTips.fromJson(x)));

String weeklyTipsToJson(List<WeeklyTips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeeklyTips {
  WeeklyTips({
    required this.id,
    required this.titleEn,
    required this.titleNp,
    required this.descriptionEn,
    required this.descriptionNp,
    required this.weekId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String titleEn;
  String titleNp;
  String descriptionEn;
  String descriptionNp;
  int weekId;
  DateTime createdAt;
  DateTime updatedAt;

  factory WeeklyTips.fromJson(Map<String, dynamic> json) => WeeklyTips(
        id: json["id"],
        titleEn: json["title_en"],
        titleNp: json["title_np"],
        descriptionEn: json["description_en"],
        descriptionNp: json["description_np"],
        weekId: json["week_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_np": titleNp,
        "description_en": descriptionEn,
        "description_np": descriptionNp,
        "week_id": weekId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
