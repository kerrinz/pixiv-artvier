import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

/// 动图状态
@Freezed(
  copyWith: true,
)
class UgoiraImageState with _$UgoiraImageState {
  const factory UgoiraImageState({
    required String illustId,
    required List<Image>? images,
    /** 0 - 1 */
    required double progress,
    required UgoiraImageLoadingState loadingState,
  }) = _UgoiraImageState;
}

enum UgoiraImageLoadingState {
  /// 暂停中
  paused,

  /// 下载中
  downloading,

  /// 解压中
  unziping,

  /// 合成中
  compositing,

  /// 失败
  failed,

  /// 成功
  success,
}
