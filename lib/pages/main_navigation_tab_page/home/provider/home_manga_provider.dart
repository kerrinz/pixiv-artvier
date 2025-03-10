import 'package:artvier/api_app/api_illusts.dart';
import 'package:artvier/base/base_provider/base_notifier.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/illusts/pixivision/spotlight_articles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 首页漫画的加载状态
final homeMangaStateProvider = StateNotifierProvider<HomeMangaStateNotifier, PageState>((ref) {
  // // 监听全局收藏状态的变化，更新列表
  ref.listen<CollectStateChangedArguments?>(globalArtworkCollectionStateChangedProvider, (previous, next) {
    if (next != null) {
      var list = ref.read(homeMangaRecommendedProvider);
      int index = list.lastIndexWhere((element) => element.id.toString() == next.worksId);
      if (index >= 0 && index < list.length) {
        var newItem = list[index]
          ..isBookmarked = next.state == CollectState.collected
          ..collectState = next.state;
        ref.read(homeMangaRecommendedProvider.notifier).update(list..[index] = newItem);
      }
    }
  });
  return HomeMangaStateNotifier(PageState.loading, ref: ref)..init();
});

/// 首页漫画的加载状态
class HomeMangaStateNotifier extends BaseStateNotifier<PageState> {
  HomeMangaStateNotifier(super.state, {required super.ref});

  /// 执行所有请求
  Future<void> allFetch() async {
    await ref.read(homeMangaRecommendedProvider.notifier).fetch();
    await ref.read(homeMangaPixivisionProvider.notifier).fetch();
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

/// 首页漫画排行，因Api限制，数据由 [homeMangaRecommendedProvider] 负责初始化
final homeMangaRankingProvider = StateProvider<List<CommonIllust>>((ref) {
  return [];
});

/// 首页推荐漫画
final homeMangaRecommendedProvider = StateNotifierProvider<HomeMangaRecommendedNotifier, List<CommonIllust>>((ref) {
  return HomeMangaRecommendedNotifier([], ref: ref);
});

/// 首页推荐漫画
class HomeMangaRecommendedNotifier extends BaseStateNotifier<List<CommonIllust>> {
  HomeMangaRecommendedNotifier(super.state, {required super.ref});

  String? nextUrl;

  fetch() async {
    var data = await ApiIllusts(requester).recommendedManga();
    nextUrl = data.nextUrl;
    state = data.illusts;
    // 更新漫画排行数据
    ref.read(homeMangaRankingProvider.notifier).update((state) => data.rankingIllusts);
  }

  Future<bool> next() async {
    if (nextUrl == null) return false;

    var data = await ApiIllusts(requester).getNextIllusts(nextUrl!);
    nextUrl = data.nextUrl;
    state = [...state, ...data.illusts];
    return nextUrl != null;
  }
}

/// 首页推荐漫画Pixivision
final homeMangaPixivisionProvider = StateNotifierProvider<HomeMangaPixivisionNotifier, List<SpotlightArticle>>((ref) {
  return HomeMangaPixivisionNotifier([], ref: ref);
});

/// 首页推荐漫画Pixivision
class HomeMangaPixivisionNotifier extends BaseStateNotifier<List<SpotlightArticle>> {
  HomeMangaPixivisionNotifier(super.state, {required super.ref});

  String? nextUrl;

  fetch() async {
    var data = await ApiIllusts(requester).illustPixivision(isManga: true);
    nextUrl = data.nextUrl;
    state = data.spotlightArticles;
  }
}
