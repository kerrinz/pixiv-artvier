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
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/everybody_newest_provider.dart';

class EverybodyNewestTabPage extends BaseStatefulPage {
  const EverybodyNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EverybodyNewestTabPageState();
}

class _EverybodyNewestTabPageState extends BasePageState<EverybodyNewestTabPage> with AutomaticKeepAliveClientMixin {
  final filters = [
    WorksType.illust,
    WorksType.manga,
    WorksType.novel,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        final worksType = ref.read(everybodyNewestWorksTypeProvider);
        if (worksType == WorksType.novel) {
          return ref.read(everybodyNewestNovelsProvider.notifier).refresh();
        } else {
          return ref.read(everybodyNewestIllustsProvider.notifier).refresh();
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
                  final worksType = ref.watch(everybodyNewestWorksTypeProvider);
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
                      final notifier = ref.read(everybodyNewestWorksTypeProvider.notifier);
                      if (tapIndex == 0 && WorksType.illust != notifier.state) {
                        ref.read(everybodyNewestWorksTypeProvider.notifier).update((state) => WorksType.illust);
                      } else if (tapIndex == 1 && WorksType.manga != notifier.state) {
                        ref.read(everybodyNewestWorksTypeProvider.notifier).update((state) => WorksType.manga);
                      } else if (tapIndex == 2 && WorksType.novel != notifier.state) {
                        ref.read(everybodyNewestWorksTypeProvider.notifier).update((state) => WorksType.novel);
                      }
                    },
                    texts: [i10n.illust, i10n.manga, i10n.novels],
                  );
                }),
              ),
              maxHeight: 40,
              minHeight: 40,
            ),
          ),
          Consumer(
            builder: (context, value, child) {
              final worksType = ref.watch(everybodyNewestWorksTypeProvider);
              if (worksType == WorksType.novel) {
                return const EverybodyNewestNovelPageView();
              } else if (worksType == WorksType.illust) {
                return const EverybodyNewestIllustPageView();
              } else {
                return const EverybodyNewestMangaPageView();
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

class EverybodyNewestIllustPageView extends ConsumerStatefulWidget {
  const EverybodyNewestIllustPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EverybodyNewestIllustPageViewState();
}

class _EverybodyNewestIllustPageViewState extends ConsumerState<EverybodyNewestIllustPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(everybodyNewestIllustsProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(everybodyNewestIllustsProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonIllust> data) {
        return SliverIllustWaterfallGridView(
          artworkList: data,
          onLazyload: () async => ref.read(everybodyNewestIllustsProvider.notifier).next(),
        );
      },
    );
  }
}

class EverybodyNewestMangaPageView extends ConsumerStatefulWidget {
  const EverybodyNewestMangaPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EverybodyNewestMangaPageViewState();
}

class _EverybodyNewestMangaPageViewState extends ConsumerState<EverybodyNewestMangaPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(everybodyNewestMangaProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(everybodyNewestMangaProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonIllust> data) {
        return SliverIllustWaterfallGridView(
          artworkList: data,
          onLazyload: () async => ref.read(everybodyNewestMangaProvider.notifier).next(),
        );
      },
    );
  }
}

class EverybodyNewestNovelPageView extends ConsumerStatefulWidget {
  const EverybodyNewestNovelPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EverybodyNewestNovelPageViewState();
}

class _EverybodyNewestNovelPageViewState extends ConsumerState<EverybodyNewestNovelPageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final list = ref.watch(everybodyNewestNovelsProvider);
    return list.when(
      loading: () => const SliverToBoxAdapter(child: Center(child: RequestLoading())),
      error: (Object error, StackTrace stackTrace) => SliverToBoxAdapter(
        child: Center(
          child: RequestLoadingFailed(
            onRetry: () async => ref.read(everybodyNewestNovelsProvider.notifier).reload(),
          ),
        ),
      ),
      data: (List<CommonNovel> data) {
        return SliverNovelListView(
          novelList: data,
          onLazyload: () async => ref.read(everybodyNewestNovelsProvider.notifier).next(),
        );
      },
    );
  }
}
