import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';
import '../model/user_model.dart';

class CachedValues {
  Future<Box<Map<dynamic, dynamic>>> openUserBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }


  

  setUserInfo(UserModel userData) async {
    final box = await openUserBox();
    await box.put(Consts.user_info_key, userData.toJson());
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
