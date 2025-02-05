import 'dart:typed_data';

import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/artwork/download_manage/provider/download_manage_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/storage/downloads/downloads_db.dart';
import 'package:dio/dio.dart';
import 'package:artvier/config/enums.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

typedef RequestExecution = Future<Response> Function(CancelToken cancelToken);

/// 下载任务队列，暂不支持暂停、断点续传
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

  /// 当前下载中的任务数量
  int get countDownloading => _imageTaskQuene.fold<int>(
      0, (previousValue, element) => previousValue + (element.downloadState == DownloadState.downloading ? 1 : 0));

  /// 下载任务队列（实时更新数据）
  List<DownloadTask> get taskQuene => _imageTaskQuene;

  Future<void> pushTask(DownloadTaskTableData taskData) async {
    DownloadTaskTableData insertedData = taskData;
    bool canDownload = countDownloading < maxConcurrentDownloads;
    // 无任务 Id 则在数据库新建新任务
    if (taskData.taskId == null) {
      insertedData = insertedData.copyWith(status: canDownload ? DownloadState.downloading : DownloadState.waiting);
      insertedData = await downloadsDatabase.addDownloadTask(insertedData.toCompanion(true));
    } else {
      // 有任务 Id 则初始化下载状态
      insertedData = insertedData.copyWith(
          receivedBytes: 0, totalBytes: 0, status: canDownload ? DownloadState.downloading : DownloadState.waiting);
      await downloadsDatabase.updateTask(insertedData);
    }
    DownloadTask downloadTask = DownloadTask(taskData: insertedData);
    downloadTask
      ..onSuccess = (data) async {
        _imageTaskQuene.remove(downloadTask);
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
      ..onFailed = (statusCode) {
        downloadsDatabase.updateTaskStatus(insertedData.taskId!, DownloadState.failed);
      }
      ..onError = (e) {
        downloadsDatabase.updateTaskStatus(insertedData.taskId!, DownloadState.failed);
        logger.e(e);
      }
      ..onFinally = () {
        /// 下载下一个等待中的任务
        int findIndex = _imageTaskQuene.indexWhere((element) => element.downloadState == DownloadState.waiting);
        if (findIndex > -1) {
          _imageTaskQuene[findIndex].start();
        }
        _imageTaskQuene.remove(downloadTask);
      };
    _imageTaskQuene.add(downloadTask);
    if (canDownload) {
      // 并发限制允许，则开始任务
      downloadTask.start();
    }
  }

  void restartTask(DownloadTaskTableData taskData) {
    int findIndex = _imageTaskQuene.indexWhere((element) => element.taskData.taskId == taskData.taskId);
    if (findIndex > -1) {
      _imageTaskQuene[findIndex].restart();
    } else {
      // 没找到
      pushTask(taskData);
    }
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
  void Function()? onFinally;

  final CancelToken _cancelToken = CancelToken();

  DownloadState _state = DownloadState.waiting;

  DownloadState get downloadState => _state;

  bool get isCanceled => _cancelToken.isCancelled;

  /// 开始任务
  start() {
    return _start().whenComplete(() {
      if (onFinally != null) onFinally!();
    });
  }

  Future _start() async {
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
          headers: HttpHostOverrides().pximgHeaders,
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

  /// 重新开始任务
  restart() {
    start();
  }
}
