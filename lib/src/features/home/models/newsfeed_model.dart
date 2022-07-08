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
  });

  int? id;
  String? author;
  String? title;
  String? url;
  String? urlToVideo;
  String? urlToImage;
  String? publishedAt;

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        url: json["url"],
        urlToVideo: json["urlToVideo"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "url": url,
        "urlToVideo": urlToVideo,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
      };
}
