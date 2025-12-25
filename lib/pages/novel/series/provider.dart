import 'dart:async';

import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/model/series_state_changed_arguments/series_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/global/provider/series_state_provider.dart';
import 'package:artvier/model_response/novels/novel_series_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 漫画系列详情
final novelSeriesDetailProvider =
    AsyncNotifierProvider.autoDispose.family<NovelSeriesDetailNotifier, NovelSeriesDetailResponse, String>(
  () => NovelSeriesDetailNotifier(),
);

class NovelSeriesDetailNotifier extends BaseAutoDisposeFamilyAsyncNotifier<NovelSeriesDetailResponse, String>
    implements AsyncListNotifier<NovelSeriesDetailResponse> {
  late String illustSeriesId;

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  final CancelToken cancelToken = CancelToken();

  @override
  FutureOr<NovelSeriesDetailResponse> build(String arg) async {
    illustSeriesId = arg;
    handleCollectState(ref);
    handleSeriesState(ref);
    return fetch();
  }

  /// 监听全局收藏状态的变化，更新列表
  handleCollectState(Ref ref) {
    ref.listen<CollectStateChangedArguments?>(globalNovelCollectionStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        var list = (state.value?.novels ?? []);
        int index = list.lastIndexWhere((element) => element.id.toString() == next.worksId);
        if (index >= 0 && index < list.length) {
          var newItem = list[index]..isBookmarked = next.state == CollectState.collected;
          update((p0) => p0..novels[index] = newItem);
        }
      }
    });
  }

  /// 监听全局追更状态的变化
  handleSeriesState(Ref ref) {
    ref.listen<SeriesStateChangedArguments?>(globalNovelSeriesStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        final currentState = state.requireValue.novelSeriesDetail.seriesWatchState ??
            (state.requireValue.novelSeriesDetail.watchlistAdded ? SeriesState.watched : SeriesState.notWatch);
        if (currentState != next.state) {
          update((p0) => p0.copyWith(novelSeriesDetail: p0.novelSeriesDetail.copyWith(seriesWatchState: next.state)));
        }
      }
    });
  }

  @override
  Future<NovelSeriesDetailResponse> fetch() async {
    var result = await ApiNovels(requester).novelSeriesDetail(illustSeriesId);
    nextUrl = result.nextUrl;
    return result;
  }

  @override
  Future<bool> next() async {
    if (!hasMore) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0.copyWith(novels: [...p0.novels, ...result.novels]));

    return nextUrl != null;
  }
}
