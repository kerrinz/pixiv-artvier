import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

/// 首页的加载状态
final homeStateProvider = StateNotifierProvider<HomeStateNotifier, PageState>((ref) {
  // // 监听全局收藏状态的变化，更新列表
  ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
    if (next != null) {
      var list = ref.read(homeIllustRecommendedProvider);
      int index = list.lastIndexWhere((element) => element.id.toString() == next.worksId);
      if (index >= 0 && index < list.length) {
        var newItem = list[index]
          ..isBookmarked = next.state == CollectState.collected
          ..collectState = next.state;
        ref.read(homeIllustRecommendedProvider.notifier).update(list..[index] = newItem);
      }
    }
  });
  return HomeStateNotifier(PageState.loading, ref: ref)..init();
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
    state = [...state, ...data.illusts];
    return nextUrl != null;
  }
}
