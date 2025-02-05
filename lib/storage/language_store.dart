import 'dart:ui';

import 'package:artvier/base/base_storage.dart';
import 'package:artvier/config/constants.dart';

class LanguageStorage extends BaseStorage {
  LanguageStorage(super.sharedPreferences);

  static const String languageCodeKey = "language_code";
  static const String countryCodeKey = "language_country_code";

  Future<bool> setLanguage(String languageCode, String countryCode) async {
    bool h = await sharedPreferences.setString(languageCodeKey, languageCode);
    return h && await sharedPreferences.setString(countryCodeKey, countryCode);
  }

  Locale getLanguageLocale() {
    String languageCode = sharedPreferences.getString(languageCodeKey) ?? CONSTANTS.default_language_code;
    String countryCode = sharedPreferences.getString(countryCodeKey) ?? CONSTANTS.default_country_code;
    return Locale(languageCode, countryCode);
  }
}
