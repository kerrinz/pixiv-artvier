import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/friends_newest_provider.dart';

class FriendsNewestTabPage extends BaseStatefulPage {
  const FriendsNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsNewestTabPageState();
}

class _FriendsNewestTabPageState extends BasePageState<FriendsNewestTabPage> with AutomaticKeepAliveClientMixin {
  final filters = [
    WorksType.illust,
    WorksType.novel,
  ];

  /// 好P友的最新美术作品（插画 + 漫画）
  final friendsNewestArtworksProvider =
      AsyncNotifierProvider<FriendsNewestArtworksNotifier, List<CommonIllust>>(FriendsNewestArtworksNotifier.new);

  /// 好P友的最新小说
  final friendsNewestNovelsProvider = AsyncNotifierProvider<FriendsNewestNovelsNotifier, List<CommonNovel>>(() {
    return FriendsNewestNovelsNotifier();
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        final worksType = ref.read(friendsNewestWorksTypeProvider);
        if (worksType == WorksType.novel) {
          return ref.read(friendsNewestNovelsProvider.notifier).refresh();
        } else {
          return ref.read(friendsNewestArtworksProvider.notifier).refresh();
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
                  final worksType = ref.watch(friendsNewestWorksTypeProvider);
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
                      final notifier = ref.read(friendsNewestWorksTypeProvider.notifier);
                      if (tapIndex == 0 &&
                          ![WorksType.illust, WorksType.manga, WorksType.mangaSeries].contains(notifier.state)) {
                        ref.read(friendsNewestWorksTypeProvider.notifier).update((state) => WorksType.illust);
                      } else if (tapIndex == 1 && WorksType.novel != notifier.state) {
                        ref.read(friendsNewestWorksTypeProvider.notifier).update((state) => WorksType.novel);
                      }
                    },
                    texts: ["${l10n.illust} • ${l10n.manga}", l10n.novels],
                  );
                }),
              ),
              maxHeight: 40,
              minHeight: 40,
            ),
          ),
          Consumer(
            builder: (context, value, child) {
              final worksType = ref.watch(friendsNewestWorksTypeProvider);
              if (worksType == WorksType.novel) {
                return FriendsNewestNovelPageView(provider: friendsNewestNovelsProvider);
              } else {
                return FriendsNewestIllustPageView(provider: friendsNewestArtworksProvider);
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

class FriendsNewestIllustPageView extends ConsumerStatefulWidget {
  const FriendsNewestIllustPageView({super.key, required this.provider});

  final AsyncNotifierProvider<FriendsNewestArtworksNotifier, List<CommonIllust>> provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsNewestIllustPageViewState();
}

class _FriendsNewestIllustPageViewState extends ConsumerState<FriendsNewestIllustPageView>
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
      data: (List<CommonIllust> data) {
        return SliverIllustWaterfallGridView(
          artworkList: data,
          onLazyload: () async => ref.read(widget.provider.notifier).next(),
        );
      },
    );
  }
}

class FriendsNewestNovelPageView extends ConsumerStatefulWidget {
  const FriendsNewestNovelPageView({super.key, required this.provider});

  final AsyncNotifierProvider<FriendsNewestNovelsNotifier, List<CommonNovel>> provider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FriendsNewestNovelPageViewState();
}

class _FriendsNewestNovelPageViewState extends ConsumerState<FriendsNewestNovelPageView>
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
      data: (List<CommonNovel> data) {
        return SliverNovelListView(
          novelList: data,
          onLazyload: () async => ref.read(widget.provider.notifier).next(),
        );
      },
    );
  }
}
