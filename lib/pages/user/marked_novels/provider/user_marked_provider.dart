import 'dart:async';

import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/marker_state_changed_arguments/marker_state_changed_arguments.dart';
import 'package:artvier/global/provider/novel_marker_provider.dart';
import 'package:artvier/model_response/novels/marker_novel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_user.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';

class UserMarkedNotifier extends BaseAutoDisposeAsyncNotifier<List<MarkedNovel>> {
  final CancelToken _cancelToken = CancelToken();

  String? nextUrl;

  @override
  FutureOr<List<MarkedNovel>> build() async {
    ref.listen<MarkerStateChangedArguments?>(globalNovelMarkerStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        var value = (state.value ?? []);
        int index = value.lastIndexWhere((element) => element.novel.id.toString() == next.worksId);
        if (index >= 0 && index < value.length) {
          if (next.state == MarkerState.marked && next.page != null) {
            final newItem =
                value[index].copyWith(novelMarker: NovelMarker(page: next.page!), markerState: MarkerState.marked);
            final list = [...value]..[index] = newItem;
            update((p0) => list);
          } else if (next.state == MarkerState.unmarked) {
            final newItem = value[index].copyWith(markerState: MarkerState.unmarked);
            final list = [...value]..[index] = newItem;
            update((p0) => list);
          } else {
            final newItem = value[index].copyWith(markerState: next.state);
            final list = [...value]..[index] = newItem;
            update((p0) => list);
          }
        }
      }
    });
    ref.onCancel(() {
      if (!_cancelToken.isCancelled) _cancelToken.cancel();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<MarkedNovel>> fetch() async {
    var result = await ApiUser(requester).markedNovels(cancelToken: _cancelToken);
    nextUrl = result.nextUrl;
    return result.markedNovels;
  }

  /// 失败后的重试，或者用于重新加载
  @override
  Future<void> reload() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下拉刷新
  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiUser(requester).nextMarkedNovels(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.markedNovels));

    return nextUrl != null;
  }
}
