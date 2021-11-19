import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pixgem/config/constants.dart';

class SaveImageUtil {
  // 保存图片
  static Future saveImageToGallery(String url, {quality = 100}) async {
    Fluttertoast.showToast(msg: "正在保存...", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes, headers: {"referer": CONSTANTS.referer}),
            onReceiveProgress: (received, total) {
      if (total != -1) {
        ///当前下载的百分比例
        print((received / total * 100).toStringAsFixed(0) + "%");
        // CircularProgressIndicator(value: currentProgress,) 进度 0-1
        // currentProgress = received / total;
      }
    });
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: quality);
    if (result["isSuccess"]) {
      Fluttertoast.showToast(msg: "保存成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    } else {
      Fluttertoast.showToast(msg: "保存失败！", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    }
    // if (Platform.isIOS) {
    //
    // } else if (Platform.isAndroid) {
    //   Directory? root = await getExternalStorageDirectory();
    //   ApiBase.dio
    //       .download(widget.urlList[_provider.currentPage].original!, root!.path + "/Download/aaa.jpg",
    //           options: Options(headers: {"referer": CONSTANTS.referer}))
    //       .then((value) => print(value.toString()), onError: (e) => print(e));
    // }
  }
}
