import 'package:artvier/business_component/listview/manga_series_listview/manga_series_listview.dart';
import 'package:artvier/business_component/listview/novel_series_listview/novel_series_listview.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/model_response/novels/novel_series_list.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_series_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';

class FollowedSeriesTabPage extends BaseStatefulPage {
  const FollowedSeriesTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedSeriesTabPageState();
}

class _FollowedSeriesTabPageState extends BasePageState<FollowedSeriesTabPage> with AutomaticKeepAliveClientMixin {
  final filters = [
    WorksType.manga,
    WorksType.novel,
  ];

  /// 追更的漫画系列
  final followedMangeSeriesProvider = AsyncNotifierProvider<FollowedMangeSeriesNotifier, List<MangaSeries>>(() {
    return FollowedMangeSeriesNotifier();
  });

  /// 追更的小说系列
  final followedNovelSeriesProvider = AsyncNotifierProvider<FollowedNovelSeriesNotifier, List<NovelSeries>>(() {
    return FollowedNovelSeriesNotifier();
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        final worksType = ref.read(followedSeriesWorksTypeProvider);
        if (worksType == WorksType.novel) {
          return ref.read(followedNovelSeriesProvider.notifier).refresh();
        } else {
          return ref.read(followedMangeSeriesProvider.notifier).refresh();
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Consumer(builder: (_, ref, __) {
                  final worksType = ref.watch(followedSeriesWorksTypeProvider);
                  int index = filters.indexOf(worksType);
                  return StatelessTextFlowFilter(
                    initialIndexes: {index >= 0 ? index : 0},
                    selectedBackground: Theme.of(context).colorScheme.secondary,
                    unselectedBackground: Theme.of(context).colorScheme.surface,
                    selectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                    unselectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                    textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                    spacing: 8,
                    onTap: (int tapIndex) {
                      final notifier = ref.read(followedSeriesWorksTypeProvider.notifier);
                      if (tapIndex == 0 &&
                          ![WorksType.illust, WorksType.manga, WorksType.mangaSeries].contains(notifier.state)) {
                        ref.read(followedSeriesWorksTypeProvider.notifier).update((state) => WorksType.illust);
                      } else if (tapIndex == 1 && WorksType.novel != notifier.state) {
                        ref.read(followedSeriesWorksTypeProvider.notifier).update((state) => WorksType.novel);
                      }
                    },
                    texts: [l10n.mangaSeries, l10n.novelSeries],
                  );
                }),
              ),
              maxHeight: 40,
              minHeight: 40,
            ),
          ),
          Consumer(
            builder: (context, value, child) {
              final worksType = ref.watch(followedSeriesWorksTypeProvider);
              if (worksType == WorksType.novel) {
                return FollowedNovelSeriesPageView(provider: followedNovelSeriesProvider);
              } else {
                return FollowedMangaSeriesPageView(provider: followedMangeSeriesProvider);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FollowedMangaSeriesPageView extends ConsumerStatefulWidget {
  const FollowedMangaSeriesPageView({super.key, required this.provider});

  final AsyncNotifierProvider<FollowedMangeSeriesNotifier, List<MangaSeries>> provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedMangaSeriesPageViewState();
}

class _FollowedMangaSeriesPageViewState extends ConsumerState<FollowedMangaSeriesPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(widget.provider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(widget.provider.notifier).reload(),
          ),
        ),
      ),
      data: (data) {
        return SliverMangaSeriesListView(
          seriesList: data,
          onLazyload: () async => ref.read(widget.provider.notifier).next(),
        );
      },
    );
  }
}

class FollowedNovelSeriesPageView extends ConsumerStatefulWidget {
  const FollowedNovelSeriesPageView({super.key, required this.provider});

  final AsyncNotifierProvider<FollowedNovelSeriesNotifier, List<NovelSeries>> provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNovelSeriesPageViewState();
}

class _FollowedNovelSeriesPageViewState extends ConsumerState<FollowedNovelSeriesPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(widget.provider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(widget.provider.notifier).reload(),
          ),
        ),
      ),
      data: (data) {
        return SliverNovelSeriesListView(
          seriesList: data,
          onLazyload: () async => ref.read(widget.provider.notifier).next(),
        );
      },
    );
  }
}
