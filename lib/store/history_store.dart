// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:pixgem/model_response/illusts/common_illust.dart';

import 'global.dart';

class HistoryStore {
  static const String HISTORY_ILLUST = "history_illust";
  static const String HISTORY_NOVEL = "history_novel";

  static List<CommonIllust> getHistoryIllust() {
    String? str = GlobalStore.globalSharedPreferences.getString(HISTORY_ILLUST);
    if (str == null) return [];
    List<dynamic> list = json.decode(str);
    List<CommonIllust> illusts = [];
    for (dynamic illust in list) {
      illusts.add(CommonIllust.fromJson(illust));
    }
    list.clear();
    return illusts;
  }

  static Future<bool> setHistoryIllust(List<CommonIllust> list) {
    return GlobalStore.globalSharedPreferences.setString(HISTORY_ILLUST, jsonEncode(list));
  }

  // 添加一条插画的历史记录，如果已有记录会拉到顶部（性能欠佳）
  static Future addIllust(CommonIllust illust) async {
    List<CommonIllust> illusts = getHistoryIllust();
    for (int i = 0; i < illusts.length; i++) {
      if (illusts[i].id == illust.id) {
        // 找到已有记录的重复项并删除
        illusts.removeAt(i);
        break;
      }
    }
    illusts.insert(0, illust);
    return await GlobalStore.globalSharedPreferences.setString(HISTORY_ILLUST, jsonEncode(illusts));
  }

  // 清空插画的历史记录
  static Future<bool> clearIllusts() async {
    return await GlobalStore.globalSharedPreferences.setString(HISTORY_ILLUST, jsonEncode([]));
  }
}
