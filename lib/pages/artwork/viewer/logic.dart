import 'dart:io';

import 'package:artvier/config/enums.dart';
import 'package:artvier/global/download_task_queue.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_page_arguments.dart';
import 'package:artvier/storage/database/downloads_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/viewer/image_viewer_page.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_state.dart';

mixin ImageViewerPageLogic on BasePageState<ImageViewerPage> {
  @override
  WidgetRef get ref;

  List<ImageQualityUrl> get urlList;

  /// 存储权限相关
  late final Permission _permission = Permission.storage;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  /// 图片浏览状态
  late final imageViewerProvider = StateProvider.autoDispose<ImageViewerPageState>(
    (ref) => ImageViewerPageState(pageIndex: widget.arguments.index, isOriginal: false),
  );

  // 检查权限，没权限会自动跳转app权限管理页
  Future<bool> checkPermissions() async {
    if (Platform.isIOS) {
      _permissionStatus = await Permission.photosAddOnly.request();
      if (_permissionStatus.isPermanentlyDenied) {
        openAppSettings(); // 权限被拒绝，跳转设置
        return false;
      }
    } else if (Platform.isAndroid) {
      //发起权限申请
      _permissionStatus = await _permission.request();
      if (_permissionStatus.isPermanentlyDenied) {
        openAppSettings(); // 权限被拒绝，跳转设置
        return false;
      }
    }
    return true;
  }

  /// 点击下载图片
  Future<void> handlePressedDownload(int index) async {
    bool isPermit = await checkPermissions();
    if (!isPermit) return; // 没权限，不下载
    ImageViewerPageArguments arg = widget.arguments;
    DownloadTaskQueue().pushTask(
      DownloadTaskTableData(
        title: arg.title,
        worksId: arg.worksId,
        downloadUrl: arg.urlList[index].original,
        totalBytes: 0,
        receivedBytes: 0,
        type: arg.downloadType,
        status: DownloadState.waiting,
      ),
    );
  }
}
