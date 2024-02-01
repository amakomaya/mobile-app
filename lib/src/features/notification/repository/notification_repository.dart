import 'dart:convert';
import 'dart:html';

import 'package:Amakomaya/src/core/network_services/urls.dart';
import 'package:Amakomaya/src/features/notification/model/notification_model.dart';
import 'package:Amakomaya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/cache/weekly_cache/cache_values.dart';

class NotificationRepo {
  Dio dio;
  SharedPreferences prefs;
  NotificationRepo(this.dio, this.prefs);
  Response? response;

  getNotification() async {
    try {
      final response = await dio.get(
        Urls.getWeeklyTips,
      );
      if (response.statusCode == 200) {
        final weekly = response.data as List;

        prefs.setString('NotificationData', jsonEncode(weekly));
        final List<NotificationModel> data = (response.data as List)
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        return data;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw (e.response?.data['message']);
      } else {
        throw ('Unexpected Error Occured');
      }
    }
  }
}
