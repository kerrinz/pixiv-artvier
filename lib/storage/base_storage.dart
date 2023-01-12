import 'package:shared_preferences/shared_preferences.dart';

class BaseStorage {
  final SharedPreferences sharedPreferences;

  SharedPreferences get prefs => sharedPreferences;

  BaseStorage(this.sharedPreferences);
}
