import 'dart:async';

import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 插画排行
/// arg: mode
final illustRankingProvier =
    AsyncNotifierProvider.autoDispose.family<IllustRankingNotifier, List<CommonIllust>, String>(
  () => IllustRankingNotifier(),
);

class IllustRankingNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<CommonIllust>, String>
    with IllustListAsyncNotifierMixin {
  late String mode;

  @override
  FutureOr<List<CommonIllust>> build(String arg) async {
    mode = arg;
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiIllusts(requester).getIllustRanking(mode: mode, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

/// 漫画排行
/// arg: mode
final mangaRankingProvier = AsyncNotifierProvider.autoDispose.family<MangaRankingNotifier, List<CommonIllust>, String>(
  () => MangaRankingNotifier(),
);

class MangaRankingNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<CommonIllust>, String>
    with IllustListAsyncNotifierMixin {
  late String mode;

  @override
  FutureOr<List<CommonIllust>> build(String arg) async {
    mode = arg;
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiIllusts(requester).getIllustRanking(mode: mode, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

/// 小说排行
/// arg: mode
final novelRankingProvier = AsyncNotifierProvider.autoDispose.family<NovelRankingNotifier, List<CommonNovel>, String>(
  () => NovelRankingNotifier(),
);

class NovelRankingNotifier extends BaseAutoDisposeFamilyAsyncNotifier<List<CommonNovel>, String>
    with NovelListAsyncNotifierMixin {
  late String mode;

  @override
  FutureOr<List<CommonNovel>> build(String arg) async {
    mode = arg;
    handleDispose(ref);
    handleCollectState(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiNovels(requester).rankingNovels(mode: mode, cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.novels;
  }
}
