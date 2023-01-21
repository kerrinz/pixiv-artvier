import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_newest.dart';
import 'package:pixgem/api_app/api_novels.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

/// 好P友的最新美术作品（插画 + 漫画）
final friendsNewestArtworksProvider =
    AutoDisposeAsyncNotifierProvider<FriendsNewestArtworksNotifier, List<CommonIllust>>(
        FriendsNewestArtworksNotifier.new);

/// 好P友的最新小说
final friendsNewestNovelsProvider =
    AutoDisposeAsyncNotifierProvider<FriendsNewestNovelsNotifier, List<CommonNovel>>(() {
  return FriendsNewestNovelsNotifier();
});

class FriendsNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  String? nextUrl;

  @override
  FutureOr<List<CommonIllust>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).friendsNewestArtworks();
    nextUrl = result.nextUrl;
    return result.illusts;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = result.nextUrl;
    state = AsyncValue.data(result.illusts);

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

class FriendsNewestNovelsNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonNovel>> {
  String? nextUrl;

  @override
  FutureOr<List<CommonNovel>> build() async {
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonNovel>> fetch() async {
    var result = await ApiNewArtWork(requester).friendsNewestNovels();
    nextUrl = result.nextUrl;
    return result.novels;
  }

  /// 下一页
  Future<bool> next() async {
    if (nextUrl == null) return false;

    var result = await ApiNovels(requester).nextNovels(nextUrl!);
    nextUrl = result.nextUrl;
    state = AsyncValue.data(result.novels);

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
