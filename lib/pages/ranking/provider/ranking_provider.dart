import 'dart:async';

import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 排行榜自选日期
final rankingDateProvier = StateProvider.autoDispose<DateTime?>((ref) {
  return null;
});

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
    ref.listen<DateTime?>(rankingDateProvier, (previous, next) {
      if (previous != next) reload();
    });
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    final date = ref.read(rankingDateProvier);
    final dateString = date != null ? formatDate(date, [yyyy, '-', mm, '-', dd]) : null;
    var result = await ApiIllusts(requester).getIllustRanking(mode: mode, date: dateString, cancelToken: cancelToken);
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
    ref.listen<DateTime?>(rankingDateProvier, (previous, next) {
      if (previous != next) reload();
    });
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
    ref.listen<DateTime?>(rankingDateProvier, (previous, next) {
      if (previous != next) reload();
    });
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
