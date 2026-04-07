import 'dart:io';

import 'package:artvier/config/enums.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/global/download_task_queue.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_page_arguments.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/artwork/viewer/image_viewer_page.dart';
import 'package:artvier/pages/artwork/viewer/model/image_quality_url_model.dart';
import 'package:artvier/pages/artwork/viewer/model/image_viewer_state.dart';
import 'package:artvier/pages/artwork/viewer/model/original_load_status.dart';

mixin ImageViewerPageLogic on BasePageState<ImageViewerPage> {
  @override
  WidgetRef get ref;

  List<ImageQualityUrl> get urlList;

  /// 存储权限相关
  late final Permission _permission = Permission.storage;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  /// 图片浏览状态
  late final imageViewerProvider = StateProvider.autoDispose<ImageViewerPageState>(
    (ref) => ImageViewerPageState(
        pageIndex: widget.arguments.index, isOriginal: widget.arguments.urlList[widget.arguments.index].normal == null),
  );

  /// 原图加载进度（按 index 记录）
  /// [ImageQualityUrl.normal] 为空时仅有原图 URL，进入页面即已是原图，无需再显示“原图加载中”。
  late final originalLoadProvider = StateProvider.autoDispose<Map<int, OriginalLoadStatus>>(
    (ref) {
      final list = widget.arguments.urlList;
      final map = <int, OriginalLoadStatus>{};
      for (var i = 0; i < list.length; i++) {
        if (list[i].normal == null) {
          map[i] = const OriginalLoadStatus(isLoading: false, progress: 1, isLoaded: true);
        }
      }
      return map;
    },
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
    await DownloadTaskQueue().pushTask(
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
    Fluttertoast.showToast(msg: "开始下载...", toastLength: Toast.LENGTH_LONG);
  }
}
