import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:artvier/global/logger.dart';

/// Copy from https://blog.csdn.net/weixin_45952652/article/details/118297876
class DownloadUtil {
  /// 用于记录正在下载的url，避免重复下载
  static Map<String, CancelToken> downloadingUrls = <String, CancelToken>{};

  /// 断点下载大文件
  static Future<void> download({
    required String url,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    void Function()? done,
    void Function(DioError)? failed,
  }) async {
    int startBytes = 0;
    bool fileExists = false;
    File f = File(savePath);
    if (await f.exists()) {
      startBytes = f.lengthSync();
      fileExists = true;
    }
    logger.i("开始：startBytes=$startBytes");
    if (fileExists && downloadingUrls.containsKey(url)) {
      return;
    }
    var dio = Dio();
    CancelToken cancelToken = CancelToken();
    downloadingUrls[url] = cancelToken;
    try {
      var response = await dio.get<ResponseBody>(
        url,
        options: Options(
          /// 以流的方式接收响应数据
          responseType: ResponseType.stream,
          followRedirects: false,
          headers: {
            /// 分段下载重点位置
            "range": "bytes=$startBytes-",
          },
        ),
      );
      File file = File(savePath);
      RandomAccessFile raf = file.openSync(mode: FileMode.append);
      int received = startBytes;
      int total = await _getContentLength(response);
      Stream<Uint8List> stream = response.data!.stream;
      StreamSubscription<Uint8List>? subscription;
      subscription = stream.listen(
        (data) {
          /// 写入文件必须同步
          raf.writeFromSync(data);
          received += data.length;
          onReceiveProgress?.call(received, total);
        },
        onDone: () async {
          downloadingUrls.remove(url);
          await raf.close();
          done?.call();
        },
        onError: (e) async {
          await raf.close();
          downloadingUrls.remove(url);
          failed?.call(e as DioError);
        },
        cancelOnError: true,
      );
      cancelToken.whenCancel.then((_) async {
        await subscription?.cancel();
        await raf.close();
      });
    } on DioError catch (error) {
      /// 请求已发出，服务器用状态代码响应它不在200的范围内
      if (CancelToken.isCancel(error)) {
        logger.i("下载取消");
      } else {
        failed?.call(error);
      }
      downloadingUrls.remove(url);
    }
  }

  /// 获取下载的文件大小
  static Future<int> _getContentLength(Response<ResponseBody> response) async {
    try {
      var headerContent = response.headers.value(HttpHeaders.contentRangeHeader);
      logger.i("下载文件$headerContent");
      if (headerContent != null) {
        return int.parse(headerContent.split('/').last);
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  /// 取消任务
  static void cancelDownload(String url) {
    downloadingUrls[url]?.cancel();
    downloadingUrls.remove(url);
  }
}
