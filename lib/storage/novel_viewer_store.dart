import 'package:artvier/base/base_storage.dart';

class NovelViewerStorage extends BaseStorage {
  NovelViewerStorage(super.sharedPreferences);

  static const _textSize = "text_size";

  // 设置主题模式
  Future<bool> setTextSize(double textSize) async {
    return await sharedPreferences.setDouble(_textSize, textSize);
  }

  // 获取主题模式
  double? textSize() {
    return sharedPreferences.getDouble(_textSize);
  }
}
