import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/logger.dart';

typedef ProgressCallback = void Function(int received, int total);

class SaveImageUtil {
  // 保存图片
  static Future<bool> saveImageToGallery(
    String url, {
    int quality = 100,
    ProgressCallback? onProgress,
  }) async {
    Response response;
    response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes, headers: {"referer": CONSTANTS.referer}),
            onReceiveProgress: (received, total) {
      if (total != -1) {
        ///当前下载的百分比
        logger.i("$url: ${(received / total * 100).toStringAsFixed(1)}%");
        if (onProgress != null) onProgress(received, total);
      }
    });

    var saveResult = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: quality);
    return saveResult["isSuccess"];
  }
}
