import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';

class SearchProvider extends BaseProvider {
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
