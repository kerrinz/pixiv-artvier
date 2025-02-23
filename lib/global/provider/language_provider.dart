import 'dart:ui';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/global/variable.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/storage/language_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalLanguageProvider = StateNotifierProvider<LanguageNotivier, Locale?>((ref) {
  final languageStore = LanguageStorage(globalSharedPreferences);
  final autoLanguage = languageStore.getAutoLanguage();
  final locale = autoLanguage ? null : languageStore.getLanguageLocale();
  return LanguageNotivier(locale, ref: ref);
});

/// Current Lanuange.
class LanguageNotivier extends BaseStateNotifier<Locale?> {
  LanguageNotivier(super.state, {required super.ref});

  /// Set null to enable auto language.
  Future<bool> setLocale(Locale? locale) async {
    final languageStore = LanguageStorage(globalSharedPreferences);
    if (locale == null) {
      final result = await languageStore.setAutoLanguage(true);
      update(null);
      HttpHostOverrides().reload();
      return result;
    } else {
      assert(locale.countryCode != null);
      final result = await languageStore.setLanguage(locale.languageCode, locale.countryCode!);
      final result2 = await languageStore.setAutoLanguage(false);
      if (result) {
        update(locale);
        HttpHostOverrides().reload();
      }
      return result && result2;
    }
  }
}
