import 'package:flutter/material.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 作品类型，当插画和漫画合并展示时，以[illust]代替[illust]和[manga]两者作为整体
enum WorksType {
  illust,
  manga,
  mangaSeries,
  novel,
}

/// 展示范围
enum Reveal {
  /// 全部
  all,

  /// 公开的
  public,

  /// 非公开的
  private,
}

/// 适用于需要切换多种类型的作品时候使用；含作品类型[WorksType]、多个列表数据[List]、常用Filter属性[Reveal]与[tag]
class WorksProvider extends ChangeNotifier {
  // 加载状态
  LoadingStatus loadingStatus;

  /// 当前展示的作品类型
  WorksType currentWorksType;

  /// 展示范围
  Reveal reveal;

  /// 标签
  String? tag;

  /// 插画列表（漫画列表也可通用）
  List<CommonIllust> illustList = [];

  /// 漫画列表（插画列表也可通用）
  List<CommonIllust> mangaList = [];

  /// 小说列表
  List<CommonNovel> novelList = [];

  WorksProvider({
    this.loadingStatus = LoadingStatus.loading,
    this.currentWorksType = WorksType.illust,
    this.reveal = Reveal.all,
    this.tag,
  });

  notify() => notifyListeners();

  /// 重置插画列表（例如：刷新插画列表/切换到插画列表）
  void resetIllust(
    List<CommonIllust> illustList, {
    LoadingStatus loadingStatus = LoadingStatus.success,
    currentWorksType = WorksType.illust,
    Reveal? reveal,
    String? tag,
  }) {
    this.illustList.clear();
    this.illustList.addAll(illustList);
    this.loadingStatus = loadingStatus;
    this.currentWorksType = currentWorksType;
    if (reveal != null) this.reveal = reveal;
    if (tag != null) this.tag = tag;
    notifyListeners();
  }

  /// 重置漫画列表（例如：刷新漫画列表/切换到漫画列表）
  void resetManga(
    List<CommonIllust> mangaList, {
    LoadingStatus loadingStatus = LoadingStatus.success,
    currentWorksType = WorksType.manga,
    Reveal? reveal,
    String? tag,
  }) {
    this.mangaList.clear();
    this.mangaList.addAll(mangaList);
    this.loadingStatus = loadingStatus;
    this.currentWorksType = currentWorksType;
    if (reveal != null) this.reveal = reveal;
    if (tag != null) this.tag = tag;
    notifyListeners();
  }

  /// 重置小说列表（例如：刷新小说列表/切换到小说列表）
  void resetNovel(
    List<CommonNovel> novelList, {
    LoadingStatus loadingStatus = LoadingStatus.success,
    currentWorksType = WorksType.novel,
    Reveal? reveal,
    String? tag,
  }) {
    this.novelList.clear();
    this.novelList.addAll(novelList);
    this.loadingStatus = loadingStatus;
    this.currentWorksType = currentWorksType;
    if (reveal != null) this.reveal = reveal;
    if (tag != null) this.tag = tag;
    notifyListeners();
  }

  /// 追加插画（例如：懒加载的加载更多）
  void appendIllusts(List<CommonIllust> illustList) {
    this.illustList.addAll(illustList);
    notifyListeners();
  }

  /// 追加漫画（例如：懒加载的加载更多）
  void appendManga(List<CommonIllust> mangaList) {
    this.mangaList.addAll(mangaList);
    notifyListeners();
  }

  /// 追加小说（例如：懒加载的加载更多）
  void appendNovels(List<CommonNovel> novelList) {
    this.novelList.addAll(novelList);
    notifyListeners();
  }

  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  void setCurrentWorksType(WorksType type) {
    currentWorksType = type;
    notifyListeners();
  }
}
