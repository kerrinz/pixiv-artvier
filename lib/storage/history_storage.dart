import 'dart:convert';

import 'package:artvier/base/base_storage.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

class HistoryStorage extends BaseStorage {
  HistoryStorage(super.sharedPreferences);

  static const String historyIllust = "history_illust";
  static const String historyNovel = "history_novel";

  List<CommonIllust> getHistoryIllust() {
    String? str = sharedPreferences.getString(historyIllust);
    if (str == null) return [];
    List<dynamic> list = json.decode(str);
    List<CommonIllust> illusts = [];
    for (dynamic illust in list) {
      illusts.add(CommonIllust.fromJson(illust));
    }
    list.clear();
    return illusts;
  }

  Future<bool> setHistoryIllust(List<CommonIllust> list) {
    return sharedPreferences.setString(historyIllust, jsonEncode(list));
  }

  /// 添加一条插画的历史记录，如果已有记录会拉到顶部
  Future addIllust(CommonIllust illust) async {
    List<CommonIllust> illusts = getHistoryIllust();
    for (int i = 0; i < illusts.length; i++) {
      if (illusts[i].id == illust.id) {
        // 找到已有记录的重复项并删除
        illusts.removeAt(i);
        break;
      }
    }
    illusts.insert(0, illust);
    return await sharedPreferences.setString(historyIllust, jsonEncode(illusts));
  }

  // 清空插画的历史记录
  Future<bool> clearIllusts() async {
    return await sharedPreferences.setString(historyIllust, jsonEncode([]));
  }
}
