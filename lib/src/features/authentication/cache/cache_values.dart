import 'dart:convert';

import 'package:aamako_maya/src/features/video/model/video_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';

class CachedValues {
  Future<Box> openUserBox() async {
    await Hive.close();
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }

  Future<Box> openVideosBox() async {
    await Hive.close();
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>('videoBox');
    return box;
  }

  //VideoList
  getVideosList() async {
    try {
      await Hive.close();
      final box = await openVideosBox();

      // final data = await (box.get("videoKey")["videos"]);
      var data = box.get("videoKey");

      if (data != null) {
        final videos = (data["videos"] as List)
            .map((e) => VideoModel.fromJson(e))
            .toList();
        // final videos=[VideoModel(id: 1, titleEn: "titleEn", titleNp: "titleNp", thumbnail: "thumbnail", path: 'path', descriptionEn: 'descriptionEn', descriptionNp: 'descriptionNp', weekId: 4, createdAt:DateTime.now(), updatedAt: DateTime.now())];

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
    await Hive.close();
    try {
      final box = await openVideosBox();
      await box.clear();
      final data = videos.map((e) => e.toJson()).toList();

      await box.put("videoKey", {"videos": data});
    } catch (e) {
      debugPrint(e.toString() + 'LIST');
      debugPrint(e.toString());
    }
  }

  //end videoslist

  setWeeklyTips(List<WeeklyTips> tips) async {
    await Hive.close();
    final box = await openUserBox();
    await box.clear();
    final data = tips.map((e) => e.toJson()).toList();
    print(data.toString() + 'msa,mas');
    await box.put(Consts.user_info_key, {"data": data});
  }

  getWeeklyTips() async {
    await Hive.close();
    final box = await openUserBox();

    final data = (box.get(Consts.user_info_key));
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
