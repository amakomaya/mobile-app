
import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/weekly_tips/model/weekly_tips_model.dart';


class NewsFeedCache {
  Future<Box> openNewsFeed() async {
    final box = await Hive.openBox<Map>('VideosBox');
    return box;
  }

  setWeeklyTips(List<WeeklyTips> tips) async {
    final box = await openNewsFeed();

    final data = tips.map((e) => e.toJson()).toList();
    await box.put('weekltTipsKey', {"data": data});
  }

  Future<List<WeeklyTips>?> getWeeklyTips() async {
    final box = await openNewsFeed();
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
