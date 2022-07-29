import 'dart:convert';

import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';

class CachedValues {
  Future<Box> openUserBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }

  Future<Box> openVideosBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>('videoBox');
    return box;
  }

  //VideoList
  getVideosList() async {
    final box = await openVideosBox();

    final data = await (box.get("videoKey"));

    if (data != null) {
      final videos =
          (data["videos"] as List).map((e) => VideoModel.fromJson(e)).toList();
      return videos;
    } else {
      return null;
    }
  }

  setVideoList(List<VideoModel> videos) async {
    final box = await openVideosBox();
    await box.clear();
    final data = videos.map((e) => e.toJson()).toList();

    await box.put("videoKey", {"videos": data});
  }

  //end videoslist

  setWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openUserBox();
    await box.clear();
    final data = tips.map((e) => e.toJson()).toList();
    print(data.toString());
    await box.put(Consts.user_info_key, {"data": data});
  }

  getWeeklyTips() async {
    final box = await openUserBox();

    final data = await (box.get(Consts.user_info_key));
    if (data != null) {
      final tips =
          (data["data"] as List).map((e) => WeeklyTips.fromJson(e)).toList();
      return tips;
    } else {
      return null;
    }
  }

  // saveWeeklyTips(List<WeeklyTips> tips) async {
  //   final box = await openWeeklyBox();
  //   // final v = await box.add(tips.map((e) => e.toJson()).toList());
  //   for (int i = 0; i < tips.length; i++) {
  //     final json = tips[i].toJson();
  //     print(json);
  //     box.add(json);
  //   }
  //   print(box.toString()+'hh');
  // }

  // getWeeklyTips() async {
  //   final Box tipsBox = await openWeeklyBox();

  //  final list=[];
  //  final li=(tipsBox.values as List).map((e) => WeeklyTips.fromJson(e)).toList();
  //  print(li[0].descriptionEn);
  //  return li;

//     final map =
//         tipsBox.toMap().values.toList().map((e) => WeeklyTips.fromJson(e)).toList();
//     print(map[1].toString()+'kk');
//  print(map[2].toString()+'kk');
//     return map;

  //   final data = await tipsBox.get(Consts.weekly_data_key);
  //   print(data.toString() + 'fff');
  //   if (data != null) {
  //     final list = (data).map((e) => WeeklyTips.fromJson(e)).toList();
  //     print(list.toString() + 'sdds');
  //     return list;
  //   }
  //   return data;
  // }
}
