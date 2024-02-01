import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/weekly_tips/model/weekly_tips_model.dart';

import '../../constant/app_constants.dart';

class WeeklyCachedValues {
  Future<Box> openUserBox() async {

    final box = await Hive.openBox<Map>(Consts.weekyl_info);
    return box;
  }

  setWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openUserBox();

    final data = tips.map((e) => e.toJson()).toList();
    await box.put('weekltTipsKey', {"data": data});
  }

  Future<List<WeeklyTips>?> getWeeklyTips() async {
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
