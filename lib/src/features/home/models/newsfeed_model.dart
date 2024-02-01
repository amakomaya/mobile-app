// To parse this JSON data, do
//
//     final newsFeedModel = newsFeedModelFromJson(jsonString);

import 'dart:convert';

NewsFeedModel newsFeedModelFromJson(String str) => NewsFeedModel.fromJson(json.decode(str));

String newsFeedModelToJson(NewsFeedModel data) => json.encode(data.toJson());

class NewsFeedModel {
  UserDetailData userDetail;
  List<NewsFeedData> data;

  NewsFeedModel({
    required this.userDetail,
    required this.data,
  });

  factory NewsFeedModel.fromJson(Map<String, dynamic> json) => NewsFeedModel(
    userDetail: UserDetailData.fromJson(json["user_detail"]),
    data: List<NewsFeedData>.from(json["data"].map((x) => NewsFeedData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_detail": userDetail.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NewsFeedData {
  int? id;
  String? type;
  String? url;
  String? urlToVideo;
  String? author;
  String? title;
  String? desc;
  String? urlToImage;
  String? publishedAt;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewsFeedData({
    required this.id,
    required this.type,
    this.url,
    this.urlToVideo,
    required this.author,
    required this.title,
    required this.desc,
    required this.urlToImage,
    required this.publishedAt,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsFeedData.fromJson(Map<String, dynamic> json) => NewsFeedData(
    id: json["id"],
    type: json["type"],
    url: json["url"],
    urlToVideo: json["url_to_video"],
    author: json["author"],
    title: json["title"],
    desc: json["desc"],
    urlToImage: json["url_to_image"],
    publishedAt: json["published_at"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "url": url,
    "url_to_video": urlToVideo,
    "author": author,
    "title": title,
    "desc": desc,
    "url_to_image": urlToImage,
    "published_at": publishedAt,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class UserDetailData {
  String userMode;
  String profileImage;
  String tollFreeNo;

  UserDetailData({
    required this.userMode,
    required this.profileImage,
    required this.tollFreeNo,
  });

  factory UserDetailData.fromJson(Map<String, dynamic> json) => UserDetailData(
    userMode: json["user_mode"],
    profileImage: json["profile_image"],
    tollFreeNo: json["toll_free_no"],
  );

  Map<String, dynamic> toJson() => {
    "user_mode": userMode,
    "profile_image": profileImage,
    "toll_free_no": tollFreeNo,
  };
}
