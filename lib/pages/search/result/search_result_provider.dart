import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';

enum SearchType {
  /// 插画·漫画
  artworks,
  // 小说
  novels,

  /// 用户
  users,
}

class SearchResultProvider extends ChangeNotifier {
  // 加载状态
  LoadingStatus loadingStatus;

  /// 当前展示的作品类型
  SearchType searchType;

  /// 搜索结果的数据列表，私有化避免内部多类型共存
  List _list = [];

  /// 类型对应表
  final Map<Type, SearchType> typeMap = {
    CommonIllust: SearchType.artworks,
    CommonNovel: SearchType.novels,
    CommonUserPreviews: SearchType.users,
  };

  List<CommonIllust> get artworkList => (_list as List<CommonIllust>);
  List<CommonNovel> get novelList => (_list as List<CommonNovel>);
  List<CommonUserPreviews> get userList => (_list as List<CommonUserPreviews>);

  /// 下一页链接（共用）
  String? nextUrl;

  bool get isEmpty => _list.isEmpty;

  SearchResultProvider({
    this.loadingStatus = LoadingStatus.loading,
    this.searchType = SearchType.artworks,
  });

  notify() => notifyListeners();

  /// 重置列表
  void resetList<T>(
    List<T> list,
    String? nextUrl, {
    LoadingStatus loadingStatus = LoadingStatus.success,
  }) {
    if (!typeMap.containsKey(T)) throw Exception("The $T (T) is not found in support list: ${typeMap.keys.toString()}");
    _list.clear();
    _list = list;
    this.loadingStatus = loadingStatus;
    searchType = typeMap[T]!;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  /// 追加
  void appendList<T>(
    List<T> list,
    String? nextUrl, {
    LoadingStatus loadingStatus = LoadingStatus.success,
  }) {
    if (!typeMap.containsKey(T)) throw Exception("The $T (T) is not found in support list: ${typeMap.keys.toString()}");
    _list.addAll(list);
    this.nextUrl = nextUrl;
    this.loadingStatus = loadingStatus;
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  void setSearchType(SearchType type) {
    searchType = type;
    notifyListeners();
  }
}
