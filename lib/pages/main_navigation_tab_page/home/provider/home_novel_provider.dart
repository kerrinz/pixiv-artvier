import 'package:artvier/api_app/api_novels.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 首页漫画的加载状态
class HomeNovelStateNotifier extends BaseStateNotifier<PageState> {
  HomeNovelStateNotifier(super.state, {required super.ref});

  /// 执行所有请求
  Future<void> allFetch() async {
    return await ref.read(homeNovelRecommendedProvider.notifier).fetch();
  }

  /// 初始化，也可用于失败后的重试
  Future<void> init() async {
    state = PageState.loading;
    try {
      await allFetch();
      state = PageState.complete;
    } catch (e) {
      state = PageState.error;
      logger.e(e);
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

/// 首页漫画排行，数据由 [homeNovelRecommendedProvider] 负责初始化
final homeNovelRankingProvider = StateProvider<List<CommonNovel>>((ref) {
  return [];
});

/// 首页推荐漫画
final homeNovelRecommendedProvider = StateNotifierProvider<HomeNovelRecommendedNotifier, List<CommonNovel>>((ref) {
  return HomeNovelRecommendedNotifier([], ref: ref);
});

/// 首页推荐漫画
class HomeNovelRecommendedNotifier extends BaseStateNotifier<List<CommonNovel>> {
  HomeNovelRecommendedNotifier(super.state, {required super.ref});

  String? nextUrl;

  fetch() async {
    var data = await ApiNovels(requester).recommendedNovels();
    nextUrl = data.nextUrl;
    state = data.novels;
    // 更新漫画排行数据
    ref.read(homeNovelRankingProvider.notifier).update((state) => data.rankingNovels);
    return data;
  }

  Future<bool> next() async {
    if (nextUrl == null) return false;

    var data = await ApiNovels(requester).nextNovels(nextUrl!);
    nextUrl = data.nextUrl;
    state = [...state, ...data.novels];
    return nextUrl != null;
  }
}
