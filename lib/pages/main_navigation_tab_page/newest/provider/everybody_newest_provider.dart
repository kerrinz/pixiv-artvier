import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_newest.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';

final everybodyNewestWorksTypeProvider = StateProvider<WorksType>((ref) {
  return WorksType.illust;
});

/// 全站插画作品
final everybodyNewestIllustsProvider = AsyncNotifierProvider<EverybodyNewestIllustsNotifier, List<CommonIllust>>(
  () => EverybodyNewestIllustsNotifier(),
);

/// 全站插漫画作品
final everybodyNewestMangaProvider = AsyncNotifierProvider<EverybodyNewestMangesNotifier, List<CommonIllust>>(
  () => EverybodyNewestMangesNotifier(),
);

/// 全站小说作品作品
final everybodyNewestNovelsProvider =
    AsyncNotifierProvider<EverybodyNewestNovelsNotifier, List<CommonNovel>>(EverybodyNewestNovelsNotifier.new);

class EverybodyNewestIllustsNotifier extends BaseAsyncNotifier<List<CommonIllust>> with IllustListAsyncNotifierMixin {
  @override
  FutureOr<List<CommonIllust>> build() async {
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).everybodysNewIllusts(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

class EverybodyNewestMangesNotifier extends BaseAsyncNotifier<List<CommonIllust>> with IllustListAsyncNotifierMixin {
  @override
  FutureOr<List<CommonIllust>> build() async {
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).everybodysNewManga(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

class EverybodyNewestNovelsNotifier extends BaseAsyncNotifier<List<CommonNovel>> with NovelListAsyncNotifierMixin {
  @override
  FutureOr<List<CommonNovel>> build() async {
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiNewArtWork(requester).everybodysNewNovels(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.novels;
  }
}
