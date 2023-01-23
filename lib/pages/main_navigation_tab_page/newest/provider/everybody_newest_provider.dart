import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_newest.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 全站插画作品（仅插画）
final everybodyNewestIllustsProvider =
    AutoDisposeAsyncNotifierProvider<EverybodyNewestArtworksNotifier, List<CommonIllust>>(
  () => EverybodyNewestArtworksNotifier(WorksType.illust),
);

/// 全站插画作品（仅漫画）
final everybodyNewestMangaProvider =
    AutoDisposeAsyncNotifierProvider<EverybodyNewestArtworksNotifier, List<CommonIllust>>(
  () => EverybodyNewestArtworksNotifier(WorksType.manga),
);

/// 全站插画作品（仅小说）
final everybodyNewestNovelsProvider =
    AutoDisposeAsyncNotifierProvider<EverybodyNewestNovelsProvider, List<CommonNovel>>(
        EverybodyNewestNovelsProvider.new);

class EverybodyNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  EverybodyNewestArtworksNotifier(this.worksType)
      : assert(worksType == WorksType.illust || worksType == WorksType.manga);

  final WorksType worksType;

  String? nextUrl;

  @override
  FutureOr<List<CommonIllust>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var result = await (worksType == WorksType.illust
        ? ApiNewArtWork(requester).everybodysNewIllusts()
        : ApiNewArtWork(requester).everybodysNewManga());
    nextUrl = result.nextUrl;
    return result.illusts;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.illusts));

    return nextUrl != null;
  }

  /// 下拉刷新
  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }

  /// 失败后的重试
  Future<void> retry() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}

class EverybodyNewestNovelsProvider extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>> {
  EverybodyNewestNovelsProvider();

  String? nextUrl;

  @override
  FutureOr<List<CommonNovel>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiNewArtWork(requester).everybodysNewNovels();
    nextUrl = result.nextUrl;
    return result.novels;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!);
    nextUrl = result.nextUrl;
    update((p0) => p0..addAll(result.novels));

    return nextUrl != null;
  }

  Future<void> refresh() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
