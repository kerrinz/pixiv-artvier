import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:archive/archive_io.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/business_component/ugoira_image/model.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:path_provider/path_provider.dart';

final ugoiraIllustProvider =
    StateNotifierProvider.autoDispose.family<UgoiraIllustNotifier, UgoiraImageState, String>((ref, illustId) {
  var notifier = UgoiraIllustNotifier(
      UgoiraImageState(
        illustId: illustId,
        images: null,
        progress: 0,
        loadingState: UgoiraImageLoadingState.paused,
      ),
      ref: ref,
      illustId: illustId);
  return notifier;
});

class UgoiraIllustNotifier extends BaseStateNotifier<UgoiraImageState> {
  String illustId;

  String? zipUrls;

  CancelToken cancelToken = CancelToken();

  UgoiraIllustNotifier(super.state, {required super.ref, required this.illustId});

  @override
  void dispose() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
    super.dispose();
  }

  start() {
    return fetch().then((value) => value, onError: (error) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        logger.i(error);
      } else {
        logger.e(error);
      }
    });
  }

  pause() {
    cancelToken.cancel();
    state = state.copyWith(loadingState: UgoiraImageLoadingState.paused);
  }

  /// 初始化（或重试）数据
  Future<List<Image>> fetch() async {
    // 下载压缩包
    state = state.copyWith(loadingState: UgoiraImageLoadingState.downloading);
    if (zipUrls == null) {
      var result = await ApiIllusts(requester).ugoiraMetadata(illustId, cancelToken: cancelToken);
      zipUrls = result.ugoiraMetadata.zipUrls.medium;
    }
    File zip = await downloadZip(HttpHostOverrides().pxImgUrl(zipUrls!));
    // 解压
    state = state.copyWith(loadingState: UgoiraImageLoadingState.unziping);
    List<FileSystemEntity> list = await unzip(zip);
    // 转换
    state = state.copyWith(loadingState: UgoiraImageLoadingState.compositing);
    List<Image> images = [];
    for (var item in list) {
      File file = item as File;
      images.add(await fileToImage(file));
    }
    if (mounted) {
      state = state.copyWith(
        images: images,
        progress: 1,
        loadingState: UgoiraImageLoadingState.success,
      );
    }
    return images;
  }

  Future<File> downloadZip(String url) async {
    Directory tempDirectory = await getTemporaryDirectory();
    String tempPath = tempDirectory.path;
    final zipPath = "$tempPath/ugoira/$illustId.zip";
    logger.i('Start download zip file: $url');
    File zipFile = File(zipPath);
    if (!zipFile.existsSync()) {
      await requester.donwload(
        url,
        zipPath,
        options: Options(
          headers: const {"referer": CONSTANTS.referer},
        ),
        cancelToken: cancelToken,
        onReceiveProgress: (count, total) {
          double progress = count.toDouble() / total.toDouble();
          // 还有后续操作，所以上限只给到 99%
          progress = progress * 0.99;
          if (progress >= 0.99) {
            progress = 0.99;
          } else if (progress < 0) {
            progress = 0;
          }
          state = state.copyWith(progress: progress);
        },
      );
    }
    return zipFile;
  }

  // 解压
  Future<List<FileSystemEntity>> unzip(File file) async {
    Directory tempDirectory = await getTemporaryDirectory();
    String tempPath = tempDirectory.path;
    try {
      var fileBytes = file.readAsBytesSync();
      Archive archive = ZipDecoder().decodeBytes(fileBytes);
      for (ArchiveFile file in archive) {
        if (file.isFile) {
          final data = file.content as List<int>;
          File('$tempPath/ugoira/$illustId/${file.name}')
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
        } else {
          Directory('$tempPath/ugoira/$illustId/${file.name}').create(recursive: true);
        }
      }
      Directory zipDirectory = Directory('$tempPath/ugoira/$illustId/');
      var list = zipDirectory.listSync();
      list.sort((prev, next) => prev.path.compareTo(next.path));
      return list;
    } catch (e) {
      if (file.existsSync()) file.deleteSync();
      if (Directory('$tempPath/ugoira/$illustId/').existsSync()) {
        Directory('$tempPath/ugoira/$illustId/').deleteSync(recursive: true);
      }
      rethrow;
    }
  }

  /// 转换图片
  Future<Image> fileToImage(File file) async {
    var completer = Completer<Image>();
    var future = completer.future;
    var list = await file.readAsBytes();
    try {
      decodeImageFromList(list, ((result) {
        completer.complete(result);
      }));
    } catch (e) {
      completer.completeError(e);
    }
    return future;
  }
}
