import 'package:dio/dio.dart';
import 'package:artvier/config/enums.dart';

typedef RequestExecution = Future<Response> Function(CancelToken cancelToken);

/// 下载任务队列（未完成的任务）
///
/// 单例模式
class DownloadTaskQueue {
  factory DownloadTaskQueue() => _instance;

  static late final DownloadTaskQueue _instance;

  final List<ImageDownloadTask> _imageTaskQuene = [];

  // final List<ImageDownloadTask> _imageSuccessTaskQuene = [];

  /// 最大并发下载任务数量
  static const maxConcurrentDownloads = 5;

  /// 图片下载任务队列
  List<ImageDownloadTask> get imageTaskQuene => _imageTaskQuene;

  void pushTask(ImageDownloadTask task) {
    // 统计正在下载中的任务数
    int countDownloading = _imageTaskQuene.fold<int>(
        0, (previousValue, element) => previousValue + (element.downloadState == DownloadState.downloading ? 1 : 0));
    _imageTaskQuene.add(task
      ..onSuccess = () {
        _onTaskSuccess(task);
      }
      ..onFailed = (statusCode) {
        _onTaskFailed(task, statusCode);
      }
      ..onError = (e) {
        _onTaskError(task, e);
      });
    if (countDownloading < maxConcurrentDownloads) {
      // 并发限制允许，则开始任务
      task.start();
    }
  }

  /// 取消任务
  void cancelTaskById(String worksId, int pIndex) {
    _imageTaskQuene.removeWhere((element) => worksId == element.worksId && pIndex == element.pIndex);
  }

  /// 重试失败的任务
  void retryFailedTaskById(String worksId, int pIndex) {
    var task = _imageTaskQuene.firstWhere((element) => worksId == element.worksId && pIndex == element.pIndex);
    task.start();
  }

  void _onTaskSuccess(DownloadTask task) {
    _imageTaskQuene.remove(task);
  }

  void _onTaskFailed(DownloadTask task, int? statusCode) {}

  void _onTaskError(DownloadTask task, Object e) {}
}

/// 图片的下载任务
///
/// [execution] 异步执行任务
/// [worksId] 作品ID
/// [pIndex] 图片在作品中的索引
class ImageDownloadTask extends DownloadTask {
  ImageDownloadTask(
    super.execution, {
    required this.worksId,
    this.pIndex = 0,
  });

  final String worksId;

  final int pIndex;
}

/// 下载任务
abstract class DownloadTask {
  DownloadTask(this.execution);

  /// 异步执行函数
  final RequestExecution execution;

  void Function()? onSuccess;
  void Function(int? statusCode)? onFailed;
  void Function(Object e)? onError;

  final CancelToken _cancelToken = CancelToken();

  DownloadState _state = DownloadState.waiting;

  DownloadState get downloadState => _state;

  bool get isCanceled => _cancelToken.isCancelled;

  /// 开始任务
  start() async {
    _state = DownloadState.downloading;
    try {
      Response result = await execution(_cancelToken);
      if (result.statusCode == 200) {
        _state = DownloadState.success;
        if (onSuccess != null) onSuccess!();
      } else {
        _state = DownloadState.failed;
        if (onFailed != null) onFailed!(result.statusCode);
      }
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.cancel) return;
      _state = DownloadState.failed;
      if (onError != null) onError!(e);
    }
  }

  /// 取消任务
  cancel() {
    if (!_cancelToken.isCancelled) _cancelToken.cancel();
  }

  /// 暂停任务（暂未支持）
  pause() => throw UnimplementedError();
}
