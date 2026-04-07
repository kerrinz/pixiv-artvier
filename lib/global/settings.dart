import 'dart:io';

import 'package:artvier/config/enums.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/preferences/resource_load_store.dart';

/// 全局设置，
/// 只包含不需要状态管理的全局设置
/// 有状态管理的全局设置在 ./provider 目录下
class GlobalSettings extends HttpOverrides {
  factory GlobalSettings() => _instance;

  static final GlobalSettings _instance = GlobalSettings._();

  static GlobalSettings get instance => _instance;

  GlobalSettings._() {
    _init();
  }

  _init() {
    final resourceLoadStorage = ResourceLoadStorage(globalSharedPreferences);
    _listPreviewQuality = resourceLoadStorage.listPreviewQuality();
    _mangaDetailsQuality = resourceLoadStorage.mangaDetailsQuality();
    _illustDetailsQuality = resourceLoadStorage.illustDetailsQuality();
  }

  /// 列表预览画质
  ListPreviewQuality _listPreviewQuality = ListPreviewQuality.medium;

  /// 漫画详情页画质
  DetailsPageQuality _mangaDetailsQuality = DetailsPageQuality.large;

  /// 插画详情页画质
  DetailsPageQuality _illustDetailsQuality = DetailsPageQuality.large;

  ListPreviewQuality get listPreviewQuality => _listPreviewQuality;
  DetailsPageQuality get mangaDetailsQuality => _mangaDetailsQuality;
  DetailsPageQuality get illustDetailsQuality => _illustDetailsQuality;

  void setListPreviewQuality(ListPreviewQuality quality) {
    _listPreviewQuality = quality;
  }

  void setMangaDetailsQuality(DetailsPageQuality quality) {
    _mangaDetailsQuality = quality;
  }

  void setIllustDetailsQuality(DetailsPageQuality quality) {
    _illustDetailsQuality = quality;
  }
}
