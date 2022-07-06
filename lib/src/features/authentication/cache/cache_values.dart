import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/app_constants.dart';
import '../../weekly_tips/model/weekly_tips_model.dart';
import '../model/user_model.dart';

class CachedValues {
  Future<Box<Map<dynamic, dynamic>>> openUserBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox<Map>(Consts.user_info);
    return box;
  }

  openWeeklyBox() async {
    // Open your boxes. Optional: Give it a type.
    final box = await Hive.openBox(Consts.weekly_data);
    return box;
  }

  //  Future<UserModel?> getUserInfo() async{

  //   final box=openUserBox();

  //   String? userInfo = box.put(Consts.user_info);
  //   if (userInfo != null) {
  //     // jsonDecode and parse the json to opject
  //     UserModel userInfoDecoded =
  //         UserModel.fromJson(jsonDecode(userInfo) as Map<String, dynamic>);
  //     return userInfoDecoded;
  //   }
  //   return null;
  // }

  setUserInfo(UserModel userData) async {
    final box = await openUserBox();
    await box.put(Consts.user_info_key, userData.toJson());
  }

  saveWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openWeeklyBox();
    final v = await box.put(
        Consts.weekly_data_key, tips.map((e) => e.toJson()).toList());
  }

Future<List<WeeklyTips>>?  getWeeklyTips() async {
    final tipsBox = await openWeeklyBox();
    print(tipsBox.name);

    final data = await tipsBox.get(Consts.weekly_data_key);
    print(data.toString() + 'fff');
    if (data != null) {
      final list = (data).map((e) => WeeklyTips.fromJson(e)).toList();
      print(list.toString() + 'sdds');
      return list;
    }
    return data;
  }
}
