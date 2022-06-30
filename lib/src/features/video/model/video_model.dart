// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
    VideoModel({
       required this.id,
    required    this.titleEn,
       required this.titleNp,
      required  this.thumbnail,
       required this.path,
      required  this.descriptionEn,
      required  this.descriptionNp,
     required   this.weekId,
     required   this.createdAt,
    required    this.updatedAt,
    });

    int id;
    String titleEn;
    String titleNp;
    String thumbnail;
    String path;
    String descriptionEn;
    String descriptionNp;
    int weekId;
    DateTime createdAt;
    DateTime updatedAt;

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        titleEn: json["title_en"],
        titleNp: json["title_np"],
        thumbnail: json["thumbnail"],
        path: json["path"],
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
        "thumbnail": thumbnail,
        "path": path,
        "description_en": descriptionEn,
        "description_np": descriptionNp,
        "week_id": weekId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
