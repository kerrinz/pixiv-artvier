import 'package:flutter/widgets.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';

class SearchProvider with ChangeNotifier {
  List<TrendTags>? trendTags; // 热门标签
  bool isExistText = false; // 搜索框是否存在文字

  void setTags(List<TrendTags> tags) {
    trendTags = tags;
    notifyListeners();
  }

  void setIsExistText(bool isExist) {
    isExistText = isExist;
    notifyListeners();
  }
}
