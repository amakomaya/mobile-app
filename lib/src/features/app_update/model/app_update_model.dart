// To parse this JSON data, do
//
//     final appUpdateModel = appUpdateModelFromJson(jsonString);

import 'dart:convert';

AppUpdateModel appUpdateModelFromJson(String str) => AppUpdateModel.fromJson(json.decode(str));

String appUpdateModelToJson(AppUpdateModel data) => json.encode(data.toJson());

class AppUpdateModel {
    bool status;
    AppUpdateData android;
    AppUpdateData ios;

    AppUpdateModel({
        required this.status,
        required this.android,
        required this.ios,
    });

    factory AppUpdateModel.fromJson(Map<String, dynamic> json) => AppUpdateModel(
        status: json["status"],
        android: AppUpdateData.fromJson(json["android"]),
        ios: AppUpdateData.fromJson(json["ios"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "android": android.toJson(),
        "ios": ios.toJson(),
    };
}

class AppUpdateData {
    String platform;
    String title;
    String message;
    String version;
    String updateAction;

    AppUpdateData({
        required this.platform,
        required this.title,
        required this.message,
        required this.version,
        required this.updateAction,
    });

    factory AppUpdateData.fromJson(Map<String, dynamic> json) => AppUpdateData(
        platform: json["platform"],
        title: json["title"],
        message: json["message"],
        version: json["version"],
        updateAction: json["update_action"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "title": title,
        "message": message,
        "version": version,
        "update_action": updateAction,
    };
}
