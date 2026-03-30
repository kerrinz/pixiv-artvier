import 'package:artvier/base/base_storage.dart';
import 'package:artvier/config/enums.dart';

/// 资源加载相关设置的存储
class ResourceLoadStorage extends BaseStorage {
  ResourceLoadStorage(super.sharedPreferences);

  /// 列表画质
  static const _listPreviewQuality = "resource_load_list_preview_quality";

  /// 插画详情页画质
  static const _illustDetailsQuality = "resource_load_illust_details_quality";

  /// 漫画详情页画质
  static const _mangaDetailsQuality = "resource_load_manga_details_quality";

  Future<bool> setListPreviewQuality(ListPreviewQuality quality) async {
    return await sharedPreferences.setString(_listPreviewQuality, quality.name);
  }

  Future<bool> setIllustDetailsQuality(DetailsPageQuality quality) async {
    return await sharedPreferences.setString(_illustDetailsQuality, quality.name);
  }

  Future<bool> setMangaDetailsQuality(DetailsPageQuality quality) async {
    return await sharedPreferences.setString(_mangaDetailsQuality, quality.name);
  }

  ListPreviewQuality listPreviewQuality() {
    final defaultQuality = ListPreviewQuality.medium; // 默认
    final value = sharedPreferences.getString(_listPreviewQuality);
    if (value == null || value.isEmpty) return defaultQuality;
    try {
      final findQuantity = ListPreviewQuality.values.byName(value);
      return findQuantity;
    } catch (e) {
      return defaultQuality;
    }
  }

  DetailsPageQuality illustDetailsQuality() {
    final defaultQuality = DetailsPageQuality.large; // 默认
    final value = sharedPreferences.getString(_illustDetailsQuality);
    if (value == null || value.isEmpty) return defaultQuality;
    try {
      final findQuantity = DetailsPageQuality.values.byName(value);
      return findQuantity;
    } catch (e) {
      return defaultQuality;
    }
  }

  DetailsPageQuality mangaDetailsQuality() {
    final defaultQuality = DetailsPageQuality.large; // 默认
    final value = sharedPreferences.getString(_mangaDetailsQuality);
    if (value == null || value.isEmpty) return defaultQuality;
    try {
      final findQuantity = DetailsPageQuality.values.byName(value);
      return findQuantity;
    } catch (e) {
      return defaultQuality;
    }
  }
}
