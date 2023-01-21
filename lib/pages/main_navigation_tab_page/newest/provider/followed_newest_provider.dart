import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/api_app/api_newest.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 关注用户最新作品的筛选条件
final followedNewestRestrictAllProvider = StateProvider.autoDispose<RestrictAll>((ref) {
  return RestrictAll.all;
});

/// 页面加载状态
final followedNewestPageStateProvider = StateNotifierProvider<FollowedNewestPageStateNotifier, PageState>((ref) {
  return FollowedNewestPageStateNotifier(PageState.loading, ref: ref);
});

/// 关注用户的最新美术作品（插画 + 漫画）
final followedNewestArtworksProvider =
    AutoDisposeAsyncNotifierProvider<FollowedNewestArtworksNotifier, List<CommonIllust>>(() {
  return FollowedNewestArtworksNotifier();
});

/// 页面加载状态
class FollowedNewestPageStateNotifier extends BaseStateNotifier<PageState> {
  FollowedNewestPageStateNotifier(super.state, {required super.ref});

  /// 执行所有请求
  Future<void> allFetch() async {
    await ref.read(followedNewestArtworksProvider.notifier).fetch();
  }

  /// 初始化，也可用于失败后的重试
  Future<void> initOrRetry() async {
    state = PageState.loading;
    try {
      await allFetch();
      state = PageState.complete;
    } catch (e) {
      state = PageState.error;
    }
  }

  /// 适用于下拉刷新
  Future<void> refresh() async {
    state = PageState.refreshing;
    try {
      await allFetch();
      state = PageState.complete;
    } catch (e) {
      state = PageState.error;
    }
  }
}

/// 关注用户的最新美术作品
class FollowedNewestArtworksNotifier extends BaseAutoDisposeAsyncNotifier<List<CommonIllust>> {
  String? nextUrl;

  late RestrictAll restrictFilter;

  @override
  FutureOr<List<CommonIllust>> build() async {
    restrictFilter = ref.watch(followedNewestRestrictAllProvider);
    return fetch();
  }

  /// 初始化数据
  Future<List<CommonIllust>> fetch() async {
    var result = await ApiNewArtWork(requester).followedNewestArtworks(restrictFilter);
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

  Future<void> refresh() async {
    // Set loading
    state = const AsyncValue.loading();
    // Reload
    state = await AsyncValue.guard(() async {
      return fetch();
    });
  }
}
