import 'dart:convert';

import 'package:hive/hive.dart';


part 'weekly_tips_model.g.dart';
List<WeeklyTips> weeklyTipsFromJson(String str) =>
    List<WeeklyTips>.from(json.decode(str).map((x) => WeeklyTips.fromJson(x)));

String weeklyTipsToJson(List<WeeklyTips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 0)
class WeeklyTips extends HiveObject{
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

  @HiveField(0)
  int id;
  @HiveField(1)
  String titleEn;
  @HiveField(2)
  String titleNp;
  @HiveField(3)
  String descriptionEn;
  @HiveField(4)
  String descriptionNp;
  @HiveField(5)
  int weekId;
  @HiveField(6)
  DateTime createdAt;
  @HiveField(7)
  DateTime updatedAt;

  factory WeeklyTips.fromJson(Map<dynamic, dynamic> json) => WeeklyTips(
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
