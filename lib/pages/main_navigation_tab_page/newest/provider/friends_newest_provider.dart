import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_newest.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/base/base_provider/illust_list_notifier.dart';
import 'package:artvier/base/base_provider/novel_list_notifier.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';

/// 好P友的最新美术作品（插画 + 漫画）
final friendsNewestArtworksProvider =
    AutoDisposeAsyncNotifierProvider<FriendsNewestArtworksNotifier, List<CommonIllust>>(
        FriendsNewestArtworksNotifier.new);

/// 好P友的最新小说
final friendsNewestNovelsProvider =
    AutoDisposeAsyncNotifierProvider<FriendsNewestNovelsNotifier, List<CommonNovel>>(() {
  return FriendsNewestNovelsNotifier();
});

class FriendsNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>>
    with IllustListAsyncNotifierMixin {
  @override
  FutureOr<List<CommonIllust>> build() async {
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).friendsNewestArtworks(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.illusts;
  }
}

class FriendsNewestNovelsNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>>
    with NovelListAsyncNotifierMixin {
  @override
  FutureOr<List<CommonNovel>> build() async {
    beforeBuild(ref);
    return fetch();
  }

  /// 初始化数据
  @override
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiNewArtWork(requester).friendsNewestNovels(cancelToken: cancelToken);
    nextUrl = result.nextUrl;
    return result.novels;
  }
}
