import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

// 相关作品
class RelatedArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  RelatedArtworksNotifier({required this.worksId});

  final String worksId;

  final CancelToken _cancelToken = CancelToken();

  String? nextUrl;

  @override
  FutureOr<List<CommonIllust>> build() async {
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    try {
      var result = await ApiIllusts(requester).getRelatedIllust(worksId);
      nextUrl = result.nextUrl;
      return result.illusts;
    } catch (e) {
      if (!(e is DioError && e.type == DioErrorType.cancel)) logger.e(e);
      rethrow;
    }
  }

  /// 失败后的重试，或者用于重新加载
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下拉刷新
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.illusts));

    return nextUrl != null;
  }
}