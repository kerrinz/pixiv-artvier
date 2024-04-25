import 'dart:typed_data';

import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/artwork/download_manage/provider/download_manage_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/storage/database/downloads_db.dart';
import 'package:dio/dio.dart';
import 'package:artvier/config/enums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

typedef RequestExecution = Future<Response> Function(CancelToken cancelToken);

/// 下载任务队列
///
/// 单例模式
class DownloadTaskQueue {
  factory DownloadTaskQueue() => _instance;

  static final DownloadTaskQueue _instance = DownloadTaskQueue._();

  static DownloadTaskQueue get instance => _instance;

  DownloadTaskQueue._();

  final List<DownloadTask> _imageTaskQuene = [];

  /// 最大并发下载任务数量
  static const maxConcurrentDownloads = 5;

  /// 下载任务队列（实时更新数据）
  List<DownloadTask> get taskQuene => _imageTaskQuene;

  void pushTask(DownloadTask task) async {
    // 统计正在下载中的任务数
    int countDownloading = _imageTaskQuene.fold<int>(
        0, (previousValue, element) => previousValue + (element.downloadState == DownloadState.downloading ? 1 : 0));
    var insertedData = await downloadsDatabase.addDownloadTask(task.taskData.toCompanion(true));
    _imageTaskQuene.add(task
      ..onSuccess = (data) async {
        _imageTaskQuene.remove(task);
        var saveResult = await ImageGallerySaver.saveImage(Uint8List.fromList(data), quality: 100);
        bool result = saveResult["isSuccess"];
        if (result) {
          downloadsDatabase.updateTaskStatus(insertedData.taskId!, DownloadState.success);
          Fluttertoast.showToast(msg: "下载成功");
        } else {
          downloadsDatabase.updateTaskStatus(insertedData.taskId!, DownloadState.failed);
          Fluttertoast.showToast(msg: "下载失败");
        }
      }
      ..onProgress = (int receivedBytes, int totalBytes) {
        downloadsDatabase.updateTaskBytes(insertedData.taskId!, receivedBytes, totalBytes);
      }
      ..onFailed = (statusCode) {}
      ..onError = (e) {
        logger.e(e);
      });

    if (countDownloading < maxConcurrentDownloads) {
      // 并发限制允许，则开始任务
      task.start();
    }
  }

  /// 取消任务
  void cancelTask(DownloadTask task) {
    task.cancel();
  }

  /// 开始任务
  void startTask(DownloadTask task) {
    task.start();
  }
}

/// 下载任务
class DownloadTask {
  DownloadTask({
    required this.taskData,
  });

  /// 任务数据
  DownloadTaskTableData taskData;

  void Function(dynamic data)? onSuccess;
  void Function(int? statusCode)? onFailed;
  void Function(Object e)? onError;
  void Function(int receivedBytes, int totalBytes)? onProgress;

  final CancelToken _cancelToken = CancelToken();

  DownloadState _state = DownloadState.waiting;

  DownloadState get downloadState => _state;

  bool get isCanceled => _cancelToken.isCancelled;

  /// 开始任务
  start() async {
    String url = HttpHostOverrides().pxImgUrl(taskData.downloadUrl);
    _state = DownloadState.downloading;
    try {
      Response result = await _request(url);
      if (result.statusCode == 200) {
        _state = DownloadState.success;
        if (onSuccess != null) onSuccess!(result.data);
      } else {
        _state = DownloadState.failed;
        if (onFailed != null) onFailed!(result.statusCode);
      }
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) return;
      _state = DownloadState.failed;
      if (onError != null) onError!(e);
    }
  }

  _request(String url) async {
    return await Dio().get(url,
        cancelToken: _cancelToken,
        options: Options(
          responseType: ResponseType.bytes,
          headers: HttpBaseOptions.pximgHeaders,
        ), onReceiveProgress: (received, total) {
      if (total != -1) {
        ///当前下载的百分比
        // print("$url: ${(received / total * 100).toStringAsFixed(1)}%");
        if (onProgress != null) onProgress!(received, total);
      }
    });
  }

  /// 取消任务
  cancel() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
  }

  /// 暂停任务（暂未支持）
  pause() => throw UnimplementedError();
}
