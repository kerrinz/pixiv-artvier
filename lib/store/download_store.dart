import 'dart:convert';

import 'package:pixgem/model_store/downloaded_illust.dart';
import 'package:pixgem/store/global.dart';

class DownloadStore {
  static const MODE = "download_mode";
  static const DOWNLOADED_HISTORY = "downloaded_history";

  static const MODE_GALLERY = 0; // 保存到相册/图库
  static const MODE_DOWNLOAD_PATH = 1; // 保存到下载路径
  static const MODE_CUSTOM = 2; // 自定义下载路径

  // 设置下载模式
  static Future setDownloadMode(int mode) async {
    return await GlobalStore.globalSharedPreferences.setInt(MODE, mode);
  }

  // 获取主题模式，不存在则默认为相册模式
  static int getDownloadMode() {
    int? result = GlobalStore.globalSharedPreferences.getInt(MODE);
    return result ?? MODE_GALLERY;
  }

  static Future addDownloadedIllust(DownloadedIllust illust) async {
    var illusts = getDownloadedIllusts();
    illusts.insert(0, illust);
    return await GlobalStore.globalSharedPreferences
        .setStringList(DOWNLOADED_HISTORY, DownloadedIllust.downloadedIllustItemListToStringList(illusts));
  }

  static List<DownloadedIllust> getDownloadedIllusts() {
    List<String>? strList = GlobalStore.globalSharedPreferences.getStringList(DOWNLOADED_HISTORY);
    return DownloadedIllust.downloadedIllustStringListToItemList(strList);
  }
}
