import 'package:artvier/config/enums.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/model/resource_load_settings_model/resource_load_settings_model.dart';
import 'package:artvier/global/settings.dart';
import 'package:artvier/preferences/resource_load_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/provider/shared_preferences_provider.dart';

/// 资源加载设置的状态
final resourceLoadSettingsProvider =
    StateNotifierProvider<ResourceLoadSettingNotifier, ResourceLoadSettingsModel>((ref) {
  // 本地缓存的主题模式（不存在则默认跟随系统）
  var pref = ResourceLoadStorage(ref.watch(globalSharedPreferencesProvider));

  pref.listPreviewQuality();
  pref.mangaDetailsQuality();
  pref.illustDetailsQuality();

  return ResourceLoadSettingNotifier(
      ResourceLoadSettingsModel(
        listPreviewQuality: pref.listPreviewQuality(),
        illustDetailsQuality: pref.illustDetailsQuality(),
        mangaDetailsQuality: pref.mangaDetailsQuality(),
      ),
      ref: ref);
});

class ResourceLoadSettingNotifier extends BaseStateNotifier<ResourceLoadSettingsModel> {
  ResourceLoadSettingNotifier(super.state, {required super.ref});

  /// 切换列表画质
  Future<bool> switchListPreviewQuality(ListPreviewQuality quality) async {
    final storage = ResourceLoadStorage(prefs);
    bool result = await storage.setListPreviewQuality(quality);
    if (result) {
      state = state.copyWith(listPreviewQuality: quality);
    } else {
      logger.e("ResourceLoadSettingNotifier: switchListPreviewQuality failed");
    }
    GlobalSettings.instance.setListPreviewQuality(quality);
    return result;
  }

  /// 切换插画详情页画质
  Future<bool> switchIllustDetailsQuality(DetailsPageQuality quality) async {
    final storage = ResourceLoadStorage(prefs);
    bool result = await storage.setIllustDetailsQuality(quality);
    if (result) {
      state = state.copyWith(illustDetailsQuality: quality);
    } else {
      logger.e("ResourceLoadSettingNotifier: switchListPreviewQuality failed");
    }
    GlobalSettings.instance.setIllustDetailsQuality(quality);
    return result;
  }

  /// 切换漫画详情页画质
  Future<bool> switchMangaDetailsQuality(DetailsPageQuality quality) async {
    final storage = ResourceLoadStorage(prefs);
    bool result = await storage.setMangaDetailsQuality(quality);
    if (result) {
      state = state.copyWith(mangaDetailsQuality: quality);
    } else {
      logger.e("ResourceLoadSettingNotifier: switchListPreviewQuality failed");
    }
    GlobalSettings.instance.setMangaDetailsQuality(quality);
    return result;
  }
}
