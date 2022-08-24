import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideosRepo {
  Dio dio;
  SharedPreferences prefs;
  VideosRepo(this.dio,this.prefs);
  getVideos() async {
    try {
      final response = await dio.get(
        Urls.getVideosUrl,
      );
      if (response.statusCode == 200) {
        await prefs.setString('videos', jsonEncode(response.data));
        final List<VideoModel> data = (response.data as List)
            .map((json) => VideoModel.fromJson(json))
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
