import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/cache/weekly_cache/cache_values.dart';

class WeeklyTipsRepo {
  Dio dio;
  SharedPreferences prefs;
  WeeklyTipsRepo(this.dio, this.prefs);
  Response? response;

  getWeeklyTips() async {
    try {
      final response = await dio.get(
        Urls.getWeeklyTips,
      );
      if (response.statusCode == 200) {
        final weekly = response.data as List;

        prefs.setString('weeklyTips', jsonEncode(weekly));
        final List<WeeklyTips> data = (response.data as List)
            .map((json) => WeeklyTips.fromJson(json))
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
