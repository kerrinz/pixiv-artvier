import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/api_app/api_illusts.dart';
import 'package:pixgem/base/base_provider.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

/// 首页的加载状态
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, PageState>((ref) {
  return HomeStateNotifier(PageState.loading, ref: ref);
});

/// 首页的加载状态
class HomeStateNotifier extends BaseStateNotifier<PageState> {
  HomeStateNotifier(super.state, {required super.ref});

  /// 执行所有请求
  Future<void> allFetch() async {
    await ref.read(homeIllustRecommendedProvider.notifier).fetch();
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
    state = data.illusts;
    return nextUrl != null;
  }
}
