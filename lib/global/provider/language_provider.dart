import 'dart:ui';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/model/language/language_model.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/preferences/language_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// APP Language
final globalLanguageProvider = StateNotifierProvider<LanguageNotivier, LanguageModel>((ref) {
  final languageStore = LanguageStorage(globalSharedPreferences);
  final autoLanguage = languageStore.getAutoLanguage();
  final locale = languageStore.getLanguageLocale();
  return LanguageNotivier(LanguageModel(appLocale: autoLanguage ? null : locale, callbackLocale: locale), ref: ref);
});

/// Current Lanuange.
class LanguageNotivier extends BaseStateNotifier<LanguageModel> {
  LanguageNotivier(super.state, {required super.ref});

  /// 切换语言
  /// 设置 null 以使用自动跟随系统
  Future<bool> switchLocale(Locale? locale) async {
    final languageStore = LanguageStorage(globalSharedPreferences);
    if (locale == null) {
      final result = await languageStore.setAutoLanguage(true);
      update(state.copyWith(appLocale: null));
      HttpHostOverrides().reload();
      return result;
    } else {
      assert(locale.countryCode != null);
      final result = await languageStore.setLanguage(locale.languageCode, locale.countryCode!);
      final result2 = await languageStore.setAutoLanguage(false);
      if (result) {
        update(state.copyWith(appLocale: locale));
        HttpHostOverrides().reload();
      }
      return result && result2;
    }
  }

  /// 当启用跟随系统后，系统切换语言的回调
  Future<bool> sytemCallback(Locale locale) async {
    final languageStore = LanguageStorage(globalSharedPreferences);
    final result =
        await languageStore.setLanguage(locale.languageCode, locale.countryCode ?? CONSTANTS.default_country_code);
    if (result) {
      update(state.copyWith(callbackLocale: locale));
      HttpHostOverrides().reload();
    }
    return result;
  }
}
