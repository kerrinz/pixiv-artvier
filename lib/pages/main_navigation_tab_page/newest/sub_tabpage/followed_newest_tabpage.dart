import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/provider/current_works_type.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_newest_provider.dart';

class FollowedNewestTabPage extends BaseStatefulPage {
  const FollowedNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestTabPageState();
}

class _FollowedNewestTabPageState extends BasePageState<FollowedNewestTabPage> with AutomaticKeepAliveClientMixin {
  final filters = [
    WorksType.illust,
    WorksType.novel,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(followedNewestArtworksProvider.notifier).refresh(),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Consumer(builder: (_, ref, __) {
                  final worksType = ref.watch(globalCurrentWorksTypeProvider);
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
                      final notifier = ref.read(globalCurrentWorksTypeProvider.notifier);
                      if (tapIndex == 0 &&
                          ![WorksType.illust, WorksType.manga, WorksType.mangaSeries].contains(notifier.state)) {
                        ref.read(globalCurrentWorksTypeProvider.notifier).update((state) => WorksType.illust);
                      } else if (tapIndex == 1 && WorksType.novel != notifier.state) {
                        ref.read(globalCurrentWorksTypeProvider.notifier).update((state) => WorksType.novel);
                      }
                    },
                    texts: ["${i10n.illust} • ${i10n.manga}", i10n.novels],
                  );
                }),
              ),
              maxHeight: 40,
              minHeight: 40,
            ),
          ),
          Consumer(
            builder: (context, value, child) {
              final worksType = ref.watch(globalCurrentWorksTypeProvider);
              if (worksType == WorksType.novel) {
                return const FollowedNewestNovelPageView();
              } else {
                return const FollowedNewestIllustPageView();
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

class FollowedNewestIllustPageView extends ConsumerStatefulWidget {
  const FollowedNewestIllustPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestIllustPageViewState();
}

class _FollowedNewestIllustPageViewState extends ConsumerState<FollowedNewestIllustPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(followedNewestArtworksProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(followedNewestArtworksProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonIllust> data) {
        return SliverIllustWaterfallGridView(
          artworkList: data,
          onLazyload: () async => ref.read(followedNewestArtworksProvider.notifier).next(),
        );
      },
    );
  }
}

class FollowedNewestNovelPageView extends ConsumerStatefulWidget {
  const FollowedNewestNovelPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestNovelPageViewState();
}

class _FollowedNewestNovelPageViewState extends ConsumerState<FollowedNewestNovelPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(followedNewestNovelsProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(followedNewestNovelsProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonNovel> data) {
        return SliverNovelListView(
          novelList: data,
          onLazyload: () async => ref.read(followedNewestNovelsProvider.notifier).next(),
        );
      },
    );
  }
}
