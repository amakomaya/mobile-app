// To parse this JSON data, do
//
//     final newsFeedModel = newsFeedModelFromJson(jsonString);

import 'dart:convert';

NewsFeedModel newsFeedModelFromJson(String str) =>
    NewsFeedModel.fromJson(json.decode(str));

String newsFeedModelToJson(NewsFeedModel data) => json.encode(data.toJson());

class NewsFeedModel {
  NewsFeedModel({
    this.id,
    this.author,
    this.title,
    this.url,
    this.urlToVideo,
    this.urlToImage,
    this.publishedAt,
    this.type,
    this.desc,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? author;
  String? title;
  String? url;
  String? urlToVideo;
  String? urlToImage;
  String? publishedAt;
  String? type;
  String? desc;
  String? createdAt;
  String? updatedAt;

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        url: json["url"],
        urlToVideo: json["url_to_video"],
        urlToImage: json["url_to_image"],
        publishedAt: json["published_at"],
        type: json["type"],
        desc: json["desc"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "url": url,
        "urlToVideo": urlToVideo,
        "urlToImage": urlToImage,
        "published_at": publishedAt,
        "type": type,
        "desc": desc,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
