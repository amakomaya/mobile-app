// To parse this JSON data, do
//
//     final audioModel = audioModelFromJson(jsonString);

import 'dart:convert';

AudioModel audioModelFromJson(String str) =>
    AudioModel.fromJson(json.decode(str));

String audioModelToJson(AudioModel data) => json.encode(data.toJson());

class AudioModel {
  AudioModel({
    required this.id,
    required this.titleEn,
    required this.titleNp,
    required this.thumbnail,
    required this.path,
    required this.weekId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String titleEn;
  String titleNp;
  String thumbnail;
  String path;
  int weekId;
  DateTime createdAt;
  DateTime updatedAt;

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        id: json["id"],
        titleEn: json["title_en"],
        titleNp: json["title_np"],
        thumbnail: json["thumbnail"],
        path: json["path"],
        weekId: json["week_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_en": titleEn,
        "title_np": titleNp,
        "thumbnail": thumbnail,
        "path": path,
        "week_id": weekId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
