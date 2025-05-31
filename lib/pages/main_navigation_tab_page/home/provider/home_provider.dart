import 'dart:async';

import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/illusts/pixivision/spotlight_articles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 首页的加载状态
class HomeIllustStateNotifier extends BaseStateNotifier<PageState> {
  HomeIllustStateNotifier(super.state, {required super.ref});

  /// 执行所有请求
  Future<void> allFetch() async {
    await ref.read(homeIllustRecommendedProvider.notifier).fetch();
    await ref.read(homePixivisionProvider.notifier).fetch();
  }

  /// 初始化，也可用于失败后的重试
  Future<void> init() async {
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
      logger.e(e);
    }
  }
}

/// 首页插画排行，因Api限制，数据由 [homeIllustRecommendedProvider] 负责初始化
final homeIllustRankingProvider = StateProvider<List<CommonIllust>>((ref) {
  return [];
});

/// 首页推荐插画
final homeIllustRecommendedProvider = StateNotifierProvider<HomeIllustRecommendedNotifier, List<CommonIllust>>((ref) {
  return HomeIllustRecommendedNotifier([], ref: ref);
});

/// 首页推荐插画
class HomeIllustRecommendedNotifier extends BaseStateNotifier<List<CommonIllust>> {
  HomeIllustRecommendedNotifier(super.state, {required super.ref});

  String? nextUrl;

  fetch() async {
    var data = await ApiIllusts(requester).recommendedIllusts();
    nextUrl = data.nextUrl;
    state = data.illusts;
    // 更新插画排行数据
    ref.read(homeIllustRankingProvider.notifier).update((state) => data.rankingIllusts);
  }

  Future<bool> next() async {
    if (nextUrl == null) return false;

    var data = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = data.nextUrl;
    state = [...state, ...data.illusts];
    return nextUrl != null;
  }
}

/// 首页推荐插画Pixivision
final homePixivisionProvider = StateNotifierProvider<HomePixivisionNotifier, List<SpotlightArticle>>((ref) {
  return HomePixivisionNotifier([], ref: ref);
});

/// 首页推荐插画Pixivision
class HomePixivisionNotifier extends BaseStateNotifier<List<SpotlightArticle>> {
  HomePixivisionNotifier(super.state, {required super.ref});

  String? nextUrl;

  fetch() async {
    var data = await ApiIllusts(requester).illustPixivision();
    nextUrl = data.nextUrl;
    state = data.spotlightArticles;
  }
}
