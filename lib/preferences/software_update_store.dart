import 'package:artvier/base/base_storage.dart';
import 'package:artvier/global/variable.dart';

class SoftwareUpdateStorage extends BaseStorage {
  SoftwareUpdateStorage(super.sharedPreferences);

  static const String _migrationKey = 'database_migrated_v0_to_v1';

  /// 是否合并迁移过 v0 -> v1 版数据库
  bool isAlreadyMigratedToV1() {
    final prefs = globalSharedPreferences;

    return prefs.getBool(_migrationKey) == true;
  }

  /// 设置是否合并迁移过 v0 -> v1 版数据库
  setAlreadyMigratedToV1(bool value) async {
    return await prefs.setBool(_migrationKey, value);
  }
}
