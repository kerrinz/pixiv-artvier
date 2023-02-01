import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_newest.dart';
import 'package:pixgem/base/base_provider/base_notifier.dart';
import 'package:pixgem/base/base_provider/illust_list_notifier.dart';
import 'package:pixgem/base/base_provider/novel_list_notifier.dart';
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
    AutoDisposeAsyncNotifierProvider<EverybodyNewestNovelsNotifier, List<CommonNovel>>(
        EverybodyNewestNovelsNotifier.new);

class EverybodyNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with IllustListAsyncNotifierMixin {
  EverybodyNewestArtworksNotifier(this.worksType)
      : assert(worksType == WorksType.illust || worksType == WorksType.manga);

  final WorksType worksType;

  @override
  FutureOr<List<CommonIllust>> build() async {
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await (worksType == WorksType.illust
        ? ApiNewArtWork(requester).everybodysNewIllusts()
        : ApiNewArtWork(requester).everybodysNewManga());
    nextUrl = result.nextUrl;
    return result.illusts;
  }

}

class EverybodyNewestNovelsNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>>
    with NovelListAsyncNotifierMixin {
  EverybodyNewestNovelsNotifier();

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
