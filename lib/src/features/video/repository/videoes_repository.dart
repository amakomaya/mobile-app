import 'dart:convert';

import 'package:aamako_maya/src/core/network_services/urls.dart';
import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:aamako_maya/src/features/weekly_tips/model/weekly_tips_model.dart';
import 'package:dio/dio.dart';

class VideosRepo {
  Response? response;
  var dio = Dio();
  getVideos() async {
    try {
      final response = await dio.get(
        Urls.getVideosUrl,
      );
      if (response.statusCode == 200) {
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
