// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'package:hive/hive.dart';

import 'dart:convert';

ForgetPasswordModel forgetPasswordFromJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordToJson(ForgetPasswordModel data) => json.encode(data.toJson());

class ForgetPasswordModel{
  ForgetPasswordModel({
    this.link
  });

  String? link;

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    link: json["link"]
      );

  Map<String, dynamic> toJson() => {
        "link": link,

      };
}
