import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:dio/dio.dart';

class WeeklyTipsRepo {
  Dio dio;
  WeeklyTipsRepo(this.dio);
  Response? response;

  getWeeklyTips() async {
    try {
      final response = await dio.get(
        Urls.getWeeklyTips,
      );
      if (response.statusCode == 200) {
        final List<WeeklyTips> data = (response.data as List).map((json) => WeeklyTips.fromJson(json)).toList();
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
