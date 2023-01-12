// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model/model_store/downloading_illust.dart';
import 'package:pixgem/global/global.dart';

class DownloadStore {
  static const MODE = "download_mode";
  static const DOWNLOADED_HISTORY = "downloaded_history";
  static const DOWNLOADING_HISTORY = "downloading_history";

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

  // 添加一条进行中（未完成）的下载任务
  static Future addDownloadingIllust(String url, DownloadingIllust illust) async {
    Map<String, DownloadingIllust> illusts = getDownloadingIllusts();
    illusts.putIfAbsent(url, () => illust);
    return await GlobalStore.globalSharedPreferences.setString(DOWNLOADING_HISTORY, jsonEncode(illusts));
  }

  // 删除一条进行中（未完成）的下载任务
  static Future removeDownloadingIllust(String urlKey) async {
    Map<String, DownloadingIllust> illusts = getDownloadingIllusts();
    illusts.remove(urlKey);
    return await GlobalStore.globalSharedPreferences.setString(DOWNLOADING_HISTORY, jsonEncode(illusts));
  }

  // 获取进行中（未完成）的插画列表
  static Map<String, DownloadingIllust> getDownloadingIllusts() {
    String? str = GlobalStore.globalSharedPreferences.getString(DOWNLOADING_HISTORY);
    if (str == null) return {};
    Map<String, dynamic> map = json.decode(str);
    Map<String, DownloadingIllust> illusts = {};
    for (String key in map.keys) {
      illusts.putIfAbsent(key, () => DownloadingIllust.fromJson(map[key]));
    }
    map.clear();
    return illusts;
  }

  // 清空下载任务
  static Future clearDownloadingIllusts() async {
    return await GlobalStore.globalSharedPreferences.setString(DOWNLOADING_HISTORY, jsonEncode([]));
  }

  // 添加一条下载完成的记录
  static Future addDownloadedIllust(CommonIllust illust) async {
    List<CommonIllust> illusts = getDownloadedIllusts();
    illusts.insert(0, illust);
    return await GlobalStore.globalSharedPreferences.setString(DOWNLOADED_HISTORY, jsonEncode(illusts));
  }

  // 获取已下载完成的插画列表
  static List<CommonIllust> getDownloadedIllusts() {
    String? str = GlobalStore.globalSharedPreferences.getString(DOWNLOADED_HISTORY);
    if (str == null) return [];
    List<dynamic> list = json.decode(str);
    List<CommonIllust> illusts = [];
    for (dynamic illust in list) {
      illusts.add(CommonIllust.fromJson(illust));
    }
    list.clear();
    return illusts;
  }

  // 清空已下载的记录
  static Future clearDownloadedIllusts() async {
    return await GlobalStore.globalSharedPreferences.setString(DOWNLOADED_HISTORY, jsonEncode([]));
  }
}
