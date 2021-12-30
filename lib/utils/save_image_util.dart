import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_store/downloading_illust.dart';
import 'package:pixgem/store/download_store.dart';
import 'package:pixgem/store/global.dart';

class SaveImageUtil {
  // 保存图片
  static Future<bool> saveIllustToGallery(CommonIllust illust, String url, {int quality = 100}) async {
    Fluttertoast.showToast(msg: "正在保存...", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    Response response;
    bool result = false;
    // 本地持久化存储里不存在该下载任务就新建下载任务
    if (!GlobalStore.globalProvider.downloadingIllust.containsKey(url)) {
      GlobalStore.globalProvider.downloadingIllust
          .putIfAbsent(url, () => DownloadingIllust(illust, 0, DownloadingStatus.downloading));
      DownloadStore.addDownloadingIllust(url, DownloadingIllust(illust, 0, DownloadingStatus.pause));
    }
    try {
      response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes, headers: {"referer": CONSTANTS.referer}),
              onReceiveProgress: (received, total) {
        bool ifFull = false; // 标记是否已满
        if (total != -1) {
          ///当前下载的百分比例
          // print((received / total * 100).toStringAsFixed(0) + "%");
          if (received / total == 1.0) ifFull = true;
          if (ifFull) {
            // 因100%后还会再执行几次，利用isFull标记让它只执行一次
            DownloadStore.removeDownloadingIllust(url);
            GlobalStore.globalProvider.downloadingIllust.remove(url);
          } else {
            GlobalStore.globalProvider.downloadingIllust[url]!.percentage = received / total; // 更新全局提供器中的下载列表对应下载进度
          }
        }
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "获取图片失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      // 更新全局变量
      GlobalStore.globalProvider.downloadingIllust[url]!.status = DownloadingStatus.failed;
      return false;
    }
    var saveResult = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: quality);
    if (saveResult["isSuccess"]) {
      Fluttertoast.showToast(msg: "保存成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      result = true;
    } else {
      Fluttertoast.showToast(msg: "保存失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      // 更新全局变量
      GlobalStore.globalProvider.downloadingIllust[url]!.status = DownloadingStatus.failed;
    }
    return result;
  }
}
