import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';
import '../model/user_model.dart';

class CachedValues {
  Future<Box> openUserBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }

  setWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openUserBox();
    await box.clear();
    final data = tips.map((e) => e.toJson()).toList();
    print(data.toString());
    await box.put(Consts.user_info_key, {"data": data});
  }

  getWeeklyTips() async {
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
