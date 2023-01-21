import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地持久化存储，用于读取和保存数据到本地。
///
/// Shared preferences, used to read and save data locally.
final globalSharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

// late final SharedPreferences globalSharedPreferences;
