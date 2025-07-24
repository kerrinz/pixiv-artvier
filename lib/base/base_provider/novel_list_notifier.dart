import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/request/http_requester.dart';

typedef State = List<CommonNovel>;

mixin NovelListAsyncNotifierMixin implements AsyncListNotifier<State> {
  String? nextUrl;

  bool get hasMore => nextUrl != null;

  final CancelToken cancelToken = CancelToken();

  AsyncValue<State> get state;

  set state(AsyncValue<State> newState);

  HttpRequester get requester;

  Future<State> update(
    FutureOr<State> Function(State) cb, {
    FutureOr<State> Function(Object err, StackTrace stackTrace)? onError,
  });

  void beforeBuild(Ref ref) {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    // // 监听全局收藏状态的变化，更新列表
    ref.listen<CollectStateChangedArguments?>(globalNovelCollectionStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        var value = (state.value ?? []);
        int index = value.lastIndexWhere((element) => element.id.toString() == next.worksId);
        if (index >= 0 && index < value.length) {
          var newItem = value[index]..isBookmarked = next.state == CollectState.collected;
          update((p0) => p0..[index] = newItem);
        }
      }
    });
  }

  /// Notifier生命周期在Dispose时触发
  ///
  /// - [AsyncValue.guard] 不会触发
  /// - 如果 [build] 中使用了 [ref.watch]，请使用 [handleCancel]
  void handleDispose(Ref ref) {
    ref.onDispose(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
  }

  /// 监听全局收藏状态的变化，更新列表
  void handleCollectState(Ref ref) {
    ref.listen<CollectStateChangedArguments?>(globalNovelCollectionStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        var value = (state.value ?? []);
        int index = value.lastIndexWhere((element) => element.id.toString() == next.worksId);
        if (index >= 0 && index < value.length) {
          var newItem = value[index]..isBookmarked = next.state == CollectState.collected;
          update((p0) => p0..[index] = newItem);
        }
      }
    });
  }

  @override
  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  @override
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  @override
  Future<bool> next() async {
    if (!hasMore) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.novels));

    return nextUrl != null;
  }
}
