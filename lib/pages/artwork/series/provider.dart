import 'dart:async';

import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/model_response/manga/manga_series_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 漫画系列详情
final mangaSeriesDetailProvider =
    AsyncNotifierProvider.autoDispose.family<MangaSeriesDetailNotifier, MangaSeriesDetailResponse, String>(
  () => MangaSeriesDetailNotifier(),
);

class MangaSeriesDetailNotifier extends BaseAutoDisposeFamilyAsyncNotifier<MangaSeriesDetailResponse, String>
    implements AsyncListNotifier<MangaSeriesDetailResponse> {
  late String illustSeriesId;

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  final CancelToken cancelToken = CancelToken();

  @override
  FutureOr<MangaSeriesDetailResponse> build(String arg) async {
    illustSeriesId = arg;
    handleCollectState(ref);
    return fetch();
  }

  /// 监听全局收藏状态的变化，更新列表
  handleCollectState(Ref ref) {
    ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
      if (next != null && state.hasValue) {
        var list = (state.value?.illusts ?? []);
        int index = list.lastIndexWhere((element) => element.id.toString() == next.worksId);
        if (index >= 0 && index < list.length) {
          var newItem = list[index]..isBookmarked = next.state == CollectState.collected;
          update((p0) => p0..illusts[index] = newItem);
        }
      }
    });
  }

  @override
  Future<MangaSeriesDetailResponse> fetch() async {
    var result = await ApiIllusts(requester).mangaSeriesDetail(illustSeriesId);
    nextUrl = result.nextUrl;
    return result;
  }

  @override
  Future<bool> next() async {
    if (!hasMore) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    update((p0) => p0.copyWith(illusts: [...p0.illusts, ...result.illusts]));

    return nextUrl != null;
  }
}
