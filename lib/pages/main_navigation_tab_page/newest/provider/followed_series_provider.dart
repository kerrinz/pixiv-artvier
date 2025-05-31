import 'dart:async';

import 'package:artvier/base/base_api.dart';
import 'package:artvier/base/base_provider/list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/model_response/novels/novel_series_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_newest.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';

final followedSeriesWorksTypeProvider = StateProvider<WorksType>((ref) {
  return WorksType.illust;
});

class FollowedMangeSeriesNotifier extends BaseAsyncNotifier<List<MangaSeries>>
    implements AsyncListNotifier<List<MangaSeries>> {
  CancelToken cancelToken = CancelToken();

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  @override
  FutureOr<List<MangaSeries>> build() async {
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<MangaSeries>> fetch() async {
    var result = await ApiNewArtWork(requester).followedMangaSeries(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.series;
  }

  @override
  Future<bool> next() async {
    if (!hasMore) return false;

    final data = await ApiBase(requester).nextUrlData(nextUrl!, cancelToken: cancelToken);
    final result = MangaSeriesListResponse.fromJson(data);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.series));

    return nextUrl != null;
  }
}

class FollowedNovelSeriesNotifier extends BaseAsyncNotifier<List<NovelSeries>>
    implements AsyncListNotifier<List<NovelSeries>> {
  CancelToken cancelToken = CancelToken();

  String? nextUrl;

  bool get hasMore => nextUrl != null;

  @override
  FutureOr<List<NovelSeries>> build() async {
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<NovelSeries>> fetch() async {
    var result = await ApiNewArtWork(requester).followedNovelSeries(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.series;
  }

  @override
  Future<bool> next() async {
    if (!hasMore) return false;

    final data = await ApiBase(requester).nextUrlData(nextUrl!, cancelToken: cancelToken);
    final result = NovelSeriesListResponse.fromJson(data);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.series));

    return nextUrl != null;
  }
}
