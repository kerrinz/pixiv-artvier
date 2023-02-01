import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_provider/list_notifier.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:pixgem/global/provider/collection_state_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/request/http_requester.dart';

typedef State = List<CommonIllust>;

mixin IllustListAsyncNotifierMixin implements AsyncListNotifier<State> {
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

  beforeBuild(Ref ref) {
    ref.onCancel(() {
      if (!cancelToken.isCancelled) cancelToken.cancel();
    });
    // // 监听全局收藏状态的变化，更新列表
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
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

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.illusts));

    return nextUrl != null;
  }
}
