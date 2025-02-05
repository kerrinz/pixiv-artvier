import 'dart:ui';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/storage/language_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalLanguageProvider = StateNotifierProvider<LanguageNotivier, Locale>((ref) {
  return LanguageNotivier(const Locale(CONSTANTS.default_language_code, CONSTANTS.default_country_code), ref: ref);
});

class LanguageNotivier extends BaseStateNotifier<Locale> {
  LanguageNotivier(super.state, {required super.ref});

  Future<bool> setLocale(Locale locale) async {
    assert(locale.countryCode != null);
    final languageStore = LanguageStorage(globalSharedPreferences);
    final result = await languageStore.setLanguage(locale.languageCode, locale.countryCode!);
    if (result) {
      update(locale);
      HttpHostOverrides().reload();
    }
    return result;
  }
}
