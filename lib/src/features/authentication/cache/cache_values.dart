import 'dart:convert';

import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';

class CachedValues {
  Future<Box> openUserBox() async {
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }

  //VideoList
  getVideosList() async {
    try {
      final box = await openUserBox();

      var data = box.get("videoKey");

      if (data != null) {
        final videos = (data["videos"] as List)
            .map((e) => VideoModel.fromJson(e))
            .toList();

        return videos;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString() + 'GIsk');
      return null;
    }
  }

  setVideoList(List<VideoModel> videos) async {
    try {
      final box = await openUserBox();

      final data = videos.map((e) => e.toJson()).toList();

      await box.put("videoKey", {"videos": data});
    } catch (e) {
      debugPrint(e.toString() + 'LIST');
      debugPrint(e.toString());
    }
  }

  //end videoslist

  setWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openUserBox();

    final data = tips.map((e) => e.toJson()).toList();
    await box.put('weekltTipsKey', {"data": data});
  }

  getWeeklyTips() async {
    final box = await openUserBox();
    final data = (box.get('weekltTipsKey'));
    if (data != null) {
      final tips =
          (data["data"] as List).map((e) => WeeklyTips.fromJson(e)).toList();
      return tips;
    } else {
      return null;
    }
  }
}
